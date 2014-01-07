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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_vccstp');
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
                            t_style += (t_style.length > 0 ? ',' : '') + as[i].noa + '@' +as[i].noa+'.'+ as[i].product;
                        }
                        q_gt('ucc', '', 0, 0, 0, "");
                        break;
                    case 'ucc':
                        t_ucc = '';
                        var as = _q_appendData("ucc", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_ucc += (t_ucc.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+'.'+as[i].product;
                        }
                        loadFinish();
                        break;
                }
            }
            function loadFinish(){
                var sInfo = (q_getPara('sys.tel')).toUpperCase();
                var s_tel = (sInfo.indexOf('FAX') > 0?sInfo.substring(0, sInfo.indexOf('FAX')):sInfo);
                var s_fax = (sInfo.indexOf('FAX') > 0?sInfo.substring(sInfo.indexOf('FAX') + 4):'');
                s_tel = (emp(s_tel) ? '　' : s_tel);
                s_fax = (emp(s_fax) ? '　' : s_fax);
                var tInfo = (q_getPara('sys.tel2')).toUpperCase();
                var t_tel = (tInfo.indexOf('FAX') > 0?tInfo.substring(0, tInfo.indexOf('FAX')):tInfo);
                if(t_tel.length ==0) t_tel = '#non';
                var t_fax = (tInfo.indexOf('FAX') > 0?tInfo.substring(tInfo.indexOf('FAX') + 4):'#non');
                s_tel = (emp(s_tel) ? '　' : s_tel);
                s_fax = (emp(s_fax) ? '　' : s_fax);
                var s_addr2 = q_getPara('sys.addr2');
                if(s_addr2.length == 0) s_addr2 = '#non';
                $('#q_report').q_report({
                    fileName : 'z_vccstp',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : r_accy
                    }, {
                        type : '0', //[2]
                        name : 's_addr',
                        value : q_getPara('sys.addr')
                    }, {
                        type : '0', //[3]
                        name : 's_tel',
                        value : s_tel
                    }, {
                        type : '0', //[4]
                        name : 's_fax',
                        value : s_fax
                    }, {
                        type : '0', //[5]
                        name : 't_addr',
                        value : s_addr2
                    }, {
                        type : '0', //[6]
                        name : 't_tel',
                        value : t_tel
                    }, {
                        type : '0', //[7]
                        name : 't_fax',
                        value : t_fax
                    }, {//[2]
                        type : '0', //[8]
                        name : 'xkind',
                        value : q_getPara('sys.stktype')
                    }, {//[3]
                        type : '0',//[9]
                        name : 'xtaxtype',
                        value : q_getPara('sys.taxtype')
                    }, {
                        type : '1', //[10][11]   1
                        name : 'xnoa'
                    }, {
                        type : '8', //[12]   2
                        name : 'xshowprice',
                        value : "1@".split(',')
                    }, {
                        type : '5', //[13]  3
                        name : 'xstype',
                        value : [q_getPara('report.all')].concat(q_getPara('vccst.stype').split(','))
                    }, {//3  [14]  4
                        type : '5',
                        name : 'showtype',
                        value : q_getMsg('showtype').split('&')
                    }, {
                        type : '8', //[15]  5
                        name : 'xmerga', 
                        value : "1@".split(',')
                    },{
                        type : '1', //[16][17]  6
                        name : 'xdate'
                    }, {
                        type : '2',//[18][19] 7
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {// [20]                 8
                        type : '5',
                        name : 'xproductno',
                        value : [q_getPara('report.all')].concat(t_ucc.split(','))
                    }, {// [21]                  9
                        type : '8',
                        name : 'xstyle',
                        value : t_style.split(',')
                    },{//[22]                      10
                        type : '8', 
                        name : 'xoption03',
                        value : q_getMsg('toption03').split('&')
                    }]
                });
                q_popAssign();
                q_langShow();
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();

                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
                $('#chkXshowprice').children('input').attr('checked', 'checked');
                $('#chkXmerga input[type="checkbox"]').prop('checked',true);
                $('#chkXstyle input[type="checkbox"]').prop('checked',true);
                var t_no = typeof (q_getId()[3]) == 'undefined' ? '' : q_getId()[3];
                if (t_no.indexOf('noa=') >= 0) {
                    t_no = t_no.replace('noa=', '');
                    if (t_no.length > 0) {
                        $('#txtXnoa1').val(t_no);
                        $('#txtXnoa2').val(t_no);
                        $('#btnOk').click();
                    }
                }
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