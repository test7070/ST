<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'view_uccc', t_content = ' ', bbsKey = ['uno'], as;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			var q_readonly = ['textProduct', 'textStore'];
			brwCount = -1;
			brwCount2 = 0;
			aPop = new Array(['textProductno', '', 'ucc', 'noa,product', 'textProductno,textProduct', 'ucc_b.aspx']
			, ['textStoreno', '', 'store', 'noa,store', 'textStoreno,textStore', 'store_b.aspx']);
			isLoadGt = 0;
			$(document).ready(function() {
				var t_para = new Array();
				try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	$('#textProductno').val(t_para.productno);
	            	$('#textBdime').val(t_para.bdime);
	            	$('#textEdime').val(t_para.edime);
	            	$('#textWidth').val(t_para.width);
	            	$('#textLengthb').val(t_para.blength);            	
	            }catch(e){
	            }
				t_content += ' where=^^ ' + SeekStr() + ' ^^';
				main();
				
			});
			/// end ready

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				
				var w = window.parent;
				mainBrow(6, t_content);
				w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color', 'red').css('font-size', 'initial');
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			var SeekF = new Array();
			function mainPost() {
				q_getFormat();
				$('#textProductno').focus(function() {
					q_cur = 1;
				}).blur(function() {
					q_cur = 0;
				});
				$('#textStoreno').focus(function() {
					q_cur = 1;
				}).blur(function() {
					q_cur = 0;
				});
				$('#seekTable td').children("input:text").each(function() {
					SeekF.push($(this).attr('id'));
				});
				SeekF.push('btnToSeek');
				$('#seekTable td').children("input:text").each(function() {
					$(this).bind('keydown', function(event) {
						keypress_bbm(event, $(this), SeekF, 'btnToSeek');
					});
				});
				$('#btnToSeek').click(function() {
					seekData(SeekStr());
					Lock();
				});
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (isLoadGt == 1) {
							abbs = _q_appendData(q_name, "", true);
							isLoadGt = 0;
							refresh();
						}
						break;
				}
			}

			function seekData(seekStr) {
				isLoadGt = 1;
				q_gt(q_name, 'where=^^ ' + seekStr + ' ^^', 0, 0, 0, "");
			}

			function bbsAssign() {

			}

			function SeekStr() {
				t_ordeno = trim($('#textOrdeno').val());
				t_productno = trim($('#textProductno').val());
				t_storeno = trim($('#textStoreno').val());
				t_radius = q_float('textRadius');
				t_bdime = q_float('textBdime');
				t_edime = q_float('textEdime');
				t_width = q_float('textWidth');
				t_lengthb = q_float('textLengthb');
				t_weight = q_float('textWeight');
				var t_where = " 1=1 " + q_sqlPara2("ordeno", t_ordeno) + 
							q_sqlPara2("productno", t_productno) + 
							q_sqlPara2("storeno", t_storeno)+
							(t_radius>0?' and radius>='+t_radius+' ':'')+
							(t_bdime>0?' and dime>='+t_bdime+' ':'') + 
							(t_edime>0?' and dime<='+t_edime+' ':'') + 
							(t_width>0?' and width>='+t_width+' ':'')+
							(t_lengthb>0?' and (lengthb=0 or lengthb>='+t_lengthb+') ':'')
						//	(t_weight>0?' and weight>='+t_weight+' ':'') + 
							;
							
				//alert(t_where);			
				return t_where;
			}

			var maxAbbsCount = 0;
			function refresh() {
				//_refresh();
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtUno_' + j).val() == abbs[i].uno) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
						if (w.q_name == 'cub' || w.q_name == 'orde') {
							for (var j = 0; j < w.q_bbtCount; j++) {
								if ((w.$('#txtUno__' + j).val() == abbs[i].uno) && (w.q_cur == 2)) {
									abbs[i].emount = dec(abbs[i].emount) + dec(w.$('#txtGmount__' + j).val());
									abbs[i].eweight = dec(abbs[i].eweight) + dec(w.$('#txtGweight__' + j).val());
								}
							}
						}
						if (dec(abbs[i].emount) <= 0 || dec(abbs[i].eweight) <= 0) {
							abbs.splice(i, 1);
							i--;
						}
					}
					maxAbbsCount = abbs.length;
				}
				q_bbsCount = (abbs.length==0?1:abbs.length);
				_refresh();
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtUno_' + t_id).val())){
							abbs[t_id]['sel'] = "true";
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
						}
					});
				});
				
				var w = window.parent;
				if (w.q_name == 'cub' && w.b_seq >= 0) {
					for (var k = 0; k < q_bbsCount; k++) {
						var thisUno = trim($('#txtUno_' + k).val()).toUpperCase();
						var t_uno = trim(w.$('#txtUno__' + w.b_seq).val()).toUpperCase();
						if (thisUno == t_uno)
							$('#radSel_' + k).prop('checked', true);
					}
				}
				_readonly(true);
				Unlock();
			}

			var exchange = function(a, b) {
				try {
					var tmpTop = a.offset().top;
					var tmpLeft = a.offset().left;
					a.offset({
						top : b.offset().top,
						left : b.offset().left
					});
					b.offset({
						top : tmpTop,
						left : tmpLeft
					});
				} catch(e) {
				}
			};
		</script>
		<style type="text/css">
			#seekForm {
				margin-left: auto;
				margin-right: auto;
				width: 950px;
			}
			#seekTable {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			#seekTable tr {
				height: 35px;
			}
			.txt.c1 {
				width: 98%;
			}
			.txt.c2 {
				width: 95%;
			}
			.lbl {
				float: right;
			}
			span {
				margin-right: 5px;
			}
			#seekTable tr td {
				width: 10%;
			}
			.num {
				text-align: right;
			}
			input[type="button"] {
				font-size: medium;
			}
			.StrX {
				margin-right: -2px;
				margin-left: -2px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style='color:White; background:#003366;' >
					<th align="center" style="width:2%;" >
						<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<td align="center" style="width:12%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:12%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:12%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:12%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:12%;"><a>尺寸</a></td>
					<!--<td align="center" style="width:280px;">厚 X 寬 X 高 X 長</td>-->
					<td align="center" style="width:8%;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblEweight_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblStoreno_st'> </a></td>
					<td align="center"><a id='lblMemo_st'> </a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;" ><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:12%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:12%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:12%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:12%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:12%;"><a id='lblSize_st'> </a></td>
					<!--<td align="center" style="width:280px;">厚 X 寬 X 高 X 長</td>-->
					<td align="center" style="width:8%;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblEweight_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblStoreno_st'> </a></td>
					<td align="center"><a id='lblMemo_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center" style="width:2%;"><input id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td align="center" style="width:12%;"><input id="txtUno.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td align="center" style="width:12%;"><input id="txtProductno.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td align="center" style="width:12%;"><input id="txtProduct.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td align="center" style="width:12%;"><input id="txtSpec.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td align="center" style="width:12%;"><input id="txtSize.*" type="text" class="txt c2" readonly="readonly"/></td>
					<!--<td  align="center" style="width:280px;">
						<input id="txtDime.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
						<a style="float: left;">X</a>
						<input id="txtWidth.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
						<a style="float: left;">X</a>
						<input id="txtRadius.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
						<a style="float: left;">X</a>
						<input id="txtLengthb.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
					</td>-->
					<td style="width:8%;"><input id="txtEmount.*" type="text" class="txt c2 num" readonly="readonly"/></td>
					<td style="width:8%;"><input id="txtEweight.*" type="text" class="txt c2 num" readonly="readonly"/></td>
					<td style="width:8%;"><input id="txtLaststoreno.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td ><input id="txtMemo.*" type="text" class="txt c2" readonly="readonly"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/brow_ctrl.inc"-->
		<div id="seekForm">
			<table id="seekTable" border="0" cellpadding='0' cellspacing='0'>
				<tr>
					<td><span class="lbl">品名編號</span></td>
					<td colspan="3">
						<input id="textProductno" type="text" style="width:25%"/>
						<input id="textProduct" type="text" style="width:73%"/>
					</td>
					<td><span class="lbl">倉庫</span></td>
					<td colspan="3">
						<input id="textStoreno" type="text" style="width:25%"/>
						<input id="textStore" type="text" style="width:65%"/>
					</td>
					<td style="display:none;"><span class="lbl">重量</span></td>
					<td style="display:none;"><input id="textWeight" type="text" class="txt c1 num"/></td>
				</tr>
				<tr>
					<td><span class="lbl">短徑</span></td>
					<td><input id="textRadius" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">厚度</span></td>
					<td colspan="3">
						<input id="textBdime" type="text" class="txt num" style="float:left;width:40%;"/>
						<span style="float:left;">~</span>
						<input id="textEdime" type="text" class="txt num" style="float:left;width:40%;"/>
					</td>
					<td><span class="lbl">寬度</span></td>
					<td><input id="textWidth" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">長度</span></td>
					<td><input id="textLengthb" type="text" class="txt c1 num"/></td>
				</tr>
				<tr>
					<td colspan="12" align="center">
					<input type="button" id="btnToSeek" value="查詢">
					</td>
				</tr>
			</table>
			<div id="q_acDiv" style="display: none;">
				<div></div>
			</div>
		</div>
	</body>
</html>