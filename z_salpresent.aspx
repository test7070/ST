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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_salpresent');   
                
                if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                $('#q_report').click(function(e) {
					now_report=$('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report;
					if(now_report=='z_salpresentst4'){
						$('#reportnote').text('※此報表為提供勞工局檢查正常出勤報表，非公司內部出勤正常報表。');
						$('#reportnote').show();
					}else{
						$('#reportnote').hide();
					}
				});
				                       
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_salpresent',
                    options : [{
                        type : '1',
                        name : 'date'
                    },{
                        type : '5',
                        name : 'xperson',
                        value : q_getPara('person.typea').split(',')
                    }, {
                        type : '2',
                        name : 'sssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    },{
                        type : '2',
                        name : 'partno',
                        dbf : 'part',
                        index : 'noa,part',
                        src : 'part_b.aspx'
                    },{
                        type : '6',
                        name : 'xworkhours'
                    },{
                        type : '6',
                        name : 'xlate'
                    },{
                        type : '6',
                        name : 'xearly'
                    },{
                        type : '1',
                        name : 'xresthours'
                    },{
                        type : '5',
                        name : 'xtype',
                        value : ('#non@全部,'+q_getPara('sss.typea')).split(',')//('#non@全部,'+((q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)?q_getPara('sss.typea_it'):q_getPara('sss.typea'))).split(',')
                    },{
                    	type : '0',
                    	name : 'r_len',
                    	value : r_len
                    },{
                        type : '1',
                        name : 'xmon'
                    },{
                        type : '5',
                        name : 'xorder',
                        value : ('sssno@員工編號,partno@部門-員工,datea@日期').split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtDate1').mask(r_picd);
                $('#txtDate2').mask(r_picd);
                $('#txtXmon1').mask(r_picm);
                $('#txtXmon2').mask(r_picm);
                
                $('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
                $('#txtXmon1').val(q_date().substr(0,r_lenm));
                $('#txtXmon2').val(q_date().substr(0,r_lenm));
                
                $('#txtXworkhours').css('width','110px');
                $('#Xworkhours').css('width','197px');
                $('#txtXlate').css('width','110px');
                $('#Xlate').css('width','197px');
                $('#txtXearly').css('width','110px');
                $('#Xearly').css('width','197px');
                $('#Xresthours').css('width','330px');
                $('#Xtype').css('width','270px');
                $('.q_report .option div .c4 ').css('font-size','medium');
                $('.q_report .option div .c4 ').css('width','180px');
                
                $('#txtXresthours1').mask('99:99');
                $('#txtXresthours2').mask('99:99');
                
                $('#txtXworkhours').keyup(function(e) {
					if(e.which>=37 && e.which<=40){return;}
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,4}\.{0,1}\d{0,1}/);
					$(this).val(tmp);
				});
				$('#txtXlate').keyup(function(e) {
					if(e.which>=37 && e.which<=40){return;}
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,3}/);
					$(this).val(tmp);
				});
				
				$('#txtXearly').keyup(function(e) {
					if(e.which>=37 && e.which<=40){return;}
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,3}/);
					$(this).val(tmp);
				});
				
				$('#txtDate1').change(function() {
					workhours();
				});
				$('#txtDate2').change(function() {
					workhours();
				});
								
				$('#txtXresthours1').val('12:00');
				$('#txtXresthours2').val('13:00');
				q_gt('holiday', "where=^^ isnull(iswork,0)=0 ^^", 0, 0, 0);
				
				if (q_getPara('sys.project').toUpperCase()=='DJ'){
					$('#txtXlate').val(2);
				}
            }
            
			function workhours() {
				var t_1911=1911;
                if(r_len==4){
					t_1911=0
				}
				
				var bdate=$('#txtDate1').val(),edate=$('#txtDate2').val();
				var t_hours=0;
				var t_date = bdate;
                var count = 0;
                while (t_date <= edate) {
					if (new Date(dec(t_date.substr(0, r_len)) + t_1911, dec(t_date.substr((r_len+1), 2)) - 1, dec(t_date.substr((r_lenm+1), 2))).getDay() == 0 || new Date(dec(t_date.substr(0, r_len)) + t_1911, dec(t_date.substr((r_len+1), 2)) - 1, dec(t_date.substr((r_lenm+1), 2))).getDay() == 6 || r_holiday.indexOf(t_date)>-1) {
		                //六日不算與假日
					} else {
						count++;
					}
                           	
					//日期加一天
					var nextdate = new Date(dec(t_date.substr(0, r_len)) + t_1911, dec(t_date.substr((r_len+1), 2)) - 1, dec(t_date.substr((r_lenm+1), 2)));
	                nextdate.setDate(nextdate.getDate() + 1)
					t_date = '' + (nextdate.getFullYear() - t_1911) + '/';
					//月份
					if (nextdate.getMonth() + 1 < 10)
						t_date = t_date + '0' + (nextdate.getMonth() + 1) + '/';
					else
						t_date = t_date + (nextdate.getMonth() + 1) + '/';
					//日期
					if (nextdate.getDate() < 10)
						t_date = t_date + '0' + (nextdate.getDate());
					else
						t_date = t_date + (nextdate.getDate());
						
				}
				t_hours = t_hours +(8* count);
				$('#txtXworkhours').val(t_hours);
            }
			
            function q_boxClose(s2) {
            	
            }
			var r_holiday= [];
            function q_gtPost(t_name) {
            	switch (t_name) {
                    case 'holiday':
                    	var as = _q_appendData('holiday', '', true);
                    	for (var i = 0; i < as.length; i++) {
                    		r_holiday.push(as[i].noa);
                    	}
                		workhours();
                    break;
            	}
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
			<div id="reportnote" style="color: red;display: none;width: 1000px;"> </div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

