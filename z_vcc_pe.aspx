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
                q_gf('', 'z_vcc_pe');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_vcc_pe',
                    options : [
                    {  //1-1  [1]
                    	type :'5', 
                    	name :'xtype',
                    	value:[q_getPara('report.all')].concat(q_getPara('vccst.stype').split(','))
                    },{//1-2  [2]
                    	type :'5',
                    	name :'ytype',
                    	value:[q_getPara('report.all')].concat(q_getPara('rc2st.stype').split(','))           
                    },{//1-3  [3][4]   
                    	type : '1',  
						name : 'xmon'            	
                    },{//1-4  [5][6]  
                    	type : '1',   
						name : 'xdate'            	
                    },{//2-1  [7][8]
                    	type : '2', 
                        name : 'xcustno',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    },{//2-2  [9][10]
                    	type : '2', 
                        name : 'xtggno',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    },{//2-3  [11]
						type : '8', 
						name : 'option1',
						value : "1@貨單金額,2@依帳款月份,3@鋼捲編號,4@僅顯示退貨".split(',')
					},{//2-4  [12][13]
						type : '2',
						name : 'xproductno',
						dbf : 'ucc',
						index : 'noa,product',
						src : 'ucc_b.aspx'
					},{//3-1  [14]
						type : '6',
						name : 'xspec',
					},{//3-2  [15][16]
						type : '1',
						name : 'xdime',
					},{//3-3  [17][18]
						type : '1',
						name : 'xwidth',
					},{//3-4  [19][20]
						type : '1',
						name : 'xlengthb',
					},{//4-1  [21]
						type : '8', 
						name : 'option2',
						value : "1@重量總計,2@鋼捲明細".split(',')
					}]
                });
                
                q_popAssign();
                q_getFormat();
                q_langShow();
                
				$('#txtXmon1').mask(r_picm);
                $('#txtXmon2').mask(r_picm);
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);

                $('#txtXwidth1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXwidth2').val(9999.99).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(9999.99);
				});
				$('#txtXdime1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXdime2').val(9999.99).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(9999.99);
				});
				$('#txtXlengthb1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXlengthb2').val(99999.9).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(99999.9);
				});
                
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
             	t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXmon1').val(t_year + '/' + t_month );
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);
                

                t_date = new Date();
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXmon2').val(t_year + '/' + t_month );
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
                
                $('#chkOption1 input').eq(0).click(function(){
					if($('#chkOption1 input').eq(2).prop('checked')){
						$('#chkOption1 input').eq(2).prop("checked",false);			
					}	
				})
				$('#chkOption1 input').eq(2).click(function(){
					if($('#chkOption1 input').eq(0).prop('checked')){
						$('#chkOption1 input').eq(0).prop("checked",false);			
					}	
				})
				
				$('#chkOption1 input').eq(1).click(function(){
					if($('#chkOption1 input').eq(1).prop('checked')){
						$('#Xdate').hide();
						$('#Xmon').show();			
					}else{
						$('#Xdate').show();
						$('#Xmon').hide();
					}	
				})
			
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }
		</script>
		<style type="text/css">
			.num{
				text-align:right;
				padding-right:2px;
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

