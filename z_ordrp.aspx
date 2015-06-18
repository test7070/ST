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
			var z_uccga = new Array(),z_uccgb = new Array(),z_uccgc = new Array();
			$(document).ready(function() {
				q_getId();
				q_gt('uccga', "", 0, 0, 0, 'uccga');
			});
			function q_gtPost(t_name) {
				switch (t_name) {
                	case 'uccga':
                		var as = _q_appendData("uccga", "", true);
                		if (as[0] != undefined) {
                			z_uccga = new Array();
	                		for(var i=0;i<as.length;i++){
	                			z_uccga.push({noa:as[i].noa,namea:as[i].namea});
	                		}
                		}
                		q_gt('uccgb', "", 0, 0, 0, 'uccgb'); 
                		break;
            		case 'uccgb':
                		var as = _q_appendData("uccgb", "", true);
                		if (as[0] != undefined) {
                			z_uccgb = new Array();
	                		for(var i=0;i<as.length;i++){
	                			z_uccgb.push({noa:as[i].noa,namea:as[i].namea});
	                		}
                		}
                		q_gt('uccgc', "", 0, 0, 0, 'uccgc'); 
                		break;  
            		case 'uccgc':
                		var as = _q_appendData("uccgc", "", true);
                		if (as[0] != undefined) {
                			z_uccgc = new Array();
	                		for(var i=0;i<as.length;i++){
	                			z_uccgc.push({noa:as[i].noa,namea:as[i].namea});
	                		}
                		}
                		q_gf('', 'z_ordrp');
                		break;            	
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	try{
                    		var t_para = JSON.parse(t_name);
                    		if(t_para.action==""){
							}
                    	}catch(e){
                    	}
                        break;
                }
			}
			function q_gfPost() {
				t_uccga = ' @全部';
                for(var i=0;i<z_uccga.length;i++){
                	t_uccga +=','+z_uccga[i].noa+'@'+z_uccga[i].noa+'. '+z_uccga[i].namea;
                }
                t_uccgb = ' @全部';
                for(var i=0;i<z_uccgb.length;i++){
                	t_uccgb +=','+z_uccgb[i].noa+'@'+z_uccgb[i].noa+'. '+z_uccgb[i].namea;
                }
               	t_uccgc = ' @全部';
                for(var i=0;i<z_uccgc.length;i++){
                	t_uccgc +=','+z_uccgc[i].noa+'@'+z_uccgc[i].noa+'. '+z_uccgc[i].namea;
                }
                
				$('#q_report').q_report({
					fileName : 'z_ordrp',
					options : [{
						type : '5', //[1]
						name : 'apv',
						value : (' @全部,1@已核准,2@未核准').split(',')
					},{
						type : '6', //[2]
						name : 'workgno'
					},{
						type : '1', //[3][4]
						name : 'rworkdate'
					}, {
						type : '5', //[5]
						name : 'uccgano',
						value : t_uccga.split(',')
					}, {
						type : '5', //[6]
						name : 'uccgbno',
						value : t_uccgb.split(',')
					}, {
						type : '5', //[7]
						name : 'uccgcno',
						value : t_uccgc.split(',')
					}]
				});
				q_popAssign();
				q_langShow();
				$('#txtRworkdate1').mask('999/99/99');
				$('#txtRworkdate1').datepicker();
				$('#txtRworkdate2').mask('999/99/99');
				$('#txtRworkdate2').datepicker();
			}

			function q_boxClose(s2) {
			}

			
		</script>
		<style type="text/css">
			.num{
				text-align:right;
				padding-right:2px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>