 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public string noa;
        }
        string connectionString = "";
        public void Page_Load()
        {
            //參數
            string t_noa = "";
            string t_db = Request.Url.Segments[1].Replace("z/", "").Replace("/", "");
           
            if (Request.QueryString["noa"] != null && Request.QueryString["noa"].Length > 0)
            {
                t_noa = Request.QueryString["noa"];
            }
            if (Request.QueryString["db"] != null && Request.QueryString["db"].Length > 0)
            {
                t_db = Request.QueryString["db"];
            }
            
        	connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database="+t_db;
            
            //資料
            System.Data.DataTable dt = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = "";

                queryString = @"select a.noa,a.productno,a.product
                                ,dbo.getComma(a.mount,-1),a.unit
                                ,dbo.getComma(isnull(a.mount*b.uweight,0),-1) weight
                                ,dbo.getComma(a.hours,-1)
                                ,a.stationno,a.station,a.processno,a.process,a.modelno,a.model,a.ordeno,c.workno
                                ,stuff((select ','+product from view_works where noa=a.noa FOR XML PATH('') ),1,1,'')
                                ,case when len(dbo.split(b.images+';',';',0))>0 then '<a href=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',0)+' ''><img border=''0'' src=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',0)+' '' width=''100px'' ></a>' else '' end img1
                                ,case when len(dbo.split(b.images+';',';',1))>0 then '<a href=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',1)+' ''><img border=''0'' src=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',1)+' '' width=''100px'' ></a>' else '' end img2
                                ,case when len(dbo.split(b.images+';',';',2))>0 then '<a href=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',2)+' ''><img border=''0'' src=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',2)+' '' width=''100px'' ></a>' else '' end img3
                                ,case when len(dbo.split(b.images+';',';',3))>0 then '<a href=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',3)+' ''><img border=''0'' src=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',3)+' '' width=''100px'' ></a>' else '' end img4
                                ,case when len(dbo.split(b.images+';',';',4))>0 then '<a href=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',4)+' ''><img border=''0'' src=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',4)+' '' width=''100px'' ></a>' else '' end img5
                                ,case when len(dbo.split(b.images+';',';',5))>0 then '<a href=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',5)+' ''><img border=''0'' src=''../images/upload/'+REPLACE(b.noa,'/','CHR(47)')+'_'+dbo.split(b.images+';',';',5)+' '' width=''100px'' ></a>' else '' end img6
                                from view_work a left join uca b on a.productno=b.noa
                                left join view_workgs c on a.cuano=c.noa and a.cuanoq=c.noq 
                                where a.noa=@t_noa
                            ";
				
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@t_noa", t_noa);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt);
                connSource.Close();
            }
            Response.Write("<table style='width:720px;word-break:break-all;'>");
            foreach (System.Data.DataRow r in dt.Rows)
            {
                Response.Write("<tr'><td style='width:120px;'>製令單號：</td><td style='width:600px;'>" + (System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0]).ToString() + "</td></tr>");
                Response.Write("<tr><td>製品編號：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1]).ToString() + "</td></tr>");
                Response.Write("<tr><td>製品名稱：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2]).ToString() + "</td></tr>");
                Response.Write("<tr><td>排程數量：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3]).ToString() + "</td></tr>");
                Response.Write("<tr><td>單位：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4]).ToString() + "</td></tr>");
                Response.Write("<tr><td>重量：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5]).ToString() + "</td></tr>");
                Response.Write("<tr><td>工時：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6]).ToString() + "</td></tr>");
                Response.Write("<tr><td>工作線別編號：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7]).ToString() + "</td></tr>");
                Response.Write("<tr><td>工作線別名稱：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8]).ToString() + "</td></tr>");
                Response.Write("<tr><td>製程編號：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9]).ToString() + "</td></tr>");
                Response.Write("<tr><td>製程名稱：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[10]) ? "" : (System.String)r.ItemArray[10]).ToString() + "</td></tr>");
                Response.Write("<tr><td>模具編號：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[11]) ? "" : (System.String)r.ItemArray[11]).ToString() + "</td></tr>");
                Response.Write("<tr><td>模具名稱：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[12]) ? "" : (System.String)r.ItemArray[12]).ToString() + "</td></tr>");
                Response.Write("<tr><td>訂單號碼：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[13]) ? "" : (System.String)r.ItemArray[13]).ToString() + "</td></tr>");
                Response.Write("<tr><td>母製令單號：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[14]) ? "" : (System.String)r.ItemArray[14]).ToString() + "</td></tr>");
                Response.Write("<tr><td>原料：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[15]) ? "" : (System.String)r.ItemArray[15]).ToString() + "</td></tr>");
                Response.Write("<tr><td>產品圖片：</td><td>" + (System.DBNull.Value.Equals(r.ItemArray[16]) ? "" : (System.String)r.ItemArray[16]).ToString());
                Response.Write((System.DBNull.Value.Equals(r.ItemArray[17]) ? "" : (System.String)r.ItemArray[17]).ToString());
                Response.Write((System.DBNull.Value.Equals(r.ItemArray[18]) ? "" : (System.String)r.ItemArray[18]).ToString());
                Response.Write((System.DBNull.Value.Equals(r.ItemArray[19]) ? "" : (System.String)r.ItemArray[19]).ToString());
                Response.Write((System.DBNull.Value.Equals(r.ItemArray[20]) ? "" : (System.String)r.ItemArray[20]).ToString());
                Response.Write((System.DBNull.Value.Equals(r.ItemArray[21]) ? "" : (System.String)r.ItemArray[21]).ToString());
            }
            Response.Write("</table>");
        }
    </script>

