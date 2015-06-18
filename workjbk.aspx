<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class Para {
            public Workj bbm;
            public Workjs [] bbs;
        }
        public class Workj
        {
            public string noa="";
            public string site = "";
            public string datea = "";
            public string odate = "";
            public string custno = "";
            public string cust = "";
            public string nick = "";
            public string tagcolor = "";
            public string trantype = "";
            public string chktype = "";
            public string worker = "";
            public string worker2 = "";
            public string memo = "";
            public string ordeaccy = "";
            public string ordeno = "";
            public float mount=0;
            public float weight=0;    
            public float lengthb=0;
            public string tolerance = "";
            public string trantype1 = "";
            public string trantype2 = "";    
        }
        public class Workjs
        {
            public string noa = "";
            public string noq = "";
            public string productno = "";
            public string product = "";
            public float lengthb = 0;
            public float mount=0;
            public float weight=0;
            public string memo = "";
            public string picno = "";
            public string imgpara = "";
            public string imgdata = "";
            public string imgbarcode = "";
            public string contno = "";
            public string contnoq = "";
            public string mech1 = "";
            public string mech2 = "";
            public string mech3 = "";
            public string mech4 = "";
            public string mech5 = "";
            public string place1 = "";
            public string place2 = "";
            public string place3 = "";
            public string place4 = "";
            public string place5 = "";
            public string time1 = "";
            public string time2 = "";
            public string time3 = "";
            public string time4 = "";
            public string time5 = "";
            public float paraa=0;
            public float parab = 0;
            public float parac = 0;
            public float parad = 0;
            public float parae = 0;
            public float paraf = 0;
            public string worker1="";
            public string worker2 = "";
            public string worker3 = "";
            public string worker4 = "";
            public string worker5 = "";
            public string place = "";
            public string cmount = "";
            public string cweight = "";
        }
        //連接字串      
        string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=ST";
        public void Page_Load()
        {
           try
           {
                //參數
                System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                Response.ContentEncoding = encoding;
                int formSize = Request.TotalBytes;
                byte[] formData = Request.BinaryRead(formSize);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                var item = serializer.Deserialize<Para>(encoding.GetString(formData));
                //string aa = "{\"bbm\":{\"noa\":\"W1031215002\",\"site\":\"\",\"datea\":\"103/12/15\",\"odate\":\"103/12/15\",\"custno\":\"0004\",\"cust\":\"豐山廣告企業社\",\"nick\":\"豐山廣告\",\"tagcolor\":\"桃紅色\",\"trantype\":\"本廠送達\",\"chktype\":\"\",\"worker\":\"軒威電腦\",\"worker2\":\"軒威電腦\",\"memo\":\"\",\"ordeaccy\":\"\",\"ordeno\":\"\",\"mount\":0,\"weight\":0,\"lengthb\":0,\"tolerance\":\"\"},\"bbs\":[{\"noq\":\"001\",\"productno\":\"A001-01-S\",\"product\":\"機能衣\",\"lengthb\":0,\"mount\":0,\"weight\":0,\"memo\":\"\",\"picno\":\"\",\"imgdata\":\"\",\"contno\":\"\",\"contnoq\":\"\",\"place1\":\"\",\"place2\":\"\",\"place3\":\"\",\"place4\":\"\",\"place5\":\"\",\"time1\":\"\",\"time2\":\"\",\"time3\":\"\",\"time4\":\"\",\"time5\":\"\",\"paraa\":0,\"parab\":0,\"parac\":0,\"parad\":0,\"parae\":0,\"paraf\":0,\"worker1\":\"\",\"worker2\":\"\",\"worker3\":\"\",\"worker4\":\"\",\"worker5\":\"\",\"place\":\"\",\"cmount\":\"\",\"cweight\":\"\"}]}";
                //var item = serializer.Deserialize<Para>(aa);
                //資料寫入
                System.Data.DataTable tranvcce = new System.Data.DataTable();
                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString))
                {
                    System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                    connSource.Open();
                    
                    //更新資料
                    string queryString =
                    @"
                    insert into workjbk(qtime,noa,[site],datea,odate,custno,cust,nick,tagcolor,trantype,chktype
	                    ,worker,worker2,memo,ordeaccy,ordeno,mount,[weight],lengthb,tolerance,trantype1,trantype2)
                    select GETDATE(),@noa,@site,@datea,@odate,@custno,@cust,@nick,@tagcolor,@trantype,@chktype
	                    ,@worker,@worker2,@memo,@ordeaccy,@ordeno,@mount,@weight,@lengthb,@tolerance,@trantype1,@trantype2;
                    declare @sel int = SCOPE_IDENTITY() select @sel";
                    
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                    
                    cmd.Parameters.AddWithValue("@noa", item.bbm.noa);
                    cmd.Parameters.AddWithValue("@site", item.bbm.site);
                    cmd.Parameters.AddWithValue("@datea", item.bbm.datea);
                    cmd.Parameters.AddWithValue("@odate", item.bbm.odate);
                    cmd.Parameters.AddWithValue("@custno", item.bbm.custno);
                    cmd.Parameters.AddWithValue("@cust", item.bbm.cust);
                    cmd.Parameters.AddWithValue("@nick", item.bbm.nick);
                    cmd.Parameters.AddWithValue("@tagcolor", item.bbm.tagcolor);
                    cmd.Parameters.AddWithValue("@trantype", item.bbm.trantype);
                    cmd.Parameters.AddWithValue("@chktype", item.bbm.chktype);
                    cmd.Parameters.AddWithValue("@worker", item.bbm.worker);
                    cmd.Parameters.AddWithValue("@worker2", item.bbm.worker2);
                    cmd.Parameters.AddWithValue("@memo", item.bbm.memo);
                    cmd.Parameters.AddWithValue("@ordeaccy", item.bbm.ordeaccy);
                    cmd.Parameters.AddWithValue("@ordeno", item.bbm.ordeno);
                    cmd.Parameters.AddWithValue("@mount", item.bbm.mount);
                    cmd.Parameters.AddWithValue("@weight", item.bbm.weight);
                    cmd.Parameters.AddWithValue("@lengthb", item.bbm.lengthb);
                    cmd.Parameters.AddWithValue("@tolerance", item.bbm.tolerance);
                    cmd.Parameters.AddWithValue("@trantype1", item.bbm.trantype1);
                    cmd.Parameters.AddWithValue("@trantype2", item.bbm.trantype2);
                    int sel = Convert.ToInt32(cmd.ExecuteScalar());
                    queryString =
                    @"insert into workjsbk(sel,noa,noq,productno,product,lengthb,mount,[weight],memo,picno
	                    ,imgpara,imgdata,imgbarcode,contno,contnoq,mech1,mech2,mech3,mech4,mech5
	                    ,place1,place2,place3,place4,place5,time1,time2,time3,time4,time5
	                    ,paraa,parab,parac,parad,parae,paraf,worker1,worker2,worker3,worker4,worker5
	                    ,place,cmount,cweight)
                      select @sel,@noa,@noq,@productno,@product,@lengthb,@mount,@weight,@memo,@picno
	                    ,@imgpara,@imgdata,@imgbarcode,@contno,@contnoq,@mech1,@mech2,@mech3,@mech4,@mech5
	                    ,@place1,@place2,@place3,@place4,@place5,@time1,@time2,@time3,@time4,@time5
	                    ,@paraa,@parab,@parac,@parad,@parae,@paraf,@worker1,@worker2,@worker3,@worker4,@worker5
	                    ,@place,@cmount,@cweight";
                    for (int i = 0; i < item.bbs.Length; i++)
                    {
                        cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                        cmd.Parameters.AddWithValue("@sel", sel);
                        cmd.Parameters.AddWithValue("@noa", item.bbs[i].noa);
                        cmd.Parameters.AddWithValue("@noq", item.bbs[i].noq);
                        cmd.Parameters.AddWithValue("@productno", item.bbs[i].productno);
                        cmd.Parameters.AddWithValue("@product", item.bbs[i].product);
                        cmd.Parameters.AddWithValue("@lengthb", item.bbs[i].lengthb);
                        cmd.Parameters.AddWithValue("@mount", item.bbs[i].mount);
                        cmd.Parameters.AddWithValue("@weight", item.bbs[i].weight);
                        cmd.Parameters.AddWithValue("@memo", item.bbs[i].memo);
                        cmd.Parameters.AddWithValue("@picno", item.bbs[i].picno);
                        cmd.Parameters.AddWithValue("@imgpara", item.bbs[i].imgpara);
                        cmd.Parameters.AddWithValue("@imgdata", item.bbs[i].imgdata);
                        cmd.Parameters.AddWithValue("@imgbarcode", item.bbs[i].imgbarcode);
                        cmd.Parameters.AddWithValue("@contno", item.bbs[i].contno);
                        cmd.Parameters.AddWithValue("@contnoq", item.bbs[i].contnoq);
                        cmd.Parameters.AddWithValue("@mech1", item.bbs[i].mech1);
                        cmd.Parameters.AddWithValue("@mech2", item.bbs[i].mech2);
                        cmd.Parameters.AddWithValue("@mech3", item.bbs[i].mech3);
                        cmd.Parameters.AddWithValue("@mech4", item.bbs[i].mech4);
                        cmd.Parameters.AddWithValue("@mech5", item.bbs[i].mech5);
                        cmd.Parameters.AddWithValue("@place1", item.bbs[i].place1);
                        cmd.Parameters.AddWithValue("@place2", item.bbs[i].place2);
                        cmd.Parameters.AddWithValue("@place3", item.bbs[i].place3);
                        cmd.Parameters.AddWithValue("@place4", item.bbs[i].place4);
                        cmd.Parameters.AddWithValue("@place5", item.bbs[i].place5);
                        cmd.Parameters.AddWithValue("@time1", item.bbs[i].time1);
                        cmd.Parameters.AddWithValue("@time2", item.bbs[i].time2);
                        cmd.Parameters.AddWithValue("@time3", item.bbs[i].time3);
                        cmd.Parameters.AddWithValue("@time4", item.bbs[i].time4);
                        cmd.Parameters.AddWithValue("@time5", item.bbs[i].time5);
                        cmd.Parameters.AddWithValue("@paraa", item.bbs[i].paraa);
                        cmd.Parameters.AddWithValue("@parab", item.bbs[i].parab);
                        cmd.Parameters.AddWithValue("@parac", item.bbs[i].parac);
                        cmd.Parameters.AddWithValue("@parad", item.bbs[i].parad);
                        cmd.Parameters.AddWithValue("@parae", item.bbs[i].parae);
                        cmd.Parameters.AddWithValue("@paraf", item.bbs[i].paraf);
                        cmd.Parameters.AddWithValue("@worker1", item.bbs[i].worker1);
                        cmd.Parameters.AddWithValue("@worker2", item.bbs[i].worker2);
                        cmd.Parameters.AddWithValue("@worker3", item.bbs[i].worker3);
                        cmd.Parameters.AddWithValue("@worker4", item.bbs[i].worker4);
                        cmd.Parameters.AddWithValue("@worker5", item.bbs[i].worker5);
                        cmd.Parameters.AddWithValue("@place", item.bbs[i].place);
                        cmd.Parameters.AddWithValue("@cmount", item.bbs[i].cmount);
                        cmd.Parameters.AddWithValue("@cweight", item.bbs[i].cweight);
                        cmd.ExecuteNonQuery();
                    }
                    connSource.Close();
                }
                Response.Write("");
            }
            catch (Exception e) {
                Response.Write(e.Message);
            }
        }
    
    </script>
