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
            t_store = '';
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_bcc8');
            });
            function q_gfPost() {
                q_gt('store', '', 0, 0, 0);
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'store':
                        t_store = '';
                        var as = _q_appendData("store", "", true);
                        t_store += '#non@全部';
                        for ( i = 0; i < as.length; i++) {
                            t_store += (t_store.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].store;
                        }
                        LoadFinish();
                        break;
                }
            }

            function LoadFinish() {
                $('#q_report').q_report({
                    fileName : 'z_bcc8',
                    options : [{/* [1]*/
                        type : '0', //數量的小數位數
                        name : 'mount_precision',
                        value : q_getPara('rc2.mountPrecision')
                    }, {/* [2]*/
                        type : '0', //價格的小數位數
                        name : 'price_precision',
                        value : q_getPara('rc2.pricePrecision')
                    }, {/* [3]*/
                        type : '0', //重量的小數位數
                        name : 'weight_precision',
                        value : q_getPara('rc2.weightPrecision')
                    }, {  //[4][5]     1
                        type : '1',
                        name : 'date'
                    }, {  //[6][7]     2 
                        type : '1',
                        name : 'mon'
                    }, {  //[8][9]     3
                        type : '2',
                        name : 'tgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }, {  //[10]       4
                        type : '5',
                        name : 'xstore',
                        value : t_store.split(',')
                    }, {  //[11][12]   5
                        type : '2',
                        name : 'xproduct',
                        dbf : 'bcc',
                        index : 'noa,product',
                        src : 'bcc_b.aspx'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtMon1').mask('999/99');
                $('#txtMon2').mask('999/99');

                $('#txtMon1').val(q_date().substr(0, 6));
                $('#txtMon2').val(q_date().substr(0, 6));

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

                $('.report ').css('width', '450px');
                $('.q_report .report div ').css('width', '225px');
            }

            function q_boxClose(s2) {
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