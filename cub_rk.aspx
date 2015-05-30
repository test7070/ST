<!DOCTYPE html>
<html>
	<head>
		<title></title>
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
			this.errorHandler = null;
			q_tables = 's';
			var toIns = true;
			var q_name = "cub";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var q_readonlys = ['txtCustno','txtComp'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			brwCount2 = 5;
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', '0txtProductno_,txtProduct_', 'ucc_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,nick', 'txtCustno_', 'cust_b.aspx'],
				['txtSpec_', 'btnSpec_', 'spec', 'noa,product', 'txtSpec_,txtClass_', 'spec_b.aspx']
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
				mainForm(0);
			}

			function sum() {
				for (var j = 0; j < q_bbsCount; j++) {
				}
			}

			function mainPost() {
				q_getFormat();
				document.title = '生產作業';
				bbmMask = [['txtDatea', r_picd]];
				bbsMask = [['txtBtime','99:99'],['txtEtime','99:99']];
				q_mask(bbmMask);
				q_cmbParse("combProcess", '日,午,晚');
                $("#combProcess").change(function(e) {
					if (q_cur == 1 || q_cur == 2){
						$('#txtProcess').val($('#combProcess').find(":selected").text());
						$(this)[0].selectedIndex=0;
					}
				});
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						else if(q_cur==0 && toIns){
							var t_h1 = q_getHref();
							if($.trim(t_h1[0])==''){
								$('#btnIns').click();
							}
							toIns = false;
						}
						break;
					default:
                    	try{
                    		t_para = JSON.parse(t_name);
                    		if(t_para.action == 'importOrde'){
                    			var as = _q_appendData("view_ordes", "", true);
		                		if (as[0] != undefined) {
		                			$('#txtCustno_'+t_para.n).val(as[0].custno);	
		                			$('#txtComp_'+t_para.n).val(as[0].comp);	
		                			$('#txtDime_'+t_para.n).val(as[0].dime);	
		                			$('#txtRadius_'+t_para.n).val(as[0].radius);	
		                			$('#txtWidth_'+t_para.n).val(as[0].width);	
		                			$('#txtLengthb_'+t_para.n).val(as[0].lengthb);
		                			$('#txtSpec_'+t_para.n).val(as[0].spec);
		                			$('#txtSource_'+t_para.n).val(as[0].source);		
		                		}else{
		                			alert('找不到訂單【'+t_para.ordeno+'-'+t_para.no2+'】');
		                		}
                    			sum();
                    		}
                    		
                    	}catch(e){
                    		
                    	}
                    	break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
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

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box("z_cub_rkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'cub_rk', "95%", "95%", m_print);
            }

			function btnOk() {
				toIns = false;
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['custno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                    $('#combProcess').attr('disabled','disabled');
                } else {	
                    $('#txtDatea').datepicker();
                    $('#combProcess').removeAttr('disabled');
                }
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtOrdeno_'+i).change(function(e){
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							n = parseInt(n);
							ImportOrde(n);
						});
						$('#txtNo2_'+i).change(function(e){
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							n = parseInt(n);
							ImportOrde(n);
						});
					}
				}
				_bbsAssign();
			}
			function ImportOrde(n){
				var t_ordeno = $('#txtOrdeno_'+n).val();
				var t_no2 = $('#txtNo2_'+n).val();
				if(t_ordeno.length>0 && t_no2.length>0){
					var t_where = "where=^^ noa='"+t_ordeno+"' and no2='" + t_no2 + "' ^^";
                	q_gt('view_ordes', t_where, 0, 0, 0, JSON.stringify({action:'importOrde',n:n,ordeno:t_ordeno,no2:t_no2}), r_accy);
				}
			}
			
			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('cub_rk_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
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
				toIns = false;
				_btnDele();
			}

			function btnCancel() {
				toIns = false;
				_btnCancel();
			}

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			
			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_popPost(id) {
				switch (id) {
					default:
						break;
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
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
				width: 70%;
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
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 95%;
				float: left;
			}
			.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm select {
				font-size: medium;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs {
				width: 1730px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: lightgrey;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			.dbbs .tbbs select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
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
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:100px; color:black;">班、線別</td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='process' style="text-align: center;">~process</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl" >班、線別</a></td>
						<td>
							<select id="combProcess" class="txt c1"> </select>
							<input id="txtProcess" type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:200px;" align="center">訂單號碼</td>
						<td style="width:100px;" align="center">客戶</td>
						<td style="width:100px;" align="center">COIL<BR>規格<BR>尺寸(厚X寬)</td>
						<td style="width:100px;" align="center">COIL<BR>重量(KG)</td>
						<td style="width:100px;" align="center">前處理液<BR>總用量(KG)</td>
						<td style="width:100px;" align="center">接著劑<BR>型號<BR>規格</td>
						<td style="width:100px;" align="center">稀釋液<BR>用量/清洗(KG)</td>
						<td style="width:100px;" align="center">背漆<BR>型號規格<BR>重量(KG)</td>
						<td style="width:100px;" align="center">背漆稀釋液<BR>總用量(KG)</td>
						<td style="width:100px;" align="center">PVC皮<BR>型號<BR>規格</td>
						<td style="width:100px;" align="center">PVC皮<BR>總用量M/KG</td>
						<td style="width:100px;" align="center">PE膜<BR>型號<BR>用量M</td>
						<td style="width:100px;" align="center">RECOIL<BR>重量(KG)</td>
						<td style="width:100px;" align="center">UNCOIL<BR>RECOIL編號</td>
						<td style="width:100px;" align="center">廢料重量(KG)</td>
						<td style="width:100px;" align="center">包裝數量<BR>/LOT</td>
						<td style="width:100px;" align="center">施工工時(分)</td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input id="txtOrdeno.*" type="text" style="float:left;width:75%;"/>
							<input id="txtNo2.*" type="text" style="float:left;width:20%;"/>
						</td>
						<td>
							<input id="txtCustno.*" type="text" style="display:none;"/>
							<input id="txtComp.*" type="text" style="float:left;width:95%;"/>
							<input id="btnCust.*" type="button" style="display:none;"/>
						</td>
						<td>
							<input id="txtSize.*" type="text" style="float:left;width:95%;"/>
							<input id="txtDime.*" type="text" class="num" style="float:left;width:45%;"/>
							<input id="txtWidth.*" type="text" class="num" style="float:left;width:45%;"/>
						</td>
						<td><input id="txtWeight.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td title="前處理液總用量(KG)"><input id="txtBdime.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td title="接著劑型號規格">
							<input id="txtProductno2.*" type="text" style="width:95%;"/>
							<input id="txtProduct2.*" type="text" style="width:95%;"/>
							<input id="btnProduct2.*" type="button" style="display:none;"/>
						</td>
						<td title="稀釋液用量/清洗(KG)"><input id="txtEdime.*" type="text" class="num" style="float:left;width:95%;"/></td>
						<td title="背漆型號規格重量(KG)">
							<input id="txtBspec.*" type="text" style="float:left;width:95%;"/>
							<input id="txtHmount.*" type="text" class="num" style="float:left;width:95%;"/>
						</td>
						<td title="背漆稀釋液總用量(KG)">
							<input id="txtWmount.*" type="text" class="num" style="float:left;width:95%;"/>
						</td>
						<td title="PVC皮型號規格">
							<input id="txtSpec.*" type="text" style="float:left;width:95%;"/>
							<input id="txtRadius.*" type="text" class="num" style="float:left;width:45%;"/>
							<input id="txtLengthb.*" type="text" class="num" style="float:left;width:45%;"/>
						</td>
						<td title="PVC皮總用量M/KG">
							<input id="txtHard.*" type="text" class="num" style="float:left;width:95%;"/>
							<input id="txtLengthb2.*" type="text" class="num" style="float:left;width:95%;"/>
						</td>
						<td title="PE膜型號用量M">
							<input id="txtSource.*" type="text" style="float:left;width:95%;"/>
							<input id="txtLengthc.*" type="text" class="num" style="float:left;width:95%;"/>
						</td>
						<td title="RECOIL重量(KG)">
							<input id="txtHweight.*" type="text" class="num" style="float:left;width:95%;"/>
						</td>
						<td title="UNCOILRECOIL編號">
							<input id="txtUno.*" type="text" style="float:left;width:95%;"/>
							<input id="txtOth.*" type="text" style="float:left;width:95%;"/>
						</td>
						<td title="廢料重量(KG)">
							<input id="txtPrice.*" type="text" class="num" style="float:left;width:95%;"/>
						</td>
						<td title="包裝數量/LOT">
							<input id="txtMount.*" type="text" class="num" style="float:left;width:95%;"/>
						</td>
						<td title="施工工時(分)">
							<input id="txtBtime.*" type="text" style="float:left;width:95%;"/>
							<input id="txtEtime.*" type="text" style="float:left;width:95%;"/>
						</td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>