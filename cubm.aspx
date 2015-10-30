<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
		
			var q_name = 'cubm', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
			var t_sqlname = 'cubm_load'; t_postname = q_name;
			var isBott = false;  /// 是否已按過 最後一頁
			var afield, t_htm;
			var i, s1;
			var decbbs = ['gmount','gweight','mount','weight','length'];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			aPop = new Array(['txtMechno_', 'btnMech_', 'mech', 'noa,mech', 'txtMecho_,txtMech','mech_b.aspx']);
			$(document).ready(function () {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
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
				bbsMask = [['txtDatea', r_picd]];
				q_mask(bbsMask);
				
				/*var no_auth=true;
				
				for(var i = 0; i < q_auth.length; i++) {
					var t_modi= (q_auth[i].substr(q_auth[i].indexOf(',')+1,5)).substr(4,1);
					
					if(q_auth[i].substr(0,q_auth[i].indexOf(','))=='saladjust'&&t_modi=='1'){
						no_auth=false;
						break;
					}
				}
				
				if(r_rank<8 && no_auth)
					$('#btnModi').hide();*/
			}

			function bbsAssign() {  /// 表身運算式
				for(var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
							$('#txtMechno_' + j).bind('contextmenu', function(e) {
	                            /*滑鼠右鍵*/
	                            e.preventDefault();
	                            var n = $(this).attr('id').replace('txtMechno_', '');
	                            $('#btnMech_'+n).click();
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
			}

			function boxStore() {
			
			}
			
			function refresh() {
				_refresh();
			}
			
			function sum() { }
			
			var salrank=[];
			var salranks=[];
			function q_gtPost(t_postname) {  /// 資料下載後 ...
				switch (t_postname) {
					default:
					break;
				}  
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
            .txt.num {
                text-align: right;
            }

		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1'   >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;"><a id='lblDatea'>作業日期</a></td>
					<td align="center" style="width:100px;"><a id='lblOrdeno'>訂單號碼</a></td>
					<td align="center" style="width:120px;"><a id='lblUno'>批號</a></td>
					<td align="center" style="width:100px;"><a id='lblMech'>機台</a></td>
					<td align="center" style="width:150px;"><a id='lblTime'>加工時間</a></td>
					<td align="center" style="width:70px;"><a id='lblGmount'>領料數</a></td>
					<td align="center" style="width:70px;"><a id='lblGweight'>領料重</a></td>
					<td align="center" style="width:70px;"><a id='lblLength'>加工米數</a></td>
					<td align="center" style="width:70px;"><a id='lblMount'>入庫數</a></td>
					<td align="center" style="width:70px;"><a id='lblWeight'>入庫重 </a></td>
					<td align="center" style="width:70px;"><a id='lblWorker'>製作人員 </a></td>
					<td align="center" style="width:70px;"><a id='lblWorker2'>品管人員 </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td ><input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
						<input type="text" id="txtDatea.*" class="txt c1"/>
						<input type="text" id="txtNoa.*" style="display:none;"/>
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtOrdeno.*" class="txt" style="width:75%;float:left;"/>
						<input type="text" id="txtNo2.*" class="txt" style="width:15%;float:left;"/>
					</td>
					<td ><input type="text" id="txtUno.*" class="txt c1"/></td>
					<td>
						<input type="text" id="txtMechno.*" class="txt" style="width:45%;float:left;"/>
						<input type="text" id="txtMech.*" class="txt" style="width:45%;float:left;"/>
					</td>
					<td>
						<input type="text" id="txtBtime.*" class="txt" style="width:40%;float:left;"/>
						<span style="display:block;width:10px;float:left;">～</span>
						<input type="text" id="txtEtime.*" class="txt" style="width:40%;float:left;"/>
					</td>
					<td><input type="text" id="txtGmount.*" class="txt num" style="width:95%;"/></td>
					<td><input type="text" id="txtGweight.*" class="txt num" style="width:95%;"/></td>
					<td><input type="text" id="txtLength.*" class="txt num" style="width:95%;"/></td>
					<td><input type="text" id="txtMount.*" class="txt num" style="width:95%;"/></td>
					<td><input type="text" id="txtWeight.*" class="txt num" style="width:95%;"/></td>
					<td ><input type="text" id="txtWorker.*" class="txt c1"/></td>
					<td ><input type="text" id="txtWorker2.*" class="txt c1"/></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
