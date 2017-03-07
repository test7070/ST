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
				q_gf('', 'z_ordcstp');
			});
			function q_gfPost() {
				var t_kind = '';
				if(q_getPara('sys.project').toUpperCase()=='PK'){
					t_kind = q_getPara('sys.stktype') + ',2@物料,3@委外';
					//ordcst.aspx  z_ordcst.aspx
				}else{
					t_kind = q_getPara('sys.stktype') + ',2@物料';
				}
				$('#q_report').q_report({
					fileName : 'z_ordcstp',
					options : [{//[1]
						type : '0',
						name : 'project',
						value : q_getPara('sys.project').toUpperCase()
					}, {//[2]
						type : '0',
						name : 'xkind',
						value : t_kind
					}, {//[3][4]
						type : '1',
						name : 'date'
					}, {//[5]
						type : '6',
						name : 'xnoa'
					}, {//[6]
						type : '6',
						name : 'xno2'
					}, {//[7]
						type : '5',
						name : 'xstype',
						value :[q_getPara('report.all')].concat(t_kind.split(','))
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#txtDate1').mask('999/99/99');
				$('#txtDate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();
				$('#Xstype select').change(function(){
					var thisVal=$(this).val();
					if(thisVal=='1'){
						var nowReport = $('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report;
						$('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report = nowReport.substring(0, nowReport.length-1)+'B';
					}else{
						var nowReport = $('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report;
						$('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report = nowReport.substring(0, nowReport.length-1)+'A';
					}
				});
				var t_key = q_getHref();
				if ($.trim(t_key[0]) == 'noa' && t_key[1] != undefined)
					$('#txtXnoa').val(t_key[1]);
				if ($.trim(t_key[2]) == 'no2' && t_key[3] != undefined)
					$('#txtXno2').val(t_key[3]);
				if($.trim($('#txtXno2').val()) != ''){
					var t_kind=$.trim(parent.window.$('#cmbKind').val());
					if(t_kind=='1'){
						$('#Xstype select').val(1);
					}else{
						$('#Xstype select').val(0);
					}
					$('#q_report .report .radio').eq(2).click();
					$('#Xstype select').change();
					$('#btnOk').click();
				}
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
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