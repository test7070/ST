﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
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
                q_gf('', 'z_jovcc');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_jovcc',
                    options : [{
						type : '0',//[1]
						name : 'accy',
                        value : q_getId() 
                    },{
						type : '0',//[2]
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					},{
                        type : '1',//[3][4]
                        name : 'xdate'
                    },{
                        type : '6',//[5]
                        name : 'xnoa'
                    },{
	                    type : '2',//[6][7]
	                    name : 'cust',
	                    dbf : 'cust',
	                    index : 'noa,comp',
	                    src : 'cust_b.aspx'
	                },{
	                    type : '2',//[8][9]
	                    name : 'tgg',
	                    dbf : 'tgg',
	                    index : 'noa,comp',
	                    src : 'tgg_b.aspx'
	                },{
	                    type : '2',//[10][11]
	                    name : 'uccga',
	                    dbf : 'uccga',
	                    index : 'noa,namea',
	                    src : ''
	                },{
	                    type : '2',//[12][13]
	                    name : 'ucc',
	                    dbf : 'ucc',
	                    index : 'noa,product',
	                    src : 'ucc_b.aspx'
	                },{
	                    type : '2',//[14][15]
	                    name : 'cust2',
	                    dbf : 'cust2',
	                    index : 'noa,comp',
	                    src : ''
	                },{
	                    type : '2',//[16][17]
	                    name : 'xsale',
	                    dbf : 'sss',
	                    index : 'noa,namea',
	                    src : 'sss_b.aspx'
	                },{/*[18]*/
                        type : '0',
                        name : 'http',
                        value:location.host
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                if(r_len==4){                 
                    $.datepicker.r_len=4;
                    //$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate2').datepicker();
                var t_key = q_getHref();
                if(t_key[1] != undefined)
                	$('#txtXnoa').val(t_key[1]);
                	
                $('.q_report .report').css('width','500px');
                $('.q_report .report div').css('width','250px');
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
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