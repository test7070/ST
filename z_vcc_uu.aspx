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
			var uccgaItem = '';
			var uccgbItem = '';
			var firstRun = false;
			var t_part = '';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gt('part', '', 0, 0, 0);
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_vcc_uu',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '0', //[2]
						name : 'xrstype',
						value : q_getPara('vcc.stype_uu')
					/*#####################*/				
					}, {
						type : '5', //[3]
						name : 'xstype',
						value : [q_getPara('report.all')].concat(q_getPara('vcc.stype_uu').split(','))
					}, {
						type : '5', //[4]/
						name : 'xgroupano',
						value : uccgaItem.split(',')
					}, {
						type : '6', //[5]
						name : 'salesgroup'
					}, {
						type : '5', //[6]/
						name : 'xgroupbno',
						value : uccgaItem.split(',')
					/*#####################*/				
					}, {
						type : '2', //[7][8]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[9][10]
						name : 'xsales',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '2', //[11][12]
						name : 'xproduct',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '2', //[13][14]
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					/*#####################*/				
					}, {
						type : '5', //[15]/
						name : 'xpartno',
						value : t_part.split(',')
					}, {
						type : '5', //[16]/
						name : 'xshowvalue',
						value : '1@數量,2@金額,3@數量+金額'.split(',')
					}, {
						type : '6', //[17]
						name : 'xyear'
					}, {
						type : '6', //[18]
						name : 'xweek'
					/*#####################*/				
					}, {
						type : '6', //[19]
						name : 'xsdate'
					}, {
						type : '6', //[20]
						name : 'xsmon'
					}, {
						type : '1', //[21][22]
						name : 'xmon'
					}, {
						type : '1', //[23][24]
						name : 'xdate'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				$('#txtXmon1').val(q_date().substring(0, 6)).mask('999/99');
				$('#txtXmon2').val(q_date().substring(0, 6)).mask('999/99');
				$('#txtXsmon').val(q_date().substring(0, 6)).mask('999/99');
				$('#txtXsdate').mask('999/99/99');
				$('#txtXsdate').val(q_date());
				$('#txtXyear').mask('999');
				$('#txtXweek').mask('99');
				$('#txtXweek').val(padL((new Date(q_date())).getWeekOfYear(), '0', 2));
				$('#txtXyear').val(r_accy.substring(0, 3));
				$('#txtXbmon1').val(r_accy + '/01').mask('999/99');
				$('#txtXbmon2').val(r_accy + '/12').mask('999/99');
				$('#txtXemon1').val(r_accy + '/01').mask('999/99');
				$('#txtXemon2').val(r_accy + '/12').mask('999/99');
				firstRun = false;
			}


			Date.prototype.getWeekOfYear = function(weekStart) {
				weekStart = (weekStart || 0) - 0;
				if (isNaN(weekStart) || weekStart > 6)
					weekStart = 0;
				var year = this.getFullYear();
				var firstDay = new Date(year, 0, 1);
				var firstWeekDays = 7 - firstDay.getDay() + weekStart;
				var dayOfYear = (((new Date(year, this.getMonth(), this.getDate())) - firstDay) / (24 * 3600 * 1000)) + 1;
				return Math.ceil((dayOfYear - firstWeekDays) / 7) + 1;
			};

			function q_boxClose(s2) {
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						uccgaItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
						}
						if (uccgbItem.length == 0) {
							q_gt('uccgb', '', 0, 0, 0, "");
							firstRun = true;
						}
						break;
					case 'uccgb':
						var as = _q_appendData("uccgb", "", true);
						as.sort(function(x,y){return x.noa-y.noa;});
						uccgbItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							uccgbItem = uccgbItem + (uccgbItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
						}
						break;
					case 'part':
						t_part = '#non@全部';
						var as = _q_appendData("part", "", true);
						for ( i = 0; i < as.length; i++) {
							t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
						}
						if (uccgaItem.length == 0) {
							q_gt('uccga', '', 0, 0, 0, "");
						}
						break;
				}
				if ((uccgaItem.length > 0) && (uccgbItem.length > 0) && firstRun) {
					q_gf('', 'z_vcc_uu');
				}
			}
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
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