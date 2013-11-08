<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		    var q_name = 'ordcs', t_bbsTag = 'tbbs', t_content = " field=productno,product,spec,dime,width,lengthb,radius,mount,weight,noa,no2,price,total,theory,memo,notv,uno,class,style,unit  order=odate ", afilter = [], bbsKey = ['noa', 'no2'], t_count = 0, as;
		    var t_sqlname = 'ordcs_load2'; t_postname = q_name; brwCount2 = 12;
		    var isBott = false;  /// 是否已按過 最後一頁
		    var txtfield = [], afield, t_data, t_htm;
		    var i, s1;
			var bbsNum = [['txtCnt', 2, 0, 1]];
		    $(document).ready(function () {
		        main();
		    });
		    		
		    function main() {
		        if (dataErr)  /// 載入資料錯誤
		        {
		            dataErr = false;
		            return;
		        }
		        mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
				var w = window.parent;
				w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color','red').css('font-size','initial');
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
   				for(var i=0;i<q_bbsCount;i++){
					$('#txtCnt_'+i).val(1).removeAttr('readonly').css('color','black').css('background','white');
				}
		    }
		    function bbsAssign() {  /// checked 
		        _bbsAssign();
				for (var j = 0; j < q_bbsCount; j++) {
					$('#txtCnt_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						var thisVal = dec($(this).val());
						if(thisVal > 0){
							$('#chkSel_'+t_IdSeq).attr('checked',true);
						}else{
							$('#chkSel_'+t_IdSeq).attr('checked',false);
						}
					});
				}
		    }
		
		    function q_gtPost() { 
		    	
		    }
			var maxAbbsCount = 0;
		    function refresh() {
		        _refresh();
		        for(var i = 0;i<abbs.length;i++){
					if (abbs[i].mount <= 0 || abbs[i].weight <= 0) {
						abbs.splice(i, 1);
						i--;
					}
		        }
		        _refresh();
				$('#checkAllCheckbox').click(function(){
					$('input[type=checkbox][id^=chkSel]').each(function(){
						var t_id = $(this).attr('id').split('_')[1];
						if(!emp($('#txtProductno_' + t_id).val()))
							$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
					});
				});
		        size_change();
		    }
		    
		    function size_change () {
				if(dec($('#txtRadius_0').val())<=0){
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
				}else{
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
				}
			}
		</script>
		<style type="text/css">
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c8 {
				float:left;
				width: 65px;
			}
			.txt.num {
				text-align: right;
			}
			input[type="text"],input[type="button"] {     
				font-size: medium;
			}
			.dbbs .tbbs{
				margin:0;
				padding:2px;
				border:2px lightgrey double;
				border-spacing:1px;
				border-collapse:collapse;
				font-size:medium;
				color:blue;
				background:#cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr{
				height:35px;
			}
			.dbbs .tbbs tr td{
				text-align:center;
				border:2px lightgrey double;
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
					<td align="center" style="width:1%;">
						<input type="checkbox" id="checkAllCheckbox"/>
					</td>
					<td align="center" style="width:6%;"><a id='lblProductno_st'></a></td>
					<td align="center" style="width:8%;"><a id='lblProduct'></a></td>
					<td align="center" style="width:8%;"><a id='lblSpec'></a></td>
					<td align="center" id='FixedSize'><a id='lblSize'></a><BR><a id='lblSize_help'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMount'></a></td>
					<td align="center" style="width:7%;"><a id='lblWeight'></a></td>
					<td align="center" style="width:7%;"><a id='lblPrice'></a></td>
					<td align="center" style="width:8%;"><a id='lblInmount_text'></a></td>
					<td align="center" style="width:10%;"><a id='lblNoa'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:550px;" >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'>
				<tr style='color:White; background:#003366;display:none;' >
					<td align="center" style="width:1%;"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:6%;"><a id='lblProductno_st'></a></td>
					<td align="center" style="width:8%;"><a id='lblProduct'></a></td>
					<td align="center" style="width:8%;"><a id='lblSpec'></a></td>
					<td align="center" id='Size'><a id='lblSize'></a><BR><a id='lblSize_help'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMount'></a></td>
					<td align="center" style="width:7%;"><a id='lblWeight'></a></td>
					<td align="center" style="width:7%;"><a id='lblPrice'></a></td>
					<td align="center" style="width:8%;"><a id='lblInmount_text'></a></td>
					<td align="center" style="width:10%;"><a id='lblNoa'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:1%;" align="center"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:6%;"><input class="txt c1"  id="txtProductno.*" type="text" /></td>
					<td style="width:8%;"><input class="txt c1" id="txtProduct.*" type="text"/></td>
					<td style="width:8%;"><input class="txt c1" id="txtSpec.*" type="text" /></td>
					<td id="FixedSize">
						<input class="txt num c8" id="txtSize1.*" type="text"/><div id="x1" style="float: left"> x</div>
						<input class="txt num c8" id="txtSize2.*" type="text"/><div id="x2" style="float: left"> x</div>
						<input class="txt num c8" id="txtSize3.*" type="text"/><div id="x3.*" style="float: left"> x</div>
						<input class="txt num c8" id="txtSize4.*" type="text"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="hidden"/>
						<input  id="txtWidth.*" type="hidden"/>
						<input  id="txtDime.*" type="hidden"/>
						<input id="txtLengthb.*" type="hidden"/>
					</td>
					<td style="width:7%;"><input class="txt num c1" id="txtMount.*" type="text"/></td>
					<td style="width:7%;"><input class="txt num c1" id="txtWeight.*" type="text" /></td>
					<td style="width:7%;"><input class="txt num c1" id="txtPrice.*" type="text"/></td>
					<td style="width:8%;"><input class="txt num c1" id="txtCnt.*" type="text"/></td>
					<td style="width:10%;">
						<input class="txt c1" id="txtNoa.*" type="text"/>
						<input class="txt c1" id="txtNo2.*" type="text" />
					</td>
					<td>
						<input class="txt c1" id="txtMemo.*" type="text"/>
						<input id="txtKind.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
			<!--#include file="../inc/pop_ctrl.inc"--> 
	</body>
</html>