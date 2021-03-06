<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
			
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_acbal');
			});  
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_acbal',
                    options : [{/* [1]*/
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {/* [2]*/
                        type : '0',
                        name : 'xname',
                        value : r_name 
                    }, {/*1-1 [3][4]*/
                        type : '1',
                        name : 'date'
                    }, {/*1-2 [5]*/
                        type : '6',
                        name : 'xbal'
                    }, {/*1-3 [6][7]*/
                        type : '2',
                        name : 'acc',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src : "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {
						type : '0',//[8]
                        name : 'xproject',
                        value : q_getPara('sys.project').toUpperCase()
                    }, {
						type : '0',//[9]
                        name : 'xr_len',
                        value : r_len
                    }]
                });
                q_popAssign();
				q_getFormat();
				q_langShow();
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
				$('#txtDate1').datepicker();
				$('#txtDate2').datepicker();
				
                $('#txtDate1').mask(r_picd);
				$('#txtDate2').mask(r_picd);
                $('#txtDate1').val((dec(q_date().substr(0, r_len))-1).toString() + '/01/01');           
                $('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0, r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
				
				if(q_getPara('sys.project').toUpperCase()=='VU' || q_getPara('sys.project').toUpperCase()=='SF'){
					if( r_accy > '105' && q_date().substr( r_len+1,2)=='01')
	  					q_func( 'accend.genNextYear', ''+parseFloat( r_accy)-1+',1');
				}
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
                <!--#include file="../inc/print_ctrl.inc"-->
            </div>
		</div>
	</body>
</html>

