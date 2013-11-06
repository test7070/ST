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
			var bbmNum = [['txtXradius1', 3, 0]];
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_uccst');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_uccst',
					options : [{
							type : '0', //[1]
							name : 'accy',
							value : q_getId()[4]
						},{
							type : '1', //[2][3]
							name : 'xdate'
						}, {
							type : '5', //[4]
							name : 'xstktype',
							value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
						}, {
							type : '5', //[5]
							name : 'xitype',
							value : [q_getPara('report.all')].concat(q_getPara('uccc.itype').split(','))
						}, {
							type : '2', //[6][7]
							name : 'xproduct',
							dbf : 'ucaucc',
							index : 'noa,product',
							src : 'ucaucc_b.aspx'
						},{
							type : '6', //[8]
							name : 'xstyle'
						},{
							type : '6', //[9]
							name : 'xwaste'
						},{
							type : '1', //[10][11]
							name : 'xradius'
						},{
							type : '1', //[12][13]
							name : 'xwidth'
						},{
							type : '1', //[14][15]
							name : 'xdime'
						},{
							type : '1', //[16][17]
							name : 'xlengthb'
						},{
							type : '2', //[18] [19]
							name : 'xstoreno',
							dbf : 'store',
							index : 'noa,store',
							src : 'store_b.aspx'
						},{
							type : '2', //[20] [21]
							name : 'xcustno',
							dbf : 'cust',
							index : 'noa,comp',
							src : 'cust_b.aspx'
						}, {
							type : '5', //[22]
							name : 'xorderstatus',
							value : [q_getPara('report.all')].concat('1@已受訂,2@未受訂'.split(','))
						}, {
							type : '8',//[23]
							name : 'xisordermemo',
							value : "1@顯示已受訂明細".split(',')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#Xdate').css('width','350px');
				$('#Xstktype').css('width','250px');
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				$('#Xtggno').hide();
				$('#Xitype .label').css('width','5px');
				$('#Xstktype .label').css('width','5px');
				$('#Xitype').css('width','120px');
				$('#Xstktype').css('width','120px');
				
				$('#Xisordermemo').css('width','300px').css('height','30px');
				$('#Xisordermemo .label').css('width','0px');
				$('#chkXisordermemo').css('padding-top','5px');
				$('#txtXedate').mask('999/99/99');
				$('#txtXedate').val(q_date());
				$('#Xstktype select').change(function(){
					size_change();
				});
				$('#Xstktype select').val('A1').change();
				$('#Xitype select').val('1').change();
				setDefaultValue();
				size_change();
				$('#Xitype .cmb').change(function() {
					if($('#Xitype .cmb').val()=='1'){
						$('#Xtggno').hide();
					}else{
						$('#Xtggno').show();
					}
				});
				$('.report').click(function(){
					size_change();
					$('#Xorderstatus select').change();
				});
				$('#chkXisordermemo input[type="checkbox"]').click(function(){
					$('#Xorderstatus select').change();
				});
				$('#Xorderstatus select').change(function(){
					var showMemo = $('#chkXisordermemo input[type="checkbox"]').is(':checked');
					var nowReport = $('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report;
					if(($(this).val() == '1') || ($(this).val() == '#non' && showMemo==true)){
						$('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report = nowReport.substring(0,8) + 'A';
						if($(this).val() == '1'){
							$('#chkXisordermemo input[type="checkbox"]').attr('checked',false);
						}
					}else{
						$('#chkXisordermemo input[type="checkbox"]').attr('checked',false);
						$('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report = nowReport.substring(0,8);
					}
				});
				$('#Xitype .cmb').change();
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
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
				var SelectedVal = $('#Xstktype select').val().toUpperCase();
				if(!($('#Xstktype').is(":hidden"))){
					switch (SelectedVal.substring(0,1)){
						case 'A':
							$('#Xradius').hide();
							$('#Xwidth').show();
							$('#lblXwidth').text('厚度');
							$('#lblXdime').text('寬度');
							$('#Xdime').show();
							$('#Xlengthb').show();
							break;
						case 'B':
							$('#Xradius').show();
							$('#Xwidth').show();
							$('#lblXwidth').text('長徑');
							$('#lblXdime').text('厚度');
							$('#Xdime').show();
							$('#Xlengthb').show();
							break;
						case 'C':
							$('#Xradius').hide();
							$('#Xwidth').hide();
							$('#Xdime').hide();
							$('#Xlengthb').show();
							break;
						default:
							$('#Xradius').show();
							$('#Xwidth').show();
							$('#lblXwidth').text('長徑');
							$('#lblXdime').text('厚度');
							$('#Xdime').show();
							$('#Xlengthb').show();
							break;
					}
					setDefaultValue();
					$('#Xitype .cmb').change();
				}
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