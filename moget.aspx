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
			var q_name = "moget";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtModel','txtOutnamea','txtInnamea'];
			var q_readonlys = ['txtWorkno'];
			var bbmNum = [['txtOutmount',10,0,1],['txtInmount',10,0,1]];
			var bbsNum = [['txtOrdmount',10,0,1],['txtMomount',10,0,1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 7;
			q_desc = 1;
			aPop = new Array(
				['txtModelno', 'lblModelno', 'model', 'noa,model', 'txtModelno,txtModel', 'model_b.aspx'],
				['txtOutsno', 'lblOutsno', 'sss', 'noa,namea', 'txtOutsno,txtOutnamea', 'sss_b.aspx'],
				['txtInsno', 'lblInsno', 'sss', 'noa,namea', 'txtInsno,txtInnamea', 'sss_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
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
				bbmMask = [['txtDatea', r_picd], ['txtOutdate', r_picd], ['txtIndate', r_picd],['txtOuttime','99:99'],['txtIntime','99:99']];
				q_mask(bbmMask);
				
				$('#txtWorkano').click(function() {
					if (!emp($('#txtWorkano').val())) {
						t_where = "noa='" + $('#txtWorkano').val() + "'";
						q_box("worka.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'worka', "95%", "95%", q_getMsg('PopWorka'));
					}
				});

				$('#txtWorkno').change(function() {
					if(!emp($('#txtWorkno').val())){
						if($('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')!=''){
							var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' and isnull(enda,0)!=1 and isnull(isfreeze,0)!=1 and (tggno is null or tggno='') ^^";
							q_gt('work', t_where, 0, 0, 0, "", r_accy);
						}else{
							alert("【"+$('#txtWorkno').val()+"】是模擬製令不得入庫!!");
						}
					}
				});
				$('#btnWork').click(function() {
					//1030630不用判斷工作中心是否有填寫
					var t_err = '';
					//t_err = q_chkEmpField([['txtModelno', q_getMsg('lblModelno')]]);
					t_err += '警告：\n　　　請輸入[ '+q_getMsg('lblModelno')+' ]才可匯入製令單\n';
					// 檢查空白
					if (t_err.length > 0) {
						alert(t_err);
						return;
					}
					if(!emp($('#txtWorkno').val()) && $('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')==''){
						alert("【"+$('#txtWorkno').val()+"】是模擬製令不得入庫!!");
						return;
					}
					
					if(!emp($('#txtWorkno').val())){
						var t_where = "where=^^ noa ='" + $('#txtWorkno').val() + "' and isnull(enda,0)!=1 and isnull(isfreeze,0)!=1 and (tggno is null or tggno='')^^";
						q_gt('work', t_where, 0, 0, 0, "", r_accy);
					}else{
						var t_where = '1=1 ';
						t_where += "and isnull(enda,0)!=1 and isnull(isfreeze,0)!=1 and (tggno is null or tggno='')";
						
						/*if (!emp($('#txtStationno').val())) 
							t_where += " and stationno='" + $('#txtStationno').val() + "' ";*/
						if (!emp($('#txtModelno').val())) 
							t_where += " and Modelno='" + $('#txtModelno').val() + "' ";
							
						var workno = $.trim($('#txtWorkno').val());
						if(workno.length > 0 ){
							t_where += " and noa=N'"+workno+"'";
						}
						
						//1030310 加入應完工日的條件
						var t_bdate = $.trim($('#txtOutdate').val());
						var t_edate = $.trim($('#txtIndate').val());
						if(t_bdate.length > 0 || t_edate.length>0){
							if(t_edate.length == 0) t_edate=r_picd
							t_where += " and uindate between '"+t_bdate+"' and '"+t_edate+"'";
						}
						t_where+=" and noa like 'W[0-9]%' ";
						
						//原先的資料
						t_where += " or noa in (select noa from mogets where noa='" + $('#txtNoa').val() + "')";
						
						q_box("work_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('popWork'));
					}
				});
				$('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});
				
				if (q_getPara('sys.project').toUpperCase()=='AD' || q_getPara('sys.project').toUpperCase()=='JO'){
					$('.team').show();
				}
			}
			function getInStr(HasNoaArray) {
				var NewArray = new Array();
				for (var i = 0; i < HasNoaArray.length; i++) {
					NewArray.push("'" + HasNoaArray[i].noa + "'");
				}
				return NewArray.toString();
			}
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'work':
						b_ret = getb_ret();
						if (b_ret && (q_cur == 1 || q_cur == 2)) {
							/*$('#txtStationno').val(b_ret[0].stationno);
							$('#txtStation').val(b_ret[0].station);*/
							$('#txtModelno').val(b_ret[0].Modelno);
							$('#txtModel').val(b_ret[0].model);
							//清空表身資料
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_' + i).click();
							}
							var t_where = "where=^^ noa in(" + getInStr(b_ret) + ")^^";
							q_gt('work', t_where, 0, 0, 0, "", r_accy);
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'modelStk_Check':
						var t_noa = trim($('#txtNoa').val());
						var t_date = trim($('#txtDatea').val());
						var t_modelno = trim($('#txtModelno').val());
						var t_outmount = dec($('#txtOutmount').val());
						var t_inmount = dec($('#txtInmount').val());
						var trueMount = 0;
						var s_stkmount = 0;
						var t_err = '';
						var as = _q_appendData("view_modelstk", "", true);
						if (as[0] != undefined){
							var t_mount = 0;
							for(var i=0;i<as.length;i++){
								var thisStkType = as[i].stktype;
								var thisMount = dec(as[i].mount);
								if(as[i].tablea=='moget'){
									trueMount = trueMount+(thisMount*(thisStkType=='1'?(-1):1));
								}
								t_mount = t_mount+(thisMount*(thisStkType=='1'?(1):(-1)));
							}
							s_stkmount = dec(t_mount);
							t_mount = t_mount-t_outmount+t_inmount;
							if(t_mount < 0){
								t_err += '庫存量不足，無法領用。\n';
								t_err += '當前庫存：'+s_stkmount+'。';
							}else if(((trueMount+t_outmount) < t_inmount)){
								t_err += '歸還數量異常。\n';
								t_err += '已借用量：'+trueMount+'。';
							}
						}else{
							t_err += '該模具不存在\n';
						}
						if(t_err.length > 0){
							alert(t_err);
							Unlock();
							return;
						}
						if(q_cur==1)
							$('#txtWorker').val(r_name);
						else
							$('#txtWorker2').val(r_name);
						
						if (t_noa.length == 0 || t_noa == "AUTO")
							q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
						else
							wrServer(t_noa);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;

					case 'work':
						var as = _q_appendData("work", "", true);
						var t_modelno = '', t_model = '';
						for ( var i = 0; i < as.length; i++) {
							for (var j = 0; j < q_bbsCount; j++) {
								if(!emp($('#txtWorkno_'+j).val()) && as[i].noa==$('#txtWorkno_'+j).val()){
									//排除已在BBS內的work
									as.splice(i, 1);
									i--;
									break;
								}
							}
						}
						for ( var i = 0; i < as.length; i++) {
							if (as[i].modelno != '') {
								t_modelno = as[i].modelno;
								t_model = as[i].model;
							}
							//扣掉本入庫單以入庫的數量
							for (var j = 0; j < abbsNow.length; j++) {
								if (abbsNow[j].workno == as[i].noa) {
									as[i].inmount = dec(as[i].inmount) - dec(abbsNow[j].mount);
								}
							}
							//本次入庫量
							as[i].smount=dec(as[i].mount)-dec(as[i].inmount);
						}
						
						var ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtStyle,txtUnit,txtSpec,txtMount,txtMemo,txtWorkno,txtOrdeno,txtNo2,txtWk_mount,txtWk_inmount,txtWk_unmount', as.length, as
						, 'productno,product,style,unit,spec,smount,memo,noa,ordeno,no2,mount,inmount,smount', 'txtWorkno');

						if (t_modelno.length != 0 || t_station.length != 0) {
							$('#txtModelno').val(t_modelno);
							$('#txtmodel').val(t_model);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('moget_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}
			
			function btnIns() {
				_btnIns();
				$('#txtDatea').val(q_date());
				$('#txtNoa').val('AUTO');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}
			

			function btnPrint() {
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}
			
			function bbsAssign(){
				for (var i = 0; i < q_bbsCount ; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
					}
				}
				_bbsAssign();
			}

			function bbsSave(as) {
				if (!as['ordeno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			function btnOk() {
				Lock();
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtModelno', q_getMsg('lblModelno')]]);
				var t_err2 = '';
				var t_outsno = $.trim($('#txtOutsno').val());
				var t_outdate = $.trim($('#txtOutdate').val());
				var t_outtime = $.trim($('#txtOuttime').val());
				var t_outmount = dec($('#txtOutmount').val());
				var t_insno = $.trim($('#txtInsno').val());
				var t_indate = $.trim($('#txtIndate').val());
				var t_inmount = dec($('#txtInmount').val());
				var t_intime = $.trim($('#txtIntime').val());
				if (t_outmount==0 || t_outsno.length==0 || t_outdate.length==0 || t_outtime.length==0){
					t_err2 += '請檢查['+q_getMsg('lblOutsno')+']　是否有輸入\n　　　';
					t_err2 += '['+q_getMsg('lblOutdate')+']\n　　　['+q_getMsg('lblOuttime')+']\n　　　['+q_getMsg('lblOutmount')+']\n';
				}else if (t_inmount==0 || t_insno.length==0 || t_indate.length==0 || t_intime.length==0){
					t_err2 += '請檢查['+q_getMsg('lblInsno')+']　是否有輸入\n　　　';
					t_err2 += '['+q_getMsg('lblIndate')+']\n　　　['+q_getMsg('lblIntime')+']\n　　　['+q_getMsg('lblInmount')+']\n';
				}
				/*if(t_outmount==0 && t_inmount==0){
					t_err2 += '請輸入['+q_getMsg('lblOutmount')+']或['+q_getMsg('lblInmount') + ']\n';
				}else{
					if(t_outmount > 0 && (t_outsno.length==0 || t_outdate.length==0 || t_outtime.length==0)){
						if(t_outsno.length==0 && t_outdate.length==0 && t_outtime.length==0){
							t_err2 += '請檢查['+q_getMsg('lblOutsno')+']\n['+q_getMsg('lblOutdate')+']\n['+q_getMsg('lblOuttime')+']\n是否有輸入';
						}
					}else if(t_outmount == 0){
						t_err2 += '請輸入['+q_getMsg('lblOutmount')+']\n';
					}
					
					if(t_inmount > 0 && (t_insno.length==0 || t_indate.length==0)){
						if(t_insno.length==0){
							t_err2 += '請輸入['+q_getMsg('lblInsno')+']\n';
						}else{
							t_err2 += '請輸入['+q_getMsg('lblIndate')+']\n';
						}
					}else if(t_inmount == 0 && (t_insno.length>0 || t_indate.length>0)){
						t_err2 += '請輸入['+q_getMsg('lblInmount')+']\n';
					}
				}*/
				if (t_err.length > 0 || t_err2.length > 0) {
					alert(t_err+t_err2);
					Unlock();
					return;
				}
				var t_modelno = trim($('#txtModelno').val());
				var t_where = "where=^^ (modelno='"+t_modelno+"') and (noa!='"+t_noa+"')^^";
				q_gt('view_modelstk', t_where, 0, 0, 0, "modelStk_Check", r_accy);
			}
			
			
			function wrServer(key_value) {
				var i;
				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
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
				dataErr = !_q_appendData(t_Table);
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
				width: 330px;
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
				width: 620px;
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
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl_1 {
				float: left;
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
			.c1 {
				width: 95%;
				float: left;
			}
			.c1_1 {
				width: 40%;
				float: left;
			}
			.c2 {
				width: 35%;
				float: left;
			}
			.c3 {
				width: 60%;
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
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 740px;
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
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewModelno'> </a></td>
						<td align="center" style="width:250px; color:black;"><a id='vewModel'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='modelno' style="text-align: center;">~modelno</td>
						<td id='model,8' style="text-align: left;">~model,8</td>
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
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblModelno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtModelno" type="text" class="txt c2" />
							<input id="txtModel" type="text" class="txt c3" />
						</td>
						<td><input type="button" id="btnWork"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOutsno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtOutsno" type="text" class="txt c2" />
							<input id="txtOutnamea" type="text" class="txt c3" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOutdate' class="lbl"> </a></td>
						<td><input id="txtOutdate" type="text" class="txt c1"/></td>
						<td><a id='lblOuttime' class="lbl_1"></a><input id="txtOuttime" type="text" class="txt c1_1"/></td>
						<td><span></span><a id='lblOutmount' class="lbl"></a></td>
						<td><input id="txtOutmount" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInsno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtInsno" type="text" class="txt c2" />
							<input id="txtInnamea" type="text" class="txt c3" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate" type="text" class="txt c1"/></td>
						<td><a id='lblIntime' class="lbl_1"></a><input id="txtIntime" type="text" class="txt c1_1"/></td>
						<td><span> </span><a id='lblInmount' class="lbl"> </a></td>
						<td><input id="txtInmount" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtMemo" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /> </td>
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
						<td align="center" style="width:120px;"><a id='lblOrdeno_s'> </a></td>
						<td align="center" style="width:30px;"><a id='lblNo2_s'> </a></td>
						<td align="center" style="width:120px;"><a id='lblProductno_s'> </a></td>
						<td align="center" style="width:120px;"><a id='lblProduct_s'> </a></td>
						<td align="center" style="width:80px;"><a id='lblOrdmount_s'> </a></td>
						<td align="center" style="width:80px;"><a id='lblMomount_s'> </a></td>
						<td align="center" style="width:130px;"><a id='lblWorknos_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td>
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td><input class="txt c1" id="txtOrdeno.*" type="text" /></td>
						<td><input class="txt c1" id="txtNo2.*" type="text" /></td>
						<td>
							<input class="btn" id="btnProductno.*" type="button" value='.' style="float:left;font-weight: bold;width:1%;" />
							<input id="txtProductno.*" type="text" style="width:80%;" />
						</td>
						<td><input class="txt c1" id="txtProduct.*" type="text" /></td>
						<td><input class="txt c1 num" id="txtOrdmount.*" type="text" /></td>
						<td><input class="txt c1 num" id="txtMomount.*" type="text" /></td>
						<td><input class="txt c1" id="txtWorkno.*" type="text" /></td>
						<td style="display:none;">
							<input id="txtNoq.*" type="hidden" />
							<input id="recno.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>