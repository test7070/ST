<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
		    $(document).ready(function () {
		        _q_boxClose();
		        q_getId();
		        q_gf('', 'uploadimg');

                q_func('etc.watch', "a")
		    });
		    function q_funcPost( func,result) {
		        $('#txtMessage').text("已上傳!!");
		    }
		    function q_gfPost() {
		        q_langShow();
		    }
		</script>
	</head>
<body>
    <div id='q_menu'></div>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <span id='txtMessage' style="font-weight: 700; font-size: x-large; color: #0000FF">圖片上傳中.....，請勿再上傳檔案，會容易造成當機</span>
    <p>&nbsp;</p>
</body>
</html>
