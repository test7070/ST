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
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_uccefep');
				
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_uccefep',
					options : [{
							type : '0',//[1]
							name : 'accy',
							value : r_accy
						},{
	                        type : '0',//[2]
	                        name : 'mountprecision',
	                        value : q_getPara('rc2.mountPrecision')
	                    },{
	                        type : '0',//[3]
	                        name : 'weightprecision',
	                        value : q_getPara('rc2.weightPrecision')
	                    },{
	                        type : '0',//[4]
	                        name : 'priceprecision',
	                        value : q_getPara('rc2.pricePrecision')
	                    },{
							type : '1',//[5][6]
							name : 'xnoa'
						},{
							type : '6',//[7]
							name : 'stkdate'
						},{
							type : '6',//[8]
							name : 'uccedate'
						},{
							type : '8',//[8]
							name : 'xshow',
							value:"1@顯示庫存差異大於0,2@顯示庫存差異小於0".split(',')
						}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				var t_noa=typeof(q_getId()[5])=='undefined'?'':q_getId()[5];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtXnoa1').val(t_noa);
                $('#txtXnoa2').val(t_noa);
				
				$('#txtStkdate').mask('999/99/99');
				$('#txtStkdate').datepicker();
				$('#txtUccedate').mask('999/99/99');
				$('#txtUccedate').datepicker();
				
				q_gt('ucce', "where=^^1=1^^ stop=1", 0, 0, 0, "ucce", r_accy);
				$('#chkXshow input').prop('checked',true);
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(t_name) {
                switch (t_name) {
                	case 'ucce':
                		var as = _q_appendData("ucce", "", true);                		
						if(as[0]!=undefined){
							if(as[0].datea!=''){
								$('#txtUccedate').val(as[0].datea);
								$('#txtStkdate').val(q_cdn(as[0].datea,-1));
							}
						}
                		break;
                }
			}
		</script>
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