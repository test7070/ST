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
            	q_getId();
                q_gf('', 'z_bankpost');       
            }); 
            
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_bankpost',
					options : [{
							type:'5',//[1]
							name: 'salary',
							value:['薪資','獎金']
						},{
							type: '6',//[2]
							name: 'month'	
						},{
							type:'6',//[3]
							name:'xdate'
						},{
							type:'6',//[4]
							name:'xnoa'
						}
					]});

				q_popAssign();
                q_langShow();
                
				$('#txtMonth').mask(r_picm);
				$('#txtMonth').val(q_date().substr(0,r_lenm));
				$('#txtXdate').mask(r_picd);
				$('#txtXdate').val(q_date());
				$('#txtXdate').datepicker();
				
				$('#btnPost').click(function() {
					var t_typea=emp($('#Salary select').val())?'#non':$('#Salary select').val();
					var t_mon=emp($('#txtMonth').val())?'#non':$('#txtMonth').val();
					var t_datea=emp($('#txtXdate').val())?'#non':$('#txtXdate').val();
					var t_noa=emp($('#txtXnoa').val())?'#non':$('#txtXnoa').val();
					
					if(t_typea.length>0 && t_mon.length>0 && t_datea.length>0)
	            		q_func('qtxt.query.postmedia', 'bankpost.txt,bankpost_media,' +encodeURI(t_typea)+';'+encodeURI(t_mon)+';'+encodeURI(t_datea)+';'+encodeURI(t_noa));
	            });
            }

			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.postmedia':
                		var s1 = location.href;
		        		var t_path = (s1.substr(7, 5) == 'local' ? xlsPath : s1.substr(0, s1.indexOf('/', 10)) + '/htm/');
		        		window.open(t_path + 'htm/PSBP-PAY-NEW.txt', "_blank", 'directories=no,location=no,menubar=no,resizable=1,scrollbars=1,status=0,toolbar=1');
                		break;
                    default:
                        break;
                }
            }
            
			
			function q_gtPost(s2) {
				
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
				<input id="btnPost" type="button"/>
			</div>
			<div class="prt" style="margin-left: -40px;">			
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          