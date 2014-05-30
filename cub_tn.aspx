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
			var q_readonly = ['txtNoa','txtComp','txtTgg','txtMech','txtWorker'];
			var q_readonlys = ['txtComp','txtOrdeno','txtNo2'];
			var bbmNum = [];
			var bbsNum = [
				['txtHard',10,0,1],['txtHweight',10,2,1],['txtLengthb',10,2,1],
				['txtLengthc',10,2,1],['txtWidth',10,2,1],['txtMount',10,2,1]
			];
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
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,nick', 'txtCustno_', 'cust_b.aspx'],
				['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtComp', 'acomp_b.aspx'],
				['txtMechno', 'lblMechno', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'],
				['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, 'LoadFirst', r_accy);
				q_gt('process', '', 0, 0, 0, "");
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
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				bbsMask = [['txtDate2', r_picd],['txtDate3', r_picd], ['txtDatea', r_picd], ['txtBtime', '99:99'], ['txtEtime', '99:99']];
				q_mask(bbmMask);
				$('#btnOrde_tn').click(function(){
					if(q_cur==1 || q_cur==2){
						var t_cno = $.trim($('#txtCno').val());
						var t_tggno = $.trim($('#txtTggno').val());
						var t_process = $.trim($('#cmbProcessno :selected').text());
						var t_where = "(1=1) ";
						t_where += "and ((charindex(N'"+t_cno+"',substring(isnull(sizea,''),0,charindex('^$^',isnull(sizea,'')))) > 0) or (charindex(N'^$^"+t_tggno+":',isnull(sizea,'')) > 0)) "; //判斷廠別
						t_where += "and (charindex(N'"+t_process+"',isnull(sizea,'')) > 0) "; //判斷加工方式
						t_where += " ";
						q_box("ordes_tn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrde'));
					}
				});
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'process':
						var as = _q_appendData("process", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].process;
							}
							q_cmbParse("cmbProcessno", t_item);
							if(abbm[q_recno]!= undefined)
						   		$("#cmbProcessno").val(abbm[q_recno].partno);
						}
						break;
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
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordes':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0) {
								b_pop = '';
								return;
							}
							if (b_ret && b_ret[0] != undefined) {
								ret = q_gridAddRow(bbsHtm, 'tbbs', 
										'txtCustno,txtClass,txtProductno,txtProduct,txtUnit,txtWidth,txtLengthb,txtSpec,txtOrdeno,txtNo2,txtMount',
										b_ret.length, b_ret,
										'custno,class,productno,product,unit,width,lengthb,spec,noa,no2,mount', 'txtProductno');
							}
							sum();
							b_ret = '';
						}
						break;
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
				toIns = false;
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box('z_cubp_tn.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				toIns = false;
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				sum();
				var t_worker = $.trim($('#txtWorker').val());
				if(t_worker.length == 0){
					$('#txtWorker').val(r_name);
				}
				var thisCno = $.trim($('#txtCno').val());
				var thisComp = $.trim($('#txtComp').val());
				for(var k=0;k<q_bbsCount;k++){
					$('#txtCno_' + k).val(thisCno);
					$('#txtComp_' + k).val(thisComp);
				}
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
				if(toIns){
					q_gt(q_name, '', 0, 0, 0, '', r_accy);
				}
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#chkSlit_' + i).change(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if($(this).prop('checked')){
								$('#txtDate2_' + n).val(q_date());
								var timeDate= new Date();
								var tHours = timeDate.getHours();
								var tMinutes = timeDate.getMinutes();
								$('#txtBtime_' + n).val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
							}else{
								$('#txtDate2_' + n).val('');
								$('#txtBtime_' + n).val('');
							}
							CountHard(n);
						});
						$('#chkCut_' + i).change(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if($(this).prop('checked')){
								var thisDate3 = $.trim($('#txtDate3_' + n).val());
								if(thisDate3.length == 0){
									$('#txtDate3_' + n).val(q_date());
								}
								var thisEtime = $.trim($('#txtEtime_' + n).val());
								if(thisEtime.length==0){
									var timeDate= new Date();
									var tHours = timeDate.getHours();
									var tMinutes = timeDate.getMinutes();
									$('#txtEtime_' + n).val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
								}
							}else{
								$('#txtDate3_' + n).val('');
								$('#txtEtime_' + n).val('');
							}
							CountHard(n);
						});
						$('#txtDate2_'+i).focusout(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							CountHard(n);
						});
						$('#txtBtime_'+i).focusout(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							CountHard(n);
						});
						$('#txtDate3_'+i).focusout(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							CountHard(n);
						});
						$('#txtEtime_'+i).focusout(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							CountHard(n);
						});
					}
				}
				_bbsAssign();
			}

			function CountHard(n){
				var bdatea = $.trim($('#txtDate2_'+n).val());
				var edatea = $.trim($('#txtDate3_'+n).val());
				var btimea = $.trim($('#txtBtime_'+n).val());
				var etimea = $.trim($('#txtEtime_'+n).val());
				if((bdatea.length==0) || (edatea.length==0) || (btimea.length==0) || (etimea.length==0))
					return;
				bdatea = (parseInt(bdatea.substring(0,3))+1911)+bdatea.substring(3);
				edatea = (parseInt(edatea.substring(0,3))+1911)+edatea.substring(3);
				var oldtime=Date.parse(bdatea+' ' + btimea);
				var newtime=Date.parse(edatea+' ' + etimea);
				$('#txtHard_'+n).val(dec(q_div(q_div(q_sub(newtime,oldtime),1000),60)));
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
					case 'txtProductno_':
						$('#txtClass_' + b_seq).focus();
						break;
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
						<td style="width:100px; color:black;">加工方式</td>
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
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblProcessno" class="lbl" ></a></td>
						<td>
							<select id="cmbProcessno" class="txt c1"></select>
							<input id="txtProcess" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCno" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtCno" type="text" style="width:30%;"/>
							<input id="txtComp" type="text" style="width:65%;"/>
						</td>
						<td><span> </span><a id="lblTggno" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtTggno" type="text" style="width:30%;"/>
							<input id="txtTgg" type="text" style="width:65%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMechno" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtMechno" type="text" style="width:30%;"/>
							<input id="txtMech" type="text" style="width:65%;"/>
						</td>
						<td></td>
						<td><input type="button" id="btnOrde_tn"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"></td>
						<td style="width:100px;"><a id='lbl_custno'> </a></td>
						<td style="width:120px;"><a id='lbl_productno'> </a></td>
						<td style="width:300px;"><a id='lbl_product'> </a>/<a id='lbl_spec'> </a></td>
						<td style="width:80px;"><a id='lbl_lengthb'> </a></td>
						<td style="width:80px;"><a id='lbl_width'> </a></td>
						<td style="width:80px;"><a id='lbl_lengthc'> </a></td>
						<td style="width:80px;"><a id='lbl_mount'> </a></td>
						<td style="width:20px; text-align: center;">開工</td>
						<td style="width:20px; text-align: center;">完工</td>
						<td style="width:80px; text-align: center;">開工日期</td>
						<td style="width:80px; text-align: center;">開工時間</td>
						<td style="width:80px; text-align: center;">完工日期</td>
						<td style="width:80px; text-align: center;">完工時間</td>
						<td style="width:80px; text-align: center;">工時(分)</td>
						<td style="width:80px; text-align: center;">工作人員</td>
						<td style="width:150px;"><a id='lbl_memo'> </a></td>
						<td style="width:180px;"><a id='lbl_ordeno'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input id="btnCustno.*" type="button" style="float:left;width:5%;"/>
							<input id="txtCustno.*" type="text" class="txt" style="width:70%;"/>
						</td>
						<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
						<td>
							<input id="txtProduct.*" type="text" class="txt c1"/>
							<input id="txtSpec.*" type="text" class="txt c1"/>
						</td>
						<td><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWidth.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtLengthc.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
						<td><input id="chkSlit.*" type="checkbox"/></td>
						<td><input id="chkCut.*" type="checkbox"/></td>
						<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
						<td><input id="txtBtime.*" type="text" class="txt c1"/></td>
						<td><input id="txtDate3.*" type="text" class="txt c1"/></td>
						<td><input id="txtEtime.*" type="text" class="txt c1"/></td>
						<td><input id="txtHard.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtProduct2.*" type="text" class="txt c1"/></td>
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td>
							<input id="txtOrdeno.*" type="text" class="txt" style="width:65%;"/>
							<input id="txtNo2.*" type="text" class="txt" style="width:25%;"/>
						</td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>