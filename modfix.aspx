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
			var q_name = "modfix";
			var q_readonly = ['txtWorker', 'txtWorker2','txtNoa','txtMech'];
			var q_readonlys = ['txtDetail1','txtDetail2','txtModel','txtNob','txtWheel1','txtCode1'];
			var bbmNum = [];
			var bbsNum = [['txtMount1',15,0,0], ['txtWeight1',15,1,0]];
			var bbmMask = [];
			var bbsMask = [];
			var pNoq =1;
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 3;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			
			aPop = new Array(			
				['txtModnoa','lblModnoa','model','noa','txtModnoa','model_b2.aspx'],
				['txtMechno','lblMechno','mech','noa,mech','txtMechno,txtMech','mech_b.aspx']
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
				
				q_cmbParse("cmbWay1",'傳統車床(砂紙研磨),傳統車床(砂輪機研磨),CNC車修,不須車修或研磨','s');
				q_cmbParse("cmbModel",q_getPara('model.type'),'s');
				
				$('#btnIn').click(function(){				
					if(!emp($('#txtModnoa').val()) && (q_cur == 1 || q_cur == 2)){
						t_where = "where=^^noa='"+$('#txtModnoa').val()+"'^^"
						q_gt('model', t_where, 0, 0, 0, "ins_model");
						t_where = "where=^^noa='"+$('#txtModnoa').val()+"'^^"
						q_gt('models', t_where, 0, 0, 0, "ins_models");
					}
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
			
			var z_frame='';
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ins_models':
						var as = _q_appendData("models", "", true);
						var str = '';
						var isexist = 0;
						var pos = 0;
						for(var i=0; i<q_bbsCount; i++){
							if($('#txtNob_'+i).val().length>0)
								pos = i+1;
						}
						for(var i=as.length-1; i>=0; i--){//判斷model.productno是否已存在於bbs內:isexist->y:1,n:0
							isexist = 0;
							for(var j=0; j<q_bbsCount ;j++){							
								if(as[i].productno == $('#txtNob_'+j).val()){								
									isexist = 1;				
								}
							}
							if(isexist == 0){//bbs插入該筆未存在資料列													
								q_bbs_addrow('bbs',pos++,0);
								$('#txtNob_'+(pos-1)).val(as[i].productno);
								$('#txtCode1_'+(pos-1)).val(as[i].number);
								$('#txtDetail1_'+(pos-1)).val((as[i].model=='1'?'成型段':'定徑段')+as[i].wheel+as[i].number);
								$('#txtFrame1_'+(pos-1)).val(z_frame);
							}
						}	
						break;
					case 'ins_model':
						var as = _q_appendData("model", "", true);
						if (as[0] != undefined) {
							z_frame = as[0].frame;
						}
						break;	
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
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
				
				var t_noa = trim($('#txtNoa').val());
			    var t_date = trim($('#txtDatea').val());
			    if (t_noa.length == 0 || t_noa == "AUTO")
			    	q_gtnoa(q_name, replaceAll(q_getPara('sys.key_modfix') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
			    else
			    	wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('modfix_s.aspx', q_name + '_s', "500px", "40%", q_getMsg("popSeek"));
			}

			function bbsAssign() {		
				//自動抓取第一筆資料
				$('#cmbWay1_0').change(function(){	
					for (var j=1; j<q_bbsCount; j++){
						$('#cmbWay1_'+j).val($('#cmbWay1_0').val());
					}
				});							
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
				q_box('z_modfix_rs.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['nob'] || !as['frame1'] || !as['mount1']) {
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
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 5px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 800px;
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
				height: 43px;
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
						<td align="center" style="width:80px; color:black;"><a id='vewMech'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="mech" style="text-align: center;">~mech</td>
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
						<td></td>
						<td></td>
						<td></td>						
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblModnoa' class="lbl btn" ></a></td>
						<td><input id="txtModnoa" type="text" class="txt  c1" /></td>
						<td><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td><input id="txtDatea" type="text" class="txt c1" style="float: left;"/></a></td>
						<td><span> </span><a id='lblNoa' class="lbl "></a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>		
					</tr>
					<tr>				
						<td><span> </span><a id="lblMechno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtMechno"  type="text" style="width:34%;"/>
							<input id="txtMech"  type="text" style="width:66%; color:green;"/>
						</td>	
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"></a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td></td>
						<td><span> </span><input id="btnIn" type="Button"/></td>

					</tr>
						
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style="width:1130px;">
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:10%;"><a id='lblNoa_s'></a></td>
					<td style="display: none;" align="center" style="width:8%;"><a id='lblModel_s'></a></td>
					<td style="display: none;" align="center" style="width:8%;"><a id='lblWheel1_s'></a></td>
					<td align="center" style="width:8%;"><a id='lblCode1_s'></a></td>
					<td align="center" style="width:10%;"><a id='lblDetail1_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblFrame1_s'></a></td>										
					<td align="center" style="width:10%;"><a id='lblWay1_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblMount1_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblWeight1_s'></a></td>
					<td style="display:none;"align="center" style="width:8%;"><a id='lblWheel2_s'></a></td>				
					<td style="display:none;" align="center" style="width:8%;"><a id='lblCode2_s'></a></td>
					<td style="display:none;" align="center" style="width:12%;"><a id='lblDetail2_s'></a></td>
					<td style="display:none;" align="center" style="width:5%;"><a id='lblFrame2_s'></a></td>
					<td style="display:none;" align="center" style="width:5%;"><a id='lblMount2_s'></a></td>
					<td style="display:none;" align="center" style="width:5%;"><a id='lblWay2_s'></a></td>
					<td style="display:none;" align="center" style="width:5%;"><a id='lblWeight2_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size:medium; font-weight:bold; width:70%;" value="-"/>
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td ><input id="txtNob.*" type="text" class="txt c1" style="width : 98% ;"/></td>
					<td style="display: none;"><input id="txtModel.*" type="text" class="txt c1" style="width : 98% ;"/></td>
					<td style="display: none;"><input id="txtWheel1.*" type="text"  style="width : 98% ;"/></td>
					<td><input id="txtCode1.*" type="text"  style="width : 98% ;"/></td>
					<td><input id="txtDetail1.*" type="text" class="txt c1" style="width:98%;"/></td>
					<td><input id="txtFrame1.*" type="text" class="num c1" style="width:98%;"/></td>																
					<td ><select id="cmbWay1.*" type="text" class="txt c1" style="width:99%;"/select></td>
					<td><input id="txtMount1.*" type="text" class="num c1" style="width:98%;"/></td>
					<td ><input id="txtWeight1.*" type="text" class="num c1" style="width:95%;"/></td>
					<td style="display:none;"><input id="txtWheel2.*" type="text"  style="width:70%;"/></td>	
					<td style="display:none;"><input id="txtCode2.*" type="text" style="width:70%;"/></td>
					<td style="display:none;"><input id="txtDetail2.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td style="display:none;"><input id="txtFrame2.*" type="text" class="num c1" style="width:95%;"/></td>
					<td style="display:none;"><input id="txtMount2.*" type="text" class="num c1" style="width:95%;"/></td>
					<td style="display:none;"><input id="txtWay2.*" type="text" class="num c1" style="width:95%;"/></td>
					<td style="display:none;"><input id="txtWeight2.*" type="text" class="num c1" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>