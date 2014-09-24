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
			aPop = new Array(['txtXpart', '', 'part', 'noa,part', 'txtXpart', "part_b.aspx"]);
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_ummfe');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ummfe',
					options : [{
						type : '6', //[1]
						name : 'xcno'
					}, {
						type : '2', //[2][3]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '1', //[4][5]
						name : 'xdate'
					}, {
						type : '1', //[6][7]
						name : 'xmon'
					}]
				});
				q_popAssign();
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();
				$('#txtSmon1').mask('999/99');
				$('#txtSmon2').mask('999/99');
				$('#Xmemo').removeClass('a2').addClass('a1');
				$('#txtXmemo').css('width', '85%');
				$('.q_report .report').css('width', '420px');
				$('.q_report .report div').css('width', '200px');

				var t_date, t_year, t_month, t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);
				$('#txtSmon1').val(t_year + '/' + t_month);
				$('#txtSmon2').val(t_year + '/' + t_month);
				$('#txtXdate1').val(t_month + '/' + t_day);

				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
				$('#txtXdate2').val(t_month + '/' + t_day);

				var tmp = document.getElementById("txtPaytype");
				var selectbox = document.createElement("select");
				selectbox.id = "combPay";
				selectbox.style.cssText = "width:15px;font-size: medium;";
				//selectbox.attachEvent('onchange',combPay_chg);
				//selectbox.onchange="combPay_chg";
				tmp.parentNode.appendChild(selectbox, tmp);
				q_cmbParse("combPay", '全部,' + q_getPara('vcc.paytype'));
				$('#txtPaytype').val('全部');

				$('#combPay').change(function() {
					var cmb = document.getElementById("combPay")
					$('#txtPaytype').val(cmb.value);
				});
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