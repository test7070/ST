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
            var q_name = "orde_import", t_content = "where=^^['','','','','','','',0,0,0,0,0,0,'')^^", bbsKey = ['uno'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var bbsNum = [['txtEweight', 2, 0, 1],['txtEmount', 2, 0, 1]];
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
	            	t_content = "where=^^['"+t_para.table+"',"
	            		+"'"+t_para.noa+"',"
	            		+"'"+t_para.custno+"',"
	            		+"'"+t_para.kind+"',"
	            		+"'"+t_para.bdate+"',"
	            		+"'"+t_para.edate+"',"
	            		+"'"+t_para.productno+"',"
	            		+t_para.bdime+","
	            		+t_para.edime+","
	            		+t_para.bwidth+","
	            		+t_para.ewidth+","
	            		+t_para.blength+","
	            		+t_para.elength+","
	            		+"'"+t_para.para+"')^^";
	            }catch(e){
	            } 
	            brwCount = -1;
	            mainBrow(0, t_content); 
            }
            function q_gtPost(t_name) {
				switch (t_name) {
					default:
						break;
				}
			}
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				$('#checkAllCheckbox').click(function(e){
					$('.ccheck').prop('checked',$(this).prop('checked'));
				});
			}
            
            function refresh() {
                _refresh();
                for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text(i+1);
				}
            }
            function bbsAssign() {
				
                	
				_bbsAssign();
			}
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:1300;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:25px;max-width: 25px;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:30px;max-width: 30px;"> </td>
					<td align="center" style="width:80px;max-width: 80px;">客戶名稱</td>
					<td align="center" style="width:80px;max-width: 80px;">品號</td>
					<td align="center" style="width:80px;max-width: 80px;">品名</td>
					<td align="center" style="width:80px;max-width: 80px;">型</td>
					<td align="center" style="width:80px;max-width: 80px;">等級</td>
					<td align="center" style="width:80px;max-width: 80px;">材質</td>
					<td align="center" style="width:80px;max-width: 80px;">厚度</td>
					<td align="center" style="width:80px;max-width: 80px;">寬度</td>
					<td align="center" style="width:80px;max-width: 80px;">長度</td>
					<td align="center" style="width:80px;max-width: 80px;">數量</td>
					<td align="center" style="width:80px;max-width: 80px;">重量</td>
					<td align="center" style="width:80px;max-width: 80px;">單位</td>
					<td align="center" style="width:80px;max-width: 80px;">未交量</td>
					<td align="center" style="width:80px;max-width: 80px;">本次裁剪數量</td>
					<td align="center" style="width:80px;max-width: 80px;">訂單編號</td>
					<td align="center" style="width:80px;max-width: 80px;">備註</td>
					<td align="center" style="width:80px;max-width: 80px;">已交量</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:1300;' >
				<tr style="display:none;">
					<th align="center" style="width:25px;max-width: 25px;"> </th>
					<td align="center" style="width:30px;max-width: 30px;"> </td>
					<td align="center" style="width:80px;max-width: 80px;">客戶名稱</td>
					<td align="center" style="width:80px;max-width: 80px;">品號</td>
					<td align="center" style="width:80px;max-width: 80px;">品名</td>
					<td align="center" style="width:80px;max-width: 80px;">型</td>
					<td align="center" style="width:80px;max-width: 80px;">等級</td>
					<td align="center" style="width:80px;max-width: 80px;">材質</td>
					<td align="center" style="width:80px;max-width: 80px;">厚度</td>
					<td align="center" style="width:80px;max-width: 80px;">寬度</td>
					<td align="center" style="width:80px;max-width: 80px;">長度</td>
					<td align="center" style="width:80px;max-width: 80px;">數量</td>
					<td align="center" style="width:80px;max-width: 80px;">重量</td>
					<td align="center" style="width:80px;max-width: 80px;">單位</td>
					<td align="center" style="width:80px;max-width: 80px;">未交量</td>
					<td align="center" style="width:80px;max-width: 80px;">本次裁剪數量</td>
					<td align="center" style="width:80px;max-width: 80px;">訂單編號</td>
					<td align="center" style="width:80px;max-width: 80px;">備註</td>
					<td align="center" style="width:80px;max-width: 80px;">已交量</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;max-width: 25px;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:30px;max-width: 30px;text-align: center;"><a id="lblNo.*" style="font-weight: bold;" readonly="readonly"> </a></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtCust.*" style="float:left;width:95%;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtProductno.*" style="float:left;width:95%;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtProduct.*" style="float:left;width:95%;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtStyle.*" style="float:left;width:95%;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtClass.*" style="float:left;width:95%;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtSpec.*" style="float:left;width:95%;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtDime.*" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtWidth.*" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtLengthb.*" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtMount.*" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtWeight.*" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtUnit.*" style="float:left;width:95%;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtNotv.*" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" id="txtN.*" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:80px;max-width: 80px;">
						<input type="text" readonly="readonly" id="txtAccy.*" style="float:left;display:none;"/>
						<input type="text" readonly="readonly" id="txtNoa.*" style="float:left;width:95%;"/>
						<input type="text" readonly="readonly" id="txtNoq.*" style="float:left;display:none;"/>
					</td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtMemo.*" style="float:left;width:95%;text-align: right;"/></td>
					<td style="width:80px;max-width: 80px;"><input type="text" readonly="readonly" id="txtC1.*" style="float:left;width:95%;text-align: right;"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

