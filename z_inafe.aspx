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
            var uccgaItem = '';
            $(document).ready(function() {
                q_getId();
                q_gt('uccga', '', 0, 0, 0, "");
                
                $('#q_report').click(function() {
					if (q_getPara('sys.project').toUpperCase()!='YC'){
						$('#Xshowlengthb').hide();
					}
					if (q_getPara('sys.project').toUpperCase()=='YC' && r_rank<8){
						$('#Xshowprice').hide();
					}
				});
            });

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_inafe',
                    options : [{
                        type : '0',
                        name : 'accy',
                        value : r_accy
                    }, {
                        type : '0', //[2]
                        name : 'mountprecision',
                        value : q_getPara('rc2.mountPrecision')
                    }, {
                        type : '0', //[3]
                        name : 'weightprecision',
                        value : q_getPara('rc2.weightPrecision')
                    }, {
                        type : '0', //[4]
                        name : 'priceprecision',
                        value : q_getPara('rc2.pricePrecision')
                    }, {
                        type : '5',
                        name : 'itype',
                        value : [q_getPara('report.all')].concat(q_getPara('inafe.typea').split(','))
                    }, {
                        type : '1',
                        name : 'xdate'
                    },{
						type : '0',//[8]
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					}, {
                        type : '2', //[9][10]
                        name : 'xproduct',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    }, {
                        type : '2', //[11][12]
                        name : 'xstore',
                        dbf : 'store',
                        index : 'noa,store',
                        src : 'store_b.aspx'
                    }, {
                        type : '2', //[13][14]
                        name : 'xpart',
                        dbf : 'part',
                        index : 'noa,part',
                        src : 'part_b.aspx'
                    }, {
                        type : '5', //[15]
                        name : 'xgroupano',
                        value : uccgaItem.split(',')
                    },{
						type : '8', //[16]
						name : 'xshowlengthb',
						value : "1@顯示箱數".split(',')
					},{
						type : '8', //[17]
						name : 'xshowprice',
						value : "1@顯示單價".split(',')
					}]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                var r_1911=1911;
				if(r_len==4){//西元年
					r_1911=0;
				}else{
					$('#txtXdate1').datepicker();
					$('#txtXdate2').datepicker();
				}
                
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);

                var t_noa = typeof (q_getId()[5]) == 'undefined' ? '' : q_getId()[5];
                t_noa = t_noa.replace('noa=', '');
                $('#txtNoa1').val(t_noa);
                $('#txtNoa2').val(t_noa);

                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
                
                if (q_getPara('sys.project').toUpperCase()!='YC'){
					$('#Xshowlengthb').hide();
				}
				if (q_getPara('sys.project').toUpperCase()=='YC' && r_rank<8){
					$('#Xshowprice').hide();
				}
				
				$('#Xdate').css('width','300px').css('height','30px');
				$('#txtXdate1').css('width','90px');
				$('#txtXdate2').css('width','90px');
				$('#Xshowlengthb').css('width','300px').css('height','30px');
				$('#chkXshowlengthb').css('width','210px');
				$('#chkXshowlengthb span').css('width','175px');
				$('#Xshowprice').css('width','300px').css('height','30px');
				$('#chkXshowprice').css('width','210px');
				$('#chkXshowprice span').css('width','175px');
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'uccga':
                        var as = _q_appendData("uccga", "", true);
                        uccgaItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
                        }
                        q_gf('', 'z_inafe');
                        break;
                }
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

