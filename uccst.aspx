<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <script src="../script/qbox.js" type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
			var q_name = "ucc";
			var q_readonly = [];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 20;
			aPop = new Array(['txtRc2acc1', 'lblRc2acc1', 'acc', 'acc1,acc2', 'txtRc2acc1,txtRc2acc2', 'acc_b.aspx']
				,['txtVccacc1', 'lblVccacc1', 'acc', 'acc1,acc2', 'txtVccacc1,txtVccacc2', 'acc_b.aspx']);
			
			t_groupano = "";
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt('uccga', '', 0, 0, 0, "");
				
			});
			function currentData() {
			}
			currentData.prototype = {
				data : [],
				/*排除的欄位,新增時不複製*/
				exclude : [],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in curData.exclude) {
							if (fbbm[i] == curData.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);		  
			}

			function mainPost() {
				q_mask(bbmMask);
				//uccst_s.aspx
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					q_cmbParse("cmbTypea", ' @ ,'+q_getPara('sys.stktype'));
				}else{
					q_cmbParse("cmbTypea", q_getPara('uccst.typea'));
				}
				q_cmbParse("cmbGroupano", t_groupano);
				if (abbm[q_recno] != undefined) {
					$("#cmbGroupano").val(abbm[q_recno].groupano);
				}
				$('#lblGroupano').click(function(e){
					q_box("uccga.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy, 'uccga', "95%", "95%", '');
				});
				
			}
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + 'st_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}  
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						t_groupano = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_groupano = t_groupano + (t_groupano.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+' . '+as[i].namea;
							}
						}
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				} 
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('uccst_s.aspx', 'uccst_s', "500px", "330px", q_getMsg("popSeek"));
			}
			function btnIns() {
				if($('#Copy').is(':checked')){
					curData.copy();
				}
				_btnIns();
				if($('#Copy').is(':checked')){
					curData.paste();
				}
				$('#txtNoa').focus();
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				q_box("z_uccstp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy, 'z_uccstp', "95%", "95%", q_getMsg('popPrint'));
			}

			function btnOk() {
				var t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa_st')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				var t_noa = trim($('#txtNoa').val());
				$('#txtUno').val(t_noa);
				if (t_noa.length == 0)
					q_gtnoa(q_name, t_noa);
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)/// popSave
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(q_cur=='1')
					$('#txtNoa').removeAttr('readonly').css('color','black').css('background','white');
				else
					$('#txtNoa').attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
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
				width: 400px; 
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
				width: 550px;
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
				color: black;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
			.txt.c1 {
				width: 100%;
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
			.num {
				text-align: right;
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa_st'> </a></td>
						<td align="center" style="width:280px; color:black;"><a id='vewProduct_st'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='product' style="text-align: left;">~product</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa_st' class="lbl"> </a></td>
						<td>
							<input id="txtNoa"  type="text" class="txt c1" />
							<input id="txtUno"  type="text" style="display:none;"/>
						</td>
						<td>
							<input id="Copy" type="checkbox" />
							<span> </span><a id="lblCopy"></a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct_st' class="lbl"> </a></td>
						<td colspan="2"><input id="txtProduct"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEngpro' class="lbl"> </a></td>
						<td colspan="2"><input id="txtEngpro"  type="text" class="txt c1" /></td>
					</tr>
					<!--<tr>
						<td><span> </span><a id='lblSpec_st' class="lbl"> </a></td>
						<td><input id="txtSpec" type="text" class="txt c1" /></td>
					</tr>-->
					<tr>
						<td><span> </span><a id='lblDensity_st' class="lbl"> </a></td>
						<td><input id="txtDensity" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblShelflife' class="lbl">保存期限</a></td>
						<td><input id="txtShelflife" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUnit_st' class="lbl"> </a></td>
						<td><input id="txtUnit" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUnit2_st' class="lbl"> </a></td>
						<td><input id="txtUnit2"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea_st' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblGroupano' class="lbl btn"> </a></td>
						<td><select id="cmbGroupano" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblVccacc1' class="lbl btn">會計科目</a></td>
						<td colspan="2">
							<input id="txtVccacc1"  type="text" class="txt" style="width:50%;" />
							<input id="txtVccacc2"  type="text" class="txt" style="width:50%;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblRc2acc1' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtRc2acc1"  type="text" class="txt" style="width:50%;" />
							<input id="txtRc2acc2"  type="text" class="txt" style="width:50%;" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
