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
            var q_name = 'saladd', t_content = ' field=noa,sssno,namea,hr_special order=odate', afilter = [], bbsKey = ['noa'], as;
            var t_sqlname = 'saladd_load';
            t_postname = q_name;
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            brwCount = -1;
            brwCount2 = 0;
            var bbsNum = [['txtHr_special', 15, 1, 1],['txtCarryforwards', 15, 1, 1]];
            
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
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }
            
            var hr_used=0,s_noa='',s_sssno='';//請假時數
            function bbsAssign() {
            	//帶入紀錄的資料
            	var as;
            	if (window.parent.q_name == 'salvacause'){
	            	var wParent = window.parent.document;
					as=wParent.getElementById("txtCarryforwards").value.split(',');
					s_noa=wParent.getElementById("txtNoa").value;
					s_sssno=wParent.getElementById("txtSssno").value;
					hr_used=dec(wParent.getElementById("txtHr_used").value);
					$('#lblhr_used').text('請假時數 '+hr_used.toFixed(1)+'/H');
				}
				
				for (var i = 0; i < as.length; i=i+2) {
	            	for (var j = 0; j < q_bbsCount; j++) {
	                	if(as[i]==$('#txtNoa_'+j).val()){
	                		$('#txtCarryforwards_'+j).val(as[i+1]);
	                		$('#chkSel_'+j).attr('checked','true');
	                		break;	
						}
	                }
				}
				
				var total=0;
				for (var j = 0; j < q_bbsCount; j++) {
					if(!emp($('#txtNoa_'+j).val())){
						total=q_add(total,dec($('#txtCarryforwards_'+j).val()));
					}
				}
				$('#lblTotal').text('共 '+total.toFixed(1)+'/H');
				
				//讀取已請時數
				var t_where = "where=^^ charindex('抵工時',hname)>0 and noa !='"+s_noa+"' and sssno='"+s_sssno+"'^^";
				q_gt('salvacause', t_where, 0, 0, 0, "salvacause", r_accy);
				
                _bbsAssign();
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#chkSel_'+i).click(function() {
                		t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						
						if($('#chkSel_'+b_seq).prop('checked')){
							$('#txtCarryforwards_'+b_seq).val($('#txtHr_special_'+b_seq).val());
						}else{
							$('#txtCarryforwards_'+b_seq).val(0);
						}
						
						var total=0;
						for (var j = 0; j < q_bbsCount; j++) {
							if(!emp($('#txtNoa_'+j).val())){
								total=q_add(total,dec($('#txtCarryforwards_'+j).val()));
							}
						}
						$('#lblTotal').text('共 '+total.toFixed(1)+'/H');
					});
                	
					$('#txtCarryforwards_' + i).change(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						
						if(dec($('#txtCarryforwards_'+b_seq).val())<0){
							alert(q_getMsg('lblCarryforwards')+'不得小於0!!');
							$('#txtCarryforwards_'+b_seq).val(0);
						}
						if(dec($('#txtCarryforwards_'+b_seq).val())>dec($('#txtHr_special_'+b_seq).val())){
							alert(q_getMsg('lblCarryforwards')+'不得大於'+q_getMsg('lblHr_special')+'!!');
							$('#txtCarryforwards_'+b_seq).val(dec($('#txtHr_special_'+b_seq).val()));
						}
						
						var total=0;
						for (var j = 0; j < q_bbsCount; j++) {
							if(!emp($('#txtNoa_'+j).val())){
								total=q_add(total,dec($('#txtCarryforwards_'+j).val()));
							}
						}
						$('#lblTotal').text('共 '+total.toFixed(1)+'/H');
					});
				}
                
            }

            function q_gtPost(t_name) {
            	switch (t_name) {
            		case 'salvacause':
            		var as = _q_appendData("salvacause", "", true);
						for (var i = 0; i < as.length; i++) {
							var cc=as[i].carryforwards.split(',');
							for (var j = 0; j < cc.length; j=j+2) {
				            	for (var k = 0; k < q_bbsCount; k++) {
				                	if(cc[j]==$('#txtNoa_'+k).val()){
				                		$('#txtHr_special_'+k).val(dec($('#txtHr_special_'+k).val())-dec(cc[j+1]));
				                		break;	
									}
				                }
							}
						}
            		break;
            	}
            }

            function refresh() {
                _refresh();
                
                $('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
            }
            
            function readonly(t_para) {
				_readonly(t_para);
				for (var j = 0; j < q_bbsCount; j++) {
					if(!emp($('#txtNoa_'+j).val())){
						$('#txtCarryforwards_'+j).removeAttr('readonly').css('background-color','');
					}
				}
			}
			
			/*function btnOk() {
				var total=0;
				for (var j = 0; j < q_bbsCount; j++) {
					if(!emp($('#txtNoa_'+j).val())){
						total=q_add(total,dec($('#txtCarryforwards_'+j).val()));
					}
				}
				
				if(hr_used!=total){
					alert('請假時數不等於'+q_getMsg('lblCarryforwards')+'!!');
					return;
				}
			}*/
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" style='color:Blue;'> </th>
					<th align="center" style='color:Blue;'><a id='lblNoa'> </a></th>
					<th align="center" style='color:Blue;'><a id='lblSssno'> </a></th>
					<th align="center" style='color:Blue;'><a id='lblNamea'> </a></th>
					<th align="center" style='color:Blue;'><a id='lblHr_specials'>可換休時數</a></th>
					<th align="center" style='color:Blue;'><a id='lblCarryforwards'>需換休時數</a></th>
				</tr>
				<tr>
					<td style="width:1%;">
						<input class="chk" id="chkSel.*" type="checkbox"/>
					</td>
					<td style="width:18%;">
						<input class="txt" id="txtNoa.*" type="text" style="width:98%;" readonly="readonly" />
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtSssno.*" type="text" style="width:98%;" readonly="readonly" />
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtNamea.*" type="text" style="width:98%;" readonly="readonly" />
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtHr_special.*" type="text" style="width:98%;text-align: right;" readonly="readonly" />
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtCarryforwards.*" type="text" style="width:98%;text-align: right;" readonly="readonly" />
					</td>
				</tr>
			</table>
			<a id='lblhr_used' style="float:left;text-align: right;">請假時數 0.0/H</a>
			<a id='lblTotal' style="float:right;text-align: right;">共 0.0/H</a>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>
