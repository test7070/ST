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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "ordc_import", t_content = "where=^^['','')^^", bbsKey = ['noa','no2'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var bbsNum = [['txtCnt', 2, 0, 1]];
       		brwCount = -1;
			brwCount2 = -1;
			t_spec='';
			
            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	t_content = "where=^^['"+t_para.tggno+"','"+t_para.kind+"','"+t_para.noa+"','"+t_para.page+"')^^";
	            }catch(e){
	            } 
	            mainBrow(0, t_content);   
            }
            function q_gtPost(t_name) {
				switch (t_name) {
					case 'spec':
						var as = _q_appendData("spec", "", true);
						t_spec='<option value=""></option>';
						for ( i = 0; i < as.length; i++) {
							t_spec += '<option value="'+as[i].noa+'">'+as[i].product+'</option>';
						}
						for(var i=0;i<q_bbsCount;i++){
							$('#combSpec_'+i).append(t_spec);
							$('#combSpec_'+i).val($('#txtSpec_'+i).val());
						}
						break;
					case q_name:
						abbs = _q_appendData(q_name, "", true);
						refresh();
						break;
				}
			}
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				q_gt('spec', '', 0, 0, 0, '');
				
				$('#checkAllCheckbox').click(function(e){
					$('.ccheck').prop('checked',$(this).prop('checked'));
				});
			}
			
			function bbsAssign() { 
				for (var j = 0; j < q_bbsCount; j++) {
					$('#txtCnt_'+j).change(function(){
						var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
						var thisVal = dec($(this).val());
						if(thisVal > 0){
							$('#chkSel_'+n).attr('checked',true);
						}else{
							$('#chkSel_'+n).attr('checked',false);
						}
					});
				}
				_bbsAssign();
		    }
            
            function refresh() {
                _refresh();
            }
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:2%;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:7%;">預計交期</td>
					<td align="center" style="width:10%;">廠商</td>
					<td align="center" style="width:15%;">單號</td>
					<td align="center" style="width:15%;">品名</td>
					<td align="center" style="width:20%;">尺寸</td>
					<td align="center" style="width:7%;">單位</td>
					<td align="center" style="width:7%;">未交數量</td>
					<td align="center" style="width:7%;">未交重量</td>
					<td align="center" style="width:5%;">/</td>
					<td align="center" style="width:15%;">備註</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;"></th>
					<td align="center" style="width:7%;">預計交期</td>
					<td align="center" style="width:10%;">廠商</td>
					<td align="center" style="width:15%;">單號</td>
					<td align="center" style="width:15%;">品名</td>
					<td align="center" style="width:20%;">尺寸</td>
					<td align="center" style="width:7%;">單位</td>
					<td align="center" style="width:7%;">未交數量</td>
					<td align="center" style="width:7%;">未交重量</td>
					<td align="center" style="width:5%;">/</td>
					<td align="center" style="width:15%;">備註</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:2%;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:7%;"><input type="text" readonly="readonly" id="txtRdate.*" style="float:left;width:95%;"/></td>
					<td style="width:10%;"><input type="text" readonly="readonly" id="txtTgg.*" style="float:left;width:95%;"/></td>
					<td style="width:15%;">
						<input type="text" readonly="readonly" id="txtNoa.*" style="float:left;width:70%;"/>
						<input type="text" readonly="readonly" id="txtNo2.*" style="float:left;width:20%;"/>
					</td>
					<td style="width:15%;">
						<input type="text" readonly="readonly" id="txtProductno.*" style="float:left;width:95%;"/>
						<input type="text" readonly="readonly" id="txtProduct.*" style="float:left;width:95%;"/>
					</td>
					<td style="width:20%;">
						<input type="text" readonly="readonly" id="txtDime.*" style="float:left;width:25%;"/>
						<a style="float:left;width:6%;">X</a>
						<input type="text" readonly="readonly" id="txtWidth.*" style="float:left;width:25%;"/>
						<a style="float:left;width:6%;">X</a>
						<input type="text" readonly="readonly" id="txtLengthb.*" style="float:left;width:25%;"/>
						<select readonly="readonly" id="combSpec.*" style="width:95%;"> </select>
						<input type="text" readonly="readonly" id="txtSpec.*" style="display:none;"/>
					</td>
					<td style="width:7%;"><input type="text" readonly="readonly" id="txtUnit.*" style="float:left;width:95%;"/></td>
					<td style="width:7%;"><input type="text" readonly="readonly" id="txtMount.*" style="float:left;width:95%;"/></td>
					<td style="width:7%;"><input type="text" readonly="readonly" id="txtWeight.*" style="float:left;width:95%;"/></td>
					<td style="width:5%;"><input type="text" id="txtCnt.*" class="txt num" style="float:left;width:95%;"/></td>
					<td style="width:15%;"><input type="text" readonly="readonly" id="txtMemo.*" style="float:left;width:95%;"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

