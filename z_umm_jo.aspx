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
            var acompItem = '';
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_umm_jo');
                //q_gt('acomp', '', 0, 0, 0, "");
            });
            
            function q_gtPost(t_name) {
                switch (t_name) {
                }
            }

            function q_gfPost() {
                $('#qReport').q_report({
                    fileName : 'z_umm_jo',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : q_getId()[4]
                    },{
						type : '0',//[2]
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					},{
						type : '0',//[3]
						name : 'xrlen',
						value : r_len
					}, {
                        type : '1', //[4][5]
                        name : 'xdate'
                    }, {
                        type : '2', //[6][7]
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '6', //[8]
                        name : 'xfdate'
                    }, {
						type : '6', //[9]
						name : 'xmon'
					}, {
                        type : '1', //[10][11]
                        name : 'xinvono'
                    }, {
                        type : '2', //[12][13]
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    },{
                        type : '8', //[14]
                        name : 'xshowsale',
                        value : "1@依業務".split(',')
                    }]
                });
                
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);
                $('#txtXmon').mask(r_picm);
                $('#txtXmon').val(q_date().substr(0,r_lenm));
                if(r_len==3){
                	$('#txtXdate1').datepicker();
                	$('#txtXdate2').datepicker();
                }
                $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
                
                $('#Xshowsale').css('width', '300px').css('height', '30px');
                $('#Xshowsale .label').css('width','0px');
                $('#chkXshowsale').css('width', '220px').css('margin-top', '5px');
                $('#chkXshowsale span').css('width','180px')
            }
		    
            function q_boxClose(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="qReport"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>