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
            var q_name = "ordb_s";
            aPop = new Array(
            	['txtTggno', 'lblTggno', 'tgg', 'noa,nick', 'txtTggno', 'tgg_b.aspx']
            	,['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick,invoicetitle,serial', 'txtCustno', 'cust_b.aspx']
            );
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
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBodate', r_picd], ['txtEodate', r_picd]];
                q_mask(bbmMask);
                switch(q_getPara('sys.project').toUpperCase()){
                	case 'PK':
                		q_cmbParse("cmbKind", '@全部,'+q_getPara('sys.stktype')+',1@物料');
                		break;
            		default:
                		q_cmbParse("cmbKind", '@全部,'+q_getPara('ordc.kind'));
                		break;
                }
                q_cmbParse("cmbTrantype",  '@全部,'+q_getPara('sys.tran'));
                $('#txtBdate').datepicker();
                $('#txtEdate').datepicker(); 
                $('#txtBodate').datepicker();
                $('#txtEodate').datepicker(); 
                $('#txtNoa').focus();
                
                if(q_getPara('sys.project').toUpperCase()=='XY'){
                	$('.ordeno').show();
                	$('.cust').show();
                	$('.trantype').show();
                }
            }

            function q_seekStr() {
                t_kind = $.trim($('#cmbKind').val());
                t_noa = $.trim($('#txtNoa').val());
                t_tggno = $.trim($('#txtTggno').val());
                t_comp = $.trim($('#txtComp').val());
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_bodate = $('#txtBodate').val();
                t_eodate = $('#txtEodate').val();
                t_ordeno = $('#txtOrdeno').val();
                t_custno = $('#txtCustno').val();
                t_cust = $('#txtCust').val();
                t_trantype = $('#cmbTrantype').val();
                
                var t_where = " 1=1 " 
                + q_sqlPara2("noa", t_noa) 
                + q_sqlPara2("datea", t_bdate, t_edate)
                + q_sqlPara2("odate", t_bodate, t_eodate)    
                + q_sqlPara2("trantype", t_trantype)        
                + q_sqlPara2("tggno", t_tggno);
                if (t_kind.length>0)
                    t_where += " and kind='"+t_kind+"'";
                if (t_comp.length>0)
                    t_where += " and charindex('" + t_comp + "',tgg)>0";
                    
				if(q_getPara('sys.project').toUpperCase()=='XY'){
					if(t_ordeno.length>0)
						t_where += " and exists (select * from view_ordbs where ordeno='"+t_ordeno+"' and noa=view_ordb"+r_accy+".noa )";
					if(t_custno.length>0)
						t_where += " and exists (select * from view_ordbs where custno='"+t_custno+"' and noa=view_ordb"+r_accy+".noa )";
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
                    <td class='seek'  style="width:20%;"><a id='lblKind'> </a></td>
                    <td><select id="cmbKind" style="width:215px; font-size:medium;" > </select></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
                    <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td   style="width:35%;" ><a id='lblOdate'> </a></td>
                    <td style="width:65%;  ">
                    <input class="txt" id="txtBodate" type="text" style="width:90px; font-size:medium;" />
                    <span style="display:inline-block; vertical-align:middle">&sim;</span>
                    <input class="txt" id="txtEodate" type="text" style="width:93px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblTggno'> </a></td>
                    <td><input class="txt" id="txtTggno" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblComp'> </a></td>
                    <td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr ordeno' style="display: none;">
                    <td class='seek'  style="width:20%;"><a id='lblOrdeno'> </a></td>
                    <td><input class="txt" id="txtOrdeno" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr cust'  style="display: none;">
                    <td class='seek'  style="width:20%;"><a id='lblCustno'> </a></td>
                    <td><input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr trantype' style="display: none;">
					<td><a>交運方式 </a></td>
					<td><select id="cmbTrantype" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
                    <td   style="width:35%;" ><a id='lblDatea'> </a></td>
                    <td style="width:65%;  ">
                    <input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
                    <span style="display:inline-block; vertical-align:middle">&sim;</span>
                    <input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
                    </td>
                </tr>
            </table>
            <!--#include file="../inc/seek_ctrl.inc"-->
        </div>
    </body>
</html>