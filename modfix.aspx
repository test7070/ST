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
			var q_readonly = ['txtWorker', 'txtWorker2','txtModNoa'];
			var q_readonlys = ['txtDetail1','txtDetail2','txtModel','txtNob','txtWheel1','txtCode1'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [['txtFrame1','99']];
			var pNoq =1;
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 5;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			q_desc = 1;
			
			aPop = new Array(
			//	['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', "tgg_b.aspx"],
				['txtNoa','lblNoa','model','noa','txtNoa','model_c.aspx'],
				['txtMech','lblMech','modeq','namea','txtMech','modeq_b2.aspx']
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
				//q_cmbParse("cmbType",' ,繪圖,領休,送修');	
				$('#btnIn').click(function(){				
					if(!emp($('#txtNoa').val()) && (q_cur == 1 || q_cur == 2)){
						q_gt('models', "where=^^noa='"+$('#txtNoa').val()+"'^^", 0, 0, 0, "ins_models");
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
			var delId='';
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ins_models':
					
						var as = _q_appendData("models", "", true);
					//	btnModi();
						//var i=0
						if(as.length-q_bbsCount >=0){
							for(var i=0;i<as.length;i++){
								q_bbs_addrow('bbs','a','') ;					
							}
						}
						var nob=[];
										
						var i;
						var seq=0;
						var flag ='0';
						for(i=0;i<q_bbsCount;i++){
							var check =0;
							$.each(as,function(index,element){	
								if(element != undefined)														
									if($('#txtNoa_'+ i ).val()== element.productno )
										check=1;																
					
							});
							/*for(var j =0 ;j<q_bbsCount;j++)	{
								if(as[i]!= undefined){	
									if($('#txtCode1_'+ j).val()==as[i].number)
										check=1;
									}
							}*/
							if(check == 0){	
								if(as[i]!= undefined){	
																
										$('#txtNob_'+ seq ).val(as[i].productno);
										$('#txtModel_'+ seq ).val(as[i].model);
										$('#txtWheel1_'+ seq).val(as[i].wheel);
										$('#txtCode1_'+ seq).val(as[i].number);
										$('#txtDetail1_'+ seq ).val(as[i].model+as[i].wheel+as[i].number);
										seq=seq+1
								}									
							}
						}							

													
						
						break;
					case 'chk_models':
					
						break;
				}
			}

			function btnOk() {
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				var t_modnoa = trim($('#txtModNoa').val());	
				var t_date = trim($('#txtDatea').val());
				if (t_modnoa.length == 0 || t_noa == "AUTO")
		            $('#txtModNoa').val(replaceAll(q_getPara('sys.key_modfix') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				
				var t_noa = trim($('#txtNoa').val());	        
		        if (t_noa.length == 0)
		            alert('模具編號不可為空');
		        else
		            wrServer(t_noa);
				
			}

			function _btnSeek() {

			}
		
				
			

			var flag =0;
			function bbsAssign() {
								
				for (var j = 0; j < q_bbsCount; j++) {	
					$('#txtWay1_'+j).change(function(){
						t_IdSeq = -1;  
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if($('#txtWay1_'+b_seq).val()>4 || $('#txtWay1').val() <1){
							alert('研磨方式請輸入數字1~4之間');
							$('#txtWay1_'+b_seq).val(1);
						}
					})
				}
				_bbsAssign();
			}
			

			

			function btnIns() {
				_btnIns();
				$('#txtModNoa').val('AUTO');
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
				if (!as['nob'] || !as['frame1'] || !as['weight1'] || !as['mount1'] || !as['way1']) {
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl btn" ></a></td>
						<td><input id="txtNoa" type="text" class="txt  c1" style="width : 130% ;"/></td>
						<td><span> </span><a id='lblMech' class="lbl btn"></a></td>
						<td><input id="txtMech" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblModNoa' class="lbl "></a></td>
						<td><input id="txtModNoa" type="text" class="txt c1"/></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td><input id="txtDatea" type="text" class="txt c1 num" style="float: left;"/></a></td>
						
						
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"></a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='' class="lbl"></a></td>
						<td><span> </span><input id="btnIn" type="Button"  style="float: left;"/></td>

					</tr>
						
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:10%;"><a id='lblNoa_s'></a></td>
					<td style="display: none;" align="center" style="width:8%;"><a id='lblModel_s'></a></td>
					<td style="display: none;" align="center" style="width:8%;"><a id='lblWheel1_s'></a></td>
					<td align="center" style="width:8%;"><a id='lblCode1_s'></a></td>
					<td align="center" style="width:12%;"><a id='lblDetail1_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblFrame1_s'></a></td>	
					<td align="center" style="width:5%;"><a id='lblMount1_s'></a></td>				
					<td align="center" style="width:5%;"><a id='lblWay1_s'></a></td>
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
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td ><input id="txtNob.*" type="text" class="txt c1" style="width : 95% ;"/></td>
					<td style="display: none;"><input id="txtModel.*" type="text" class="txt c1" style="width : 95% ;"/></td>
					<td style="display: none;"><input id="txtWheel1.*" type="text"  style="width : 95% ;"/></td>
					<td><input id="txtCode1.*" type="text"  style="width : 95% ;"/></td>
					<td><input id="txtDetail1.*" type="text" class="txt c1" style="width : 95% ;"/></td>
					<td><input id="txtFrame1.*" type="text" class="num c1" style="width : 95% ;"/></td>					
					<td><input id="txtMount1.*" type="text" class="num c1" style="width : 95% ;"/></td>						
					<td ><input id="txtWay1.*" type="text" class="num c1"  style="width : 95% ;"/></td>
					<td ><input id="txtWeight1.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td style="display:none;"><input id="txtWheel2.*" type="text"  style="width : 70% ;"/>
						
					</td>
					<td style="display:none;"><input id="txtCode2.*" type="text" style="width : 70% ;"/>
						
					</td>
					<td style="display:none;"><input id="txtDetail2.*" type="text" class="txt c1" style="width : 95% ;"/></td>
					<td style="display:none;"><input id="txtFrame2.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td style="display:none;"><input id="txtMount2.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td style="display:none;"><input id="txtWay2.*" type="text" class="num c1" style="width : 95% ;"/></td>
					<td style="display:none;"><input id="txtWeight2.*" type="text" class="num c1" style="width : 95% ;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>