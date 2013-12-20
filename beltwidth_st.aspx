<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'bandwidth');
				$('#q_report').hide();
				$('.prt').hide();
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'bandwidth',
					options : []
				});
				q_popAssign();
				q_langShow();
				$('#btnXauthority').click(function(e) {
					$('#btnAuthority').click();
				});
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {  
				}
			}
			
			function q_funcPost(t_func, result) {
			}

			function q_boxClose(t_name) {
			}
			
		</script>
	</head>
	<style>
		*{
			font-size:medium;
		}
		td{
			width:100px;
			border:1px solid #000;
			text-align:center;
		}
		.stList{
		}
		.tdleft{
			padding-left:2px;
			border-top:none;
			border-left:none;
			border-right:none;
			text-align:left;
		}
		.tdright{
			padding-right:2px;
			border-top:none;
			border-left:none;
			border-right:none;
			text-align:right;
		}
		.tdcenter{
			border-top:none;
			border-left:none;
			border-right:none;
			text-align:center;
		}
		.divleft{
			float:left;
			padding-left:2px;
		}
		.divright{
			float:right;
			padding-right:2px;
		}
		.noborder{
			border:none;
			width:30px;
		}
		.trsepart{
			height:15px;
		}
		.td1{
			width:70px;
			border-right:none;
			border-top:none;
		}
		.td2{
			border-right:none;
			border-top:none;
		}
		.td3{
			border-right:none;
			border-top:none;
		}
		.td4{
			border-right:none;
			border-top:none;
		}
		.td5{
			border-top:none;
		}
		.trhead1{
			height:30px;
		}
		.trhead2{
		}
		.trhead3{
		}
		.trhead4{
		}
		.trcontent{
		}
		.out{
			border-top:40px #D6D3D6 solid;
			width:0px;
			height:0px;
			border-left:80px #BDBABD solid;
			position:relative;
		}
		.sA{
			font-style:normal;
			display:block;
			position:absolute;
			top:-40px;
			left:-40px;
			width:35px;
		}
		.sB{
			font-style:normal;
			display:block;
			position:absolute;
			top: -20px;
			left: -80px;
			width: 40px;
		}
	</style>
	<body ondragstart="return false" draggable="false"
		ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
		ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
		ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	 >
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div id="TableList">
				<table class="stList" border="0" cellpadding='0' cellspacing='0'>
					<tr class="trhead1">
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">1/2"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
						<td class="noborder"></td>
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">3/4"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
					</tr>
					<tr class="trhead2">
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
						<td class="noborder"></td>
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
					</tr>
					<tr class="trhead3">
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>21.7</td>
						<td class="td3"><sup>ø</sup>21.3</td>
						<td class="td4"><sup>ø</sup>21.4</td>
						<td class="td5"><sup>ø</sup>21.2</td>
						<td class="noborder"></td>
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>27.2</td>
						<td class="td3"><sup>ø</sup>26.7</td>
						<td class="td4"><sup>ø</sup>26.9</td>
						<td class="td5"><sup>ø</sup>26.7</td>
					</tr>
					<tr class="trhead4">
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
						<td class="noborder"></td>
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">1.2</td>
						<td class="td2">67.5</td>
						<td class="td3">66.5</td>
						<td class="td4">67.0</td>
						<td class="td5">66.0</td>
						<td class="noborder"></td>
						<td class="td1">1.2</td>
						<td class="td2">85.0</td>
						<td class="td3">83.5</td>
						<td class="td4">84.0</td>
						<td class="td5">83.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">1.6</td>
						<td class="td2">66.5</td>
						<td class="td3">66.5</td>
						<td class="td4">66.0</td>
						<td class="td5">65.0</td>
						<td class="noborder"></td>
						<td class="td1">1.6</td>
						<td class="td2">84.0</td>
						<td class="td3">82.5</td>
						<td class="td4">83.0</td>
						<td class="td5">83.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.0</td>
						<td class="td2">66.0</td>
						<td class="td3">64.5</td>
						<td class="td4">65.0</td>
						<td class="td5">64.5</td>
						<td class="noborder"></td>
						<td class="td1">2.0</td>
						<td class="td2">83.0</td>
						<td class="td3">81.5</td>
						<td class="td4">82.0</td>
						<td class="td5">82.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.3</td>
						<td class="td2">65.0</td>
						<td class="td3">64.0</td>
						<td class="td4">64.5</td>
						<td class="td5">64.0</td>
						<td class="noborder"></td>
						<td class="td1">2.3</td>
						<td class="td2">82.5</td>
						<td class="td3">81.0</td>
						<td class="td4">81.5</td>
						<td class="td5">81.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.6</td>
						<td class="td2">64.5</td>
						<td class="td3">63.5</td>
						<td class="td4">64.0</td>
						<td class="td5">63.0</td>
						<td class="noborder"></td>
						<td class="td1">2.6</td>
						<td class="td2">82.0</td>
						<td class="td3">80.5</td>
						<td class="td4">81.0</td>
						<td class="td5">80.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.8</td>
						<td class="td2">64.0</td>
						<td class="td3">63.0</td>
						<td class="td4">63.5</td>
						<td class="td5">62.5</td>
						<td class="noborder"></td>
						<td class="td1">2.8</td>
						<td class="td2">81.5</td>
						<td class="td3">80.0</td>
						<td class="td4">80.5</td>
						<td class="td5">80.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.2</td>
						<td class="td2">63.0</td>
						<td class="td3">62.0</td>
						<td class="td4">62.5</td>
						<td class="td5">62.0</td>
						<td class="noborder"></td>
						<td class="td1">3.2</td>
						<td class="td2">80.0</td>
						<td class="td3">79.0</td>
						<td class="td4">79.5</td>
						<td class="td5">79.0</td>
					</tr>
					<tr class="trsepart"><td class="noborder" colspan="11"><hr></td></tr>
					<tr class="trhead1">
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">1"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
						<td class="noborder"></td>
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">1-1/4"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
					</tr>
					<tr class="trhead2">
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
						<td class="noborder"></td>
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
					</tr>
					<tr class="trhead3">
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>34.0</td>
						<td class="td3"><sup>ø</sup>33.4</td>
						<td class="td4"><sup>ø</sup>33.8</td>
						<td class="td5"><sup>ø</sup>33.5</td>
						<td class="noborder"></td>
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>42.7</td>
						<td class="td3"><sup>ø</sup>42.1</td>
						<td class="td4"><sup>ø</sup>42.5</td>
						<td class="td5"><sup>ø</sup>42.2</td>
					</tr>
					<tr class="trhead4">
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
						<td class="noborder"></td>
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">1.2</td>
						<td class="td2">106.5</td>
						<td class="td3">104.5</td>
						<td class="td4">105.5</td>
						<td class="td5">104.5</td>
						<td class="noborder"></td>
						<td class="td1">1.2</td>
						<td class="td2">133.5</td>
						<td class="td3">131.5</td>
						<td class="td4">133.0</td>
						<td class="td5">132.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">1.6</td>
						<td class="td2">105.5</td>
						<td class="td3">103.5</td>
						<td class="td4">104.5</td>
						<td class="td5">104.0</td>
						<td class="noborder"></td>
						<td class="td1">1.6</td>
						<td class="td2">132.5</td>
						<td class="td3">131.0</td>
						<td class="td4">132.0</td>
						<td class="td5">131.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.0</td>
						<td class="td2">104.5</td>
						<td class="td3">102.5</td>
						<td class="td4">103.5</td>
						<td class="td5">103.0</td>
						<td class="noborder"></td>
						<td class="td1">2.0</td>
						<td class="td2">132.0</td>
						<td class="td3">130.0</td>
						<td class="td4">131.5</td>
						<td class="td5">130.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.3</td>
						<td class="td2">104.0</td>
						<td class="td3">102.0</td>
						<td class="td4">103.0</td>
						<td class="td5">102.5</td>
						<td class="noborder"></td>
						<td class="td1">2.3</td>
						<td class="td2">131.0</td>
						<td class="td3">129.5</td>
						<td class="td4">130.5</td>
						<td class="td5">129.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.6</td>
						<td class="td2">103.5</td>
						<td class="td3">101.5</td>
						<td class="td4">102.5</td>
						<td class="td5">101.5</td>
						<td class="noborder"></td>
						<td class="td1">2.6</td>
						<td class="td2">130.5</td>
						<td class="td3">128.5</td>
						<td class="td4">130.0</td>
						<td class="td5">129.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.8</td>
						<td class="td2">103.0</td>
						<td class="td3">101.0</td>
						<td class="td4">102.0</td>
						<td class="td5">101.0</td>
						<td class="noborder"></td>
						<td class="td1">2.8</td>
						<td class="td2">130.0</td>
						<td class="td3">128.0</td>
						<td class="td4">129.5</td>
						<td class="td5">128.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.2</td>
						<td class="td2">102.0</td>
						<td class="td3">100.0</td>
						<td class="td4">101.0</td>
						<td class="td5">100.5</td>
						<td class="noborder"></td>
						<td class="td1">3.2</td>
						<td class="td2">129.0</td>
						<td class="td3">127.5</td>
						<td class="td4">128.5</td>
						<td class="td5">127.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.6</td>
						<td class="td2">101.5</td>
						<td class="td3">99.5</td>
						<td class="td4">100.5</td>
						<td class="td5">99.5</td>
						<td class="noborder"></td>
						<td class="td1">3.6</td>
						<td class="td2">128.5</td>
						<td class="td3">126.5</td>
						<td class="td4">127.5</td>
						<td class="td5">127.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.0</td>
						<td class="td2">100.5</td>
						<td class="td3">98.5</td>
						<td class="td4">99.5</td>
						<td class="td5">98.5</td>
						<td class="noborder"></td>
						<td class="td1">4.0</td>
						<td class="td2">127.5</td>
						<td class="td3">125.5</td>
						<td class="td4">127.0</td>
						<td class="td5">126.0</td>
					</tr>
					<tr class="trsepart"><td class="noborder" colspan="11"><hr></td></tr>
					<tr class="trhead1">
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">1-1/2"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
						<td class="noborder"></td>
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">2"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
					</tr>
					<tr class="trhead2">
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
						<td class="noborder"></td>
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
					</tr>
					<tr class="trhead3">
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>48.6</td>
						<td class="td3"><sup>ø</sup>48.3</td>
						<td class="td4"><sup>ø</sup>48.4</td>
						<td class="td5"><sup>ø</sup>48.1</td>
						<td class="noborder"></td>
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>60.5</td>
						<td class="td3"><sup>ø</sup>60.3</td>
						<td class="td4"><sup>ø</sup>60.3</td>
						<td class="td5"><sup>ø</sup>59.9</td>
					</tr>
					<tr class="trhead4">
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
						<td class="noborder"></td>
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">1.2</td>
						<td class="td2">152.0</td>
						<td class="td3">151.0</td>
						<td class="td4">151.5</td>
						<td class="td5">150.5</td>
						<td class="noborder"></td>
						<td class="td1">1.6</td>
						<td class="td2">188.5</td>
						<td class="td3">188.0</td>
						<td class="td4">188.0</td>
						<td class="td5">187.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">1.6</td>
						<td class="td2">151.0</td>
						<td class="td3">150.5</td>
						<td class="td4">150.5</td>
						<td class="td5">150.0</td>
						<td class="noborder"></td>
						<td class="td1">2.0</td>
						<td class="td2">188.0</td>
						<td class="td3">187.0</td>
						<td class="td4">187.0</td>
						<td class="td5">186.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.0</td>
						<td class="td2">150.5</td>
						<td class="td3">149.5</td>
						<td class="td4">150.0</td>
						<td class="td5">149.5</td>
						<td class="noborder"></td>
						<td class="td1">2.3</td>
						<td class="td2">187.0</td>
						<td class="td3">186.5</td>
						<td class="td4">186.5</td>
						<td class="td5">186.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.3</td>
						<td class="td2">150.0</td>
						<td class="td3">149.0</td>
						<td class="td4">149.0</td>
						<td class="td5">149.0</td>
						<td class="noborder"></td>
						<td class="td1">2.6</td>
						<td class="td2">186.5</td>
						<td class="td3">186.0</td>
						<td class="td4">186.0</td>
						<td class="td5">184.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.6</td>
						<td class="td2">149.0</td>
						<td class="td3">148.0</td>
						<td class="td4">148.5</td>
						<td class="td5">147.5</td>
						<td class="noborder"></td>
						<td class="td1">3.2</td>
						<td class="td2">185.0</td>
						<td class="td3">184.5</td>
						<td class="td4">184.5</td>
						<td class="td5">183.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.8</td>
						<td class="td2">148.5</td>
						<td class="td3">147.5</td>
						<td class="td4">148.0</td>
						<td class="td5">147.0</td>
						<td class="noborder"></td>
						<td class="td1">4.0</td>
						<td class="td2">183.5</td>
						<td class="td3">183.0</td>
						<td class="td4">183.0</td>
						<td class="td5">181.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.2</td>
						<td class="td2">148.0</td>
						<td class="td3">147.0</td>
						<td class="td4">147.5</td>
						<td class="td5">146.5</td>
						<td class="noborder"></td>
						<td class="td1">4.5</td>
						<td class="td2">182.0</td>
						<td class="td3">181.5</td>
						<td class="td4">181.5</td>
						<td class="td5">180.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.8</td>
						<td class="td2">147.0</td>
						<td class="td3">146.0</td>
						<td class="td4">146.5</td>
						<td class="td5">145.5</td>
						<td class="noborder"></td>
						<td class="td1">5.4</td>
						<td class="td2">180.5</td>
						<td class="td3">180.0</td>
						<td class="td4">180.0</td>
						<td class="td5">178.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.0</td>
						<td class="td2">146.0</td>
						<td class="td3">145.0</td>
						<td class="td4">145.5</td>
						<td class="td5">144.5</td>
						<td class="noborder"></td>
						<td class="td1 noborder"></td>
						<td class="td2 noborder"></td>
						<td class="td3 noborder"></td>
						<td class="td4 noborder"></td>
						<td class="td5 noborder"></td>
					</tr>
					<tr class="trsepart"><td class="noborder" colspan="11"><hr></td></tr>
					<tr class="trhead1">
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">2-1/2"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
						<td class="noborder"></td>
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">3"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
					</tr>
					<tr class="trhead2">
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
						<td class="noborder"></td>
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
					</tr>
					<tr class="trhead3">
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>76.3</td>
						<td class="td3"><sup>ø</sup>73.0</td>
						<td class="td4"><sup>ø</sup>76.0</td>
						<td class="td5"><sup>ø</sup>75.6</td>
						<td class="noborder"></td>
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>89.1</td>
						<td class="td3"><sup>ø</sup>88.9</td>
						<td class="td4"><sup>ø</sup>88.8</td>
						<td class="td5"><sup>ø</sup>88.3</td>
					</tr>
					<tr class="trhead4">
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
						<td class="noborder"></td>
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.0</td>
						<td class="td2">237.5</td>
						<td class="td3">227.0</td>
						<td class="td4">236.5</td>
						<td class="td5">235.0</td>
						<td class="noborder"></td>
						<td class="td1">2.3</td>
						<td class="td2">277.0</td>
						<td class="td3">276.5</td>
						<td class="td4">276.0</td>
						<td class="td5">275.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.3</td>
						<td class="td2">236.5</td>
						<td class="td3">226.5</td>
						<td class="td4">236.0</td>
						<td class="td5">235.0</td>
						<td class="noborder"></td>
						<td class="td1">2.6</td>
						<td class="td2">276.5</td>
						<td class="td3">275.5</td>
						<td class="td4">275.5</td>
						<td class="td5">274.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.6</td>
						<td class="td2">236.0</td>
						<td class="td3">226.0</td>
						<td class="td4">235.0</td>
						<td class="td5">235.0</td>
						<td class="noborder"></td>
						<td class="td1">3.2</td>
						<td class="td2">275.0</td>
						<td class="td3">274.5</td>
						<td class="td4">274.0</td>
						<td class="td5">272.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.2</td>
						<td class="td2">235.0</td>
						<td class="td3">224.5</td>
						<td class="td4">234.0</td>
						<td class="td5">232.5</td>
						<td class="noborder"></td>
						<td class="td1">4.0</td>
						<td class="td2">273.0</td>
						<td class="td3">272.5</td>
						<td class="td4">272.0</td>
						<td class="td5">270.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.0</td>
						<td class="td2">233.0</td>
						<td class="td3">222.5</td>
						<td class="td4">232.0</td>
						<td class="td5">231.0</td>
						<td class="noborder"></td>
						<td class="td1">4.5</td>
						<td class="td2">272.0</td>
						<td class="td3">271.5</td>
						<td class="td4">271.0</td>
						<td class="td5">269.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.5</td>
						<td class="td2">232.0</td>
						<td class="td3">221.5</td>
						<td class="td4">231.0</td>
						<td class="td5">230.0</td>
						<td class="noborder"></td>
						<td class="td1">5.4</td>
						<td class="td2">270.0</td>
						<td class="td3">269.5</td>
						<td class="td4">269.0</td>
						<td class="td5">267.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">5.4</td>
						<td class="td2">230.0</td>
						<td class="td3">219.5</td>
						<td class="td4">229.0</td>
						<td class="td5">228.0</td>
						<td class="noborder"></td>
						<td class="td1">6.0</td>
						<td class="td2">269.0</td>
						<td class="td3">268.5</td>
						<td class="td4">268.0</td>
						<td class="td5">266.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">6.0</td>
						<td class="td2">228.5</td>
						<td class="td3">218.0</td>
						<td class="td4">227.5</td>
						<td class="td5">226.5</td>
						<td class="noborder"></td>
						<td class="td1 noborder"></td>
						<td class="td2 noborder"></td>
						<td class="td3 noborder"></td>
						<td class="td4 noborder"></td>
						<td class="td5 noborder"></td>
					</tr>
					<tr class="trsepart"><td class="noborder" colspan="11"><hr></td></tr>
					<tr class="trhead1">
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">3-1/2"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
						<td class="noborder"></td>
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">4"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
					</tr>
					<tr class="trhead2">
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
						<td class="noborder"></td>
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
					</tr>
					<tr class="trhead3">
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>102.1</td>
						<td class="td3"><sup>ø</sup>101.6</td>
						<td class="td4"><sup>ø</sup>101.0</td>
						<td class="td5"><sup>ø</sup>100.7</td>
						<td class="noborder"></td>
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>114.8</td>
						<td class="td3"><sup>ø</sup>114.3</td>
						<td class="td4"><sup>ø</sup>114.1</td>
						<td class="td5"><sup>ø</sup>113.5</td>
					</tr>
					<tr class="trhead4">
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
						<td class="noborder"></td>
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.4</td>
						<td class="td2">317.5</td>
						<td class="td3">316.0</td>
						<td class="td4">314.0</td>
						<td class="td5">315.0</td>
						<td class="noborder"></td>
						<td class="td1">2.4</td>
						<td class="td2">357.5</td>
						<td class="td3">356.0</td>
						<td class="td4">355.5</td>
						<td class="td5">355.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.6</td>
						<td class="td2">317.0</td>
						<td class="td3">315.5</td>
						<td class="td4">313.5</td>
						<td class="td5">314.0</td>
						<td class="noborder"></td>
						<td class="td1">2.6</td>
						<td class="td2">357.0</td>
						<td class="td3">355.5</td>
						<td class="td4">355.0</td>
						<td class="td5">354.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">2.8</td>
						<td class="td2">316.5</td>
						<td class="td3">315.0</td>
						<td class="td4">313.0</td>
						<td class="td5">313.5</td>
						<td class="noborder"></td>
						<td class="td1">2.8</td>
						<td class="td2">356.5</td>
						<td class="td3">355.0</td>
						<td class="td4">354.5</td>
						<td class="td5">354.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.0</td>
						<td class="td2">316.0</td>
						<td class="td3">314.5</td>
						<td class="td4">312.5</td>
						<td class="td5">313.0</td>
						<td class="noborder"></td>
						<td class="td1">3.0</td>
						<td class="td2">356.0</td>
						<td class="td3">354.5</td>
						<td class="td4">354.0</td>
						<td class="td5">353.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.2</td>
						<td class="td2">315.5</td>
						<td class="td3">314.0</td>
						<td class="td4">312.0</td>
						<td class="td5">312.5</td>
						<td class="noborder"></td>
						<td class="td1">3.2</td>
						<td class="td2">355.5</td>
						<td class="td3">354.0</td>
						<td class="td4">353.5</td>
						<td class="td5">353.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.5</td>
						<td class="td2">315.0</td>
						<td class="td3">313.5</td>
						<td class="td4">311.5</td>
						<td class="td5">312.0</td>
						<td class="noborder"></td>
						<td class="td1">3.5</td>
						<td class="td2">355.0</td>
						<td class="td3">353.5</td>
						<td class="td4">353.0</td>
						<td class="td5">351.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.8</td>
						<td class="td2">314.5</td>
						<td class="td3">313.0</td>
						<td class="td4">311.0</td>
						<td class="td5">311.5</td>
						<td class="noborder"></td>
						<td class="td1">3.8</td>
						<td class="td2">354.5</td>
						<td class="td3">353.0</td>
						<td class="td4">352.5</td>
						<td class="td5">350.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.0</td>
						<td class="td2">314.0</td>
						<td class="td3">312.5</td>
						<td class="td4">310.5</td>
						<td class="td5">311.0</td>
						<td class="noborder"></td>
						<td class="td1">4.0</td>
						<td class="td2">354.0</td>
						<td class="td3">352.5</td>
						<td class="td4">352.0</td>
						<td class="td5">350.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.2</td>
						<td class="td2">313.5</td>
						<td class="td3">312.0</td>
						<td class="td4">310.0</td>
						<td class="td5">310.5</td>
						<td class="noborder"></td>
						<td class="td1">4.2</td>
						<td class="td2">353.5</td>
						<td class="td3">352.0</td>
						<td class="td4">351.5</td>
						<td class="td5">349.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.5</td>
						<td class="td2">313.0</td>
						<td class="td3">311.5</td>
						<td class="td4">309.5</td>
						<td class="td5">310.0</td>
						<td class="noborder"></td>
						<td class="td1">4.5</td>
						<td class="td2">353.0</td>
						<td class="td3">351.0</td>
						<td class="td4">350.5</td>
						<td class="td5">348.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">5.0</td>
						<td class="td2">312.0</td>
						<td class="td3">310.5</td>
						<td class="td4">308.5</td>
						<td class="td5">307.5</td>
						<td class="noborder"></td>
						<td class="td1">5.0</td>
						<td class="td2">352.0</td>
						<td class="td3">350.0</td>
						<td class="td4">349.5</td>
						<td class="td5">347.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">5.4</td>
						<td class="td2">311.0</td>
						<td class="td3">309.5</td>
						<td class="td4">307.5</td>
						<td class="td5">306.5</td>
						<td class="noborder"></td>
						<td class="td1">5.4</td>
						<td class="td2">351.0</td>
						<td class="td3">349.0</td>
						<td class="td4">348.5</td>
						<td class="td5">347.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">6.0</td>
						<td class="td2">309.5</td>
						<td class="td3">308.0</td>
						<td class="td4">306.0</td>
						<td class="td5">305.0</td>
						<td class="noborder"></td>
						<td class="td1">6.0</td>
						<td class="td2">349.5</td>
						<td class="td3">348.0</td>
						<td class="td4">347.5</td>
						<td class="td5">345.5</td>
					</tr>
					<tr class="trsepart"><td class="noborder" colspan="11"><hr></td></tr>
					<tr class="trhead1">
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">5"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
						<td class="noborder"></td>
						<td class="tdleft" colspan="2">±公差1mm</td>
						<td class="tdcenter">6"</td>
						<td class="tdright" colspan="2">單位：m/m</td>
					</tr>
					<tr class="trhead2">
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
						<td class="noborder"></td>
						<td class="td1">規格</td>
						<td class="td2">JIS G3452</td>
						<td class="td3">ASTM A53A</td>
						<td class="td4">BSM BSB</td>
						<td class="td5">BSA</td>
					</tr>
					<tr class="trhead3">
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>139.8</td>
						<td class="td3"><sup>ø</sup>141.3</td>
						<td class="td4"><sup>ø</sup>139.6</td>
						<td class="td5"><sup>ø</sup>139.5</td>
						<td class="noborder"></td>
						<td class="td1">外徑</td>
						<td class="td2"><sup>ø</sup>165.2</td>
						<td class="td3"><sup>ø</sup>168.3</td>
						<td class="td4"><sup>ø</sup>165.1</td>
						<td class="td5"><sup>ø</sup>164.9</td>
					</tr>
					<tr class="trhead4">
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
						<td class="noborder"></td>
						<td class="td1">
							<div class="out"><span class="sA">帶寬</span><span class="sB">管厚</span></div>
						</td>
						<td class="td2">W S</td>
						<td class="td3">W S</td>
						<td class="td4">W S</td>
						<td class="td5">W S</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.0</td>
						<td class="td2">435.0</td>
						<td class="td3">439.5</td>
						<td class="td4">434.0</td>
						<td class="td5">435.0</td>
						<td class="noborder"></td>
						<td class="td1">3.2</td>
						<td class="td2">514.0</td>
						<td class="td3">524.0</td>
						<td class="td4">513.5</td>
						<td class="td5">515.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.2</td>
						<td class="td2">434.5</td>
						<td class="td3">439.0</td>
						<td class="td4">433.5</td>
						<td class="td5">433.0</td>
						<td class="noborder"></td>
						<td class="td1">3.5</td>
						<td class="td2">513.5</td>
						<td class="td3">523.0</td>
						<td class="td4">513.0</td>
						<td class="td5">512.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.5</td>
						<td class="td2">433.5</td>
						<td class="td3">438.5</td>
						<td class="td4">433.0</td>
						<td class="td5">432.5</td>
						<td class="noborder"></td>
						<td class="td1">3.8</td>
						<td class="td2">513.0</td>
						<td class="td3">522.5</td>
						<td class="td4">514.0</td>
						<td class="td5">512.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">3.8</td>
						<td class="td2">433.0</td>
						<td class="td3">438.0</td>
						<td class="td4">432.5</td>
						<td class="td5">432.0</td>
						<td class="noborder"></td>
						<td class="td1">4.0</td>
						<td class="td2">512.5</td>
						<td class="td3">522.0</td>
						<td class="td4">513.5</td>
						<td class="td5">511.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.0</td>
						<td class="td2">432.5</td>
						<td class="td3">437.5</td>
						<td class="td4">432.0</td>
						<td class="td5">431.5</td>
						<td class="noborder"></td>
						<td class="td1">4.2</td>
						<td class="td2">512.0</td>
						<td class="td3">521.5</td>
						<td class="td4">511.5</td>
						<td class="td5">511.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.2</td>
						<td class="td2">432.0</td>
						<td class="td3">437.0</td>
						<td class="td4">431.5</td>
						<td class="td5">431.0</td>
						<td class="noborder"></td>
						<td class="td1">4.5</td>
						<td class="td2">511.0</td>
						<td class="td3">521.0</td>
						<td class="td4">510.5</td>
						<td class="td5">509.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">4.5</td>
						<td class="td2">431.5</td>
						<td class="td3">436.0</td>
						<td class="td4">431.0</td>
						<td class="td5">431.5</td>
						<td class="noborder"></td>
						<td class="td1">4.8</td>
						<td class="td2">510.5</td>
						<td class="td3">520.5</td>
						<td class="td4">510.0</td>
						<td class="td5">509.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">5.0</td>
						<td class="td2">430.0</td>
						<td class="td3">435.0</td>
						<td class="td4">429.5</td>
						<td class="td5">429.0</td>
						<td class="noborder"></td>
						<td class="td1">5.0</td>
						<td class="td2">510.0</td>
						<td class="td3">520.0</td>
						<td class="td4">509.5</td>
						<td class="td5">509.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">5.4</td>
						<td class="td2">429.5</td>
						<td class="td3">434.0</td>
						<td class="td4">429.0</td>
						<td class="td5">428.5</td>
						<td class="noborder"></td>
						<td class="td1">5.4</td>
						<td class="td2">509.0</td>
						<td class="td3">519.0</td>
						<td class="td4">508.5</td>
						<td class="td5">508.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">6.0</td>
						<td class="td2">428.0</td>
						<td class="td3">433.0</td>
						<td class="td4">427.5</td>
						<td class="td5">427.5</td>
						<td class="noborder"></td>
						<td class="td1">6.0</td>
						<td class="td2">508.0</td>
						<td class="td3">517.5</td>
						<td class="td4">507.5</td>
						<td class="td5">507.0</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">6.6</td>
						<td class="td2">427.0</td>
						<td class="td3">431.5</td>
						<td class="td4">426.0</td>
						<td class="td5">425.5</td>
						<td class="noborder"></td>
						<td class="td1">6.6</td>
						<td class="td2">506.5</td>
						<td class="td3">516.5</td>
						<td class="td4">506.0</td>
						<td class="td5">505.5</td>
					</tr>
					<tr class="trcontent">
						<td class="td1">7.0</td>
						<td class="td2">426.0</td>
						<td class="td3">430.5</td>
						<td class="td4">425.5</td>
						<td class="td5">425.0</td>
						<td class="noborder"></td>
						<td class="td1">7.0</td>
						<td class="td2">505.5</td>
						<td class="td3">515.5</td>
						<td class="td4">505.0</td>
						<td class="td5">504.5</td>
					</tr>

				<!--

					<tr class="trcontent">
						<td class="td1"></td>
						<td class="td2"></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
						<td class="noborder"></td>
						<td class="td1"></td>
						<td class="td2"></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>

				-->
				</table>
			</div>
			<div class="prt" style="margin-left: -40px;">
			<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>