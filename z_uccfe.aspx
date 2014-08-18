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
				_q_boxClose();
				q_getId();
				q_gf('', 'z_uccfe');
			});
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_uccfe',
					options : [{
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					},{
						type : '0',//[2]
						name : 'mountprecision',
						value : q_getPara('vcc.mountPrecision')
					},{
						type : '0',//[3]
						name : 'weightprecision',
						value : q_getPara('vcc.weightPrecision')
					},{
						type : '0',//[4]
						name : 'priceprecision',
						value : q_getPara('vcc.pricePrecision')
					}, {
						type : '1', //1
						name : 'date' //[5][6]
					}, {
						type : '2',//2
						name : 'product', //[7][8]
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '2',//4
						name : 'storeno', //[9][10]
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
						type : '2', // 8 [11][12]
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '6', //10
						name : 'enddate' //[13]
					}, {
						type : '1', //20
						name : 'udate' //[14][15]
					}, {
						type : '8',//40
						name : 'less_safe',//[16]
						value : '1@僅顯示低於安全存量'.split(',')
					}, {
						type : '8',//80
						name : 'allucc',//[17]
						value : '1@顯示所有物品'.split(',')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();

				$('#txtUdate1').mask('999/99/99');
				$('#txtUdate1').datepicker();
				$('#txtUdate2').mask('999/99/99');
				$('#txtUdate2').datepicker();
				$('#txtDate1').mask('999/99/99');
				$('#txtDate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();

				$('#txtEnddate').mask('999/99/99');
				$('#txtEnddate').val(q_date());
				
				$('#Allucc').css('width','300px').css('height','30px');
				$('#Allucc .label').css('width','0px');
				$('#Less_safe').css('width','300px').css('height','30px');
				$('#Less_safe .label').css('width','0px');
				$('#Udate').css('width','300px');
				$('#txtUdate1').css('width','90px');
				$('#txtUdate2').css('width','90px');
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(t_name) {
				switch (t_name) {
				}
			}
		</script>
		<style type="text/css">
			/*.q_report .option {
			 width: 600px;
			 }
			 .q_report .option div.a1 {
			 width: 580px;
			 }
			 .q_report .option div.a2 {
			 width: 220px;
			 }
			 .q_report .option div .label {
			 font-size:medium;
			 }
			 .q_report .option div .text {
			 font-size:medium;
			 }
			 .q_report .option div .cmb{
			 height: 22px;
			 font-size:medium;
			 }
			 .q_report .option div .c2 {
			 width: 80px;
			 }
			 .q_report .option div .c3 {
			 width: 110px;
			 }*/
		</style>
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