<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
		
			var q_name = 'ssschg', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
			var t_sqlname = 'ssschg_load'; t_postname = q_name;
			var isBott = false;  /// 是否已按過 最後一頁
			var afield, t_htm;
			var i, s1;
			var decbbs = ['money', 'bo_admin', 'bo_traffic', 'bo_full', 'bo_special', 'bo_oth', 'salary','meals'];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtMoney',10,0,1],['txtBo_admin',10,0,1],['txtBo_traffic',10,0,1],['txtBo_special',10,0,1],['txtBo_oth',10,0,1],['txtBo_full',10,0,1],['txtSalary',10,0,1],['txtMeals',10,0,1]];
			var bbmMask = [];
			var bbsMask = [];
			aPop = new Array(['txtOpartno_', 'txtOpartno_', 'part', 'noa,part', 'txtOpartno_,txtOpart_','part_b.aspx'],
			['txtApartno_', 'txtApartno_', 'part', 'noa,part', 'txtApartno_,txtApart_','part_b.aspx'],
			['txtOjobno_', 'txtOjobno_', 'salm', 'noa,job', 'txtOjobno_,txtOjob_','salm_b.aspx'],
			['txtAjobno_', 'txtAjobno_', 'salm', 'noa,job', 'txtAjobno_,txtAjob_','salm_b.aspx']);
			$(document).ready(function () {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (location.href.indexOf('?') < 0)   // debug
				{
					location.href = location.href + "?;;;noa='0015'";
					return;
				}
				if (!q_paraChk())
					return;
				
				main();
			});            /// end ready

			function main() {
				if (dataErr)  /// 載入資料錯誤
				{
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname);
			}

			function mainPost() {
				q_getFormat();
				bbsMask = [['txtDatea', r_picd],['txtBfdatea', r_picd]];
				q_mask(bbsMask);

				

				
				var no_auth=true;
				
				for(var i = 0; i < q_auth.length; i++) {
					var t_modi= (q_auth[i].substr(q_auth[i].indexOf(',')+1,5)).substr(4,1);
					
					if(q_auth[i].substr(0,q_auth[i].indexOf(','))=='ssschg'&&t_modi=='1'){
						no_auth=false;
						break;
					}
				}
				
				if(r_rank<8 && no_auth)
					$('#btnModi').hide();
			}

			function bbsAssign() {  /// 表身運算式
				for(var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtDatea_'+j).blur(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(b_seq>=0&&!emp($('#txtDatea_'+b_seq).val())){
								if(!emp($('#txtDatea_'+(b_seq-1)).val())){
									if(emp($('#txtTypea_'+b_seq).val())){
										$('#txtTypea_'+b_seq).val($('#txtTypea_'+(b_seq-1)).val());
									}
									if(emp($('#txtBfdatea_'+b_seq).val())){
										$('#txtBfdatea_'+b_seq).val($('#txtBfdatea_'+(b_seq-1)).val());
									}
									if(emp($('#txtOpartno_'+b_seq).val())){
										$('#txtOpartno_'+b_seq).val($('#txtOpartno_'+(b_seq-1)).val());
									}
									if(emp($('#txtOpart_'+b_seq).val())){
										$('#txtOpart_'+b_seq).val($('#txtOpart_'+(b_seq-1)).val());
									}
									if(emp($('#txtApartno_'+b_seq).val())){
										$('#txtApartno_'+b_seq).val($('#txtApartno_'+(b_seq-1)).val());
									}
									if(emp($('#txtApart_'+b_seq).val())){
										$('#txtApart_'+b_seq).val($('#txtApart_'+(b_seq-1)).val());
									}
									if(emp($('#txtOjobno_'+b_seq).val())){
										$('#txtOjobno_'+b_seq).val($('#txtOjobno_'+(b_seq-1)).val());
									}
									if(emp($('#txtOjob_'+b_seq).val())){
										$('#txtOjob_'+b_seq).val($('#txtOjob_'+(b_seq-1)).val());
									}
									if(emp($('#txtAjobno_'+b_seq).val())){
										$('#txtAjobno_'+b_seq).val($('#txtAjobno_'+(b_seq-1)).val());
									}
									if(emp($('#txtAjob_'+b_seq).val())){
										$('#txtAjob_'+b_seq).val($('#txtAjob_'+(b_seq-1)).val());
									}
									if(emp($('#txtOclass5_'+b_seq).val())){
										$('#txtOclass5_'+b_seq).val($('#txtOclass5_'+(b_seq-1)).val());
									}
									if(emp($('#txtAclass5_'+b_seq).val())){
										$('#txtAclass5_'+b_seq).val($('#txtAclass5_'+(b_seq-1)).val());
									}
									if(emp($('#txtReason_'+b_seq).val())){
										$('#txtReason_'+b_seq).val($('#txtReason_'+(b_seq-1)).val());
									}
									if(emp($('#txtHandover_'+b_seq).val())){
										$('#txtHandover_'+b_seq).val($('#txtHandover_'+(b_seq-1)).val());
									}
								}
							}
						});
					}
				}
				_bbsAssign();
				
			}
			
			function btnOk() {
				sum();
				
				t_key = q_getHref();
				
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['datea'] ) {  // Dont Save Condition
					as[bbsKey[0]] = '';   /// noa  empty --> dont save
					return;
				}

				q_getId2('', as);  // write keys to as
				
				return true;

			}

			function btnModi() {
				var t_key = q_getHref();
				
				if (!t_key)
					return;
				
				_btnModi();
				
				/*for (i = 0; i < abbsDele.length; i++) {
					abbsDele[i][bbsKey[0]] = t_key[1];
				}*/
				/*if(emp($('#txtDatea_0').val()))
					$('#txtDatea_0').val(q_date());
				$('#txtJobno_0').focus();*/
			}

			function boxStore() {
			
			}
			
			function refresh() {
				_refresh();
			}
			
			function sum() { }
			
			function q_gtPost() {
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();  /// 表身運算式
			}

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            .tbbs {
                font-size: 12pt;
                color: blue;
                text-align: left;
                border: 1px #DDDDDD solid;
                width: 100%;
                height: 100%;
            }
            .txt.c1 {
                width: 95%;
            }
            .td1 {
                width: 2%;
            }
            .td2 {
                width: 4%;
            }
            .td3 {
                width: 5%;
            }
            .td4 {
                width: 7%;
            }
            .txt.num {
                text-align: right;
            }

		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1'   >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<!--<td align="center" class="td1"><a id='lblNoa'></a></td>-->
					<td align="center" class="td4"><a id='lblDatea'> </a></td>
					<td align="center" class="td2"><a id='lblTypea'> </a></td>
					<td align="center" class="td4"><a id='lblBfdatea'> </a></td>
					<td align="center" class="td2"><a id='lblOpartno'> </a></td>
					<td align="center" class="td4"><a id='lblOpart'> </a></td>
					<td align="center" class="td2"><a id='lblApartno'> </a></td>
					<td align="center" class="td4"><a id='lblApart'> </a></td>
					<td align="center" class="td2"><a id='lblOjobno'> </a></td>
					<td align="center" class="td4"><a id='lblOjob'> </a></td>
					<td align="center" class="td2"><a id='lblAjobno'> </a></td>
					<td align="center" class="td4"><a id='lblAjob'> </a></td>
					<td align="center" class="td4"><a id='lblOclass5'> </a></td>
					<td align="center" class="td4"><a id='lblAclass5'> </a></td>
					<td align="center" class="td4"><a id='lblReason'> </a></td>
					<td align="center" class="td4"><a id='lblHandover'> </a></td>
					<td align="center" class="td4"><a id='lblMemo'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td ><input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  /></td>
					<td >
						<input class="txt c1"  id="txtDatea.*" type="text"  />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td ><input class="txt c1" id="txtTypea.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtBfdatea.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtOpartno.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtOpart.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtApartno.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtApart.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtOjobno.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtOjob.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtAjobno.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtAjob.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtOclass5.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtAclass5.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtReason.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtHandover.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtMemo.*" type="text" /></td>

				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
