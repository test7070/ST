<%@ Import Namespace="System.Data" %>
<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public string date;
        }
        
        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        string connectionString = "";
        public void Page_Load()
        {
        	string db = "st";
        	if(Request.QueryString["db"] !=null && Request.QueryString["db"].Length>0)
        		db= Request.QueryString["db"];
        	connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database="+db;

			var item = new ParaIn();
            if (Request.QueryString["date"] != null && Request.QueryString["date"].Length > 0)
            {
                item.date = Request.QueryString["date"];
            }
            
            //資料
            System.Data.DataSet ds = new System.Data.DataSet();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString =@"[dbo].[uccstk] @t_date";
               
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.CommandTimeout = 0;
                cmd.Parameters.AddWithValue("@t_date", item.date);
                adapter.SelectCommand = cmd;
                adapter.Fill(ds);
                connSource.Close();
            }
            foreach (System.Data.DataRow r in ds.Tables[0].Rows)
            {
               Response.Write( System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0]);    
            }
        }
    </script>