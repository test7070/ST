<%@ Page Language="C#" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title>upload</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src="../script/qbox.js" type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
            var q_name = 'uploadimg';
            var tname=window.parent.q_name;
			var tnoa=q_getHref()[1];
            $(document).ready(function () {
                _q_boxClose();
                q_getId();
                q_gf('', 'uploadimg');
                
                $('#btnAuthority').click(function () {
                    btnAuthority(q_name);
                });
                
                $('#btnDele1').click(function() {
                	if(tnoa!=undefined && (tname=='ucc' || tname=='uca' || tname=='ucx')){
                		if(confirm('確認刪除圖片1?')){
                			q_func('qtxt.query.deleimg', 'uploadimg.txt,deleimg,'+ encodeURI(tnoa)+ ';'+encodeURI(tname)+ ';01');
                		}
                	}
				});
				$('#btnDele2').click(function() {
                	if(tnoa!=undefined && (tname=='ucc' || tname=='uca' || tname=='ucx')){
                		if(confirm('確認刪除圖片2?')){
                			q_func('qtxt.query.deleimg', 'uploadimg.txt,deleimg,'+ encodeURI(tnoa)+ ';'+encodeURI(tname)+ ';02');
                		}
                	}
				});
				$('#btnDele3').click(function() {
                	if(tnoa!=undefined && (tname=='ucc' || tname=='uca' || tname=='ucx')){
                		if(confirm('確認刪除圖片3?')){
	                		q_func('qtxt.query.deleimg', 'uploadimg.txt,deleimg,'+ encodeURI(tnoa)+ ';'+encodeURI(tname)+ ';03');
	                	}
                	}
				});
				$('#btnDele4').click(function() {
                	if(tnoa!=undefined && (tname=='ucc' || tname=='uca' || tname=='ucx')){
                		if(confirm('確認刪除圖片4?')){
                			q_func('qtxt.query.deleimg', 'uploadimg.txt,deleimg,'+ encodeURI(tnoa)+ ';'+encodeURI(tname)+ ';04');
                		}
                	}
				});
				$('#btnDele5').click(function() {
                	if(tnoa!=undefined && (tname=='ucc' || tname=='uca' || tname=='ucx')){
                		if(confirm('確認刪除圖片5?')){
                			q_func('qtxt.query.deleimg', 'uploadimg.txt,deleimg,'+ encodeURI(tnoa)+ ';'+encodeURI(tname)+ ';05');
                		}
                	}
				});
				$('#btnDele6').click(function() {
                	if(tnoa!=undefined && (tname=='ucc' || tname=='uca' || tname=='ucx')){
                		if(confirm('確認刪除圖片6?')){
	                		q_func('qtxt.query.deleimg', 'uploadimg.txt,deleimg,'+ encodeURI(tnoa)+ ';'+encodeURI(tname)+ ';06');
	                	}
                	}
				});
				
				$('#btnDeleall').click(function() {
					if(tnoa!=undefined && (tname=='ucc' || tname=='uca' || tname=='ucx')){
	                	if(confirm('確認刪除全部圖片?')){
	                		q_func('qtxt.query.deleimgall', 'uploadimg.txt,deleimgall,'+ encodeURI(tnoa)+ ';'+encodeURI(tname));
	                	}
	                }
				});
                
            });

            function q_gfPost() {
                q_langShow();
            }
            
            function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.deleimg':
						alert('圖片已刪除完畢!!');
						break
					case 'qtxt.query.deleimgall':
						alert('圖片全部已刪除完畢!!');
						break;
					default:
						break;
				}
			}
	</script>
    <script language="c#" runat="server">
        public void Page_Load()
        {
            Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            byte[] bCrLf = { 0xd, 0xa };// \r\n
   
            string savepath = "D:\\t\\";
			
			Response.Write("<div id='q_menu'></div>");
			Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			Response.Write("<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>");
			Response.Write("<p>&nbsp;</p>");
            Response.Write("<div>");
            Response.Write("<form name=\"form1\" method=\"post\" enctype=\"multipart/form-data\" style=\"width:500px;\">");
            Response.Write("<a style='margin-right: 10px;'>圖片1</a><span></span><input type=\"file\" name=\"btnFile1\" style='font-size: medium;'/><input type=\"button\" id=\"btnDele1\" value='刪除' style='font-size: medium;'/><P>");
            Response.Write("<a style='margin-right: 10px;'>圖片2</a><span></span><input type=\"file\" name=\"btnFile2\" style='font-size: medium;'/><input type=\"button\" id=\"btnDele2\" value='刪除' style='font-size: medium;'/><P>");
            Response.Write("<a style='margin-right: 10px;'>圖片3</a><span></span><input type=\"file\" name=\"btnFile3\" style='font-size: medium;'/><input type=\"button\" id=\"btnDele3\" value='刪除' style='font-size: medium;'/><P>");
            Response.Write("<a style='margin-right: 10px;'>圖片4</a><span></span><input type=\"file\" name=\"btnFile4\" style='font-size: medium;'/><input type=\"button\" id=\"btnDele4\" value='刪除' style='font-size: medium;'/><P>");
            Response.Write("<a style='margin-right: 10px;'>圖片5</a><span></span><input type=\"file\" name=\"btnFile5\" style='font-size: medium;'/><input type=\"button\" id=\"btnDele5\" value='刪除' style='font-size: medium;'/><P>");
            Response.Write("<a style='margin-right: 10px;'>圖片6</a><span></span><input type=\"file\" name=\"btnFile6\" style='font-size: medium;'/><input type=\"button\" id=\"btnDele6\" value='刪除' style='font-size: medium;'/><P><BR>");
            Response.Write("<input type=\"submit\" name=\"btnUpload\" value=\"upload\"  style='font-size: medium;'/>");
            Response.Write("</form>");
            Response.Write("</div>");
        	string uri = Request.Url.ToString();
        	string noa =uri.Split(';')[3].Split('=')[1].Replace("'","");   
            //Response.Write(noa);
            
            if (formSize == 0)
            {
                return;
            }       
            //origin
            string origin = encoding.GetString(formData);
            // sign
            int nSign = IndexOf(formData, bCrLf);
            if (nSign == -1)
            {
                Response.Write("<br>" + "Error_1: token sign error!" + "</br>");
                return;
            }
            byte[] sign = new byte[nSign];
            Array.ConstrainedCopy(formData, 0, sign, 0, nSign);
            string cSign = encoding.GetString(sign);
            byte[] signStr = new byte[nSign + 2];
            Array.ConstrainedCopy(sign, 0, signStr, 0, nSign);
            Array.ConstrainedCopy(bCrLf, 0, signStr, nSign, 2);
            string cSignStr = encoding.GetString(signStr);
            byte[] signEnd = new byte[nSign+2];
            Array.ConstrainedCopy(sign, 0, signEnd, 0, nSign);
            Array.ConstrainedCopy((new byte[] {0x2d, 0x2d}), 0, signEnd, nSign, 2);//add --
            string cSignEnd = encoding.GetString(signEnd);
            
            Array[] item = new Array[2];
            ArrayList items = new ArrayList();
            
            byte[] temp = new byte[formData.Length];
            byte[] temp2 = null;
            byte[] temp3 = null;
            int str,end;
            Array.ConstrainedCopy(formData, 0, temp, 0, temp.Length);
            try
            {
                while (true)
                {
                    if (IndexOf(temp, sign) == -1)
                        break;
                    else
                    {
                        str = IndexOf(temp, signStr);
                        if (str == -1)
                        {
                            //Response.Write("<br>end</br>");     
                            break;
                        }
                        
                        temp2 = new byte[temp.Length - (str + signStr.Length)];
                        Array.ConstrainedCopy(temp, str + signStr.Length,temp2, 0, temp2.Length);
                        end = IndexOf(temp2, signStr);
                        end = (end == -1 ? IndexOf(temp2, signEnd) : end);
                        if (end == -1)
                        {
                            Response.Write("<br>Struct error!</br>");
                            break;
                        }
                        item = new Array[2];
                        temp3 = new byte[end];
                        Array.ConstrainedCopy(temp2, 0, temp3, 0, temp3.Length);
                        str = IndexOf(temp3, (new byte[] { 0xd, 0xa, 0xd, 0xa }));
                        item[0] = new byte[str];
                        Array.ConstrainedCopy(temp3, 0, item[0], 0, item[0].Length);
                        item[1] = new byte[temp3.Length - (str + 4)-2];
                        Array.ConstrainedCopy(temp3, str + 4, item[1], 0, item[1].Length);
                        items.Add(item);
                        
                        temp = new byte[temp2.Length-end];
                        Array.ConstrainedCopy(temp2, end, temp, 0, temp.Length);                  
                    }
                }
                
                IEnumerator e = items.GetEnumerator();
                int nCount = 0;
                while (e.MoveNext())
                {
                    Array[] obj = (Array[])e.Current;
                    string header = encoding.GetString((byte[])obj[0]);
                    int nFileNameStr = header.IndexOf("filename=\"") + 10;
                    if (nFileNameStr >= 10)
                    {
                    	nCount++;
                        string path = header.Substring(nFileNameStr, header.IndexOf("\"", nFileNameStr) - nFileNameStr);
                        string filename = System.IO.Path.GetFileName(path);
                        if (filename.Length != 0)
                        {
                        	filename =System.IO.Path.GetFileName(path);
                        	string extension = filename.Split('.')[filename.Split('.').Length-1];
                        	string filename2 = noa+"_"+("00"+nCount).Substring(("00"+nCount).Length-2)+"."+extension;
                        	
                            try
                            {
                                System.IO.FileStream fs = new System.IO.FileStream(savepath + filename2, System.IO.FileMode.OpenOrCreate);
                                System.IO.BinaryWriter w = new System.IO.BinaryWriter(fs);
                                w.Write((byte[])obj[1]);
                                w.Close();
                                fs.Close();

                                Response.Write("<br>" + filename2 + "  upload finish!" + "</br>");
                            }
                            catch (System.Exception se)
                            {
                                Response.Write("<br>" + se.Message + "</br>");
                            }
                        }
                    }
                }
                
                string url = Request.UrlReferrer.ToString();
				Response.Redirect("uploadimg_post.aspx"+ ( url.IndexOf("?") > 0 ?  url.Substring( url.IndexOf("?")) : ""));   ///
            }
            catch (System.Exception e)
            {
                Response.Write("<br>" + e.Message + "</br>");
            }  
        }

        public int IndexOf(byte[] ByteArrayToSearch, byte[] ByteArrayToFind)
        {
            Encoding encoding = Encoding.ASCII;
            string toSearch = encoding.GetString(ByteArrayToSearch, 0, ByteArrayToSearch.Length);
            string toFind = encoding.GetString(ByteArrayToFind, 0, ByteArrayToFind.Length);
            int result = toSearch.IndexOf(toFind, StringComparison.Ordinal);
            return result;
        }
    </script>
</head>
<body>

</body>
</html>
