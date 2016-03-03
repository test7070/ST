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
			var q_name = "modout";
			var q_readonly = ['txtNoa','txtModnoa','txtMech','txtWorker', 'txtWorker2'];
			var q_readonlys = ['txtNob','txtCode','txtDetail'];
			var bbmNum = [];
			var bbsNum = [['txtMount',15,0,0]];
			var bbmMask = [];
			var bbsMask = [['txtDatea',r_picd]];
			var pNoq =1;
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 3;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			q_desc = 1;
					
			aPop = new Array(
				['txtFixnoa','lblFixnoa','modfix','noa,modnoa,frame,mechno,mech','txtFixnoa,txtModnoa,txtFrame,txtMechno,txtMech','modfix_b.aspx'],
				['txtFrame','lblFrame','modfix','noa,modnoa,frame,mechno,mech','txtFixnoa,txtModnoa,txtFrame,txtMechno,txtMech','modfix_b.aspx'],
				['txtMechno','lblMechno','mech','noa,mech','txtMechno,txtMech','mech_b.aspx'],
				['txtSssno','lblSssno','nhpe','noa,namea','txtSssno,txtNamea','']
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
				bbmMask = [['txtDatea',r_picd]];
				q_mask(bbmMask);				

				$('#btnIn').click(function(){		
					//2016/01/28原匯入維修資料改匯入入庫資料							
					if(!emp($('#txtFixnoa').val()) && (q_cur == 1 || q_cur == 2) ){
						//105/02/25 判斷是否有進行 維修 
						q_gt('modfixc', "where=^^innoa='"+$('#txtFixnoa').val()+"' and isnull(fixed,0)=0 ^^", 0, 0, 0, "check_modfixs",r_accy,1);
						var as = _q_appendData("modfixc", "", true);
						if (as[0] != undefined) {
							alert('模具入庫單【'+$('#txtFixnoa').val()+'】尚在維修中【'+as[0].noa+'】!!');
						}else{
							q_gt('modfix', "where=^^noa='"+$('#txtFixnoa').val()+"'^^", 0, 0, 0, "getmodfixs",r_accy,1);
							var ass = _q_appendData("modfixs", "", true);
							//清除表身
							for(var i=0; i<q_bbsCount; i++){
								$('#btnMinus_'+i).click();
							}
							q_gridAddRow(bbsHtm, 'tbbs', 'txtNob,txtCode,txtDetail,txtFrame,txtMount,txtWeight'
							, ass.length, ass, 'nob,code1,detail1,frame1,mount1,weight1', 'txtNob');
							;
							sum();
							//q_gt('modfix', "where=^^noa='"+$('#txtFixnoa').val()+"'^^", 0, 0, 0, "ins_modfixs");	
						}
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
			
			function q_gtPost(t_name) {
				switch (t_name) {
					/*case 'ins_modfixs':
						var as = _q_appendData("modfixs", "", true);
						if (as[0] != undefined) {
							t_data1 = as;
						}
						var str = '';
						var isexist = 0;
						var pos = 0;
						for(var i=0; i<q_bbsCount; i++){//bbs最後一列之行數
							if($('#txtNob_'+i).val().length>0)
								pos = i+1;
						}
						$.each(as, function(index, elm){//判斷modfixs.nob是否已存在於bbs內:isexist->y:1,n:0
							isexist = 0;
							for(var i=0; i<q_bbsCount ;i++){							
								if(elm.nob == $('#txtNob_'+i).val()){								
									isexist = 1;				
								}
							}
							if(isexist == 0){//bbs插入該筆未存在資料列													
								q_bbs_addrow('bbs',pos++,0);
								$('#txtNob_'+(pos-1)).val(elm.nob);
								$('#txtCode_'+(pos-1)).val(elm.code1);
								$('#txtDetail_'+(pos-1)).val(elm.detail1);
								$('#txtFrame_'+(pos-1)).val(elm.frame1);
								$('#txtMount_'+(pos-1)).val(elm.mount1);
								$('#txtWeight_'+(pos-1)).val(elm.weight1);
							}
						});
						sum();
						break;*/
					case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                   		 break;	
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')],['txtMechno', q_getMsg('lblMechno')]]);
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
			    	q_gtnoa(q_name, replaceAll(q_getPara('sys.key_modout') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
			    else
			    	wrServer(t_noa);
								
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('modout_s.aspx', q_name + '_s', "500px", "40%", q_getMsg("popSeek"));
			}

			function sum() {		
				var sum = 0;
				for (var i=0; i<q_bbsCount; i++){
					sum = sum + dec($('#txtMount_'+i).val());
				}
				$('#textSum').val(sum);				
			}
			
			function bbsAssign() {			
				for (var i=0; i<q_bbsCount; i++) {	
					//計算領用數量
					$('#txtMount_'+i).change(function(){
						sum();
					});
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
				q_box('z_modout_rs.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + "' and modnoa='" + trim($('#txtModnoa').val())  + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['nob']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['date'] = abbm2['date'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);		
				refreshBbm();
				sum();
			}

			function refreshBbm() {
				$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				$('#textSum').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
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
			}.tview {
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
				width: 1000px;
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
				width: 99%;
				float: left;
			}
			.txt.c2 {
				width: 95%;
				float: left;
			}
			.txt.c3 {
				width: 49%;
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
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="mech" style="text-align: center;">~mech</td>
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
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFixnoa' class="lbl btn" > </a></td>
						<td><input id="txtFixnoa" type="text" class="txt  c1" /></td>
						<td><span> </span><a id='lblModnoa' class="lbl " > </a></td>
						<td><input id="txtModnoa" type="text" class="txt  c1" /></td>
						<td><span> </span><a id='lblFrame' class="lbl btn" > </a></td>
						<td><input id="txtFrame" type="text" class="txt  c1" /></td>
						<td><span> </span><a id='lblNoa' class="lbl " > </a></td>
						<td><input id="txtNoa" type="text" class="txt  c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMechno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtMechno" type="text" style="width:25%;"/>
							<input id="txtMech" type="text" style="width:75%; color:green;"/>
						</td>	
						<td><span> </span><a id='lblDatea' class="lbl " > </a></td>
						<td><input id="txtDatea" type="text" class="txt  c1" /></td>
						<td><span> </span><a id='lblSum' class="lbl"> </a></td>
						<td><input id="textSum"  type="text"  class="num c1" style="width:100%"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSssno' class="lbl"> </a></td>
						<td><input id="txtSssno"  type="text"  class="txt c1"/></td>
						<td><input id="txtNamea"  type="text"  class="txt c1"/></td>
						<td><span> </span><input id="btnIn" type="button" style="width: 100%"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>	
					</tr>		
				</table>
			</div>
		</div>
		<div class='dbbs' style="width:1225px">
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:15%;"><a id='lblNob_s' > </a></td>
					<td style="display: none;" align="center" style="width:5%;"><a id='lblModel_s'> </a></td>
					<td style="display: none;" align="center" style="width:5%;"><a id='lblWheel_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblCode_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblDetail_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblFrame_s'> </a></td>	
					<td align="center" style="width:10%;"><a id='lblMount_s'> </a></td>				
					<td align="center" style="width:15%;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size:medium; font-weight:bold; width:85%" value="-"/>
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td ><input id="txtNob.*" type="text" class="txt c1" style="width:98%;"/></td>
					<td style="display: none;"><input id="txtModel.*" type="text" class="txt c1" style="width:98%;"/></td>
					<td style="display: none;"><input id="txtWheel.*" type="text"  style="width:98%;"/></td>				
					<td><input id="txtCode.*" type="text"  style="width:98%;"/></td>
					<td><input id="txtDetail.*" type="text" class="txt c1" style="width:98%;"/></td>
					<td><input id="txtFrame.*" type="text" class="txt c1" style="width:98%;"/></td>					
					<td><input id="txtMount.*" type="text" class="num c1" style="width:98%;"/></td>						
					<td ><input id="txtMemo.*" type="text" class="txt c1"  style="width:98%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>