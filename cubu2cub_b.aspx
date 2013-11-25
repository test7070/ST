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
			var q_name = 'view_cubu2cub', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], as;
			//, t_where = '';
			var t_sqlname = 'view_cubu2cub';
			t_postname = q_name;
			brwCount = -1;
			brwCount2 = 0;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
			q_desc=1;
			$(document).ready(function() {
				if (!q_paraChk())
					return;

				main();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				var w = window.parent;
				w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color','red').css('font-size','initial');
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function mainPost(){
			}

			function bbsAssign() {
				_bbsAssign();
			}

			function q_gtPost(t_name) {
			}

			function refresh() {
				_refresh();
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtOrdeno_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
			}

		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			select {
				font-size: medium;
			}
			#dbbs,#dFixedTitle{
				width:1900px;
			}
			.txt{
				float:left;
			}
			.c1{
				width:90%;
			}
			.c2{
				width:85%;
			}
			.c3{
				width:71%;
			}
			.num{
				text-align: right;
			}
			.btn{
				font-weight: bold;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:3%;"><a id='lblPrt'></a></td>
					<td align="center" style="width:2%;"><a id='lblStyle'></a></td>
					<td align="center" style="width:10%;"><a id='lblUno'></a></td>
					<td align="center" style="width:10%;"><a id='lblOrdeno'></a></td>
					<td align="center" style="width:6%;"><a id='lblCustno'></a></td>
					<td align="center" style="width:5%;"><a id='lblDatea'></a></td>
					<td align="center" style="width:6%;"><a id='lblStoreno'></a></td>
					<td align="center" style="width:4%;"><a id='lblClass'></a></td>
					<td align="center" style="width:6%;"><a id='lblProductno'></a></td>
					<td align="center" style="width:260px;"><a id='lblSizea'></a></td>
					<td align="center" style="width:4%;"><a id='lblMount'></a></td>
					<td align="center" style="width:4%;"><a id='lblWeight'></a></td>
					<td align="center" style="width:4%;"><a id='lblInweight'></a></td>
					<td align="center" style="width:4%;"><a id='lblWaste'></a></td>
					<td align="center" style="width:4%;"><a id='lblGmount'></a></td>
					<td align="center" style="width:2%;"><a id='lblCut'></a></td>
					<td align="center" style="width:2%;"><a id='lblSlit'></a></td>
					<td align="center" style="width:2%;"><a id='lblSale'></a></td>
					<td align="center" style="width:2%;"><a id='lblOrdc'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
			</table>
		</div>
		<div  id="dbbs" style="overflow-y: scroll;height:550px;">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;display:none;' >
					<td align="center"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center"><a id='lblPrt'></a></td>
					<td align="center"><a id='lblStyle'></a></td>
					<td align="center"><a id='lblUno'></a></td>
					<td align="center"><a id='lblOrdeno'></a></td>
					<td align="center"><a id='lblCustno'></a></td>
					<td align="center"><a id='lblDatea'></a></td>
					<td align="center"><a id='lblStoreno'></a></td>
					<td align="center"><a id='lblClass'></a></td>
					<td align="center"><a id='lblProductno'></a></td>
					<td align="center"><a id='lblSizea'></a></td>
					<td align="center"><a id='lblMount'></a></td>
					<td align="center"><a id='lblWeight'></a></td>
					<td align="center"><a id='lblInweight'></a></td>
					<td align="center"><a id='lblWaste'></a></td>
					<td align="center"><a id='lblGmount'></a></td>
					<td align="center"><a id='lblCut'></a></td>
					<td align="center"><a id='lblSlit'></a></td>
					<td align="center"><a id='lblSale'></a></td>
					<td align="center"><a id='lblOrdc'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center" style="width:1%;">
						<input id="chkSel.*" type="checkbox"/>
					</td>
					<td style="width:3%;"><input type="text" id="txtPrt.*" class="txt c1" style="text-align: center;"/></td>
					<td style="width:2%;"><input type="text" id="txtStyle.*" class="txt c1" style="text-align: center;"/></td>
					<td style="width:10%;"><input type="text" id="txtUno.*" class="txt c1"/></td>
					<td style="width:10%;">
						<input type="text" id="txtOrdeno.*" class="txt" style="width:65%;"/>
						<input type="text" id="txtNo2.*" class="txt" style="width:25%;"/>
					</td>
					<td style="width:6%;">
						<input id="btnCustno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtCustno.*" class="txt c3"/>
						<input type="text" id="txtComp.*" class="txt c1"/>
					</td>
					<td style="width:5%;"><input type="text" id="txtDatea.*" class="txt c1"/></td>
					<td style="width:6%;">
						<input id="btnStoreno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtStoreno.*" class="txt c3"/>
						<input type="text" id="txtStore.*" class="txt c1"/>
					</td>
					<td style="width:4%;">
						<input type="text" id="txtClass.*" class="txt c1"/>
						<input type="text" id="txtSpec.*" class="txt c1"/>
					</td>
					<td style="width:6%;">
						<input id="btnProductno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtProductno.*" class="txt c3"/>
						<input type="text" id="txtProduct.*" class="txt c1"/>
					</td>
					<td style="width:260px;">
						<input type="text" id="txtRadius.*" class="num" style="width:19%;"/>x
						<input type="text" id="txtWidth.*" class="num" style="width:19%;"/>x
						<input type="text" id="txtDime.*" class="num" style="width:19%;"/>x
						<input type="text" id="txtLengthb.*" class="num" style="width:19%;"/>
					</td>
					<td style="width:4%;"><input type="text" id="txtMount.*" class="txt c1 num"/></td>
					<td style="width:4%;"><input type="text" id="txtWeight.*" class="txt c1 num"/></td>
					<td style="width:4%;"><input type="text" id="txtInweight.*" class="txt c1 num"/></td>
					<td style="width:4%;"><input type="text" id="txtWaste.*" class="txt c1 num"/></td>
					<td style="width:4%;"><input type="text" id="txtGmount.*" class="txt c1 num"/></td>
					<td style="width:2%;"><input type="checkbox" id="chkCut.*" class="txt c1"/></td>
					<td style="width:2%;"><input type="checkbox" id="chkSlit.*" class="txt c1"/></td>
					<td style="width:2%;"><input type="checkbox" id="chkSale.*" class="txt c1"/></td>
					<td style="width:2%;"><input type="checkbox" id="chkOrdc.*" class="txt c1"/></td>
					<td><input type="text" id="txtMemo.*" class="txt c1"/></td>
				</tr>
			</table>
		</div>
			<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>
