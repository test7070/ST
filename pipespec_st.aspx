<!doctype html>
<html>
	<head>
		<meta charset="utf-8" />
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
				q_gf('', 'pipespec');
				$('#q_report').hide();
				$('.prt').hide();
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'pipespec',
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
		<style>
			table{
				border:0px;
			}
			.center{
				text-align:center;
			}
			.end{
				border-right:1px solid #000;
			}
			td{
				border:1px solid #000;
				border-bottom:none;
				border-right:none;
				width:9%;
				padding-left:3px;
				height:22px;
			}
			.lasttr td{
				border-bottom:1px solid #000;
			}
		</style>
	</head>
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
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="4" class="center">圓管</td>
						<td colspan="4" class="center end">方管</td>
					</tr>
					<tr>
						<td class="center">尺寸</td>
						<td class="center">黑皮<br>(m/m)</td>
						<td class="center">鋅板<br>(m/m)</td>
						<td> </td>
						<td class="center">尺寸<br>(m/m)</td>
						<td class="center">黑皮<br>(m/m)</td>
						<td class="center">鋅板<br>(m/m)</td>
						<td class="end"> </td>
					</tr>
					<tr>
						<td>
						    <span style="display:block;width:10px;float:left;">&nbsp;</span>
						    <a>1/2"</a>
						</td>
						<td>
						    <span style="display:block;width:5px;float:left;">&nbsp;</span>
						    <span style="display:block;width:30px;float:left;">1.2</span>
						    <span style="display:block;width:10px;float:left;">~</span>
						    <span style="display:block;width:5px;float:left;">&nbsp;</span>
						    <span style="display:block;width:30px;float:left;">3.0</span>
						</td>
						<td>
						    <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.0</span>
                        </td>
						<td></td>
						<td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>38 x 38</a>
                        </td>
						<td>
						    <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.2</span>
						</td>
						<td>
						    <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.2</span>
						</td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>3/4"</a>
                        </td>
						<td>
						    <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.0</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.0</span>
                        </td>
						<td></td>
						<td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>100 x 100</a>
                        </td>
						<td>
						    <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>1"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.0</span>
                        </td>
						<td>
						    <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.0</span>
                        </td>
						<td></td>
						<td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>125 x 75</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>1-1/4"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.2</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.2</span>
                        </td>
						<td></td>
						<td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>125 x 125</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>1-1/2"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.2</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.2</span>
                        </td>
						<td></td>
						<td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>150 x 100</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>2"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.2</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.2</span>
                        </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>2-1/2"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>3"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>3-1/2"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
                        <td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>4"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
                        <td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>5"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
                        <td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>6"</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">6.0</span>
                        </td>
                        <td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.95</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">4.0</span>
                        </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>19.1(m/m)</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.0</span>
                        </td>
                        <td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.0</span>
                        </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="end"></td>
					</tr>
					<tr>
					    <td>
                            <span style="display:block;width:10px;float:left;">&nbsp;</span>
                            <a>25.4(m/m)</a>
                        </td>
						<td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.0</span>
                        </td>
                        <td>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">1.2</span>
                            <span style="display:block;width:10px;float:left;">~</span>
                            <span style="display:block;width:5px;float:left;">&nbsp;</span>
                            <span style="display:block;width:30px;float:left;">3.0</span>
                        </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="end"></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="end"> </td>
					</tr>
					<tr class="lasttr">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="end"> </td>
					</tr>
				</table>
			</div>
			<div class="prt" style="margin-left: -40px;">
			<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>