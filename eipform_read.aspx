<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public void Page_Load()
		{
			string files = "";
			if (Request.QueryString["files"] != null && Request.QueryString["files"].Length > 0)
            {
                files = Request.QueryString["files"];
                
                string path = "";
                string filepath = "";
                
	            if (Request.QueryString["filepath"] != null && Request.QueryString["filepath"] != "#non" && Request.QueryString["filepath"].Length > 0)
	            {
	                filepath = Request.QueryString["filepath"];
	                path = filepath + files+ @".htm";
	            }else{
                	path = @"F:\doc\eipform\htm\" + files+ @".htm";
				}
			
				if (System.IO.File.Exists(path))
			    {
			        string readText = System.IO.File.ReadAllText(path,System.Text.Encoding.Default);
			        Response.Write(readText);
			    }
			    else
			    {
			        Response.Write("No file!");
			    }
            }
		}
    </script>
