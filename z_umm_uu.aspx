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
			var t_part = '';
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			$(document).ready(function() {
				q_getId();
				q_gt('part', '', 0, 0, 0);
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_umm_uu',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : r_accy + "_" + r_cno
					}, {
						type : '0', //[2]
						name : 'xaccy',
						value : r_accy
					}, {
						type : '1', //[3][4]
						name : 'xmon'
					}, {
						type : '2', //[5][6]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '5', //[7]
						name : 'xpart',
						value : t_part.split(',')
					}, {
						type : '2', //[8][9]
						name : 'xsales',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '6', //[10]
						name : 'salesgroup'
					}, {
						type : '1', //[11][12]
						name : 'vdate'
					}, {
						type : '1', //[13][14]
						name : 'vmon'
					}, {
                        type : '2', //[15][16]
                        name : 'product',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    },{
						type : '0', //[17] //判斷vcc是內含或應稅 內含不抓vcca
						name : 'vcctax',
						value : q_getPara('sys.d4taxtype')
					},{
                        type : '6', //[18]
                        name : 'xmemo'
                    },{
						type : '6', //[19]
						name : 'xzip'
					},{
						type : '5', //[20]
						name : 'xcity',
						value : (' @全部,基隆市,台北市,新北市,桃園縣,新竹市,新竹縣,苗栗縣,台中市,彰化縣,南投縣,雲林縣,嘉義市,嘉義縣,台南市,高雄市,屏東縣,台東縣,花蓮縣,宜蘭縣,澎湖縣,金門縣,連江縣').split(',')
					}, {
                        type : '8', //[21]
                        name : 'showunpay', //只顯示未收
                        value : "1@只顯示未收".split(',')
	                }]
				});
				q_popAssign();
				q_langShow();
				$('#txtXmon1').val(q_date().substring(0,6)).mask('999/99');
				$('#txtXmon2').val(q_date().substring(0,6)).mask('999/99');
				$('#txtVdate1').mask('999/99/99');
				$('#txtVdate2').mask('999/99/99');
				
				$('#Xmemo').removeClass('a2').addClass('a1');
                $('#txtXmemo').css('width', '85%');
                
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtVdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtVdate2').val(t_year + '/' + t_month + '/' + t_day);
                
                
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
                switch (s2) {
                    case 'part':
                        t_part = '#non@全部';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_gf('', 'z_umm_uu');
                        break;
                }
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