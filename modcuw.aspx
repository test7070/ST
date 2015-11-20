<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "modcuw";
			var q_readonly = ['txtWorker', 'txtNoa'];
			var q_readonlys = ['txtMech'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var pNoq =1;
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 5;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			
			aPop = new Array(
				['txtMechno_','btnMech_','mech','noa,mech','txtMechno_,txtMech_','mech_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				bbsNum = [['txtBorntime', 15, 0],['txtAddtime', 15, 0],['txtChgfre', 15, 0],['txtChgtime', 15, 0],['txtFaulttime', 15, 0],
						  ['txtDelaytime', 15, 0],['txtWaittime', 15, 0],['txtWaitfedtime', 15, 0],['txtLacksss', 15, 0]];
				
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
			var delId='';
			function q_gtPost(t_name) {
				switch (t_name) {			
					case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                    break;	
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				
				if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_modfix') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				
				if (q_cur == 1) {
					
					t_where = "where=^^ noa='" + t_noa + "'^^";
					q_gt('modfix', t_where, 0, 0, 0, "checkModelno_btnOk", r_accy);
				} else {
					wrServer(t_noa);
				}
				
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('modcuw_s.aspx', q_name + '_s', "500px", "40%", q_getMsg("popSeek"));
			}

			function bbsAssign() {
								
				for (var j = 0; j < q_bbsCount; j++) {	
					
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
               	$('#txtDatea').val(q_date()); 
				refreshBbm();

			}

			function btnModi() {			
				_btnModi();
				refreshBbm();
			}

			function btnPrint() {
				
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['mechno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);		
				refreshBbm();
			}

			function refreshBbm() {
				$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
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
				width: 450px;
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
				width: 10%;
			}
			.tbbm .tdZ {
				width: 1%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
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
				width: 95%;
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
			}
			.dbbs {
				width: 1260px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"], select {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="datea" style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl "></a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>		
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td><input id="txtDatea" type="text" class="txt c1" style="float: left;"/></a></td>	
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
					</tr>
						
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1100px;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>					
					<td align="center" style="width:30%;"><a id='lblMechno_s'> </a></td>
					<td align="center" ><a id='lblBorntime_s'> </a></td>
					<td align="center" ><a id='lblAddtime_s'> </a></td>
					<td align="center" ><a id='lblChgfre_s'> </a></td>
					<td align="center" ><a id='lblChgtime_s'> </a></td>
					<td align="center" ><a id='lblFaulttime_s'> </a></td>
					<td align="center" ><a id='lblDelaytime_s'> </a></td>
					<td align="center" ><a id='lblWaittime_s'> </a></td>
					<td align="center" ><a id='lblWaitfedtime_s'> </a></td>
					<td align="center" ><a id='lblLacksss_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input id="btnMinus.*" type="button" class="btn" value='-' style=" font-weight: bold;" />			
					</td>								

					<td>
					<input id="txtNoq.*" type="hidden" />
					<input id="txtMechno.*" type="text" class="txt" style="width:35%;"/>
					<input id="txtMech.*"type="text" class="txt" style="width:50%;"/>
					<input id="btnMech.*" type="button" value="." style="width:7%;" />
					</td>
					
					<td ><input id="txtBorntime.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td ><input id="txtAddtime.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td ><input id="txtChgfre.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td ><input id="txtChgtime.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td ><input id="txtFaulttime.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td ><input id="txtDelaytime.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td ><input id="txtWaittime.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td ><input id="txtWaitfedtime.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td ><input id="txtLacksss.*" type="text" class="num c1" style="width : 95% ;"/></td>
				</tr>
				
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
