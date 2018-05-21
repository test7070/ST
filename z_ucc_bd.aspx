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
			var t_store = '',t_ucc='';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gt('store', '', 0, 0, 0, "store", r_accy );
				
			});
			function q_gtPost(t_name) {
				switch (t_name) {
                    case 'store':
                        t_store = '';
                        var as = _q_appendData("store", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_store += (t_store.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].store;
                        }
                        q_gt('ucc', '', 0, 0, 0, "");
                        break;
                    case 'ucc':
						t_ucc = '';
						var as = _q_appendData("ucc", "", true);
						for ( i = 0; i < as.length; i++) {
							t_ucc += (t_ucc.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].noa;
						}
						q_gf('', 'z_ucc_bd');
						break;
                }
			}
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ucc_bd',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_ucc_bd.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '0', //[3]
						name : 'itype',
						value : q_getPara('uccc.itype')
					}, {
						type : '5', //[4] 1
						name : 'xbproduct',
						value : t_ucc.split('&')
					}, {
						type : '5', //[5] 2
						name : 'xeproduct',
						value : t_ucc.split('&')
					}, {
						type : '1', //[6][7] 3
						name : 'xdime'
					}, {
						type : '1', //[8][9] 4
						name : 'xwidth'
					}, {
						type : '1', //[10][11] 5
						name : 'xlength'
					}, {
						type : '1', //[12][13] 6
						name : 'xradius'
					}, {
						type : '6', //[14] 7
						name : 'xplace'
					}, {
						type : '6', //[15] 8
						name : 'xuno'
					}, {
						type : '6', //[16] 9
						name : 'xcust'
					}, {
						type : '6', //[17] 10
						name : 'xspec'
					}, {
                        type : '8',//[18] 11
                        name : 'xitype',
                        value : q_getPara('uccc.itype').split(',')
                    }, {
						type : '6', //[19] 12
						name : 'xdate'
					}, {
                        type : '8',//[20] 13
                        name : 'xdetail',
                        value : "1@明細".split(',')
                    }, {
                        type : '8',//[21] 14
                        name : 'xstore',
                        value : t_store.split(',')
                    }]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				$('#txtXdate').mask(r_picd);
				$('#txtXdate').datepicker();
				
				$('#Xbproduct select').change(function(e){
					$('#Xeproduct select').val($('#Xbproduct select').val());
				});
				$('#Xeproduct select')[0].selectedIndex=$('#Xeproduct select').children().length-1;
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