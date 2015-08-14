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
			/*aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx']
			,['txtXcarplateno', 'lblXcarplate', 'carplate', 'noa,carplate,driver', 'txtXcarplateno', 'carplate_b.aspx']
			,['txtXproductno', 'lblXproductno', 'fixucc', 'noa,namea', 'txtXproductno', 'fixucc_b.aspx']);*/
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_anaSSS');
			});  
            function q_gfPost() {
            	$('#q_report').q_report({
            		fileName : 'z_anaSSS',						
					 options : [{
						type : '1', //[1][2]
						name : 'age',
						index:'age'
					},{
						type :'1',//[3][4]
						name : 'wage'
					},{
						type:'6',//[5]
						name:'rage'
					},{
						type:'6',//[6]
						name:'rwage'
					},{
						type:'8',//[7]
						name:'type',
						value :['根據新進與總離職人數','根據上月員工人數','根據本月員工人數','根據基準年月區間人數']
					},{
						type :'1',//[8][9]
						name : 'Mon'
					},{
						type:'8',//[10]
						name:'clerk',
						value :['在職員工','離職員工']
					},{
						type:'8',//[11]
						name:'sex',
						value :['男','女']
					},{
						type :'1',//[12][13]
						name : 'yage'
					}]});
					
					q_langShow();
					q_popAssign();
					
					$(txtAge1).val('20');
					$(txtAge2).val('50');
					$(txtWage1).val('1');
					$(txtWage2).val('15');
					$(txtRage).val('5');
					$(txtRwage).val('1');
					
					$('#txtMon1').mask('999/99');
                	$('#txtMon2').mask('999/99');
                	
                	$('#txtYage1').mask('99年99月');
                	$('#txtYage2').mask('99年99月');
                	$('#txtYage1').val('00年05月')	;
                	$('#txtYage2').val('05年00月')
				
					
					
				var t_date, t_year, t_month, t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtMon1').val(t_year + '/' + t_month);

				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtMon2').val(t_year + '/' + t_month);
					
					q_getFormat();
					
             }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
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

