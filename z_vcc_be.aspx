<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
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
                q_gf('', 'z_vcc_be');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_vcc_be',
                    options : [{/*1[1][2] */
                        type : '1',
                        name : 'xnoa',
                    }, {/*2[3][4]*/
                        type : '1',
                        name : 'xdate'
                    }, {/*3[5][6]*/
                        type : '2',
                        name : 'xcustno',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    },{/*[7] */
                        type : '0',
                        name : 'userno',
                        value : r_userno
                    },{/*[8] */
                        type : '0',
                        name : 'rank',
                        value : r_rank
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);

                if (r_len == 3) {//西元年
                    $('#txtXdate1').datepicker();
                    $('#txtXdate2').datepicker();
                }

                $('#txtXdate1').val(q_cdn(q_date().substr(0, r_lenm) + '/01', 0));
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0, r_lenm) + '/01', 60).substr(0, r_lenm) + '/01', -1));
                
                if(r_rank<8){
                	$('#txtXcustno1a').val(r_userno).attr('disabled', 'disabled');;
                	$('#txtXcustno1b').val(r_name).attr('disabled', 'disabled');;
                	$('#txtXcustno2a').val(r_userno).attr('disabled', 'disabled');;
                	$('#txtXcustno2b').val(r_name).attr('disabled', 'disabled');;
                	$('#btnXcustno1').hide();
                	$('#btnXcustno2').hide();
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