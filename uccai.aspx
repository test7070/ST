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
					['txtCustno', 'lblCust', 'cust', 'noa,comp,startdate', 'txtCustno,txtComp,txtStartdate', 'cust_b.aspx'],
					['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
				);
				
                q_popAssign();
                q_langShow();
					
				$('#txtBdate').mask(r_picd);
				$('#txtEdate').mask(r_picd);
				$('#txtMon').mask(r_picm);
				$('#txtStartdate').mask('99');
                    
				$('#txtBdate').val(q_date().substr(0,r_lenm)+'/01');
				$('#txtEdate').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
                
                $('#checkCustorde').change(function(e) {
					if($('#checkCustorde').prop('checked')){
						q_box("ordes_b2_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where
						, 'ordes_xy', "95%", "650px", q_getMsg('popOrde'));
							
					}else{
						$('#txtCustorde').val('');
					}
				});
                
                $('#btnGenvcca').click(function(e) {
					
				});
				
				$('#txtStartdate').focusout(function() {
					if($(this).val()=='01' || $(this).val()=='00' || $(this).val().length==0 || $(this).val().length==1){
						$('#txtBdate').val(q_date().substr(0,r_lenm)+'/01');
						$('#txtEdate').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
					}else{
						$('#txtBdate').val(q_cdn(q_date().substr(0,r_lenm)+'/01',-1).substr(0,r_lenm)+'/'+$('#txtStartdate').val());
						$('#txtEdate').val(q_cdn(q_date().substr(0,r_lenm)+'/'+$('#txtStartdate').val(),-1));
					}
				});
				
				$('#btnXauthority').click(function(e) {
					$('#btnAuthority').click();
				});
				
				var SeekF= new Array();
				$('#uccai td').children("input:text").each(function() {
					SeekF.push($(this).attr('id'));
				});
								
				$('#uccai td').children("input:text").each(function() {
					$(this).mousedown(function(e) {
						$(this).focus();
						$(this).select();
						});
										
					$(this).bind('keydown', function(event) {
						keypress_bbm(event, $(this), SeekF, SeekF[$.inArray($(this).attr('id'),SeekF)+1]);	
					});
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
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:500px">
					<tr>
						<td align="center"><a id="lblCust" class="lbl" style="font-size: medium;"> </a></td>
						<td colspan="4">
							<input id="txtCustno"  type="text"  class="txt" style="width: 30%; font-size: medium;"/>
							<input id="txtComp"  type="text"  class="txt" style="width: 65%; font-size: medium;" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td align="center"><a id="lblSales" class="lbl" style="font-size: medium;"> </a></td>
						<td colspan="4">
							<input id="txtSalesno"  type="text"  class="txt" style="width: 30%; font-size: medium;"/>
							<input id="txtSales"  type="text"  class="txt" style="width: 65%; font-size: medium;" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td style="width:75px;" align="center"><a id="lblStartdate" class="lbl" style="font-size: medium;"> </a></td>
						<td style="width:40px;"><input id="txtStartdate"  type="text"  class="txt" style="width: 33px; font-size: medium;"/></td>
						<td style="width:80px;" align="center"><a id="lblDatea" class="lbl" style="font-size: medium;"> </a></td>
						<td style="width:200px">
							<input id="txtBdate"  type="text" class="txt" style="width: 85px; font-size: medium;"/>~
							<input id="txtEdate"  type="text" class="txt" style="width: 85px; font-size: medium;"/>
						</td>
						<td align="center" style="width:75px;">
							<input id='checkCustorde' type="checkbox">
							<a id="lblCustorde" class="lbl" style="font-size: medium;"> </a>　
						</td>
					</tr>
					
					<tr>
						<td align="center" colspan="5">
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