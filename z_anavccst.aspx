<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			var uccgaItem = '',cnoitem='';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				
				q_gf('', 'z_anavccst');
				
				$('#q_report').click(function() {
					now_report=$('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report;
					if(now_report=='z_anavccst04'){
						$('#lblXdate').text('訂單日期');
					}else{
						$('#lblXdate').text(q_getMsg("lblXdate"));
					}
				});
						
			});
			function q_gfPost() {
				q_gt('uccga', '', 0, 0, 0, "");
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						if (as[0] != undefined) {
						 	uccgaItem = ' @未設定';
							for (var i = 0; i < as.length; i++) {
								uccgaItem += (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+' . '+as[i].namea;
							}
						}
						q_gt('acomp', '', 0, 0, 0, "");
						break;
					case 'acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							cnoitem = '#non@全部';
							for (var i = 0; i < as.length; i++) {
								cnoitem += (cnoitem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+' . '+as[i].nick;
							}
						}
						loadFinish();
						break;
				} 
			}
			function loadFinish(){
				$('#q_report').q_report({
					fileName : 'z_anavccst',
					options : [{
						type : '1', //[1][2]  1
						name : 'xdate'
					}, {
						type : '2', //[3][4]  2
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[5][6]  3
						name : 'xsales',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
                        type : '8',//[7]   4
                        name : 'xitem',
                        value : uccgaItem.split(',')
                    }, {
                        type : '8',//[8]  5
                        name : 'xoption01',
                        value : q_getMsg('xoption01').split('&')
                    }, {
                        type : '5',//[9]  6
                        name : 'xkind',
                        value : '全部,鋼捲,鋼管'.split(',')
                    }, {
						type : '2', //[10][11] 7
						name : 'xproduct',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					},{
						type : '1', //[12][13]  8
						name : 'xdime'
					},{
						type : '1', //[14][15]]   9
						name : 'xwidth'
					},{
						type : '6', //[16]   10  bd使用
						name : 'xrate'
					}, {
                        type : '5',//[17]   11  bd使用
                        name : 'xcno',
                        value : cnoitem.split(',')
                    }]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				if (r_len == 4) {
					$.datepicker.r_len = 4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
				}
				
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask(r_picd);
				$('#txtXdate2').datepicker();
				$('#chkXitem').children('input').attr('checked', 'checked');
				
				$('#txtXdime1').css('text-align','right').val('0');
				$('#txtXdime2').css('text-align','right').val('999');
				$('#txtXwidth1').css('text-align','right').val('0');
				$('#txtXwidth2').css('text-align','right').val('9999');
				
				$('#txtXrate').css('text-align','right').val('0');
				$('#txtXrate').css('width','60px');
				
				if(q_getPara('sys.project').toUpperCase()!='BD'){
					var t_index=-1;
					for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
						if($('#q_report').data('info').reportData[i].report=='z_anavccst05'){
							t_index=i;
							break;	
						}
					}
					if(t_index>-1){
						$('#q_report div div').eq(i).hide();
					}
				}else{
					$('#chkXoption01').children('input').attr('checked', 'checked');
				}
				
			}
			function q_boxClose(s2) {
			}
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div>需先執行【庫存成本表-結轉】，進貨成本才會重新計算‧</div>
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>