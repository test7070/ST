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
				$('#txtMon').val(q_date().substr(0,r_lenm));
				$('[name=xradio]').first().prop('checked',true)
				$('#txtBdate').removeAttr('disabled');
				$('#txtEdate').removeAttr('disabled');
				$('#txtStartdate').attr('disabled', 'disabled');
                
                $('#checkCustorde').change(function(e) {
					if($('#checkCustorde').prop('checked')){
						q_box("ordes_b2_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where
						, 'ordes_xy', "95%", "650px", q_getMsg('popOrde'));
							
					}else{
						$('#txtCustorde').val('');
					}
				});
                
                $('#btnGenvcca').click(function(e) {
                	var t_salesno='#non';
					var t_custno='#non';
					var t_mon='#non';
					var t_bdate='#non';
					var t_edate='#non';
					var t_startdate='#non';
					var t_radio=$('[name=xradio]:checked').val();
                	
                	if($.trim($('#txtMon').val()).length==0 && t_radio=='2'){
                		alert('【月結】方式帳款月份禁止空白!!')
                		return;
                	}
                						
					if($.trim($('#txtSalesno').val()).length>0){t_salesno=$.trim($('#txtSalesno').val());}
					if($.trim($('#txtCustno').val()).length>0){t_custno=$.trim($('#txtCustno').val());}
					if($.trim($('#txtMon').val()).length>0){t_mon=$.trim($('#txtMon').val());}
					
					if(t_radio=='1'){
						if($.trim($('#txtBdate').val()).length>0){t_bdate=$.trim($('#txtBdate').val());}
						if($.trim($('#txtEdate').val()).length>0){t_edate=$.trim($('#txtEdate').val());}
					}
					if(t_radio=='2'){
						if($.trim($('#txtStartdate').val()).length>0){t_startdate=$.trim($('#txtStartdate').val());}
					}
					
					q_func('qtxt.query.vccamon', 'cust_ucc_xy.txt,vccamon,' 
					+ encodeURI(t_salesno) + ';' + encodeURI(t_custno) + ';' + encodeURI(t_mon) + ';' + encodeURI(t_bdate)+ ';' + encodeURI(t_edate) 
					+ ';' + encodeURI(t_startdate) + ';' + encodeURI(t_radio) + ';' + encodeURI(r_userno) + ';' + encodeURI(r_name));
					
					$('#btnGenvcca').attr('disabled', 'disabled');
				});
				
				/*$('#txtStartdate').focusout(function() {
					if($(this).val()=='01' || $(this).val()=='00' || $(this).val().length==0 || $(this).val().length==1){
						$('#txtBdate').val(q_date().substr(0,r_lenm)+'/01');
						$('#txtEdate').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
					}else{
						$('#txtBdate').val(q_cdn(q_date().substr(0,r_lenm)+'/01',-1).substr(0,r_lenm)+'/'+$('#txtStartdate').val());
						$('#txtEdate').val(q_cdn(q_date().substr(0,r_lenm)+'/'+$('#txtStartdate').val(),-1));
					}
				});*/
				
				$('[name=xradio]').change(function() {
					if($('[name=xradio]:checked').val()=='1'){
						$('#txtBdate').removeAttr('disabled');
						$('#txtEdate').removeAttr('disabled');
						$('#txtStartdate').attr('disabled', 'disabled');
					}else if($('[name=xradio]:checked').val()=='2'){
						$('#txtStartdate').removeAttr('disabled');
						$('#txtBdate').attr('disabled', 'disabled');
						$('#txtEdate').attr('disabled', 'disabled');
					}else{
						$('#txtStartdate').attr('disabled', 'disabled');
						$('#txtBdate').attr('disabled', 'disabled');
						$('#txtEdate').attr('disabled', 'disabled');
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
            	switch (t_name) {  
                	case 'qtxt.query.vccamon':
                		var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if(as[0].t_err){
								alert(as[0].t_err);
							}else{
								var t_where="1=1 and (noa between '"+as[0].binvono+"' and '"+as[0].einvono+"') ";
								if(as[0].radio=='1')
									t_where=t_where+" and [type]='W' "
								if(as[0].radio=='2')
									t_where=t_where+" and [type]='M' "
								else
									t_where=t_where+" and [type]='P' "
								
								q_box("vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcca', "95%", "95%", $('#btnGenvcca').val());
							}
							$('#btnGenvcca').removeAttr('disabled');
						}else{
							alert('開立發票失敗，請聯絡工程師!!');
						}
                		break;
                }
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
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:500px;">
					<tr>
						<td align="center" style="width:85px;"><a id="lblSales" class="lbl" style="font-size: medium;"> </a></td>
						<td colspan="3">
							<input id="txtSalesno"  type="text"  class="txt" style="width: 30%; font-size: medium;"/>
							<input id="txtSales"  type="text"  class="txt" style="width: 65%; font-size: medium;" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td align="center"><a id="lblCust" class="lbl" style="font-size: medium;"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text"  class="txt" style="width: 30%; font-size: medium;"/>
							<input id="txtComp"  type="text"  class="txt" style="width: 65%; font-size: medium;" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td align="center"><a id="lblMon" class="lbl" style="font-size: medium;"> </a></td>
						<td colspan="3"><input id="txtMon"  type="text"  class="txt" style="width: 90px; font-size: medium;"/></td>
					</tr>
					<tr>
						<td align="center"><input name="xradio" type="radio" value="1">週結</td>
						<td align="center"><a id="lblDatea" class="lbl" style="font-size: medium;"> </a></td>
						<td colspan="2">
							<input id="txtBdate"  type="text" class="txt" style="width: 90px; font-size: medium;"/>~
							<input id="txtEdate"  type="text" class="txt" style="width: 90px; font-size: medium;"/>
						</td>
					</tr>
					<tr>
						<td align="center"><input name="xradio" type="radio" value="2">月結</td>
						<td style="width:85px;" align="center"><a id="lblStartdate" class="lbl" style="font-size: medium;"> </a></td>
						<td style="width:200px;"><input id="txtStartdate"  type="text"  class="txt" style="width: 33px; font-size: medium;"/></td>
					</tr>
					<tr>
						<td align="center"><input name="xradio" type="radio" value="3">PO&nbsp;&nbsp;&nbsp;</td>
						<td colspan="3"> </td>
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