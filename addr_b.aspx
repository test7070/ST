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
			//custprice,driverprice,driverprice2,commission
            var q_name = 'addr', t_content = 'field=noa,addr', bbsKey = ['noa'], as  ,  t_sqlname='addr2';
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
         
            $(document).ready(function() {
                main();
            });
            // end ready

            function main() {
                if(dataErr)// 載入資料錯誤
                {
                    dataErr = false;
                    return;
                }
                mainBrow(0, t_content);
            }
            
            function mainPost(){
				q_getFormat();
				q_cmbParse("cmbTranstyle", q_getPara('sys.transtyle2'),'s');
				q_gt('carspec', '', 0, 0, 0, "");
			}
			
			var carspec_item='';
            function q_gtPost(t_name) {
            	switch (t_name) {
					case 'carspec':
						var as = _q_appendData("carspec", "", true);
						carspec_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							carspec_item = carspec_item + (carspec_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].spec;
						}
						
						for (var j = 0; j < brwCount; j++) {
							if($('#combCarspecno_'+j).length<1)
								continue;
								q_cmbParse("combCarspecno_"+j, carspec_item);	//IR
					        
					        if(!emp($('#txtCarspecno_'+j).val()))
					        	$('#combCarspecno_'+j).val($('#txtCarspecno_'+j).val());
					        else
					        	$('#combCarspecno_'+j).text('');
					        
							$('#combCarspecno_'+j).attr('disabled', 'disabled');
				            //$('#combCarspecno_'+j).css('background', t_background2);
				        }
						break;
				}
            }

            function refresh() {
                _refresh();
            }
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" > </th>
					<th align="center" style='color:blue;' ><a id='lblTranstart'> </a></th>
					<th align="center" style='color:blue;' ><a id='lblPost'> </a></th>
					<th align="center" style='color:blue;' ><a id='lblCarspecno'> </a></th>
					<th align="center" style='color:blue;' ><a id='lblTranstyle'> </a></th>
					<th align="center" style='color:blue;' ><a id='lblDriverprice2'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;">
							<input name="sel"  id="radSel.*" type="radio" />
							<input class="txt" id="txtNoa.*" type="hidden" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtTranstart.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtAddr.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:19%;">
						 <select id="combCarspecno.*" class="txt c1" style="width:98%;"> </select>
						 <input class="txt" id="txtCarspecno.*" type="hidden" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:19%;">
						 <select id="cmbTranstyle.*" class="txt c1" style="width:98%;"> </select>
					</td>
					<td style="width:19%;">
						<input class="txt" id="txtDriverprice2.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>
