<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "custprice_s";
			aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx']
				,['txtAgentno', 'lblAgentno', 'agent', 'noa,agent', 'txtAgentno', 'agent_b.aspx']
            	,['txtProductno', 'lblProductno', 'view_ucaucc', 'noa,product', 'txtProductno', 'ucaucc_b.aspx']);
            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
				$('#txtNoa').focus();
                //$('#txtBdate').datepicker();
                //$('#txtEdate').datepicker();
            }

            function q_seekStr() {
                t_noa = $.trim($('#txtNoa').val());
                t_bdate = $.trim($('#txtBdate').val());
                t_edate = $.trim($('#txtEdate').val());
                t_custno = $.trim($('#txtCustno').val());
                t_comp = $.trim($('#txtComp').val());
                t_agentno = $.trim($('#txtAgentno').val());
                t_agent = $.trim($('#txtAgent').val());
                t_productno = $.trim($('#txtProductno').val());
                t_product = $.trim($('#txtProduct').val());

                var t_where = " 1=1 " 
                	+ q_sqlPara2("noa", t_noa) 
                	+ q_sqlPara2("datea", t_bdate, t_edate) 
					+ q_sqlPara2("custno", t_custno) 
					+ q_sqlPara2("agentno", t_agentno) 
					+ q_sqlPara2("productno", t_productno);
				
				if(t_comp.length>0)
					t_where += " and charindex('"+t_comp+"',comp)>0";
				if(t_agent.length>0)
					t_where += " and charindex('"+t_agent+"',agent)>0";
				if(t_product.length>0)
					t_where += " and charindex('"+t_product+"',product)>0";
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'>客戶編號</a></td>
					<td>
						<input class="txt" id="txtCustno" type="text" style="width:200px; font-size:medium;" />&nbsp;
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'>客戶名稱</a></td>
					<td>
						<input class="txt" id="txtComp" type="text" style="width:200px; font-size:medium;" />&nbsp;
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAgentno'>經銷商編號</a></td>
					<td>
						<input class="txt" id="txtAgentno" type="text" style="width:200px; font-size:medium;" />&nbsp;
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAgent'>經銷商名稱</a></td>
					<td>
						<input class="txt" id="txtAgent" type="text" style="width:200px; font-size:medium;" />&nbsp;
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblProductno'>產品編號</a></td>
					<td>
						<input class="txt" id="txtProductno" type="text" style="width:200px; font-size:medium;" />&nbsp;
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblProduct'>產品名稱</a></td>
					<td>
						<input class="txt" id="txtProduct" type="text" style="width:200px; font-size:medium;" />&nbsp;
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
