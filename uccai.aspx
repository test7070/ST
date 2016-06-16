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
                q_gf('', 'uccai');
                
                $('#q_report').hide();
                $('.prt').hide();
            });
            function q_gfPost() {
                $('#q_report').q_report({
					fileName : 'uccai',
					options : []
				});
				
				aPop = new Array(
					['textCustno', 'lblCust', 'cust', 'noa,comp,nick,tel,invoicetitle', 'textCustno,textComp', 'cust_b.aspx'],
					['textSalesno', 'lblSales', 'sss', 'noa,namea', 'textSalesno,textSales', 'sss_b.aspx']
				);
				
                q_popAssign();
                q_langShow();
					
				$('#textBdate').mask(r_picd);
				$('#textEdate').mask(r_picd);
				$('#textMon').mask(r_picm);
				$('#textStartdate').mask('99');
                    
				$('#textBdate').val(q_date().substr(0,r_lenm)+'/01');
				$('#textEdate').val(q_date());
                
                $('#checkCustorde').change(function(e) {
					if($('#checkCustorde').prop('checked')){
						q_box("ordes_b2_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where
						, 'ordes_xy', "95%", "650px", q_getMsg('popOrde'));
							
					}else{
						$('#textCustorde').val('');
					}
				});
                
                $('#btnGenvcca').click(function(e) {
					
				});
				
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
	
<body ondragstart="return false" draggable="false"
        ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
        ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
		<div id="q_menu"> </div>
		<div id='q_acDiv'> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<input id="btnXauthority" type="button" style="float:left; width:80px;font-size: medium;"/>
			<div id="uccai">
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:400px">
					<tr>
						<td style="width:30%" align="center"><a id="lblDatea" class="lbl" style="font-size: medium;"> </a></td>
						<td style="width:70%" colspan="3">
							<input id="textBdate"  type="text" class="txt" style="width: 40%; font-size: medium;"/>~
							<input id="textEdate"  type="text" class="txt" style="width: 40%; font-size: medium;"/>
						</td>
					</tr>
					<tr>
						<td style="width:30%" align="center"><a id="lblMon" class="lbl" style="font-size: medium;"> </a></td>
						<td style="width:30%"><input id="textMon"  type="text"  class="txt" style="width: 95%; font-size: medium;"/></td>
						<td style="width:20%" align="center"><a id="lblStartdate" class="lbl" style="font-size: medium;"> </a></td>
						<td style="width:20%"><input id="textStartdate"  type="text"  class="txt" style="width: 95%; font-size: medium;"/></td>
					</tr>
					<tr>
						<td align="center"><a id="lblCust" class="lbl" style="font-size: medium;"> </a></td>
						<td colspan="3">
							<input id="textCustno"  type="text"  class="txt" style="width: 30%; font-size: medium;"/>
							<input id="textComp"  type="text"  class="txt" style="width: 65%; font-size: medium;"/>
						</td>
					</tr>
					<tr>
						<td align="center"><a id="lblSales" class="lbl" style="font-size: medium;"> </a></td>
						<td colspan="3">
							<input id="textSalesno"  type="text"  class="txt" style="width: 30%; font-size: medium;"/>
							<input id="textSales"  type="text"  class="txt" style="width: 65%; font-size: medium;"/>
						</td>
					</tr>
					<tr>
						<td align="center">
							<input id='checkCustorde' type="checkbox">
							<a id="lblCustorde" class="lbl" style="font-size: medium;"> </a>　
						</td>
						<td colspan="3"><input id="textCustorde"  type="text"  class="txt" style="width: 98%; font-size: medium;" disabled="disabled"/></td>
					</tr>
					<tr>
						<td align="center" colspan="4">
							<input id="btnGenvcca" type="button" style="font-size: medium;"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>