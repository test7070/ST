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
			aPop = new Array(
				['txtXsssno', 'lblXsssno', 'sss', 'noa,namea', 'txtSssno', 'sss_b.aspx'],
				['txtXcomp', 'lblXcomp', 'acomp', 'noa,acomp', 'txtXcomp', 'acomp_b.aspx'],
				['txtXcustno', 'lblXcustno', 'cust', 'noa,comp', 'txtXcustno', 'cust_b.aspx'],
				['txtSssall', '', 'sssall', 'noa,namea', 'txtSssall', 'sssall_b.aspx'],
				['txtCarownerno', 'lblCarownerno', 'carowner', 'noa,namea', 'txtCarownerno', 'carowner_b.aspx']
			);
			
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_labase');
			});
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_labase',
					options : [{//[1]
						type : '0',
						name : 'accy',
						value : r_accy
					}, {
						type : '2', //[2][3]
						name : 'xsssno',
						dbf : 'sssall',
						index : 'noa,namea',
						src : 'sssall_b.aspx'
					}, {
						type : '2', //[4][5]
						name : 'xcno',
						dbf : 'acomp',
						index : 'noa,acomp',
						src : 'acomp_b.aspx'
					}, {
						type : '1', //[6][7]
						name : 'xmon'
					}, {
						type : '6', //[8]
						name : 'cmon'
					}, {
						type : '5', //select[9]
						name : 'xlab',
						value : ('全部,投保,退保').split(',')
					}, {
						type : '1', //[10][11]
						name : 'salary'
					}, {
						type : '6', //[12]
						name : 'xyear'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				if (r_len == 4) {
					$.datepicker.r_len = 4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
				}
				
				$('#txtXmon1').mask(r_picm);
				$('#txtXmon2').mask(r_picm);
				$('#txtCmon').mask(r_picm);
				$('#txtXyear').mask(r_pic);
				$('#txtXyear').val(q_date().substring(0, r_len));
				
				$('#txtXmon1').val(q_date().substring(0, r_lenm));
				$('#txtXmon2').val(q_date().substring(0, r_lenm));

				$('#txtSalary1').val(0);
				$('#txtSalary2').val(999999);
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