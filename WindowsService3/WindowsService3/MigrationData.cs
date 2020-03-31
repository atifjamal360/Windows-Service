using System;
using System.Data;
using System.Net;
using System.ServiceProcess;
using System.IO;
using System.Data.SqlClient;
using System.Timers;

namespace WindowsService3
{
    public partial class MigrationData : ServiceBase
    {
        string query = "select * from Detail_1";
        string query1 = "Truncate table Detail_2";
        string ConnectionRealDb = "Data Source=HAIER-PC;Initial Catalog=db1; User ID=sa; Password = corem3";
        string ConnectionbackUpDb = "Data Source=HAIER-PC;Initial Catalog=db2; User ID=sa; Password = corem3";

        Timer timer1 = new Timer();
        
        public MigrationData()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            if (!CheckInternetConnection())
            {
                this.WriteToFile("Service is started at " + DateTime.Now);
                this.WriteToFile("Internet Connection Lost.");
            }
            else
            {
                this.WriteToFile("Service is started at " + DateTime.Now);
                this.CopyDatabaseRows(ConnectionRealDb, ConnectionbackUpDb, query);
            }
            timer1.Elapsed += new ElapsedEventHandler(OnElapsedTime);
            timer1.Interval = 60000; //It's means after every 1mint.  
            timer1.Enabled = true;
        }

        protected override void OnStop()
        {
            if (!CheckInternetConnection())
            {
                this.WriteToFile("Internet Connection Lost.");
                WriteToFile("Service is stopped at " + DateTime.Now);

            }
            else
            {
                this.CopyDatabaseRows(ConnectionRealDb, ConnectionbackUpDb, query);
                WriteToFile("Service is stopped at " + DateTime.Now);

            }
            timer1.Enabled = false;
        }

        private void OnElapsedTime(object source, ElapsedEventArgs e)
        {
            if (!CheckInternetConnection())
            {
                this.WriteToFile("Internet Connection Lost.");
            }
            else
            {
                WriteToFile("Service is recall at " + DateTime.Now);
                this.CopyDatabaseRows(ConnectionRealDb, ConnectionbackUpDb, query);

            }
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
            //Initialization
            SqlConnection backUpDbConnection = null;
            SqlCommand command2 = null;
            SqlBulkCopy bulkCopy = null;
            SqlConnection realDbConnection = null;
            SqlCommand command = null;
            SqlDataReader dr = null;

            // Create a new DataTable.    
            DataTable detail = new DataTable("Detail_2");
            DataColumn dtColumn;
            DataRow myDataRow;
            DataSet dataSet;

            // Create id column  
            dtColumn = new DataColumn();
            dtColumn.DataType = typeof(Int32);
            dtColumn.ColumnName = "u_Id";
            dtColumn.Caption = "Id";
            dtColumn.ReadOnly = false;
            dtColumn.Unique = true;
            // Add column to the DataColumnCollection.  
            detail.Columns.Add(dtColumn);

            // Create Name column.    
            dtColumn = new DataColumn();
            dtColumn.DataType = typeof(String);
            dtColumn.ColumnName = "u_Name";
            dtColumn.Caption = "Name";
            dtColumn.AutoIncrement = false;
            dtColumn.ReadOnly = false;
            dtColumn.Unique = false;
            /// Add column to the DataColumnCollection.  
            detail.Columns.Add(dtColumn);

            // Create Age column.    
            dtColumn = new DataColumn();
            dtColumn.DataType = typeof(Int32);
            dtColumn.ColumnName = "u_Age";
            dtColumn.Caption = "Age";
            dtColumn.ReadOnly = false;
            dtColumn.Unique = false;
            // Add column to the DataColumnCollection.    
            detail.Columns.Add(dtColumn);

            // Create Code column.    
            dtColumn = new DataColumn();
            dtColumn.DataType = typeof(String);
            dtColumn.ColumnName = "u_Code";
            dtColumn.Caption = "Code";
            dtColumn.ReadOnly = false;
            dtColumn.Unique = false;
            dtColumn.DefaultValue = "EA";
            // Add column to the DataColumnCollection.    
            detail.Columns.Add(dtColumn);

            // Make id column the primary key column.    
            DataColumn[] PrimaryKeyColumns = new DataColumn[1];
            PrimaryKeyColumns[0] = detail.Columns["u_Id"];
            detail.PrimaryKey = PrimaryKeyColumns;

            // Create a new DataSet  
            dataSet = new DataSet();

            // Add detail to the DataSet.    
            dataSet.Tables.Add(detail);

            realDbConnection = new SqlConnection(ConnectionRealDb);
            
            realDbConnection.Open();
            command = new SqlCommand(query, realDbConnection);
            dr = command.ExecuteReader();

            while (dr.Read())
            {
                myDataRow = detail.NewRow();
                myDataRow["u_Id"] = dr.GetValue(0).ToString();
                myDataRow["u_Name"] = dr.GetValue(1).ToString();
                myDataRow["u_Age"] = dr.GetValue(2).ToString();
                detail.Rows.Add(myDataRow);
            }
            realDbConnection.Close();

            backUpDbConnection = new SqlConnection(ConnectionbackUpDb);

            backUpDbConnection.Open();
            //Truncate Backup table, to save from dublication of data
            command2 = new SqlCommand(query1, backUpDbConnection);
            command2.ExecuteNonQuery();
            
            using (bulkCopy = new SqlBulkCopy(backUpDbConnection))
            {
                foreach (DataColumn get in detail.Columns)
                    bulkCopy.ColumnMappings.Add(get.ColumnName, get.ColumnName);

                bulkCopy.DestinationTableName = detail.TableName;
                try
                {
                    bulkCopy.WriteToServer(detail);
                }
                catch (Exception ex)
                {
                    this.WriteToFile(ex.Message);
                }
            }
            backUpDbConnection.Close();
        }

        //Check Internet Connection
        public static bool CheckInternetConnection()
        {
            try
            {
                using (var client = new WebClient())
                using (var stream = client.OpenRead("http://www.google.com"))
                {
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}