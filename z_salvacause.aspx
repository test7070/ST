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
                q_gf('', 'z_salvacause');
            });
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_salvacause',
						options : [{
                        type : '6',
                        name : 'xnoa'
                    },{
                        type : '1',
                        name : 'xdate'
                    },{
                        type : '1',
                        name : 'ydate'
                    },{
                    	type : '2',
                        name : 'sss',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    },{
						type : '8',
						name : 'xshow',
						value : ('1@顯示換休明細,2@顯示扣抵明細').split(',')
					},{
						type : '0', //換休期限
						name : 'carryforwards',
						value : q_getPara('salvacause.carryforwards')
					},{
                        type : '6',
                        name : 'xyear'
                    },{/* [11]*/
                        type : '0',
                        name : 'xproject',
                        value : q_getPara('sys.project').toUpperCase()
                    },{
                        type : '8',
                        name : 'xoutdate',
                        value : ('1@含離職人員').split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                var t_noa=typeof(q_getId()[5])=='undefined'?'':q_getId()[5];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtXnoa').val(t_noa).width(100);
                
                if(r_len==4){                
                    $.datepicker.r_len=4;
                    //$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                $('#txtXyear').mask(r_pic);
                $('#txtXyear').val(q_date().substr(0,r_len));
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate2').datepicker();
                $('#txtYdate1').mask(r_picd);
                $('#txtYdate1').datepicker();
                $('#txtYdate2').mask(r_picd);
                $('#txtYdate2').datepicker();
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
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>