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
			/*function loadScript(url, callback)
			{
			    // Adding the script tag to the head as suggested before
			    var head = document.getElementsByTagName('head')[0];
			    var script = document.createElement('script');
			    //script.type = 'text/javascript';
			    script.src = url;
			
			    // Then bind the event to the callback function.
			    // There are several events for cross browser compatibility.
			    script.onreadystatechange = callback;
			    script.onload = callback;
			
			    // Fire the loading
			    head.appendChild(script);
			}
*/
            $(document).ready(function() {
            	
            	q_getId();
                q_gf('', 'z_rc2st');
            });
            function q_gfPost() {
            	q_gt('style', "", 0, 0, 0, "");    
            	//loadScript("css/jquery/ui/jquery.ui.datepicker.js");
            }
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'style':
						t_style = 'A,B@捲、板';
						var as = _q_appendData("style", "", true);
						for ( i = 0; i < as.length; i++) {
							t_style += (t_style.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].noa + '.' + as[i].product;
						}
						
						loadFinish();
						break;
				}
			}
			function loadFinish(){
				var t_kind = '';
				switch(q_getPara('sys.project').toUpperCase()){
					case 'PK':
						t_kind = q_getPara('sys.stktype')+',2@物料,3@委外';
						break;
					default:
						t_kind = q_getPara('sys.stktype');
						break;
				}
				
				$('#q_report').q_report({
                    fileName : 'z_rc2st',
                    options : [
                    {// [1]
                        type : '0',
                        name : 'accy',
                        value : r_accy
                    },{//1  [2][3]
                        type : '1',
                        name : 'date'
                    }, {//2 [4][5]
                        type : '1',
                        name : 'mon'
                    }, {//3 [6][7]
                        type : '2',
                        name : 'tgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }, {//4 [8][9]
                        type : '2',
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {//5 [10][11]
                        type : '2',
                        name : 'product',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {//6 [12][13]
                        type : '1',
                        name : 'xdime'
                    }, {//7 [14][15]
                        type : '1',
                        name : 'xwidth'
                    }, {//8 [16][17]
                        type : '1',
                        name : 'xlength'
                    }, {//9 [18][19]
                        type : '1',
                        name : 'xradius'
                    }, {
						type : '5', //10 [20]
						name : 'xstyle',
						value : [q_getPara('report.all')].concat(t_style.split('&'))
					}, {
						type : '5', //11 [21]
						name : 'xkind',
						value : [q_getPara('report.all')].concat(t_kind.split(','))
					}]
                });
                q_popAssign();
                
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtMon1').mask('999/99');
                $('#txtMon2').mask('999/99');
                var t_date,t_year,t_month,t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear()-1911;
                t_year = t_year>99?t_year+'':'0'+t_year;
                t_month = t_date.getUTCMonth()+1;
                t_month = t_month>9?t_month+'':'0'+t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day>9?t_day+'':'0'+t_day;
                $('#txtDate1').val(t_year+'/'+t_month+'/'+t_day);
                
                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear()-1911;
                t_year = t_year>99?t_year+'':'0'+t_year;
                t_month = t_date.getUTCMonth()+1;
                t_month = t_month>9?t_month+'':'0'+t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day>9?t_day+'':'0'+t_day;
                $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
			}
            function q_boxClose(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
        ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
        ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
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