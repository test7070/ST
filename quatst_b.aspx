<html xmlns="http://www.w3.org/1999/xhtml">
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
		var q_name = 'view_quats', t_bbsTag = 'tbbs', t_content = " field=productno,product,size,radius,dime,width,lengthb,unit,mount,weight,notv,noa,no3,price,spec,class,theory,style  order=odate ", afilter = [], bbsKey = ['noa', 'no3'], t_count = 0, as;
		var t_sqlname = 'view_quats';
		t_postname = q_name;
		brwCount2 = 12;
		var isBott = false;  /// 是否已按過 最後一頁
		var txtfield = [], afield, t_data, t_htm;
		var i, s1;
	
		$(document).ready(function () {
			main();
		});		 /// end ready
	
		function main() {
			if (dataErr){
				dataErr = false;
				return;
			}
			mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
		}
	
		function bbsAssign() {  /// checked 
			_bbsAssign();
		}
		function q_gtPost() { 
	
		}
		var maxAbbsCount = 0;
		function refresh() {
			var w = window.parent;
			if (maxAbbsCount < abbs.length) {
				for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
					for (var j = 0; j < w.abbsNow.length; j++) {
						if (w.abbsNow[j].quatno == abbs[i].noa && w.abbsNow[j].no3 == abbs[i].no3) {
							abbs[i].notv = dec(abbs[i].notv)+dec(w.abbsNow[j].mount);
							abbs[i]['sel'] = "true";
							$('#chkSel_' + abbs[i].rec).attr('checked', true);
						}
					}
					if (abbs[i].mount <= 0 || abbs[i].weight <= 0 || abbs[i].notv <=0) {
						abbs.splice(i, 1);
						i--;
					}
					}
				maxAbbsCount = abbs.length;
			}
			_refresh();
			$('#checkAllCheckbox').click(function(){
				$('input[type=checkbox][id^=chkSel]').each(function(){
					var t_id = $(this).attr('id').split('_')[1];
					if(!emp($('#txtNoa_' + t_id).val()))
						$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
				});
			});
			size_change();
		}
			function size_change () {
				var w = window.parent;
				var t_Kind = (w.$('#cmbKind').val()?w.$('#cmbKind').val():'');
				t_Kind = t_Kind.substring(0, 1);
				if(t_Kind=='B'){
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					 for (var j = 0; j < brwCount2 ; j++) {
						$('#txtSize4_'+j).removeAttr('hidden');
						$('#x3_'+j).removeAttr('hidden');
						$('*[id="FixedSize"').css('width','297px');
						q_tr('txtSize1_'+ j ,q_float('txtRadius_'+j));
						q_tr('txtSize2_'+ j ,q_float('txtWidth_'+j));
						q_tr('txtSize3_'+ j ,q_float('txtDime_'+j));
						q_tr('txtSize4_'+ j ,q_float('txtLengthb_'+j));
					 }
				 }else{
					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					for (var j = 0; j < brwCount2 ; j++) {
						$('#txtSize4_'+j).attr('hidden', 'true');
						$('#x3_'+j).attr('hidden', 'true');
						$('*[id="FixedSize"').css('width','222px');
						q_tr('txtSize1_'+ j ,q_float('txtDime_'+j));
						q_tr('txtSize2_'+ j ,q_float('txtWidth_'+j));
						q_tr('txtSize3_'+ j ,q_float('txtLengthb_'+j));
						$('#txtSize4_'+j).val(0);
						$('#txtRadius_'+j).val(0);
					 }
				 }
			}
	</script>
	<style type="text/css">
		.seek_tr
		{color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
			.txt.c8 {
				float:left;
				width: 65px;
				
			}
			.txt.num {
				text-align: right;
			}
	</style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
	<div id="dbbs">
		<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
			<tr style='color:White; background:#003366;' >
				<td align="center">
					<input type="checkbox" id="checkAllCheckbox"/>
				</td>
				<td align="center"><a id='lblProductno'></a></td>
				<td align="center"><a id='lblProduct'></a></td>
				<td align="center" id='FixedSize'><a id='lblSpec'></a><BR><a id='lblSize_help'> </a></td>
				<td align="center"><a id='lblUnit'></a></td>
				<td align="center"><a id='lblMount'></a></td>
				<td align="center"><a id='lblWeight'></a></td>
				<td align="center"><a id='lblPrice'></a></td>
				<td align="center"><a id='lblNotv'></a></td>
				<td align="center"><a id='lblNoa'></a></td>
				<td align="center"><a id='lblMemo'></a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td style="width:1%;" align="center"><input id="chkSel.*" type="checkbox"  /></td>
				<td style="width:8%;"><input class="txt"  id="txtProductno.*" type="text" style="width:98%;" /></td>
				<td style="width:8%;"><input class="txt" id="txtProduct.*" type="text" style="width:98%;" /></td>
				<td id="FixedSize">
					<input class="txt num c8" id="txtSize1.*" type="text"/><div id="x1" style="float: left"> x</div>
					<input class="txt num c8" id="txtSize2.*" type="text"/><div id="x2" style="float: left"> x</div>
					<input class="txt num c8" id="txtSize3.*" type="text"/><div id="x3.*" style="float: left"> x</div>
					<input class="txt num c8" id="txtSize4.*" type="text"/>
					<!--上為虛擬下為實際-->
					<input id="txtRadius.*" type="hidden"/>
					<input id="txtWidth.*" type="hidden"/>
					<input id="txtDime.*" type="hidden"/>
					<input id="txtLengthb.*" type="hidden"/>
				</td>
				<td style="width:4%;"><input class="txt" id="txtUnit.*" type="text" style="width:94%;"/></td>
				<td style="width:5%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
				<td style="width:6%;"><input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/></td>
				<td style="width:8%;"><input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/></td>
				<td style="width:8%;"><input class="txt" id="txtNotv.*" type="text" style="width:96%; text-align:right;"/></td>
				<td style="width:5%;"><input class="txt" id="txtNoa.*" type="text" style="width:96%;"/><input class="txt" id="txtNo3.*" type="text" /></td>
				<td><input class="txt" id="txtMemo.*" type="text" style="width:98%;"/><input id="recno.*" type="hidden" /></td>
			</tr>
		</table>
		<!--#include file="../inc/pop_ctrl.inc"--> 
	</div>
</body>
</html>