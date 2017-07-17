﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            var q_name = "ordest_s";
			aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,nick', 'txtCustno', 'cust_b.aspx']
			 ,['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno', 'sss_b.aspx']);
            $(document).ready(function() {
                main();
            });
            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBtrandate', r_picd], ['txtEtrandate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbKind", '@全部,'+q_getPara('sys.stktype'));
                q_cmbParse("cmbStype", '@全部,'+q_getPara('orde.stype'));
                q_cmbParse("cmbEnda", '@全部,1@已結案,0@未結案');
                q_cmbParse("cmbApv", '@全部,1@已核准,0@未核准');
                $('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
                $('#txtNoa').focus();
                /*$('#txtEdime').val(99999);
                $('#txtEwidth').val(99999);
                $('#txtElengthb').val(99999);
                $('#txtEradius').val(99999);*/
                
                if(q_getPara('sys.comp').substring(0,2)=="傑期")
		        {
		        	$('.pk').show();
		        }
            }
            function q_seekStr() {
            	t_kind = $.trim($('#cmbKind').val());
            	t_stype = $.trim($('#cmbStype').val());
            	t_enda = $.trim($('#cmbEnda').val());
            	t_apv = $.trim($('#cmbApv').val());
                t_noa = $.trim($('#txtNoa').val());
		        t_custno = $.trim($('#txtCustno').val());
		        t_comp = $.trim($('#txtComp').val());
		        t_uno = $.trim($('#txtUno').val());
		        t_salesno = $.trim($('#txtSalesno').val());
				t_custorde = $.trim($('#txtCustorde').val());
							
		        t_bdate = $('#txtBdate').val();
		        t_edate = $('#txtEdate').val();
		        
		        t_bdime = q_float('txtBdime');
		        t_edime = q_float('txtEdime');
				t_bwidth = q_float('txtBwidth');
				t_ewidth = q_float('txtEwidth');
				t_blengthb = q_float('txtBlengthb');
				t_elengthb = q_float('txtElengthb');
				t_bradius = q_float('txtBradius');
		        t_eradius = q_float('txtEradius');
				
				t_custpro = $.trim($('#txtCustpro').val());
				
		        var t_where = " 1=1 " 
		        + q_sqlPara2("kind", t_kind)
		        + q_sqlPara2("stype", t_stype)
		        + q_sqlPara2("noa", t_noa) 
		        + q_sqlPara2("datea", t_bdate, t_edate)     
		        + q_sqlPara2("custno", t_custno)
		        + q_sqlPara2("salesno", t_salesno);
		        
		        if(q_getPara('sys.comp').substring(0,2)=="傑期")
		        {
		        	//2016/02/17 改模糊查詢
		        	if (t_custorde.length>0)
                    	t_where += " and charindex('" + t_custorde + "',custorde)>0";
                    
		        	//t_where += q_sqlPara2("custorde", t_custorde);
		        }
		        
		        if(t_apv=='1')
		        	t_where += " and len(isnull(apv,''))>0";
		        if(t_apv=='0')
		        	t_where += " and len(isnull(apv,''))=0";
		        if (t_comp.length>0)
                    t_where += " and charindex('" + t_comp + "',comp)>0";
				if(t_uno.length>0)
		       		t_where += " and exists(select noa from view_ordet"+r_accy+" where view_ordet"+r_accy+".noa=view_orde"+r_accy+".noa and view_ordet"+r_accy+".uno='"+t_uno+"')";
		       	if(t_enda=='0'){
		       		t_where += " and (enda=0 and exists(select noa from view_ordes"+r_accy+" where view_ordes"+r_accy+".noa=view_orde"+r_accy+".noa and view_ordes"+r_accy+".enda=0))";
		       	}
		       	if(t_enda=='1'){
		       		t_where += " and (enda=1 or exists(select noa from view_ordes"+r_accy+" where view_ordes"+r_accy+".noa=view_orde"+r_accy+".noa and view_ordes"+r_accy+".enda=1))";
		       	}
		       	if(t_bdime!=0){
		       		t_where += " and ( not exists(select top 1 noa from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa) or " 
		       		+" (exists (select * from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa "
		       		+" and isnull(view_ordes"+r_accy+".dime,0) >= "+t_bdime+")))";
		       	}
		       	if(t_edime!=0){
		       		t_where += " and ( not exists(select top 1 noa from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa) or " 
		       		+" (exists (select * from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa "
		       		+" and isnull(view_ordes"+r_accy+".dime,0) <= "+t_edime+")))";
		       	}
		       	if(t_bwidth!=0){
		       		t_where += " and ( not exists(select top 1 noa from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa) or " 
		       		+" (exists (select * from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa "
		       		+" and isnull(view_ordes"+r_accy+".width,0) >= "+t_bwidth+")))";
		       	}
		       	if(t_ewidth!=0){
		       		t_where += " and ( not exists(select top 1 noa from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa) or " 
		       		+" (exists (select * from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa "
		       		+" and isnull(view_ordes"+r_accy+".width,0) <= "+t_ewidth+")))";
		       	}
		       	if(t_blengthb!=0){
		       		t_where += " and ( not exists(select top 1 noa from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa) or " 
		       		+" (exists (select * from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa "
		       		+" and isnull(view_ordes"+r_accy+".lengthb,0) >= "+t_blengthb+")))";
		       	}
		       	if(t_elengthb!=0){
		       		t_where += " and ( not exists(select top 1 noa from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa) or " 
		       		+" (exists (select * from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa "
		       		+" and isnull(view_ordes"+r_accy+".lengthb,0) <= "+t_elengthb+")))";
		       	}
		       	if(t_bradius!=0){
		       		t_where += " and ( not exists(select top 1 noa from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa) or " 
		       		+" (exists (select * from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa "
		       		+" and isnull(view_ordes"+r_accy+".radius,0) >= "+t_bradius+")))";
		       	}
		       	if(t_eradius=0){
		       		t_where += " and ( not exists(select top 1 noa from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa) or " 
		       		+" (exists (select * from view_ordes"+r_accy+" where view_orde"+r_accy+".noa=view_ordes"+r_accy+".noa "
		       		+" and isnull(view_ordes"+r_accy+".radius,0) <= "+t_eradius+")))";
		       	}
		       	if(t_custpro.length>0){
		       		t_where += " and exists(select noa from view_ordes"+r_accy+" where view_ordes"+r_accy+".noa=view_orde"+r_accy+".noa and view_ordes"+r_accy+".custpro='"+t_custpro+"')";
		       	}
		        t_where = ' where=^^' + t_where + '^^ ';
		        return t_where;
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblStype'> </a></td>
					<td><select id="cmbStype" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblKind'> </a></td>
					<td><select id="cmbKind" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblEnda'> </a></td>
					<td><select id="cmbEnda" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblApv'> </a></td>
					<td><select id="cmbApv" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
					<td>
					<input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'></a></td>
					<td>
					<input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblSalesno'></a></td>
                    <td>
                    <input class="txt" id="txtSalesno" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblUno'></a></td>
					<td>
					<input class="txt" id="txtUno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDime'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdime" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdime" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblWidth'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBwidth" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEwidth" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblLengthb'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBlengthb" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtElengthb" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblRadius'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBradius" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEradius" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr pk' style="display:none;">
					<td class='seek'  style="width:20%;"><a id='lblCustorde'></a></td>
					<td><input class="txt" id="txtCustorde" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr pk' style="display:none;">
					<td class='seek'  style="width:20%;"><a id='lblCustpro'>客戶產編</a></td>
					<td><input class="txt" id="txtCustpro" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>