using System;
using System.Data;
using System.ServiceProcess;
using System.IO;
using System.Data.SqlClient;
using System.Timers;

namespace WindowsService3
{
    public partial class MigrationsService : ServiceBase
    {
        string realDbConnection = "Data Source=HAIER-PC;Initial Catalog=db1;User Id = sa;Password = corem3";
        string backUpDbConnection = "Data Source=HAIER-PC;Initial Catalog=db2;User Id = sa;Password = corem3";
        string query = "Select * from detail_1";

        Timer timer1 = new Timer();
        
        public MigrationsService()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            this.CopyDatabaseRows(realDbConnection, backUpDbConnection, query);
            this.WriteToFile("Service is started at " + DateTime.Now);
            timer1.Elapsed += new ElapsedEventHandler(OnElapsedTime);
            timer1.Interval = 60000; //It's means after every 1mint.  
            timer1.Enabled = true;
        }

        protected override void OnStop()
        {
            this.CopyDatabaseRows(realDbConnection, backUpDbConnection, query);
            WriteToFile("Service is stopped at " + DateTime.Now);
            timer1.Enabled = false;
        }

        private void OnElapsedTime(object source, ElapsedEventArgs e)
        {
            this.CopyDatabaseRows(realDbConnection, backUpDbConnection, query);
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

        public void CopyDatabaseRows(string RealConnectionString, string BackupConnectionString, string queryString)
        {
            SqlConnection connectRealDb = null;
            DataSet dataSet = null;
            SqlCommand command1 = null;
            SqlCommand command2 = null;
            DataTable dataTable = null;
            SqlDataAdapter dataAdapter = null;
            SqlConnection connectBackUpDb = null;
            SqlBulkCopy bulkCopy = null;

            try
            {
                //Connect to first database table to retreive row/rows and populate dataset + datatable.
                dataSet = new DataSet();
                connectRealDb = new SqlConnection(RealConnectionString);
                connectRealDb.Open();

                command1 = new SqlCommand(queryString, connectRealDb);
                dataTable = new DataTable();
                dataAdapter = new SqlDataAdapter(queryString, connectRealDb);

                dataAdapter.FillSchema(dataSet, SchemaType.Mapped);
                dataAdapter.Fill(dataSet, "Detail_1");
                dataTable = dataSet.Tables["Detail_1"];
                connectRealDb.Close();

                //Connect to second Database and Insert row/rows.
                connectBackUpDb = new SqlConnection(BackupConnectionString);
                connectBackUpDb.Open();

                //Truncate Backup table, to save from dublication of data
                string query1 = "Truncate table Detail_2";
                command2 = new SqlCommand(query1, connectBackUpDb);
                command2.ExecuteNonQuery();

                bulkCopy = new SqlBulkCopy(connectBackUpDb);
                bulkCopy.DestinationTableName = "Detail_2";
                bulkCopy.WriteToServer(dataTable);
                connectBackUpDb.Close();
            }
            catch (Exception ex)
            {
                this.WriteToFile(ex.Message);
            }
            finally
            {
                connectRealDb.Dispose();
                connectBackUpDb.Dispose();
                command1.Dispose();
                command2.Dispose();
                dataSet.Dispose();
                dataAdapter.Dispose();
                dataTable.Dispose();
            }
        }
    }
}