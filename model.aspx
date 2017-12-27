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
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "model";
			var q_readonly = ['txtWorker', 'txtWorker2','txtMaxmodmount'];
			var q_readonlys = [];
			var bbmNum = [['txtYearmount', 10, 0, 1], ['txtUsemount', 10, 0, 1], ['txtInmount', 10, 0, 1]
			, ['txtInmoney', 10, 0, 1], ['txtMount', 10, 0, 1],['txtModmounts',10,0,1],['txtMaxmodmount',10,0,1]];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 5;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			q_desc = 1;
			aPop = new Array(
				['txtStationno', 'lblStationno', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
				['txtModgno', 'lblModg', 'modg', 'noa,namea', 'txtModgno,txtModg', 'modg_b.aspx']
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
				var bbmMask = [['txtIndate', r_picd]];
				q_mask(bbmMask);
				$('#txtNoa').change(function(e) {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0) {
						if ((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())) {
							t_where = "where=^^ noa='" + $(this).val() + "'^^";
							q_gt('model', t_where, 0, 0, 0, "checkModelno_change", r_accy);
						} else {
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
							Unlock();
						}
					}
				});
				
				$('#txtInmount').change(function() {
					if(dec($('#txtInmount').val())==0){
						$('#txtInmount').val(1);
					}
					$('#txtMaxmodmount').val(q_mul(dec($('#txtInmount').val()),dec($('#txtModmounts').val())));
				});
				
				$('#txtModmounts').change(function() {
					if(dec($('#txtModmounts').val())==0){
						$('#txtModmounts').val(1);
					}
					$('#txtMaxmodmount').val(q_mul(dec($('#txtInmount').val()),dec($('#txtModmounts').val())));
				});
				
				if(q_getPara('sys.project').toUpperCase()=='AD' || q_getPara('sys.project').toUpperCase()=='JO'){
					$('#lblFrame').text('儲位架');
				}
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
					case 'checkModelno_change':
						var as = _q_appendData("model", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].model);
						}
						break;
					case 'checkModelno_btnOk':
						var as = _q_appendData("model", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].model);
							Unlock();
							return;
						} else {
							wrServer($.trim($('#txtNoa').val()));
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				
				var t_noa=$('#txtNoa').val();
				
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + t_noa + "'^^";
					q_gt('model', t_where, 0, 0, 0, "checkModelno_btnOk", r_accy);
				} else {
					wrServer(t_noa);
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('model_s.aspx', q_name + '_s', "550px", "350px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				refreshBbm();
				$('#txtIndate').val(q_date());
				$('#txtNoa').focus();
				$('#txtInmount').val(1);
				$('#txtModmounts').val(1);
				$('#txtMaxmodmount').val(1);
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				refreshBbm();
				$('#txtNoa').focus();
			}

			function btnPrint() {

			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product']) {
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
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
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
				width: 750px;
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
				/*width: 10%;*/
			}
			.tbbm .tdZ {
				/*width: 1%;*/
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
			}
			.txt.c3 {
				width: 50%;
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
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewModel'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="model" style="text-align: center;">~model</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td style="width:110px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:110px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:110px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblModel' class="lbl"> </a></td>
						<td><input id="txtModel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblModg' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtModgno" type="text" class="txt c3"/>
							<input id="txtModg" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblYearmount' class="lbl"> </a></td>
						<td><input id="txtYearmount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblUsemount' class="lbl"> </a></td>
						<td><input id="txtUsemount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblFix' class="lbl"> </a></td>
						<td colspan="2"><input id="txtFix" type="text" class="txt c3 num"/><span> </span>需保養</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoldingcycle' class="lbl"> </a></td>
						<td><input id="txtMoldingcycle" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblStationno' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtStationno" type="text" style="width:35%" class="txt"/>
							<input id="txtStation" type="text" style="width:65%" class="txt"/>
						</td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblInmount' class="lbl"> </a></td>
						<td><input id="txtInmount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblInmoney' class="lbl"> </a></td>
						<td><input id="txtInmoney" type="text" class="txt c1 num"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblModmounts' class="lbl"> </a></td>
						<td><input id="txtModmounts" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblMaxmodmount' class="lbl" style="text-align: right;width: 95%;"> </a></td>
						<td><input id="txtMaxmodmount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblFrame' class="lbl"> </a></td>
						<td><input id="txtFrame" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt c1 num"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="display: none;"><!--106/12/22 隱藏-->
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:15%;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:25%;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblSuitproduct_s'> </a></td>
					<td align="center" style="width:22%;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:22%;"><a id='lblMemo2_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td>
						<input id="txtProductno.*" type="text" style="width:80%;" />
						<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td><input id="txtProduct.*" type="text" style="width:95%;" /></td>
					<td><input id="txtSuitproduct.*" type="text" style="width:95%;" /></td>
					<td><input id="txtMemo.*" type="text" style="width:95%;" /></td>
					<td><input id="txtMemo2.*" type="text" style="width:95%;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>