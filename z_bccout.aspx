<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			t_isInit = false;
            t_store = '';
		
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_bccout');
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
                        break;
                }
                if (!t_isInit  && t_store.length > 0) {
                	t_isInit = true;
                	var t_noa=typeof(q_getId()[3])=='undefined'?'':q_getId()[3];
                	t_noa  =  t_noa.replace('noa=','');
               $('#q_report').q_report({
					fileName : 'z_bccout',
					options : [{/* [1]*/
						type : '0',//數量的小數位數
						name : 'mount_precision',
						value : q_getPara('rc2.mountPrecision')
					},{/* [2]*/
						type : '0',//價格的小數位數
						name : 'price_precision',
						value : q_getPara('rc2.pricePrecision')
					},{
                        type : '6',
                        name : 'xyear'
                    },{
                        type : '1',
                        name : 'date'
                    }, {
                        type : '2',
                        name : 'xbccno',
                        dbf : 'bcc',
                        index : 'noa,product',
                        src : 'bcc_b.aspx'
                    },{
                        type : '2',
                        name : 'sss',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    },{/*3*/
						type : '5',
						name : 'xstore',
						value : t_store.split(',')
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
                $('#txtXnoa').val(t_noa);
                
                 var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-r_1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate1').val(t_year+'/'+t_month+'/'+t_day);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-r_1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
	                }
	                $('#txtXyear').val(q_getId()[4]);
	         }

            function q_boxClose(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
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
           
          