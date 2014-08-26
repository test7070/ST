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

			q_desc = 1;
			q_tables = 's';
			var q_name = "vccew";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtSales','txtWeight','txtCardeal'];
			var q_readonlys = ['txtStore','txtNoq'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtCustno', 'lblCustno', 'cust', 'noa,comp,tel,fax,trantype,zip_comp,addr_comp', 'txtCustno,txtComp,txtTel,txtFax,cmbTrantype,txtZip_post,txtAddr_post', 'cust_b.aspx'],
				['txtOrdewno', '', 'ordew', 'noa,custno,comp,trantype,stype,tel,fax,addr2,salesno,sales,cno,acomp,paytype', 'txtOrdewno,txtCustno,txtComp,cmbTrantype,cmbStype,txtTel,txtFax,txtAddr_post,txtSalesno,txtSales,txtCno,txtAcomp,txtPaytype', ''],
				['txtBccno_', 'btnBccno_', 'bcc', 'noa,product,unit', 'txtBccno_,txtBccname_,txtUnit_', 'bcc_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
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
                var t1 = 0, t_unit='', t_mount=0, t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_weight += q_float('txtWeight_' + j);
                }// j
                q_tr('txtWeight', t_weight);
            }

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtCldate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbStype", q_getPara('ordew.stype'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				
				bbmNum = [['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1]];
				bbsNum = [['txtMount', 10, q_getPara('vcc.mountPrecision'), 1],['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1]];

				var t_where = "where=^^ 1=1  group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");

				
				$('#btnOrdewimport').click(function() {
					var ordewno = $('#txtOrdewno').val();
					var t_where = " 1=1 and isnull(enda,0)=0 and isnull(cancel,0)=0 and noa in (select noa from ordew where stype='"+$('#cmbStype').val()+"')";
					if (ordewno.length > 0)
						t_where += " and noa='" + ordewno + "'";
					t_where += q_sqlPara2('custno', $('#txtCustno').val());
					q_box("ordews_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordews', "95%", "95%", $('#btnOrdewimport').val());
				});
				
				$('#txtAddr_post').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});

				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordews':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}
							
							for (var i = 0; i < b_ret.length; i++) {
								b_ret[i].mount=dec(b_ret[i].mount)-dec(b_ret[i].c1);
								b_ret[i].weight=dec(b_ret[i].weight)-dec(b_ret[i].c2);
							}
							
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdewno,txtNo2,txtBccno,txtBccname,txtUnit,txtMount,txtWeight,txtMemo'
							, b_ret.length, b_ret, 'noa,no2,bccno,bccname,unit,mount,weight,memo', 'txtBccno');
							
							sum();
							
							if (b_ret[0].noa != undefined) {
								var t_where = "noa='" + b_ret[0].noa + "'";
								q_gt('ordew', t_where, 0, 0, 0, "", r_accy);
							}
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var focus_addr = '';
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'ordew':
						var ordew = _q_appendData("ordew", "", true);
						if (ordew[0] != undefined){
							$('#txtCno').val(ordew[0].cno);
							$('#txtAcomp').val(ordew[0].acomp);
							$('#txtCustno').val(ordew[0].custno);
							$('#txtComp').val(ordew[0].comp);
							$('#txtTel').val(ordew[0].tel);
							$('#txtFax').val(ordew[0].fax);
							$('#txtPaytype').val(ordew[0].paytype);
							$('#txtTrantype').val(ordew[0].trantype);
							$('#txtAddr_post').val(ordew[0].addr2.length>0?ordew[0].addr2:ordew[0].addr);
							$('#txtZip_post').val(ordew[0].addr2.length>0?ordew[0].post2:ordew[0].post);
							$('#txtOrdewno').val(ordew[0].noa);
							$('#txtSalesno').val(ordew[0].salesno);
							$('#txtSales').val(ordew[0].sales);
							$('#txtMemo').val(ordew[0].memo);
						}
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vccew') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('vccew_s.aspx', q_name + '_s', "500px", "360px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function combPay_chg() {
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr_post').val($('#combAddr').find("option:selected").text());
					$('#txtZip_post').val($('#combAddr').find("option:selected").val());
				}
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtWeight_' + j).change(function() {
							sum();
						});
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				var t_where = "where=^^ 1=1  group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
				t_where = "noa='" + $('#txtNoa').val() + "'";
				q_box("z_vccewp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['bccno'] && !as['bccname']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
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

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
				}
			}

		</script>
		<style type="text/css">
			#dmain {
			}
			.dview {
				float: left;
				width: 28%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 70%;
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
				/*width: 9%;*/
			}
			.tbbm .tdZ {
				width: 3%;
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
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 97%;
				float: left;
			}
			.txt.c2 {
				width: 14%;
				float: left;
			}
			.txt.c3 {
				width: 26%;
				float: left;
			}
			.txt.c4 {
				width: 25%;
				float: left;
			}
			.txt.c5 {
				width: 60%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 98%;
				float: left;
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
			.tbbm td input[type="button"] {
				float: left;
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
			}

			.num {
				text-align: right;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
			}

			.tbbs .td1 {
				width: 4%;
			}
			.tbbs .td2 {
				width: 6%;
			}
			.tbbs .td3 {
				width: 8%;
			}
			.tbbs .td4 {
				width: 2%;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1260px;">
			<div class="dview" id="dview" style="float: left;  width:32%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:30%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:35%"><a id='vewCust'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='comp,4'>~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr class="tr0" style="height: 0px;">
						<td class="td1" style="width: 120px;"> </td>
						<td class="td2" style="width: 105px;"> </td>
						<td class="td4" style="width: 105px;"> </td>
						<td class="td5" style="width: 105px;"> </td>
						<td class="td5" style="width: 105px;"> </td>
						<td class="td3" style="width: 105px;"> </td>
						<td class="td4" style="width: 105px;"> </td>
						<td class="td6" style="width: 105px;"> </td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td5" colspan="2"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblOrdewno" class="lbl"> </a></td>
						<td class="td4"><input id="txtOrdewno"  type="text" class="txt c1"/></td>
						<td class="td6"><input id="btnOrdewimport" type="button"/></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblCno" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCno"  type="text" class="txt c1"/></td>
						<td class="td3" colspan="3"><input id="txtAcomp"  type="text" class="txt c7"/></td>
						<td class="td3"><span> </span><a id="lblStype" class="lbl"> </a></td>
						<td class="td4"><select id="cmbStype" class="txt c1"> </select></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCustno"  type="text" class="txt c1"/></td>
						<td class="td3" colspan="3"><input id="txtComp"  type="text" class="txt c7"/></td>
						<td class="td4"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td class="td5"><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td class="td6"><select id="combPaytype" class="txt c1" onchange='combPaytype_chg();'> </select></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblTel" class="lbl"> </a></td>
						<td class="td2" colspan="4"><input id="txtTel"  type="text" class="txt c7"/></td>
						<td class="td1"><span> </span><a id="lblFax" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtFax"  type="text" class="txt c7"/></td>
					</tr>

					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblAddr_post" class="lbl"> </a></td>
						<td class="td2" colspan="4">
							<input id="txtZip_post"  type="text" class="txt c7" style="width: 25%;"/>
							<input id="txtAddr_post"  type="text" class="txt c7" style="width: 68%;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg();'> </select>
						</td>
						<td class="td3"><span> </span><a id="lblTrantype" class="lbl"> </a></td>
						<td class="td4" colspan="2"><select id="cmbTrantype" class="txt c1"> </select></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCardealno"  type="text" class="txt c1"/></td>
						<td class="td3" colspan="3"><input id="txtCardeal"  type="text" class="txt c1"/></td>
						<td class="td6"><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td class="td7" colspan="2"><input id="txtCarno"  type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtSalesno"  type="text" class="txt c1"/></td>
						<td class="td3"><input id="txtSales"  type="text" class="txt c1"/></td>
						<td class="td1"><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td class="td2"><input id="txtWeight"  type="text" class="txt c1 num"/></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="8"><textarea id="txtMemo" cols="5" rows="10" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
					<tr class="tr7">
						<td class="td5"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td6"><input id="txtWorker" type="text" class="txt c1" /></td>
						<td class="td7"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td8"><input id="txtWorker2" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;' >
						<td align="center">
							<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" style="width:10%;"><a id='lblOrdewno_s'> </a></td>
						<td align="center" style="width:4%;"><a id='lblNo2_s'> </a></td>
						<td align="center" style="width:13%;"><a id='lblbccno_s'> </a></td>
						<td align="center" style="width:20%;"><a id='lblbccname_s'> </a></td>
						<td align="center" style="width:4%;"><a id='lblUnit_s'> </a></td>
						<td align="center" style="width:7%;"><a id='lblMount_s'> </a></td>
						<td align="center" style="width:7%;"><a id='lblWeight_s'> </a></td>
						<td align="center" style="width:10%;"><a id='lblStoreno_s'> </a></td>
						<td align="center"><a id='lblMemo_s'> </a></td>
						<td align="center" style="width:4%;"><a id='lblNoq_s'> </a></td>
						<td align="center" style="width:4%;"><a id='lblEnds_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
						<td><input class="txt c1" id="txtOrdewno.*" type="text" /></td>
						<td><input class="txt c1" id="txtNo2.*" type="text" /></td>
						<td>
							<input class="txt c1" id="txtBccno.*" type="text"  style="width: 80%;"/>
							<input class="btn"  id="btnBccno.*" type="button" value='.' style=" font-weight: bold;" />
						</td>
						<td><input class="txt c1" id="txtBccname.*" type="text" /></td>
						<td><input class="txt c1" id="txtUnit.*" type="text" /></td>
						<td><input class="txt num c1" id="txtMount.*" type="text"/></td>
						<td><input class="txt num c1" id="txtWeight.*" type="text"/></td>
						<td>
							<input id="txtStoreno.*" type="text" class="txt c1" style="width: 75%"/>
							<input class="btn"  id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;" />
							<input id="txtStore.*" type="text" class="txt c1"/>
						</td>
						<td><input class="txt c1" id="txtMemo.*" type="text" /></td>
						<td><input class="txt c1" id="txtNoq.*" type="text" /></td>
						<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>