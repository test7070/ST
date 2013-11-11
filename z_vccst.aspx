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
			if(location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;100";
			}
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_vccst');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_vccst',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					},{
						type : '1', //[2][3]1
						name : 'xdate'
					},{
						type : '1', //[4][5]2
						name : 'xmon'
					},{
						type : '2', //[6][7]4
						name : 'xpno',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					},{
						type : '2', //[8][9]8
						name : 'xcust',	
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					},{
						type : '5', //[10]1
						name : 'xstype',
						value : [q_getPara('report.all')].concat(q_getPara('vccst.stype').split(','))
					},{
						type : '5', //[11]2
						name : 'xtypea',
						value : q_getPara('vccst.typea')
					},{
						type : '6', //[12]4
						name : 'xspec'
					},{
						type : '1', //[13][14]8
						name : 'xradius'
					},{
						type : '1', //[15][16]1
						name : 'xwidth'
					},{
						type : '1', //[17][18]2
						name : 'xdime'
					},{
						type : '1', //[19][20]4
						name : 'xlengthb'
					}]
				});
				q_popAssign();
				q_langShow();
				$('#txtXmon1').mask('999/99');
				$('#txtXmon2').mask('999/99');
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				setDefaultValue();
				size_change();
				$('.report').click(function(){
					size_change();
				});
				var t_date,t_year,t_month,t_day;
					t_date = new Date();
					t_date.setDate(1);
					t_year = t_date.getUTCFullYear()-1911;
					t_year = t_year>99?t_year+'':'0'+t_year;
					t_month = t_date.getUTCMonth()+1;
					t_month = t_month>9?t_month+'':'0'+t_month;
					t_day = t_date.getUTCDate();
					t_day = t_day>9?t_day+'':'0'+t_day;
					$('#txtXdate1').val(t_year+'/'+t_month+'/'+t_day);
					$('#txtXmon1').val(t_year+'/'+t_month);
					
					t_date = new Date();
					t_date.setDate(35);
					t_date.setDate(0);
					t_year = t_date.getUTCFullYear()-1911;
					t_year = t_year>99?t_year+'':'0'+t_year;
					t_month = t_date.getUTCMonth()+1;
					t_month = t_month>9?t_month+'':'0'+t_month;
					t_day = t_date.getUTCDate();
					t_day = t_day>9?t_day+'':'0'+t_day;
					$('#txtXdate2').val(t_year+'/'+t_month+'/'+t_day);
					$('#txtXmon2').val(t_year+'/'+t_month);
			}

			function setDefaultValue(){
				$('#txtXradius1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXradius2').val(9999.99).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(9999.99);
				});
				$('#txtXwidth1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXwidth2').val(9999.99).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(9999.99);
				});
				$('#txtXdime1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXdime2').val(9999.99).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(9999.99);
				});
				$('#txtXlengthb1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXlengthb2').val(99999.9).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(99999.9);
				});
			}
			function size_change(){
				var nowReport = $('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].reportName;
				nowReport = trim(nowReport);
				if(nowReport.indexOf('管')>-1){
					$('#lblXwidth').text('長徑');
					$('#lblXdime').text('厚度');
				}else{
					$('#lblXwidth').text('厚度');
					$('#lblXdime').text('寬度');
				}
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
		</script>
		<style type="text/css">
			.num{
				text-align:right;
				padding-right:2px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
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