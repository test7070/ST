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
			var q_name = "get";
			var q_readonly = ['txtNoa', 'txtWorker','txtTotal'];
			var q_readonlys = ['txtOrdeno', 'txtNo2'];
			var bbmNum = [['txtPrice', 15, 3, 1],['txtTranmoney', 10, 0, 1],['txtTotal', 10, 3, 1]];
			var bbsNum = [['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1], ['txtRadius', 10, 3, 1], ['txtWidth', 10, 2, 1], ['txtDime', 10, 3, 1], ['txtLengthb', 10, 2, 1], ['txtMount', 10, 0, 1], ['txtGmount', 10, 0, 1], ['txtGweight', 10, 3, 1], ['txtWeight', 10, 3, 1]];
			var bbmMask = [];
			var bbsMask = [['txtStyle', 'A']];
			q_desc = 1;
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,product,spec,radius,width,dime,lengthb,style,class,eweight,emount', '0txtUno_,txtProductno_,txtProduct_,txtSpec_,txtRadius_,txtWidth_,txtDime_,txtLengthb_,txtStyle_,txtClass_,txtGweight_,txtGmount_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%'],
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
				['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('style', '', 0, 0, 0, '');
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_weight = q_add(t_weight, q_float('txtGweight_' + j));
					// 重量合計
					t_unit = $('#txtUnit_' + j).val();
					t_mount = (!t_unit || emp(t_unit) || trim(t_unit).toLowerCase() == 'kg' ? $('#txtWeight_' + j).val() : $('#txtMount_' + j).val());
					// 計價量
					$('#txtTotal_' + j).val(round(q_mul(dec($('#txtPrice_' + j).val()), dec(t_mount)), 0));
				}// j

				$('#txtTotal').val(round(t_weight, 0));
				if (!emp($('#txtPrice').val()))
					$('#txtTranmoney').val(round(q_mul(t_weight, dec($('#txtPrice').val())), 0));
			}

			function mainPost() {// 載入資料完，未 refresh 前
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtCucdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('get.typea'));
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				// 需在 main_form() 後執行，才會載入 系統參數
				/* 若非本會計年度則無法存檔 */
				$('#txtDatea').focusout(function() {
					if ($(this).val().substr(0, 3) != r_accy) {
						$('#btnOk').attr('disabled', 'disabled');
						alert(q_getMsg('lblDatea') + '非本會計年度。');
					} else {
						$('#btnOk').removeAttr('disabled');
					}
				});
				//變動尺寸欄位
				$('#cmbKind').change(function() {
					size_change();
				});
				$('#txtPrice').change(function(){
					sum();
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordes':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0) {
								b_pop = '';
								return;
							}
							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2', b_ret.length, b_ret, 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2', 'txtProductno,txtProduct,txtSpec');
							/// 最後 aEmpField 不可以有【數字欄位】
							bbsAssign();
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var StyleList = '';
			var t_uccArray = new Array;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
				} /// end switch
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}

			function btnOk() {
				Lock(1, {
					opacity : 0
				});
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}
				$('#txtWorker').val(r_name);
				sum();
				var t_noa = trim($('#txtNoa').val());
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")/// 自動產生編號
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_get') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('get_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
			}

			function getTheory(b_seq) {
				t_Radius = $('#txtRadius_' + b_seq).val();
				t_Width = $('#txtWidth_' + b_seq).val();
				t_Dime = $('#txtDime_' + b_seq).val();
				t_Lengthb = $('#txtLengthb_' + b_seq).val();
				t_Mount = $('#txtGmount_' + b_seq).val();
				t_Style = $('#txtStyle_' + b_seq).val();
				t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting = {
					calc : StyleList,
					ucc : t_uccArray,
					radius : t_Radius,
					width : t_Width,
					dime : t_Dime,
					lengthb : t_Lengthb,
					mount : t_Mount,
					style : t_Style,
					productno : t_Productno,
					round : 3
				};
				return theory_st(theory_setting);
			}

			function bbsAssign() {/// 表身運算式
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnMinus_' + j).click(function() {
							btnMinus($(this).attr('id'));
						});
						$('#txtGweight_' + j).change(function(e) {
							sum();
						});
						$('#txtStyle_' + j).blur(function() {
							$('input[id*="txtProduct_"]').each(function() {
								thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
								$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
							});
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							ProductAddStyle(n);
						});
						//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
						$('#textSize1_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if ($('#cmbKind').val().substr(0, 1) == 'A') {
								q_tr('txtDime_' + n, q_float('textSize1_' + n));
							} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
								q_tr('txtRadius_' + n, q_float('textSize1_' + n));
							}
							q_tr('txtGweight_' + n, getTheory(n));
						});
						$('#textSize2_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if ($('#cmbKind').val().substr(0, 1) == 'A') {
								q_tr('txtWidth_' + n, q_float('textSize2_' + n));
							} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
								q_tr('txtWidth_' + n, q_float('textSize2_' + n));
							}
							q_tr('txtGweight_' + n, getTheory(n));
						});
						$('#textSize3_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if ($('#cmbKind').val().substr(0, 1) == 'A') {
								q_tr('txtLengthb_' + n, q_float('textSize3_' + n));
							} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
								q_tr('txtDime_' + n, q_float('textSize3_' + n));
							} else {//鋼筋、胚
								q_tr('txtLengthb_' + n, q_float('textSize3_' + n));
							}
							q_tr('txtGweight_' + n, getTheory(n));
						});
						$('#textSize4_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if ($('#cmbKind').val().substr(0, 1) == 'A') {
								q_tr('txtRadius_' + n, q_float('textSize4_' + n));
							} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
								q_tr('txtLengthb_' + n, q_float('textSize4_' + n));
							}
							q_tr('txtGweight_' + n, getTheory(n));
						});
						$('#txtGmount_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							q_tr('txtGweight_' + n, getTheory(n));
						});
						//-------------------------------------------------------------------------------------
					}
				}//j
				_bbsAssign();
				size_change();
			}

			function btnIns() {
				_btnIns();
				$('#cmbKind').val(q_getPara('vcc.kind'));
				size_change();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
				size_change();
				sum();
			}

			function btnPrint() {
				q_box('z_getstp.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['productno'] && !as['product'] && !as['spec']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['date'] = abbm2['date'];
				as['custno'] = abbm2['custno'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				//q_popPost('txtProductno_');
				$('input[id*="txtProduct_"]').each(function() {
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
					$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
				});
				size_change();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function() {
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
						});
						if (trim($('#txtStyle_' + b_seq).val()).length != 0)
							ProductAddStyle(b_seq);
						$('#txtStyle_' + b_seq).focus();
						break;
					case 'txtUno_':
						var thisRet = getb_ret();
						size_change();
						if(thisRet){
							var t_uno = trim($('#txtUno_' + b_seq).val()).toUpperCase().substring(0, 1);
							if ('XYZ'.indexOf(t_uno) > -1 && trim(t_uno) != '') {
								$('#txtProductno_' + b_seq).focus();
							} else {
								//if(trim(t_uno) == '') b_seq = x_bseq;
								if (thisRet.length >= 1) {
									$('#txtUno_' + b_seq).val(thisRet[0].uno);
								}
								$('#txtMount_' + b_seq).focus();
							}
						}
						break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				size_change();
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				size_change();
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

			function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
				$('#cmbKind').val((($('#cmbKind').val()) ? $('#cmbKind').val() : q_getPara('vcc.kind')));
				var t_kind = (($('#cmbKind').val()) ? $('#cmbKind').val() : '');
				t_kind = t_kind.substr(0, 1);
				if (t_kind == 'A') {
					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).hide();
						$('#Size').css('width', '230px');
						$('#textSize1_' + j).val($('#txtDime_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				} else if (t_kind == 'B') {
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).show();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).show();
						$('#Size').css('width', '310px');
						$('#textSize1_' + j).val($('#txtRadius_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtDime_' + j).val());
						$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
					}
				} else {//鋼筋和鋼胚
					$('#lblSize_help').text(q_getPara('sys.lblSizec'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).hide();
						$('#textSize2_' + j).hide();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).hide();
						$('#x2_' + j).hide();
						$('#x3_' + j).hide();
						$('#Size').css('width', '70px');
						$('#textSize1_' + j).val(0);
						$('#txtDime_' + j).val(0);
						$('#textSize2_' + j).val(0);
						$('#txtWidth_' + j).val(0);
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
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
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 98%;
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
				width: 12%;
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
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c6 {
				width: 90%;
				float: left;
				text-align: center;
			}
			.txt.c8 {
				float: left;
				width: 65px;
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
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left; width:30%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewStoreno'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='storeno store,4'>~storeno ~store,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr class="tr1">
						<td class='td1'><span> </span><a id="lblType" class="lbl"> </a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
						<td class='td3'><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td class="td4">
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td class='td5'><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td class="td6">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr2">
						<td class='td1'><span> </span><a id="lblCustno" class="lbl btn" > </a></td>
						<td class="td2" colspan="3">
						<input id="txtCustno" type="text" class="txt c2"/>
						<input id="txtComp" type="text" class="txt c3"/>
						</td>
						<td class='td5'><span> </span><a id="lblKind" class="lbl" > </a></td>
						<td class="td6"><select id="cmbKind" class="txt c1"></select></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblStore" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtStoreno" type="text" class="txt c2" />
						<input id="txtStore" type="text" class="txt c3"/>
						</td>
						<td class='td3'><span> </span><a id="lblVno" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtVno" type="text" class="txt c1"/>
						</td>
						<td class="td5">
						<input id="btnStk" type="button" style="display:none;"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtCardealno" type="text" class="txt c2"/>
						<input id="txtCardeal" type="text" class="txt c3"/>
						</td>
						<td class='td3'><span> </span><a id="lblWaste" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtWaste" type="text" class="txt c1"/>
						</td>
						<td class="td5">
						<input id="btnWaste" type="button" style="display:none;"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblTrantype" class="lbl"> </a></td>
						<td class="td2"><select id="cmbTrantype" class="txt c1"></select></td>
						<td class="td3"><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td class="td4"><input id="txtCarno" type="text" class="txt c1" /></td>
						<td class="td5"><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td class="td6"><input id="txtPrice" type="text" class="txt c1 num" /></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtTotal" type="text" class="txt c1 num" />
						</td>
						<td class='td3'><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblTranmoney" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtTranmoney" type="text" class="txt c1 num" />
						</td>
					</tr>
					<tr class="tr8">
						<td class='td1'><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td class="td2" colspan='5'>						<textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height: 50px;" > </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;">
					<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:1%;"></td>
					<td align="center" style="width:20%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:10%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
					<td align="center" id='Size'><a id='lblSize_help'> </a>
					<BR>
					<a id='lblSize_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblGmount_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblGweight_st'> </a></td>
					<td align="center" style="width:6%;display:none;"><a id='lblWeight_st'> </a></td>
					<td align="center"><a id='lblMemo_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
					<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td><td>
					<input class="btn" id="btnUno.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					<input id="txtUno.*" type="text" style="width:75%;"/>
					</td>
					<td>
					<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					<input id="txtProductno.*" type="text" style="width:70%;" />
					<input id="txtClass.*" type="text" style="width: 93%;float:left;"/>
					</td>
					<td>
					<input class="txt c6" id="txtStyle.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtProduct.*" type="text" />
					</td>
					<td>
					<input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/>
					<div id="x1.*" style="float: left">
						x
					</div>
					<input class="txt num c8" id="textSize2.*" type="text" disabled="disabled"/>
					<div id="x2.*" style="float: left">
						x
					</div>
					<input class="txt num c8" id="textSize3.*" type="text" disabled="disabled"/>
					<div id="x3.*" style="float: left">
						x
					</div>
					<input class="txt num c8" id="textSize4.*" type="text" disabled="disabled"/>
					<!--上為虛擬下為實際-->
					<input id="txtRadius.*" type="hidden"/>
					<input id="txtWidth.*" type="hidden"/>
					<input id="txtDime.*" type="hidden"/>
					<input id="txtLengthb.*" type="hidden"/>
					<input class="txt c1" id="txtSpec.*" type="text"/>
					</td>
					<td>
					<input class="txt num c1" id="txtGmount.*" type="text"/>
					</td>
					<td>
					<input class="txt num c1" id="txtGweight.*" type="text"/>
					</td>
					<td style="display:none;">
					<input class="txt num c1" id="txtWeight.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtMemo.*" type="text" />
					<input class="txt" id="txtOrdeno.*" style="float:left;width:70%;">
					<input class="txt" id="txtNo2.*" style="width:23%;">
					<input id="txtNoq.*" type="hidden" />
					<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>