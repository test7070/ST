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
            var t_store = '',t_bcctype='',t_Finish=false;
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_bcc9');
            });
            function q_gfPost() {
                q_gt('store', '', 0, 0, 0);
                q_gt('bcctype', '', 0, 0, 0);
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'store':
                        t_store = '';
                        var as = _q_appendData("store", "", true);
                        t_store += '';
                        for ( i = 0; i < as.length; i++) {
                            t_store += (t_store.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].store;
                        }
                        //loadFinish();
                        break;
					case 'bcctype':
                        t_bcctype = '';
                        var as = _q_appendData("bcctype", "", true);
                        t_bcctype += '@';
                        for ( i = 0; i < as.length; i++) {
                            t_bcctype += (t_bcctype.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
                        }
                        break;
                }
                
                if (t_bcctype.length>0 && t_store.length>0 && !t_Finish){
                	t_Finish=true;
                	t_bcctype=t_bcctype.substr(2,t_bcctype.length)
                	loadFinish();
                }
            }
            function loadFinish() {
                $('#q_report').q_report({
                    fileName : 'z_bcc9', 
                    options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_bcc9.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
                        type : '1', 
                        name : 'date'
                    }, {
                        type : '2', 
                        name : 'bcc', 
                        dbf : 'bcc', 
                        index : 'noa,product', 
                        src : 'bcc_b.aspx'
                    }, {
                        type : '8', 
                        name : 'xstore', 
                        value : t_store.split(',')
                    }, {
                        type : '8', 
                        name : 'xtype', 
                        value : t_bcctype.split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                var r_1911=1911;
                if(r_len==4){
                    var r_1911=0;                  
                    $.datepicker.r_len=4;
                    //$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                $('#txtDate1').mask(r_picd);
                $('#txtDate1').datepicker();
                $('#txtDate2').mask(r_picd);
                $('#txtDate2').datepicker();
                //全沒選 = 全選, 避免有些主檔已被刪除
                //$('#chkXstore').children('input').attr('checked', 'checked');
                //$('#chkXtype').children('input').attr('checked', 'checked');
                
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);
                
                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
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