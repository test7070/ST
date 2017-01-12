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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			var q_name = "custprices";
			var q_readonly = ['txtNoa', 'txtDatea','txtWorker','txtNotaxprice','txtPrice'];
			//var bbmNum = [['txtPrice', 10],['txtOprice', 10],['txtDiscount', 10],['txtNotaxprice', 10],['txtTaxrate', 10]];    
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_xchg = 1;
            brwCount2 = 20;
			aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx'],
            ['txtAgentno', 'lblAgentno', 'agent', 'noa,agent', 'txtAgentno,txtAgent', 'agent_b.aspx'],
            ['txtProductno', 'lblProduct', 'view_ucaucc', 'noa,product,unit,saleprice', 'txtProductno,txtProduct,txtUnit,txtOprice', 'ucaucc_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});
			
			function sum(){
				if(!(q_cur==1 || q_cur==2))
					return;	
				$('#txtOprice').val(q_float('txtOprice'));
				$('#txtDiscount').val(q_float('txtDiscount')==0?100:q_float('txtDiscount'));
				$('#txtTaxrate').val(q_float('txtTaxrate')==0?0:q_float('txtTaxrate'));
				$('#txtNotaxprice').val(q_mul(q_float('txtOprice'),q_float('txtDiscount'))/100);	
				$('#txtPrice').val(q_mul(q_float('txtNotaxprice'),(100-q_float('txtTaxrate'))/100));
			}
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				
				$('#txtOprice').change(function(e){
					sum();
				});
				$('#txtDiscount').change(function(e){
					sum();
				});
				$('#txtTaxrate').change(function(e){
					sum();
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('custprice_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoq').val('001');
				$('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtBdate').val(q_date());
				refreshBbm();
				sum();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				refreshBbm();
				sum();
			}

			function btnPrint() {
				q_box("z_custprice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'tgg', "95%", "95%", q_getMsg('popTgg'));
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				sum();
                $('#txtWorker').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_custprice') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
			}

			function refreshBbm() {
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtBdate').datepicker('destroy');
				}else{
					$('#txtBdate').datepicker();
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 1200px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 700px;
				/*margin: -1px;
				 border: 1px black solid;*/
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 9%;
			}
			.tbbm .tdZ {
				width: 2%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: black;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 40%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.num {
				text-align: right;
			}
			.bbs {
				float: left;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'>編號</a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewComp'>客戶</a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewProduct'>產品</a></td>
						<td align="center" style="width:40px; color:black;"><a id='vewUnit'>單位</a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewOprice'>銷售單價</a></td>
						<td align="center" style="width:50px; color:black;"><a id='vewDiscount'>折扣%</a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNotaxprice'>未稅價</a></td>
						<td align="center" style="width:50px; color:black;"><a id='vewTaxrate'>稅率%</a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewPrice'>經銷價</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='comp' style="text-align: center;">~comp</td>
						<td id='product' style="text-align: center;">~product</td>
						<td id='unit' style="text-align: center;">~unit</td>
						<td id='oprice' style="text-align: center;">~oprice</td>
						<td id='discount' style="text-align: center;">~discount</td>
						<td id='notaxprice' style="text-align: center;">~notaxprice</td>
						<td id='taxrate' style="text-align: center;">~taxrate</td>
						<td id='price' style="text-align: center;">~price</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl">編號</a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtNoq" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl">登錄日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblBdate' class="lbl">生效日期</a></td>
						<td><input id="txtBdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn">客戶</a></td>
						<td colspan="3">
							<input id="txtCustno" type="text" class="txt" style="float:left;width:40%;"/>
							<input id="txtComp" type="text" class="txt" style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAgent' class="lbl btn">經銷商</a></td>
						<td colspan="3">
							<input id="txtAgentno" type="text" class="txt" style="float:left;width:40%;"/>
							<input id="txtAgent" type="text" class="txt" style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct' class="lbl btn">產品</a></td>
						<td colspan="3">
							<input id="txtProductno" type="text" class="txt" style="float:left;width:40%;"/>
							<input id="txtProduct" type="text" class="txt" style="float:left;width:60%;"/>
						</td>
						<td><span> </span><a id='lblUnit' class="lbl">單位</a></td>
						<td><input id="txtUnit" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOprice' class="lbl">銷售單價</a></td>
						<td><input id="txtOprice" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblDiscount' class="lbl">折扣%</a></td>
						<td><input id="txtDiscount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblNotaxprice' class="lbl">未稅價</a></td>
						<td><input id="txtNotaxprice" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td colspan="2"> </td>
						<td><span> </span><a id='lblTaxrate' class="lbl">稅率%</a></td>
						<td><input id="txtTaxrate" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblPrice' class="lbl">經銷價</a></td>
						<td><input id="txtPrice" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl">備註</a></td>
						<td colspan="5">
							<textarea id="txtMemo" style="width:100%; height:100px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl">製單人</a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>