<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			var q_name = 'uccab', t_bbsTag = 'tbbs', t_content = " ", afilter = [], t_count = 0, as, brwCount2 = 15;
			var t_sqlname = 'uccab_load'; t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var decbbs = [];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = ['txtNoq'];
			var bbmNum = [];
			var bbsNum = [['txtBeginmount', 15, 2, 1],['txtBeginmoney', 15, 0, 1],['txtLastmount', 15, 2, 1],['txtUse_mount', 15, 2, 1],['txtTax_mount', 15,2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			aPop = new Array(['txtPr_invent_', '', 'ucca', 'noa,product,typea,unit', '0txtPr_invent_,txtProduct_,txtType_,txtUnit_', 'ucca_b.aspx']);
			$(document).ready(function () {
			    bbmKey = [];
                bbsKey = ['noa', 'noq'];
				if (location.href.indexOf('?') < 0)   // debug
				{
					location.href = location.href + "?;;;noa='0015'";
					return;
				}
				if (!q_paraChk()) {
					return;
				}
				main();
			});                  /// end ready
			
			function main() {
				if (dataErr)
				{
					dataErr = false;
					return;
				}
				
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
			}
			
			function mainPost(){
			    q_getFormat();
				q_mask(bbmMask);
				$('#txtNoa').val(q_getHref()[1]);
				$('#txtInvent_').val(q_getHref()[1]);
				
			}
			
			function bbsAssign() {
				_bbsAssign();
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#btnMinus_' + j).click(function () { 
						btnMinus($(this).attr('id'));
					});
					$('#txtInvent_'+j).val(q_getHref()[1]);
				} //j
			}
			
			function btnOk() {
				t_key = q_getHref();
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2); 
			}
			
			function bbsSave(as) {
				if (!as['pr_invent'] ) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2( '' , as);  // write keys to as
				return true;
			}
			
			function btnModi() {
				var t_key = q_getHref();
				if (!t_key)
					return;
				_btnModi();
			}
			
			function refresh() {
                _refresh();
			}
						
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
			
			function btnMinus(id) {
				_btnMinus(id);
			}
			
			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}

		</script>
	    <style type="text/css">
	       .num {
                text-align: right;
            }
	    </style>
	</head>
	<body>
		<div style="float:left;width:100%;margin-bottom: 10px;">
			<div class='dbbm' style="width: 100%;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr style="height: 1px;">
						<td style="width: 80px;"> </td>
						<td style="width: 20%;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 20%;"> </td>
						<td style="width: 80px;"> </td>
						<td style="width: 20%;"><input id="txtNoa" type="hidden" /> </td>
					</tr>
				</table>
			</div>
			<div id="dbbs" class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;' >
						<td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
						<td align="center" style="width:10%;"><a id='lblInvent'>配方代碼</a></td>
						<td align="center" style="width:20%;"><a id='lblPr_invent'>配方名稱</a></td>
						<td align="center" style="width:10%;"><a id='lblTypea'>性質</a></td>
						<td align="center" style="width:6%;"><a id='lblUnit'>單位</a></td>
						<td align="center" style="width:10%;"><a id='lblUse_mount'>實耗數量</a></td>
						<td align="center" style="width:10%;"><a id='lblTax_mount'>應耗數量</a></td>
						<td align="center" style="width:10%;"><a id='lblBeginmount'>期初已耗數量</a></td>
						<td align="center" style="width:10%;"><a id='lblBeginmoney'>期初已耗金額</a></td>
						<td align="center" style="width:10%;"><a id='lblLastmount'>期末投入數量</a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
							<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
							<input id="txtNoa.*" type="hidden"/>
							<input id="txtNoq.*" type="hidden" />
							<input id="txtInvent.*" type="hidden"/>
						</td>
						<td><input class="txt" id="txtPr_invent.*" type="text" style="width:98%;"/></td>
						<td><input class="txt" id="txtProduct.*" type="text" style="width:98%;"/></td>
						<td><input class="txt" id="txtType.*" type="text" style="width:98%;"/>
						</td>
						<td><input class="txt" id="txtUnit.*" type="text" style="width:98%;"/></td>
						<td><input class="txt num" id="txtUse_mount.*" type="text" style="width:98%;"/></td>
						<td><input class="txt num" id="txtTax_mount.*" type="text" style="width:98%;"/></td>
						<td><input class="txt num" id="txtBeginmount.*" type="text" style="width:98%;"/></td>
						<td><input class="txt num" id="txtBeginmoney.*" type="text" style="width:98%;"/></td>
						<td><input class="txt num" id="txtLastmount.*" type="text" style="width:98%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
