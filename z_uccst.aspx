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

			var t_style = '',t_ucc='',t_spec='';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_uccst');
			});
			function q_gfPost() {
				q_gt('style', '', 0, 0, 0, "");
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'style':
						t_style = '';
						var as = _q_appendData("style", "", true);
						for ( i = 0; i < as.length; i++) {
							t_style += (t_style.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + '.' + as[i].product;
						}
						q_gt('ucc', '', 0, 0, 0, "");
						break;
					case 'ucc':
                        t_ucc = ' @';
                        var as = _q_appendData("ucc", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_ucc += (t_ucc.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa;
                        }
                        q_gt('spec', '', 0, 0, 0, "");
                        break;
                    case 'spec':
						t_spec = ' @全部';
						var as = _q_appendData("spec", "", true);
						for ( i = 0; i < as.length; i++) {
							t_spec += (t_spec.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].product;
						}
						loadFinish();
						break;
				}
			}

			function loadFinish() {
				$('#q_report').q_report({
					fileName : 'z_uccst',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_orde_rkp.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '1', //[3][4] 1
						name : 'xdate'
					}, {
						type : '5', //[5] 2
						name : 'xstktype',
						value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
					}, {
						type : '5', //[6] 3
						name : 'xitype',
						value : [q_getPara('report.all')].concat(q_getPara('uccc.itype').split(','))
					}, {
						type : '5', //[7] 4
						name : 'xbproduct',
						value : t_ucc.split(',')
					}, {
						type : '5', //[8] 5
						name : 'xeproduct',
						value : t_ucc.split(',')
					}, {
						type : '2', //[9] [10] 6
						name : 'xstoreno',
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
						type : '1', //[11][12] 7
						name : 'xwidth'
					}, {
						type : '1', //[13][14] 8
						name : 'xdime'
					}, {
						type : '1', //[15][16] 9
						name : 'xlengthb'
					}, {
						type : '5', //[17] 10
						name : 'xstyle',
						value : [q_getPara('report.all')].concat(t_style.split(','))
					}, {
                        type : '5', //[18] 11
                        name : 'xspec',
                        value : t_spec.split(',')
                    }, {
						type : '6', //[19] 12
						name : 'xsource'
					}, {
						type : '5', //[20] 13
						name : 'xsortby',
						value : 'datea@依日期,pno@依品號,sizea@依尺寸,dime@依厚度,memo@依備註'.split(',')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				$('#Xdate').css('width', '350px');
				$('#Xstktype').css('width', '250px');
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				$('#Xitype .label').css('width', '5px');
				$('#Xstktype .label').css('width', '5px');
				$('#Xitype').css('width', '120px');
				$('#Xstktype').css('width', '120px');
			}

			function q_boxClose(s2) {
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