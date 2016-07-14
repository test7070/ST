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
			var q_name = "model";
			var q_readonly = ['txtWorker', 'txtWorker2'];
			var q_readonlys = ['txtProductno','txtWheel'];
			var bbmNum = [['txtFrame',10,0,0]];
			var bbsNum = [['txtMount',15,0,1], ['txtBottom',15,2,1]];
			var bbmMask = [];
			var bbsMask = [];
			var pNoq =0;
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 5;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			q_desc = 1;
			aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,nick', 'txtTggno,txtTgg', 'tgg_b.aspx']
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
			var wheel1=q_getPara('model.wheeltype1');
			var wheel2=q_getPara('model.wheeltype2');
			function mainPost() {
				q_getFormat();
				var bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);				
				q_cmbParse("cmbUsetype", q_getPara('model.usetype'));
			
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
				q_cmbParse("cmbModel",q_getPara('model.type'),'s');

				
				
		
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
					case 'checkProductno':
						var as = _q_appendData("models", "", true);

						
						if (as[0] != undefined ) {
							qPno=qPno+1;
						}else
							qPno=1;
					
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
				if ((/^(\w+|\w+\u002D\w+)$/g).test(t_noa)) {
				} else {
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
					Unlock();
					return;
				}
				
				autoProductno();
				
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
				q_box('model_rs_s.aspx', q_name + '_s', "500px", "40%", q_getMsg("popSeek"));
			}
			function changeWheel(count){
				var nb1=q_getPara('model.nbtype1')
				var nb2=q_getPara('model.nbtype2')			
				var nb3=q_getPara('model.nbtype3')
				var nb4=q_getPara('model.nbtype4')
				var nb5=q_getPara('model.nbtype5')
				var nb6=q_getPara('model.nbtype6')
				var nb7=q_getPara('model.nbtype7')
				var nb8=q_getPara('model.nbtype8')
				var wheel1=q_getPara('model.wheeltype1');
				var wheel2=q_getPara('model.wheeltype2');				
					if( $('#cmbModel_'+count).val()==1){
						q_cmbParse("combWheel_"+count,wheel1);	
						var wh= $('#txtWheel_'+count).val();
						switch(wh){
							case "主輪":
								q_cmbParse("combNumber_"+count,nb1);
								break;
							case "立輪":
								q_cmbParse("combNumber_"+count,nb2);
								break;
							case "導縫輪":
								q_cmbParse("combNumber_"+count,nb4);
								break;
							case "熔接輪":
								q_cmbParse("combNumber_"+count,nb3);
								break;
							}
						}
						else if($('#cmbModel_'+count).val()==2){
							q_cmbParse("combWheel_"+count,wheel2);
							var wh= $('#txtWheel_'+count).val();
								switch(wh){
									case "主輪":
										q_cmbParse("combNumber_"+count,nb5);
										break;
									case "立輪":
										q_cmbParse("combNumber_"+count,nb6);
										break;
									case "十字輪":
										q_cmbParse("combNumber_"+count,nb7);
										break;
									case "出口輪":
										q_cmbParse("combNumber_"+count,nb8);
										break;
							}
					}
			}
			function autoNoa(count){
				var flag =0;
				if(!emp('#txtNumber_'+count)){
					var bs =[];
					var max = 0;
					for (var j = 0; j < q_bbsCount; j++) {
						bs[j]=$('#txtNumber_'+j).val();						
					}
					for (var i =0 ;i < q_bbsCount; i++){
						if($('#txtNumber_'+count).val()==bs[i] && count != i){
							var tmp=0;
							tmp=$('#txtProductno_'+i).val().substring($('#txtProductno_'+i).val().length-1,$('#txtProductno_'+i).val().length)
							if(parseInt(tmp) > max)
								max = parseInt(tmp);
							flag = 1;
						}
					}
					if (flag == 1){
						
						pNoq=max+1;
						}
					else
						pNoq=1;
					$('#txtProductno_'+count).val($('#txtNoa').val()+$('#txtNumber_'+count).val()+pNoq);
				}
			}
			
			
			
			var flag =0;
			
			function autoProductno(){
				var bs =[];
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtNumber_'+i).val())){
						if(bs.length==0){
							bs.push({
								number:$('#txtNumber_'+i).val(),
								no:1
							})
							$('#txtProductno_'+i).val($('#txtNoa').val()+$('#txtNumber_'+i).val()+'1');
						}else{
							var t_no=0;
							var t_j=0;
							for (var j = 0; j < bs.length; j++) {
								if(bs[j].number==$('#txtNumber_'+i).val()){
									t_no=bs[j].no;
									t_j=j;
									break;
								}
							}
							if(t_no==0){
								bs.push({
									number:$('#txtNumber_'+i).val(),
									no:1
								})
								t_no=1;
								$('#txtProductno_'+i).val($('#txtNoa').val()+$('#txtNumber_'+i).val()+'1');
							}else{
								t_no=t_no+1;
								$('#txtProductno_'+i).val($('#txtNoa').val()+$('#txtNumber_'+i).val()+t_no);
								bs[t_j].no=t_no;
							}
						}
					}
				}
			}			
			
			function sum() {		
				var sum = 0;
				for (var i=0; i<q_bbsCount; i++){
					sum = sum + dec($('#txtMount_'+i).val());
				}
				$('#textSum').val(sum);				
			}
			
			function bbsAssign() {
							
				for (var j = 0; j < q_bbsCount; j++) {
					//計算庫存數
					$('#txtMount_'+j).change(function(){
						sum();
					});	
										
					$('#combWheel_'+j).change(function(){
						t_IdSeq = -1;  
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){
							$("#txtWheel_"+b_seq).val($('#combWheel_'+b_seq).find("option:selected").text())
							$("#combNumber_"+b_seq).empty();
							changeWheel(b_seq);
						}
					});
			
						changeWheel(j);

					$('#cmbModel_'+j).change(function(){
						t_IdSeq = -1;  
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;

						$("#combWheel_"+b_seq).empty();
						$("#combNumber_"+b_seq).empty();
						changeWheel(b_seq);
						
					});
											
					$('#combNumber_'+j).change(function(){
						t_IdSeq = -1;  
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){	
							$("#txtNumber_"+b_seq).val($('#combNumber_'+b_seq).find("option:selected").text())					
							autoNoa(b_seq);
						}
					});
					
					$('#txtNumber_'+j).change(function(){
						t_IdSeq = -1;  
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						var nb=$('#txtNumber_'+b_seq).val();
						var nb1=q_getPara('model.nbtype1');
						var nb2=q_getPara('model.nbtype2');		
						var nb3=q_getPara('model.nbtype3');
						var nb4=q_getPara('model.nbtype4');
						var nb5=q_getPara('model.nbtype5');
						var nb6=q_getPara('model.nbtype6');
						var nb7=q_getPara('model.nbtype7');
						var nb8=q_getPara('model.nbtype8');
						var model,wheel;
											
						if(nb1.match(nb)){
								model ="1";
								wheel ="主輪";
						}
						if(nb2.match(nb)){
								model ="1";
								wheel ="立倫";
						}
						if( nb3.match(nb)){
								model ="1";
								wheel ="導縫輪";
						}
						if(nb4.match(nb)){
								model ="1";
								wheel ="熔接輪";
						}
						if(nb5.match(nb)){
								model ="2";
								wheel ="主輪";
						}
						if(nb6.match(nb)){
								model ="2";
								wheel ="立輪";
						}
						if(nb7.match(nb)){
								model ="2";
								wheel ="十字輪";
						}
						if(nb8.match(nb)){
								model ="2";
								wheel ="出口輪";				
						}						
						
						$("#combWheel_"+b_seq).empty();
						$("#combNumber_"+b_seq).empty();
						$('#cmbModel_'+b_seq).val(model);
						changeWheel(b_seq);
						$('#txtWheel_'+b_seq).val(wheel);
					});
									
				}
				_bbsAssign();
			}
			

			function btnIns() {
				_btnIns();
				refreshBbm();
				$('#txtDatea').val(q_date());
				$('#txtNoa').focus();
			}

			function btnModi() {
				
				_btnModi();
				refreshBbm();
				$('#txtNoa').focus();
			}

			function btnPrint() {
				q_box('z_model_rs.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] ) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);		
				refreshBbm();
				sum();
			}

			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
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
				height: 38px;
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
				width: 95%;
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
						<td align="center" style="width:80px; color:black;"><a id='vewTgg'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="tgg" style="text-align: center;">~tgg</td>
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
						<td><span> </span><a id='lblNoa' class="lbl" ></a></td>
						<td><input id="txtNoa" type="text" class="txt  c1"/></td>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno"  type="text" style="width:32%;"/>
							<input id="txtTgg"  type="text" style="width:66%; color:green;"/>
						</td>		
					</tr>					
					<tr>
						<td><span> </span><a id='lblSpec' class="lbl"></a></td>
						<td><input id="txtSpec" type="text" class="txt c1 "/></td>
						<td><span> </span><a id='lblFrame' class="lbl"></a></td>
						<td><input id="txtFrame" type="text" class="c1 num"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1 "/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTube' class="lbl"></a></td>
						<td><input id="txtTube" type="text" class="txt c1 "/></td>
						<td><span> </span><a id='lblHeart' class="lbl"> </a></td>
						<td><input id="txtHeart" type="text" class="c1 num"/></td>
						<td><span> </span><a id='lblSum' class="lbl"></a></td>
						<td><input id="textSum"  type="text"  class="num c1" style="width:95%"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUsetype' class="lbl"></a></td>						
						<td><select id="cmbUsetype"  class="txt c1"></select></td>
						<td><span> </span><a id='lblSaver' class="lbl"> </a></td>
						<td><input id="txtSaver" type="text" class="txt c1 "/></td>						
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"></a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style="width: 1050px;">
				<tr style="color:white; background:#003366;">
					<td  align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20%;"><a id='lblProductno_s'></a></td>
					<td align="center" style="width:10%;"><a id='lblModelre_s'></a></td>
					<td align="center" style="width:12%;"><a id='lblWheel_s'></a></td>	
					<td align="center" style="width:12%;"><a id='lblNumber_s'></a></td>				
					<td align="center" style="width:10%;"><a id='lblBottom_s'></a></td>
					<td align="center" style="width:10%;"><a id='lblMount'></a></td>				
					<td align="center" ><a id='lblMemors2_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center" >
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold; width:25px" value="-"/>
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input id="txtProductno.*" type="text" style="width:98%;"/></td>
					<td><select id="cmbModel.*" type="text" class="txt c1"/select></td>
					<td>
						<input id="txtWheel.*" type="text" class="txt c1" style="width:75%;"/>	
						<select id="combWheel.*" type="text" class="txt c1" style="width:20%;"/select>
					</td>				
					<td>
						<input id="txtNumber.*" type="text" class="txt c1" style="width:75%;"/>
						<select id="combNumber.*" type="text" class="txt c1" style="width:20%;"/select>
					</td>						
					<td ><input id="txtBottom.*" type="text" class="num c1" style="width:98%;" /></td>
					<td ><input id="txtMount.*" type="text" class="num c1" style="width:98%;" /></td>
					<td><input id="txtMemo2.*" type="text" style="width:98%;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>