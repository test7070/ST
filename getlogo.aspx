<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        public void Page_Load()
        {//http://localhost:1216/Default.aspx?noa=lienchy&db=st
            string db = Request.QueryString["db"] == null ? "" : Request.QueryString["db"];
            string noa = Request.QueryString["noa"] == null ? "" : Request.QueryString["noa"];
            string connString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + db;   
            string img = "";
            string base64String = "";
            string filename = "logo.bmp";
            try
            {
                System.Data.DataTable dt = new System.Data.DataTable();
                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connString))
                {
                    System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                    connSource.Open();
                    string queryString = @"select img from logo where noa=@noa ";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                    cmd.Parameters.AddWithValue("@noa", noa);
                    adapter.SelectCommand = cmd;
                    adapter.Fill(dt);
                    connSource.Close();
                }
                foreach (System.Data.DataRow r in dt.Rows)
                {
                    img = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                    base64String = img.Substring(img.IndexOf("base64") + 7);
                    filename = "logo." + img.Substring(img.IndexOf("data:image/") + 11, img.IndexOf(";base64") - (img.IndexOf("data:image/") + 11));
                }
                var bytes = Convert.FromBase64String(base64String);
                stream.Write(bytes, 0, bytes.Length);
            }
            catch (Exception e)
            {

            }
            //Response.Write(filename);
            Response.ContentType = "application/x-msdownload;";
            Response.AddHeader("Content-transfer-encoding", "binary");
            Response.AddHeader("Content-Disposition", "attachment;filename=" + filename);
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
    </script>
