<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		this.errorHandler = null;
		function onPageError(error) {
			alert("An error occurred:\r\n" + error.Message);
		}
		var q_name="flor";
		var q_readonly = ['txtNoa','txtDatea'];
		var bbmNum = [['txtUsd', 15, 5, 1],['txtRmd', 15, 5, 1],['txtEur', 15, 5, 1]];
		var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
		$(document).ready(function () {
			bbmKey = ['noa'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1);
		});

		////////////////// end Ready
		function main() {
			if (dataErr){
				dataErr = false;
				return;
			}
			mainForm(0); // 1=Last  0=Top
		}  ///  end Main()

		function mainPost() { 
			bbmMask = [['txtDate1',r_picd],['txtDate2',r_picd]];
			q_mask(bbmMask);
		}

		function q_boxClose( s2) { 
			var ret; 
			switch (b_pop) { 
				case q_name + '_s':
					q_boxClose2(s2); /// q_boxClose 3/4
					break;
			} /// end Switch
		}


		function q_gtPost(t_name) {  
			switch (t_name) {
				case q_name: if (q_cur == 4) 
						q_Seek_gtPost();
					break;
			}  /// end switch
		}
		
		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
		}

		function btnIns() {
			_btnIns();
			$('#txtNoa').val('AUTO');
			$('#txtDatea').val(q_date());
			$('#txtDate1').focus();
		}

		function btnModi() {
			if (emp($('#txtDate1').val()))
				return;
			_btnModi();
			$('#txtDate1').focus();
		}

		function btnPrint() {
 
		}
		function btnOk() {
			var t_err = '';
			t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDate1', q_getMsg('lblDatea')], ['txtDate2', q_getMsg('lblDatea')] ]);
			if( t_err.length > 0) {
				alert(t_err);
				return;
			}
			var t_noa = trim($('#txtNoa').val());
			if ( t_noa.length==0 || t_noa=='AUTO')
				q_gtnoa(q_name, replaceAll(q_getPara('sys.key_flor') + $('#txtDatea').val(), '/', ''));
			else
				wrServer(  t_noa);
		}

		function wrServer( key_value) {
			var i;
			xmlSql = '';
			if (q_cur == 2) 
				xmlSql = q_preXml();
			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			_btnOk(key_value, bbmKey[0], '','',2);
		}
	  
		function refresh(recno) {
			_refresh(recno);
		}

		function readonly(t_para, empty) {
			_readonly(t_para, empty);
		}

		function btnMinus(id) {
			_btnMinus(id);
		}

		function btnPlus(org_htm, dest_tag, afield) {
			_btnPlus(org_htm, dest_tag, afield);
		}

		function q_appendData(t_Table) {
			return _q_appendData(t_Table);
		}

		function btnSeek(){
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
			width: 40%;
		}
		.tview {
			margin: 0;
			padding: 2px;
			border: 1px black double;
			border-spacing: 0;
			font-size: medium;
			background-color: #FFFF66;
			color: blue;
		}
		.tview td {
			padding: 2px;
			border: 1px black solid;
		}
		.dbbm {
			float: left;
			width: 55%;
			margin: -1px;
			border: 1px black solid;
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
			font-size: medium;
		}
		.tbbm tr td .lbl.btn:hover {
			color: #FF8F19;
		}
		.txt.c1 {
			width: 98%;
			float: left;
		}
		.txt.num {
			text-align: right;
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
			font-size:medium;
		}
		input[type="text"],input[type="button"] {	 
			font-size: medium;
		}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id='dmain'>
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview">
				<table class="tview" id="tview" border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td colspan="2" align="center" style="width:35%"><a id='vewDatea'></a></td>
						<td align="center" style="width:20%"><a id='vewUsd'></a></td>
						<td align="center" style="width:20%"><a id='vewRmd'></a></td>
						<td align="center" style="width:20%"><a id='vewEur'></a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='date1'>~date1</td>
						<td align="center" id='date2'>~date2</td>
						<td align="right" id='usd,5,1'>~usd,5,1</td>
						<td align="right" id='rmd,5,1'>~rmd,5,1</td>
						<td align="right" id='eur,5,1'>~eur,5,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='5'>
					<tr>
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td class="td4"><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td class="td5"></td>
						<td class="td6"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblDate" class="lbl"></a></td>
						<td class="td2" colspan="2">
							<input id="txtDate1"  type="text" style="float:left; width:40%;"/>
							<span style="float:left; width:5px;"> </span><span style="float:left; width:20px; font-weight: bold;font-size: 20px;">～</span><span style="float:left; width:5px;"> </span>
							<input id="txtDate2"  type="text" style="float:left; width:40%;"/>
						</td>
						<td class="td5" ></td>
						<td class="td6"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblUsd" class="lbl"></a></td>
						<td class="td2"><input id="txtUsd"  type="text"  class="txt c1 num"/></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
						<td class="td6"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblRmd" class="lbl"></a></td>
						<td class="td2"><input id="txtRmd"  type="text"  class="txt c1 num"/></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
						<td class="td6"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblEur" class="lbl"></a></td>
						<td class="td2"><input id="txtEur"  type="text"  class="txt c1 num"/></td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"></td>
						<td class="td6"></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>