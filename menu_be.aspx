<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			$(document).ready(function() {
				q_getId();
				q_gf('', 'menu_be');
			});

			var t_permit;
			var r_rank = '9';
			function q_gfPost() {
				document.title = 'ERP系統選單';
				$('#userno').text(r_userno);
				$('#rname').text(r_name);
				
				
				$('.leftbox a').each(function() {
					child = $(this).attr('id');
					auth_child = $(this).attr('id');
					
					//取得讀取權限
					var t_permit=false;
					if (auth_child) {
						for (var i = 0; i < q_auth.length; i++){
							if (auth_child == q_auth[i].substr(0, auth_child.length)) {
								t_permit = q_auth[i].substr(auth_child.length + 1, 1) == '1' ? true : false;
								break;
							}
						}
					}
					
					//外部廠商開放的網頁id
					//var outs_aspx=['z_vcc_be'];
					
					//處理開放網頁
					if(child!='download'){
						if (r_rank < 8 && !t_permit){ //沒有執行權限
							//$(this).parent().remove();
						}else{//有權限
							$(this).click(function() {
								window.open($(this).attr('class')+".aspx?"+q_getId()[0]+";"+q_getId()[1]+";"+q_getId()[2]+";;"+q_getId()[4]);
							});
						}
					}else{
						/*if(r_outs==1){
							$(this).parent().remove();
						}*/
					}
				});
				
				$('.leftbox ol li ').each(function(index) {
					if($(this).html().indexOf('</a>')==-1){
						$(this).remove();
					}
				});

			}

			function q_gtPost(t_name) {
				switch (t_name) {

				}
			}

			function q_boxClose(s2) {
			}
		</script>
		<style type="text/css">
			.leftbox {
				float: left;
				width: 400px;
				/*padding:15px 30px;*/
			}
			.righttbox {
				float: left;
				width: 800px;
				/*padding:15px 30px;*/
			}
			
			ol {
			  list-style-type: none;
			  margin: 0;
			  padding: 0.3em;
			  margin-left: 2em;
			}
			
			ol > li {
			  display: table;
			  margin-bottom: 0.6em;
			}
			
			ol > li:before {
			  display: table-cell;
			  padding-right: 0.6em;    
			}
			
			li ol > li {
			  margin: 0;
			}
			
			.leftbox a{
				cursor: pointer;
				color: #0300FA;
				text-decoration:underline;
			}
			
			.leftbox a:hover { 
			    color: #FA0300;
			}

		</style>
	</head>
	<body>
		<div id="q_menu"> </div>
		<div style="width:1250px;height: 800px;">
			<div style="width:1250px;height: 30px;"> </div>
			<div style="width:1250px;height: 30px;">
				<a style="font-size: 20px;">ERP系統選單</a>
			</div>
			<div class="leftbox" style="height: 700px;">
				<ol>
					<li>1.　作業選單
						<ol>
							<li>1.1　<a id="cust" class="cust_be">客戶主檔</a></li>
							<li>1.2　<a id="vcc" class="vcc_be">銷售作業</a></li>
							<li>1.3　<a id="z_vcc_be" class="z_vcc_be">銷售報表</a></li>
						</ol>
					</li>
					<li>2.　其他工具程式
						<ol>
							<li>2.1　<a id="z_drun" class="z_drun">使用紀錄查詢</a></li>
							<li>2.2　<a id="dmess" class="dmess">訊息發送作業</a></li>
							<li>2.3　<a id="nhpe" class="nhpe">員工密碼設定</a></li>
							<li>2.4　<a id="quser" class="quser">ip帳號登入控管</a></li>
							<li>2.5　<a id="download" href="http://59.125.143.170/g.exe">連線程式下載</a></li>
						</ol>
					</li>
				</ol>
			</div>
			<div class="righttbox top" style="height:80%;">
			</div>
			<div class="righttbox bottom" style="height:20%;text-align: right">
				<table style="float: right;">
					<tr align="right">
						<td  align="center"><a id="userno"> </a></td>
						<td  align="center"><a id="rname"> </a></td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>


