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
                q_gf('', 'z_vcct');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_vcct',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : r_accy
                    }, {//1-1 [2][3]
                        type : '1',
                        name : 'xdate'
                    }, {//1-2 [4][5]
                        type : '1',
                        name : 'xnoa'
                    }, {//1-3 [6]
                        type : '6',
                        name : 'xserial'
                    }, {//1-4 [7]
                        type : '6',
                        name : 'xbook'
                    }, {//2-1 [8]
                        type : '5',
                        name : 'xtypea',
                        value : [q_getPara('report.all')].concat(q_getPara('vcct.typea').split(','))
                    }, {//2-2 [9]
                        type : '5',
                        name : 'xkind',
                        value : [q_getPara('report.all')].concat(replaceAll(q_getPara('vcct.kind'), '@,', '').split(','))
                    }, {//2-3 [10][11]
                        type : '1',
                        name : 'xmon'
                    }, {//2-4 [12]
                        type : '5',
                        name : 'ytypea',
                        value : [q_getPara('report.all')].concat('2@二聯式,3@三聯式'.split(','))
                    }, {
                        type : '0', //[13]
                        name : 'xproject',
                        value : q_getPara('sys.project').toUpperCase()
                    }, {//3-1 [14]
                        type : '6',
                        name : 'xinvosix'
                    }, {
                        type : '0', //[15]
                        name : 'xlen',
                        value : r_len
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                if (r_len == 4) {
                    $.datepicker.r_len = 4;
                    //$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }

                $('#cmbKind').css("width", "515px");

                $('#txtXdate1').mask(r_picd);
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate2').datepicker();

                $('#txtXmon1').mask(r_picm);
                $('#txtXmon2').mask(r_picm);
                $('#lblXinvosix').css('font-size', '12px');

                $('#txtXinvosix').keyup(function() {
                    $(this).val($(this).val().substr(0, 8));
                });

                $('#txtXdate1').val(q_cdn(q_date().substr(0, r_lenm) + '/01', 0));
                $('#txtXmon1').val(q_date().substr(0, r_lenm));

                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0, r_lenm) + '/01', 60).substr(0, r_lenm) + '/01', -1));
                $('#txtXmon2').val(q_date().substr(0, r_lenm));

            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }
		</script>
		<style type="text/css">
            #frameReport table {
                border-collapse: collapse;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
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

