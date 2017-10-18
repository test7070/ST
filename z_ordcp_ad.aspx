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
                q_gf('', 'z_ordcp_ad');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_ordcp_ad',
                    options : [{/* [1]*/
						type : '0',
						name : 'accy',
                        value : q_getId()[4] 
                    },{/*1 [2][3]*/
                        type : '1',
                        name : 'xnoa'
                    },{/*2 [4][5]*/
                        type : '1',
                        name : 'xdate'
                    },{/*3 [6][7]*/
                        type : '1',
                        name : 'xfdate'
                    },{
                        type : '2',/*4 [8][9]*/
                        name : 'xtggno',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    },{
                        type : '2',/*5 [10][11]*/
                        name : 'xproduct',
                        dbf : 'ucaucc',
                        index :'noa,product',
                        src : 'ucaucc_b.aspx'
                    },{
                        type : '2', /*6 [12][13]*/
                        name : 'xsales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
						type : '0', //[14]
						name : 'xip',
						value : location.hostname
					}]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#txtXdate1').mask(r_picd);
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask(r_picd);
				$('#txtXdate2').datepicker();
				$('#txtXfdate1').mask(r_picd);
				$('#txtXfdate1').datepicker();
				$('#txtXfdate2').mask(r_picd);
				$('#txtXfdate2').datepicker();
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				
				$('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
				$('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));
				$('#txtXfdate1').val(q_date().substr(0,r_lenm)+'/01');
				$('#txtXfdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));

                var t_para = (typeof (q_getId()[4]) == 'undefined' ? '' : q_getId()[4]).split('&');
                for(var i=0;i<t_para.length;i++){
                    if(t_para[i].indexOf('noa=') >= 0){
                        t_no = t_para[i].replace('noa=', '');
                        if (t_no.length > 0) {
                            $('#txtXnoa1').val(t_no);
                            $('#txtXnoa2').val(t_no);
                        }
                    }    
                } 
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