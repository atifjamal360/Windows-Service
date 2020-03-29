using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using System.Data.SqlClient;
using System.IO;
using System.Data.Sql;

namespace WindowsService2
{
    public partial class Service1 : ServiceBase
    {
        Timer timer = new Timer();

        public Service1()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            this.BackUp();
            this.WriteToFile("Service is started at " + DateTime.Now);
            timer.Elapsed += new ElapsedEventHandler(OnElapsedTime);
            timer.Interval = 3600000; //It's means after every 1 Hour.  
            timer.Enabled = true;
        }

        protected override void OnStop()
        {
            this.BackUp();
            WriteToFile("Service is stopped at " + DateTime.Now);
            timer.Enabled = false;
        }

        private void OnElapsedTime(object source, ElapsedEventArgs e)
        {
            this.BackUp();
            WriteToFile("Service is recall at " + DateTime.Now);
        } 


        // This function create LOG file and write all the situation of service
        public void WriteToFile(string Message)
        {
            string path = AppDomain.CurrentDomain.BaseDirectory + "\\Logs";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            string filepath = AppDomain.CurrentDomain.BaseDirectory + "\\Logs\\ServiceLog_" + DateTime.Now.Date.ToShortDateString().Replace('/', '_') + ".txt";
            if (!File.Exists(filepath))
            {
                // Create a file to write to.   
                using (StreamWriter sw = File.CreateText(filepath))
                {
                    sw.WriteLine(Message);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(filepath))
                {
                    sw.WriteLine(Message);
                }
            }
        }  


        // This function is used to copy data from one table to another table.
        public void BackUp()
        {
            SqlConnection con = null;
            SqlCommand str = null;
            try 
            {
                con = new SqlConnection("Data Source=HAIER-PC;Initial Catalog=Shop;User ID = sa;Password = corem3");
                con.Open();
                //Console.WriteLine("Database Connected.");
                string query = "insert into detail_2 (u_Name,u_Age) select u_Name,u_Age from detail_1";
                str = new SqlCommand(query, con);
                str.ExecuteNonQuery();
                //string query1 = "Truncate table detail_1";
                //SqlCommand str1 = new SqlCommand(query1, con);
                //str1.ExecuteNonQuery();
                con.Close();
            }
            catch( Exception ex )
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                this.WriteToFile(ex.Message);
            }
            finally
            {
                str.Dispose();
                con.Dispose();
            }
        }
    }
}