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
				q_gf('', 'z_ordhfep');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ordhfep', options : [{
						type : '0', name : 'xworker', value : r_name
					},{
						type : '6', name : 'xnoa'
					}, {
						type : '1', name : 'date'
					}, {
						type : '2'
						, name : 'tgg'
						, dbf : 'tgg'
						, index : 'noa,comp'
						, src : 'tgg_b.aspx'
					}]
				});
				q_popAssign();
				$('#txtDate1').mask('999/99/99');
				$('#txtDate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();
				
				try{
				    var item = JSON.parse(q_getId()[3]);
				    if(item.noa!=undefined){
				        $('#txtXnoa').val(item.noa);
				    }
				}catch(e){
				    
				}
			    if($('#txtXnoa').val().length == 0){ 
    				var t_date, t_year, t_month, t_day;
    				t_date = new Date();
    				t_date.setDate(1);
    				t_year = t_date.getFullYear() - 1911;
    				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
    				t_month = t_date.getMonth() + 1;
    				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
    				t_day = t_date.getDate();
    				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
    				$('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);
    				t_date.setDate(t_date.getDate()+32);
    				t_date.setDate(1);
    				t_year = t_date.getFullYear() - 1911;
    				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
    				t_month = t_date.getMonth() + 1;
    				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
    				t_day = t_date.getDate();
    				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
    				$('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
				}
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