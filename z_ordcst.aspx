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
				q_getId();
				q_gf('', 'z_ordcst');

			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ordcst',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1', //[2][3] 1
						name : 'date'
					}, {
						type : '1', //[4][5] 2
						name : 'odate'
					}, {
						type : '2', //[6][7] 3
						name : 'tgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '2', //[8][9] 4
						name : 'sales',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '2', //[10][11] 1
						name : 'product',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					}, {
						type : '5', //[12] 2
						name : 'stype',
						value : [q_getPara('report.all')].concat(q_getPara('ordc.stype').split(','))
					}, {
						type : '5', //[13] 3
						name : 'tran',
						value : [q_getPara('report.all')].concat(q_getPara('sys.tran').split(','))
					}, {
						type : '5', //[14] 4
						name : 'cancel',
						value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
					}, {
						type : '5', //[15] 1
						name : 'end',
						value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
					}, {
						type : '1', //[16][17] 2
						name : 'xdime'
					}, {
						type : '1', //[18][19] 3
						name : 'xwidth'
					}, {
						type : '1', //[20][21] 4
						name : 'xlengthb'
					}, {
						type : '8', //[22] 1
						name : 'detail',
						value : (new Array('detail@明細'))
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();

				$('#txtOdate1').mask('999/99/99');
				$('#txtOdate1').datepicker();
				$('#txtOdate2').mask('999/99/99');
				$('#txtOdate2').datepicker();
				$('#txtOddate1').mask('999/99/99');
				$('#txtOddate1').datepicker();
				$('#txtOddate2').mask('999/99/99');
				$('#txtOddate2').datepicker();
				setDefaultValue();
				
				//未結案
				$('#End').children().eq(1).val('0');
				
				var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_date.setDate(-2);
                t_date.setDate(0);
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtOdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtOdate2').val(t_year + '/' + t_month + '/' + t_day);
			}
            function setDefaultValue() {
                $('#txtXwidth1').val(0).addClass('num').focusout(function() {
                    $(this).val(dec($(this).val()));
                    if ($(this).val() == 'NaN')
                        $(this).val(0);
                });
                $('#txtXwidth2').val(9999.99).addClass('num').focusout(function() {
                    $(this).val(dec($(this).val()));
                    if ($(this).val() == 'NaN')
                        $(this).val(9999.99);
                });
                $('#txtXdime1').val(0).addClass('num').focusout(function() {
                    $(this).val(dec($(this).val()));
                    if ($(this).val() == 'NaN')
                        $(this).val(0);
                });
                $('#txtXdime2').val(9999.99).addClass('num').focusout(function() {
                    $(this).val(dec($(this).val()));
                    if ($(this).val() == 'NaN')
                        $(this).val(9999.99);
                });
                $('#txtXlengthb1').val(0).addClass('num').focusout(function() {
                    $(this).val(dec($(this).val()));
                    if ($(this).val() == 'NaN')
                        $(this).val(0);
                });
                $('#txtXlengthb2').val(99999.9).addClass('num').focusout(function() {
                    $(this).val(dec($(this).val()));
                    if ($(this).val() == 'NaN')
                        $(this).val(99999.9);
                });
            }
			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
		</script>
		<style type="text/css">
			.num {
				text-align: right;
				padding-right: 2px;
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