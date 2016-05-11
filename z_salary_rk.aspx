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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_salary_rk');

                $('#q_report').click(function(e) {

                });
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_salary_rk',
                    options : [{
                        type : '6',
                        name : 'xmon'
                    }, {
                        type : '5',
                        name : 'xtypea',
                        value : (('').concat(new Array('薪資','津貼'))).split(',')
                    }, {
                        type : '5',
                        name : 'xkind',
                        value : (('').concat(new Array("本月", "上期", "下期"))).split(',')
                    }, {
                        type : '2',
                        name : 'xsssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '1',
                        name : 'xdate'
                    }, {
                        type : '5',
                        name : 'xorder',
                        value : (('').concat(new Array("部門", "員工編號"))).split(',')
                    }, {
                        type : '6',
                        name : 'xyear'
                    }, {
                        type : '5',
                        name : 'xservice',
                        value : (('').concat(new Array("#non@全部", "1@在職", "0@離職"))).split(',')
                    }, {
                        type : '6',
                        name : 'xmemo'
                    }]
                });
                q_popAssign();
                $('#txtXmon').mask(r_picm);
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate2').datepicker();

               $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXmon').val(q_date().substr(0,r_lenm));
                $('#txtXyear').val(q_date().substr(0,r_len));
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
            }

            function q_funcPost(t_func, result) {
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

