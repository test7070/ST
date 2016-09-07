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
            var q_name = "crmchart";
            aPop = new Array();
            //預設圖型抬頭
			var DC1Chart='';
			var DC2Chart='';
			var DC3Chart='';
			var DC4Chart='';
			var DC5Chart='';
			var DC6Chart='';
			var DC1Title1='';
			var DC2Title1='';
			var DC3Title1='';
			var DC4Title1='';
			var DC5Title1='';
			var DC6Title1='';
			var DC1Title2='';
			var DC2Title2='';
			var DC3Title2='';
			var DC4Title2='';
			var DC5Title2='';
			var DC6Title2='';
			var DC1Where='';
			var DC2Where='';
			var DC3Where='';
			var DC4Where='';
			var DC5Where='';
			var DC6Where='';
			var DC1Stitle='';
			var DC2Stitle='';
			var DC3Stitle='';
			var DC4Stitle='';
			var DC5Stitle='';
			var DC6Stitle='';
			var DC1Dselect='';
			var DC2Dselect='';
			var DC3Dselect='';
			var DC4Dselect='';
			var DC5Dselect='';
			var DC6Dselect='';
			//目前Chart路徑和圖
			var C1title='';
			var C1Chart='';
			var C2title='';
			var C2Chart='';
			var C3title='';
			var C3Chart='';
			var C4title='';
			var C4Chart='';
			var C5title='';
			var C5Chart='';
			var C6title='';
			var C6Chart='';
			var C1Where=[];
			var C2Where=[];
			var C3Where=[];
			var C4Where=[];
			var C5Where=[];
			var C6Where=[];
			var C1Stitle='';
			var C2Stitle='';
			var C3Stitle='';
			var C4Stitle='';
			var C5Stitle='';
			var C6Stitle='';
			var C1Dselect='';
			var C2Dselect='';
			var C3Dselect='';
			var C4Dselect='';
			var C5Dselect='';
			var C6Dselect='';
			
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', q_name);

				$('#DashboardSelect').change(function(e) {
					switch($(this).val()) {
						case ''://無選取
							$('#Chart1').hide();
							$('#Chart2').hide();
							$('#Chart3').hide();
							$('#Chart4').hide();
							$('#Chart5').hide();
							$('#Chart6').hide();
                   			break;
                   		case 'sale'://銷售活動儀表板
                   			//預設-----------------------------------------------
                   			DC1Chart='traChart';
							DC2Chart='barChart2';
							DC3Chart='barChart';
							DC1Title1='依銷售階段的商機準銷售案源';
							DC2Title1='目標進度(金額)';
							DC3Title1='銷售排行榜';
							DC1Title2='開啟的商機';
							DC2Title2='有效目標';
							DC3Title2='成交商機';
							DC1Stitle='空白';
							DC2Stitle='月份';
							DC3Stitle='加總 (實際營收)';
							DC1Where="select stage text@#~sum(money)total from crmbusiness where datea between '"+$('#txtBmon').val()+"' and '"+$('#txtEmon').val()+"' and money>0 group by stage ";
							DC1Where=DC1Where+" order by case when stage='潛在機會' then 1 when stage='初步接洽' then 2 when stage='需求確認' then 3 when stage='建議/報價' then 4 when stage='談判協商' then 5 when stage='成交' then 6 when stage='失敗' then 7 else 9 end"
							DC2Where="select a.mon text@#~SUM(b.mount*b.price) total1@#~ isnull((select money from view_orde where mon=a.mon)@#~0)total2 from saleforecast a left join saleforecasts b on a.noa=b.noa group by a.mon order by a.mon";
							DC3Where="select salesno@#~sales text@#~sum(total)total from view_orde where mon between '"+$('#txtBmon').val()+"' and '"+$('#txtEmon').val()+"' and total>0 group by salesno@#~sales order by salesno@#~sales";
							DC1Dselect=",possibility@可能性,theme@主題,custno@客戶,sales@業務";
							DC2Dselect=",custno@客戶,sales@業務,productno@產品";
							DC3Dselect=",custno@客戶,style@類別,mon@月份,productno@產品";
							//data-------------------------------------------------
							Charthome('Chart1');
							Charthome('Chart2');
							Charthome('Chart3');
							//---------------------------------------
                   			$('#Chart1').show();
							$('#Chart2').show();
							$('#Chart3').show();
							$('#Chart4').hide();
							$('#Chart5').hide();
							$('#Chart6').hide();
                   			break;
                   		case 'service'://客戶服務績效儀表板
                   			//預設-----------------------------------------------
                   			DC1Chart='barChart2';
							DC2Chart='barChart2';
							DC3Chart='barChart2';
							DC4Chart='pieChart';
							DC5Chart='barChart2';
							DC6Chart='barChart2';
							DC1Title1='趨勢產品問題 (過去 7 天前 5 項)';
							DC2Title1='案例組合 (依優先順序)';
							DC3Title1='依專員排列的使用中案例';
							DC4Title1='案例組合 (依來源)';
							DC5Title1='依優先順序排列案例 (每個負責人)';
							DC6Title1='依事件類型組合的案例';
							DC1Title2='使用中的案例';
							DC2Title2='使用中的案例';
							DC3Title2='使用中的案例';
							DC4Title2='所有案例';
							DC5Title2='所有案例';
							DC6Title2='使用中的案例';
							//data-------------------------------------------------
			                Charthome('Chart1');
							Charthome('Chart2');
							Charthome('Chart3');
							Charthome('Chart4');
							Charthome('Chart5');
							Charthome('Chart6');
							//---------------------------------------
                   			$('#Chart1').show();
							$('#Chart2').show();
							$('#Chart3').show();
							$('#Chart4').show();
							$('#Chart5').show();
							$('#Chart6').show();
                   			break;
                   		case 'marketing'://行銷儀表板
                   			//預設-----------------------------------------------
                   			DC1Chart='pieChart';
							DC2Chart='barChart2';
							DC3Chart='barChart';
							DC4Chart='barChart';
							DC1Title1='行銷活動類型組合';
							DC2Title1='行銷活動預算與實際成本的比較 (按月份)';
							DC3Title1='依來源行銷活動排列潛在客戶';
							DC4Title1='行銷活動產生的營收';
							DC1Title2='所有行銷活動與行銷活動範本';
							DC2Title2='所有行銷活動與行銷活動範本';
							DC3Title2='所有潛在客戶';
							DC4Title2='關閉的商機';
							//data-------------------------------------------------
							Charthome('Chart1');
							Charthome('Chart2');
							Charthome('Chart3');
							Charthome('Chart4');
							//---------------------------------------
                   			$('#Chart1').show();
							$('#Chart2').show();
							$('#Chart3').show();
							$('#Chart4').show();
							$('#Chart5').hide();
							$('#Chart6').hide();
                   			break;
                   		case 'manager'://客戶服務經理儀表板
                   			//預設-----------------------------------------------
                   			DC1Chart='barChart2';
							DC2Chart='barChart';
							DC3Chart='barChart2';
							DC1Title1='依專員排列的使用中案例';
							DC2Title1='已解決的案例 CSAT (依負責人)';
							DC3Title1='案例組合 (依優先順序)';
							DC1Title2='使用中的案例';
							DC2Title2='使用中的案例';
							DC3Title2='使用中的案例';
							//data-------------------------------------------------
							Charthome('Chart1');
							Charthome('Chart2');
							Charthome('Chart3');
							//---------------------------------------
                   			$('#Chart1').show();
							$('#Chart2').show();
							$('#Chart3').show();
							$('#Chart4').hide();
							$('#Chart5').hide();
							$('#Chart6').hide();
                   			break;
                   		case ''://客戶服務代表社交儀表板
                   			$('#Chart1').hide();
							$('#Chart2').hide();
							$('#Chart3').hide();
							$('#Chart4').hide();
							$('#Chart5').hide();
							$('#Chart6').hide();
                   			break;
                	}
                	C1title='向下切入';
					C1Chart=DC1Chart;
					C2title='向下切入';
					C2Chart=DC2Chart;
					C3title='向下切入';
					C3Chart=DC3Chart;
					C4title='向下切入';
					C4Chart=DC4Chart;
					C5title='向下切入';
					C5Chart=DC5Chart;
					C6title='向下切入';
					C6Chart=DC6Chart;
					
					//帶入參數
					//var cust2a='#non',part2a='#non',sss2a='#non';
					//if(!emp($('#txtCust2a').val()))
					//	cust2a=$('#txtCust2a').val();
					//if(!emp($('#txtPart2a').val()))
					//	part2a=$('#txtPart2a').val();
					//if(!emp($('#txtSss2a').val()))
					//	sss2a=$('#txtSss2a').val();
					//q_func('qtxt.query','z_anadc.txt,'+txtreport+','+encodeURI(r_accy) + ';' + encodeURI($('#txtDate1').val()) + ';' + encodeURI($('#txtDate2').val()) + ';' + encodeURI($('#txtXmon').val()) + ';' + encodeURI($('#txtCust1a').val())+ ';' + encodeURI(cust2a)+ ';' + encodeURI($('#txtPart1a').val())+ ';' + encodeURI(part2a)+ ';' + encodeURI($('#txtSss1a').val())+ ';' + encodeURI(sss2a)+ ';' + encodeURI($('#txtXyear1').val())+ ';' + encodeURI($('#txtXyear2').val()));
					//$('#Loading').Loading();
				});
				
				$('#ChartChange').click(function() {
					var Charid=$('#Chartid').val();
					var Chartxt=$('#Charttext').val();
					var ChartSelect=$('#ChartSelect').val();
					var DataSelect=$("#DataSelect option:selected").text();
					var DataSelectval=$("#DataSelect").val();
					var showtitle2='';
					if(Charid=='' || ChartSelect=='' || DataSelect=='' || DataSelectval==''){
						return;
					}
					
					if(Charid=='Chart1'){
						C1title=C1title+">>"+Chartxt;
						C1Chart=C1Chart+">>"+ChartSelect;
						C1Stitle=C1Stitle+">>"+DataSelect;
						C1Dselect=C1Dselect+","+DataSelectval+'@'+DataSelect;
						showtitle2=C1title;
					}else if(Charid=='Chart2'){
						C2title=C2title+">>"+Chartxt;
						C2Chart=C2Chart+">>"+ChartSelect;
						C2Stitle=C2Stitle+">>"+DataSelect;
						C2Dselect=C2Dselect+","+DataSelectval+'@'+DataSelect;
						showtitle2=C2title;
					}else if(Charid=='Chart3'){
						C3title=C3title+">>"+Chartxt;
						C3Chart=C3Chart+">>"+ChartSelect;
						C3Stitle=C3Stitle+">>"+DataSelect;
						C3Dselect=C3Dselect+","+DataSelectval+'@'+DataSelect;
						showtitle2=C3title;
					}else if(Charid=='Chart4'){
						C4title=C4title+">>"+Chartxt;
						C4Chart=C4Chart+">>"+ChartSelect;
						C4Stitle=C4Stitle+">>"+DataSelect;
						C4Dselect=C4Dselect+","+DataSelectval+'@'+DataSelect;
						showtitle2=C4title;
					}else if(Charid=='Chart5'){
						C5title=C5title+">>"+Chartxt;
						C5Chart=C5Chart+">>"+ChartSelect;
						C5Stitle=C5Stitle+">>"+DataSelect;
						C5Dselect=C5Dselect+","+DataSelectval+'@'+DataSelect;
						showtitle2=C5title;
					}else if(Charid=='Chart6'){
						C6title=C6title+">>"+Chartxt;
						C6Chart=C6Chart+">>"+ChartSelect;
						C6Stitle=C6Stitle+">>"+DataSelect;
						C6Dselect=C6Dselect+","+DataSelectval+'@'+DataSelect;
						showtitle2=C6title;
					}
					
					if($('#ChartSelect').val()=='traChart'){
						$('#'+Charid).traChart({
		                	title:'',
		                	title2:showtitle2,
							data : traData,
							previous:true
						});
					}else if($('#ChartSelect').val()=='barChart'){
						$('#'+Charid).barChart({
		                	title:'',
		                	title2:showtitle2,
		                	ltitle:DataSelect,
		                	btitle:'加總 (實際營收)',
							data : barData,
							previous:true
						});
					}else if($('#ChartSelect').val()=='barChart2'){
						$('#'+Charid).barChart2({
		                	title:'',
		                	title2:showtitle2,
		                	ltitle:'金額',
							btitle:DataSelect,
							btitle1:'估計',
							btitle2:'實際',
							data : barData2,
							previous:true
						});
					}else if($('#ChartSelect').val()=='pieChart'){
						var color=new Array();
		                for (var i=0;i<pieData.length;i++){
		                	color.push(getRndColor());
		                }
						$('#'+Charid).pieChart({
							title:'',
		                	title2:showtitle2,
							data : pieData,
							x : 200,
							y : 200,
							radius : 150,
							color:color,
							previous:true
						});
					}
					
					$('#downChart').hide();
					$('#DataSelect').val('');
					$('#ChartSelect').val('');
				});
            });
			
			var traData=[];
			var barData=[];
			var barData2=[];
			var pieData=[];
            function q_gfPost() {
                q_popAssign();
                
                $('#txtBmon').val(q_date().substr(0,r_len)+'/01');
                $('#txtEmon').val(q_date().substr(0,r_lenm));
                
                //漏斗測試資料
				traData=[];
				traData.push({
					text:'授與資格',
					total:300000
				});
				traData.push({
					text:'開發',
					total:200000
				});
				traData.push({
					text:'提案',
					total:100000
				});
				traData.push({
					text:'關閉',
					total:50000
				});
                //長條(直)測試資料
				barData2=[];
				barData2.push({
					text:'中秋銷售',
					total1:5000000,
					total2:5216500
				});
				barData2.push({
					text:'秋季促銷',
					total1:3000000,
					total2:3513100,
				});
				barData2.push({
					text:'換季銷售',
					total1:5500000,
					total2:4612000
				}); 
				//長條(橫)測試資料
				barData=[];
				barData.push({
					sssno:'A001',
					text:'胡小瓜',
					total:5216500
				});
				barData.push({
					sssno:'A002',
					text:'林俊傑',
					total:3513100
				});
				barData.push({
					sssno:'A003',
					text:'吳竑驛',
					total:4612000
				});
				barData.push({
					sssno:'A004',
					text:'黃瑞仁',
					total:3902300
				});
				barData.push({
					sssno:'A004',
					text:'陳忠堅',
					total:3223300
				});
				barData.push({
					sssno:'A004',
					text:'吳秋東',
					total:2213600
				});
				barData.push({
					sssno:'A004',
					text:'陳金昌',
					total:3542600
				});
				barData.push({
					sssno:'A004',
					text:'許世豐',
					total:2926300
				});
				barData.push({
					sssno:'A004',
					text:'林益成',
					total:1202300
				});
				//圓餅圖
				pieData=[];
                pieData.push({
                	text:'胡小瓜', //說明
                	total:5216500,
                	value:'$'+FormatNumber(5216500) //圖說名
                });
                pieData.push({
                	text:'林俊傑',
                	total:3513100,
                	value:'$'+FormatNumber(3513100)
                });
                pieData.push({
                	text:'吳竑驛',
                	total:4612000,
                	value:'$'+FormatNumber(4612000)
                });
                pieData.push({
                	text:'黃瑞仁',
                	total:3902300,
                	value:'$'+FormatNumber(3902300)
                });
                pieData.push({
                	text:'陳忠堅',
                	total:3223300,
                	value:'$'+FormatNumber(3223300)
                });
                pieData.push({
                	text:'吳秋東',
                	total:2213600,
                	value:'$'+FormatNumber(2213600)
                });
                pieData.push({
                	text:'陳金昌',
                	total:3542600,
                	value:'$'+FormatNumber(3542600)
                });
                pieData.push({
                	text:'許世豐',
                	total:2926300,
                	value:'$'+FormatNumber(2926300)
                });
                pieData.push({
                	text:'林益成',
                	total:1202300,
                	value:'$'+FormatNumber(1202300)
                });
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
					
                }
            }

            //設定色彩
            var color = new Array();

            function getRndColor(s) {
                var getColor = function() {
                    var r = Math.ceil((Math.random() * 85) + 170).toString(16);
                    //亮色
                    r = r.length == 1 ? '0' + r : r;
                    return r;
                }
                var color = (s == undefined) ? '#' : '';
                return (color + getColor() + getColor() + getColor());
            }
            
            function Chartprev(chartid) {
				var t_title='';
				var t_chart='';
				var t_stitle='';
				var t_select='';
				if(chartid=='Chart1'){
					t_title=C1title.split('>>');
					t_chart=C1Chart.split('>>');
					t_stitle=C1Stitle.split('>>');
					t_select=C1Dselect.split(',');
				}else if(chartid=='Chart2'){
					t_title=C2title.split('>>');
					t_chart=C2Chart.split('>>');
					t_stitle=C2Stitle.split('>>');
					t_select=C2Dselect.split(',');
				}else if(chartid=='Chart3'){
					t_title=C3title.split('>>');
					t_chart=C3Chart.split('>>');
					t_stitle=C3Stitle.split('>>');
					t_select=C3Dselect.split(',');
				}else if(chartid=='Chart4'){
					t_title=C4title.split('>>');
					t_chart=C4Chart.split('>>');
					t_stitle=C4Stitle.split('>>');
					t_select=C4Dselect.split(',');
				}else if(chartid=='Chart5'){
					t_title=C5title.split('>>');
					t_chart=C5Chart.split('>>');
					t_stitle=C5Stitle.split('>>');
					t_select=C5Dselect.split(',');
				}else if(chartid=='Chart6'){
					t_title=C6title.split('>>');
					t_chart=C6Chart.split('>>');
					t_stitle=C6Stitle.split('>>');
					t_select=C6Dselect.split(',');
				}
				var new_title='';
				var new_title2='';
				var new_chart='';
				var new_stitle='';
				var new_select='';
				var change_chart='';
				var change_stitle='';
				for (var i=0;i<t_title.length-1;i++){
						new_title2=new_title2+(new_title2.length>0?'>>':'')+t_title[i];
						new_chart=new_chart+(new_chart.length>0?'>>':'')+t_chart[i];
						new_stitle=new_stitle+(new_stitle.length>0?'>>':'')+t_stitle[i];
						new_select=new_select+(i>0?',':'')+t_select[i];
						change_chart=t_chart[i];
						change_stitle=t_stitle[i];
				}
				if(chartid=='Chart1'){
					C1title=new_title2;
					C1Chart=new_chart;
					C1Stitle=new_stitle;
					C1Dselect=new_select;
				}else if(chartid=='Chart2'){
					C2title=new_title2;
					C2Chart=new_chart;
					C2Stitle=new_stitle;
					C2Dselect=new_select;
				}else if(chartid=='Chart3'){
					C3title=new_title2;
					C3Chart=new_chart;
					C3Stitle=new_stitle;
					C3Dselect=new_select;
				}else if(chartid=='Chart4'){
					C4title=new_title2;
					C4Chart=new_chart;
					C4Stitle=new_stitle;
					C4Dselect=new_select;
				}else if(chartid=='Chart5'){
					C5title=new_title2;
					C5Chart=new_chart;
					C5Stitle=new_stitle;
					C5Dselect=new_select;
				}else if(chartid=='Chart6'){
					C6title=new_title2;
					C6Chart=new_chart;
					C6Stitle=new_stitle;
					C6Dselect=new_select;
				}
									
				if(new_title2=='向下切入'){
					Charthome(chartid);
					return;
				}
																		
				if(change_chart=='traChart'){
					$('#'+chartid).traChart({
				       	title:new_title,
						title2:new_title2,
						data : traData,
						previous:true
					});
				}else if(change_chart=='barChart'){
					$('#'+chartid).barChart({
						title:new_title,
						title2:new_title2,
						ltitle:change_stitle,
						btitle:'加總 (實際營收)',
						data : barData,
						previous:true
					});
				}else if(change_chart=='barChart2'){
					$('#'+chartid).barChart2({
						title:new_title,
						title2:new_title2,
						ltitle:'金額',
						btitle:change_stitle,
						btitle1:'估計',
						btitle2:'實際',
						data : barData2,
						previous:true
					});
				}else if(change_chart=='pieChart'){
					var color=new Array();
					for (var i=0;i<pieData.length;i++){
						color.push(getRndColor());
					}
					$('#'+chartid).pieChart({
						title:new_title,
						title2:new_title2,
						data : pieData,
						x : 200,
						y : 200,
						radius : 150,
						color:color,
						previous:true
					});
				}
            }
            
            function Charthome(chartid) {
            	var change_chart='',new_title='',new_title2='',new_btitle='';
            	var as=undefined;
            	if(chartid=='Chart1'){
					C1title='向下切入';
					C1Chart=DC1Chart;
					C1Stitle=DC1Stitle;
					C1Dselect='';
					change_chart=DC1Chart;
					new_title=DC1Title1;
					new_title2=DC1Title2;
					new_btitle=DC1Stitle;
					C1Where=[];
					C1Where.push(DC1Where);
					if(DC1Where!=''){
						q_func('qtxt.query.crmquery', 'crm.txt,query,' + encodeURI(DC1Where),r_accy,1);
						as = _q_appendData("tmp0", "", true, true);
					}
				}else if(chartid=='Chart2'){
					C2title='向下切入';
					C2Chart=DC2Chart;
					C2Stitle=DC2Stitle;
					C2Dselect='';
					change_chart=DC2Chart;
					new_title=DC2Title1;
					new_title2=DC2Title2;
					new_btitle=DC2Stitle;
					C2Where=[];
					C2Where.push(DC2Where);
					if(DC2Where!=''){
						q_func('qtxt.query.crmquery', 'crm.txt,query,' + encodeURI(DC2Where),r_accy,1);
						as = _q_appendData("tmp0", "", true, true);
					}
				}else if(chartid=='Chart3'){
					C3title='向下切入';
					C3Chart=DC3Chart;
					C3Stitle=DC3Stitle;
					C3Dselect='';
					change_chart=DC3Chart;
					new_title=DC3Title1;
					new_title2=DC3Title2;
					new_btitle=DC3Stitle;
					C3Where=[];
					C3Where.push(DC3Where);
					if(DC3Where!=''){
						q_func('qtxt.query.crmquery', 'crm.txt,query,' + encodeURI(DC3Where),r_accy,1);
						as = _q_appendData("tmp0", "", true, true);
					}
				}else if(chartid=='Chart4'){
					C4title='向下切入';
					C4Chart=DC4Chart;
					C4Stitle=DC4Stitle;
					C4Dselect='';
					change_chart=DC4Chart;
					new_title=DC4Title1;
					new_title2=DC4Title2;
					new_btitle=DC2Stitle;
					C4Where=[];
					C4Where.push(DC4Where);
					if(DC4Where!=''){
						q_func('qtxt.query.crmquery', 'crm.txt,query,' + encodeURI(DC4Where),r_accy,1);
						as = _q_appendData("tmp0", "", true, true);
					}
				}else if(chartid=='Chart5'){
					C5title='向下切入';
					C5Chart=DC5Chart;
					C5Stitle=DC5Stitle;
					C5Dselect='';
					change_chart=DC5Chart;
					new_title=DC5Title1;
					new_title2=DC5Title2;
					new_btitle=DC2Stitle;
					C5Where=[];
					C5Where.push(DC5Where);
					if(DC5Where!=''){
						q_func('qtxt.query.crmquery', 'crm.txt,query,' + encodeURI(DC5Where),r_accy,1);
						as = _q_appendData("tmp0", "", true, true);
					}
				}else if(chartid=='Chart6'){
					C6title='向下切入';
					C6Chart=DC6Chart;
					C6Stitle=DC6Stitle;
					C6Dselect='';
					change_chart=DC6Chart;
					new_title=DC6Title1;
					new_title2=DC6Title2;
					new_btitle=DC2Stitle;
					C6Where=[];
					C6Where.push(DC6Where);
					if(DC2Where!=''){
						q_func('qtxt.query.crmquery', 'crm.txt,query,' + encodeURI(DC6Where),r_accy,1);
						as = _q_appendData("tmp0", "", true, true);
					}
				}
				
				if (as != undefined) {
					if (as[0] != undefined){
						if (as[0].terr != undefined){
							return;
						}
					}
					if(change_chart=='traChart'){
						traData=[];
						for(var i=0;i<as.length;i++){
							traData.push({
								text:as[i].text,
								total:dec(as[i].total)
							});
						}
					}else if(change_chart=='barChart'){
						barData=[];
						for(var i=0;i<as.length;i++){
							barData.push({
								text:as[i].text,
								total:dec(as[i].total)
							});
						}
					}else if(change_chart=='barChart2'){
						barData2=[];
						for(var i=0;i<as.length;i++){
							barData2.push({
								text:as[i].text,
								total1:dec(as[i].total1),
								total2:dec(as[i].total2)
							});
						}
					}else if(change_chart=='pieChart'){
					}
				}
				
				if(change_chart=='traChart'){
					$('#'+chartid).traChart({
				       	title:new_title,
						title2:new_title2,
						data : traData,
						previous:false
					});
				}else if(change_chart=='barChart'){
					$('#'+chartid).barChart({
						title:new_title,
						title2:new_title2,
						ltitle:'負責人',
						btitle:new_btitle,
						data : barData,
						previous:false
					});
				}else if(change_chart=='barChart2'){
					$('#'+chartid).barChart2({
						title:new_title,
						title2:new_title2,
						ltitle:'金額',
						btitle:new_btitle,
						btitle1:'估計',
						btitle2:'實際',
						data : barData2,
						previous:false
					});
				}else if(change_chart=='pieChart'){
					var color=new Array();
					for (var i=0;i<pieData.length;i++){
						color.push(getRndColor());
					}
					$('#'+chartid).pieChart({
						title:new_title,
						title2:new_title2,
						data : pieData,
						x : 200,
						y : 200,
						radius : 150,
						color:color,
						previous:false
					});
				}
			}
			
            ;(function($, undefined) {
                $.fn.Loading = function() {
                    $(this).data('info', {
                        init : function(obj) {
                            obj.html('').width(250).height(100).show();
                            var tmpPath = '<defs>' + '<filter id="f1" x="0" y="0">' + '<feGaussianBlur in="SourceGraphic" stdDeviation="5" />' + '</filter>' + '<filter id="f2" x="0" y="0">' + '<feGaussianBlur in="SourceGraphic" stdDeviation="5" />' + '</filter>' + '</defs>' + '<rect width="200" height="10" fill="yellow" filter="url(#f1)"/>' + '<rect x="0" y="0" width="20" height="10" fill="RGB(223,116,1)" stroke="yellow" stroke-width="2" filter="url(#f2)">' + '<animate attributeName="x" attributeType="XML" begin="0s" dur="6s" fill="freeze" from="0" to="200" repeatCount="indefinite"/>' + '</rect>';
                            tmpPath += '<text x="40" y="35" fill="black">資料讀取中...</text>';
                            obj.append('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                        }
                    });
                    $(this).data('info').init($(this));
                }
                //----------------------------------------------------------------------------------------------
                //漏斗
                $.fn.traChart = function(value) {
                    $(this).data('info', {
                        value : value,
                        fillColor : color,
                        strokeColor : ["#000000"],
                        focusfillColor : "#FFEEFE",
                        focusIndex : -1,
                        total:0,
                        init : function(obj) {
                        	if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            var total = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                total += obj.data('info').value.data[i].total;
                            }
                            obj.data('info').total=total;
                            obj.data('info').refresh(obj);
                        },
                        refresh : function(obj) {
                            obj.html('');
                            var tmpPath = '';
                            var t_detail = obj.data('info').value.data;
                            var t_title = obj.data('info').value.title;
                            var t_title2 = obj.data('info').value.title2;
                            //背景
                            var objWidth = 500;
                            var objHeight = 800;
                            var tmpPath = '<rect id="back" x="0" y="0" width="' + objWidth + '" height="' + objHeight + '" style="fill:#FFFFFF;stroke-width:1;stroke:rgb(0,0,0)"/>';
                            
                            var t_total = obj.data('info').total;
                            var t_x=0,t_x2=0;
                            var t_y=0;
                            var t_h=50;//抬頭留空
                            var b_h=60;//符號說明留底
                            var o_w=50; //左右邊界
                            var o_h=20;//上下邊界
                            var b_h=60;//符號說明留底
                            var ib_h=20;//符號與圖形間距
                            var b_split=3;//符號一行個數
                            var b_w=100;//金錢說明留底
                            t_x=o_w; //梯型 底x1座標 暫存
                            t_x2=o_w;//梯型 底x2座標 暫存
                            t_y=o_h+t_h;//高度暫存
                            //符號 說明座標暫存
                            t_sx=o_w+10;
                            t_sy=objHeight-o_h-b_h+10;
                            
                            //抬頭
                            tmpPath += '<text id="text_title" x="' + (o_h + 25) + '" y="' + (o_h +10) + '" fill="#000000" style="font-size:24px;font-weight: bold;" >' + t_title + '</text>';
                            tmpPath += '<text id="text_title2" x="' + (o_h + 45) + '" y="' + (o_h +35) + '" fill="#000000" style="font-size:18px;" >' + t_title2 + '</text>';
                            
                            for (var i = 0; i < t_detail.length; i++) {
								var tt_h=round((objHeight-b_h-ib_h-t_h-(o_h*2))*t_detail[i].total/t_total,0)-5;
								if(i==0){
									var t_w=round((objWidth-b_w-(o_w*2))*((t_detail.length-i)/t_detail.length),0);
									t_x2=t_x2+t_w;
								}
								
								var tt_w=0;
								if(i+1<t_detail.length){
									tt_w=round((objWidth-b_w-(o_w*2))*((t_detail.length-i-1)/t_detail.length),0);
								}
								
								var t_color=getRndColor();
                               //圖型
								tmpPath += '<polygon class="chart_tra" id="Trachart_' + i + '" points="'+t_x+','+t_y+' '+(t_x2)+','+t_y+' '
								+(t_x2-(tt_w/t_detail.length))+','+(t_y+tt_h)+' '+(t_x+(tt_w/t_detail.length))+','+(t_y+tt_h)+'" fill="'+t_color+'"/>';
								//金額
								tmpPath += '<text id="text_' + i + '" x="' + (t_x2 + 5) + '" y="' + (t_y + ((tt_h+5)/2)) + '" fill="#000000" >' + '$'+FormatNumber(t_detail[i].total) + '</text>';
								//符號說明
								tmpPath += '<rect x="'+(t_sx)+'" y="'+(t_sy)+'" width="20" height="20" fill="'+t_color+'"/>';
								tmpPath += '<text x="'+(t_sx+25)+'" y="'+(t_sy+15)+'" fill="black">'+t_detail[i].text+'</text>';
                                
                                t_x2=t_x2-(tt_w/t_detail.length);
								t_x=t_x+(tt_w/t_detail.length);
								t_y=t_y+tt_h+5;
								
								t_sx=t_sx+25+((objWidth-(o_w*2)-((20+20)*b_split))/(b_split));
								if((i+1)%b_split==0){
									t_sx=o_w+10;
									t_sy=t_sy+25;
								}
							}
							
							if(obj.data('info').value.previous==true){
								tmpPath += '<text class="href" id="prev" text-anchor="end" x="' + (objWidth-o_w) + '" y="' + (objHeight-o_h+10) + '" fill="#0000FF" style="font-size:12px;font-weight: bold;text-decoration:underline;">回上一層</text>';
								tmpPath += '<text class="href" id="home" x="' + (o_w) + '" y="' + (objHeight-o_h+10) + '" fill="#0000FF"  style="font-size:12px;font-weight: bold;text-decoration:underline;">回最上層</text>';
							}

                            obj.width(objWidth).height(objHeight).html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph1">' + tmpPath + '</svg> ');
                            
                            $('.graph1').css('width',objWidth+'px');
                            $('.graph1').css('height',objHeight+'px');
                            
                            obj.children('svg').find('polygon').click(function(e) {
                            	$('#Chartid').val(obj.attr('id'));
								var n = $(this).attr('id').replace('Trachart_', '');
								$('#Charttext').val(t_detail[n].text);
								//select 重新帶入--------------------------
									$('#DataSelect').text('');
									var t_dselect='';
									var t_select='';
									if(obj.attr('id')=='Chart1'){
										t_dselect=DC1Dselect.split(',');
										t_select=C1Dselect.split(',');
									}else if(obj.attr('id')=='Chart2'){
										t_dselect=DC2Dselect.split(',');
										t_select=C2Dselect.split(',');
									}else if(obj.attr('id')=='Chart3'){
										t_dselect=DC3Dselect.split(',');
										t_select=C3Dselect.split(',');
									}else if(obj.attr('id')=='Chart4'){
										t_dselect=DC4Dselect.split(',');
										t_select=C4Dselect.split(',');
									}else if(obj.attr('id')=='Chart5'){
										t_dselect=DC5Dselect.split(',');
										t_select=C5Dselect.split(',');
									}else if(obj.attr('id')=='Chart6'){
										t_dselect=DC6Dselect.split(',');
										t_select=C6Dselect.split(',');
									}
									var t_stmp='@選取欄位',t_tmp='';
									for(var i=0;i<t_dselect.length;i++){
										t_tmp=t_dselect[i];
										for(var j=0;j<t_select.length;j++){
											if(t_tmp==t_select[j]){
												t_tmp='';
												break;
											}
										}
										if(t_tmp.length>0)
											t_stmp=t_stmp+','+t_tmp;
									}
									q_cmbParse("DataSelect",t_stmp);
									//select--------------------------------
								$('#downChart').css('top',e.pageY).css('left',e.pageX).show();
                            });
                            obj.children('svg').find('rect').click(function(e) {
								$('#downChart').hide();
                            });
                            obj.children('svg').find('.href').click(function(e) {
								if($(this).attr('id')=='prev'){
									Chartprev(obj.attr('id'));
								}
								if($(this).attr('id')=='home'){
									Charthome(obj.attr('id'));
								}
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
                //----------------------------------------------------------------------------------------------
                //長條(橫)
                $.fn.barChart = function(value) {
                    $(this).data('info', {
                        value : value,
                        maxMoney : 0,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            var maxtotal = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                            	if(maxtotal<=obj.data('info').value.data[i].total){
                            		maxtotal=obj.data('info').value.data[i].total;
                            	}
                            }
                            obj.data('info').maxMoney=Math.ceil(maxtotal/Math.pow(10,((maxtotal).toString().length-2)))*Math.pow(10,((maxtotal).toString().length-2));
                            obj.data('info').refresh(obj);
                        },
                        refresh : function(obj) {
                        	obj.html('');
                            var tmpPath = '';
                            var t_detail = obj.data('info').value.data;
                            var t_title = obj.data('info').value.title;
                            var t_title2 = obj.data('info').value.title2;
                            var t_ltitle = obj.data('info').value.ltitle;
                            var t_btitle = obj.data('info').value.btitle;
                             //背景
                            var objWidth = 500;
                            var objHeight = 400;
                            var tmpPath = '<rect id="back" x="0" y="0" width="' + objWidth + '" height="' + objHeight + '" style="fill:#FFFFFF;stroke-width:1;stroke:rgb(0,0,0)"/>';
							var o_w=50; //左右邊界
                            var o_h=20;//上下邊界
							var t_h=50;//抬頭留空
                            var lt_w=30; //左抬頭 留空
                            var ln_w=60; //左標題 留空
                            var bt_w=20; //下抬頭 留空
                            var bn_w=20; //下標題 留空
                            
                            //抬頭
                            tmpPath += '<text id="text_title" x="' + (o_h + 25) + '" y="' + (o_h +10) + '" fill="#000000" style="font-size:24px;font-weight: bold;" >' + t_title + '</text>';
                            tmpPath += '<text id="text_title2" x="' + (o_h + 45) + '" y="' + (o_h +35) + '" fill="#000000" style="font-size:18px;" >' + t_title2 + '</text>';
                            
                            var t_maxMoney=obj.data('info').maxMoney;
                            var strX=o_w+lt_w+ln_w;
                            var strY=objHeight-o_h-bt_w-bn_w;
                            var t_width=objWidth-(o_w*2)-lt_w-ln_w;
                            var t_height=objHeight-(o_h*2)-bt_w-bn_w-t_h;
                            
                            //X軸
                            tmpPath += '<line x1="' + strX + '" y1="' + strY + '" x2="' + (strX + t_width+10) + '" y2="' + strY + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text text-anchor="end"  x="'+strX+'" y="'+(strY+15)+'" fill="#000000" >0</text>';
                            tmpPath += '<text text-anchor="middle"  x="' + (strX + t_width) + '" y="' + (strY +20) + '" fill="#000000" >' + FormatNumber(t_maxMoney) + '</text>';
                            tmpPath += '<line x1="' + (strX + t_width) + '" y1="' + (strY +5)  + '" x2="' + (strX + t_width) + '" y2="' + (strY -5) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            //Y軸
                            tmpPath += '<line x1="' + strX + '" y1="' + strY + '" x2="' + strX + '" y2="' + (strY-t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            
                            tmpPath += '<text id="textltitle" text-anchor="middle " x="' + (o_w) + '" y="' + (strY-(t_height/2)) + '" fill="#000000" style="writing-mode: tb;">' + t_ltitle + '</text>';
                            tmpPath += '<text id="textbtitle" text-anchor="middle " x="' + (strX+(t_width/2)) + '" y="' + (strY+30) + '" fill="#000000" >' + t_btitle + '</text>';
                            
                            var b_height=round(t_height/t_detail.length,0);//長條寬度
                            
                            for (var i = 0; i < t_detail.length; i++) {
                            	//左標題
                            	tmpPath += '<text text-anchor="end" style="dominant-baseline: middle;"  x="'+(strX-3)+'" y="'+(strY-(b_height*(t_detail.length-i))+(b_height/2))+'" fill="#000000" >'+t_detail[i].text+'</text>';
                            	//長條圖
                            	var t_color=getRndColor();
                            	tmpPath += '<rect id="Barchart2_'+i+'" x="'+(strX+1)+'" y="'+(strY-(b_height*(t_detail.length-i))+5)+'" width="'+(t_width*t_detail[i].total/t_maxMoney)+'" height="'+(b_height-10)+'" fill="'+t_color+'"/>';
                            	//金額	
                            	if(t_detail[i].total/t_maxMoney>0.9){
                            		tmpPath += '<text text-anchor="end" style="dominant-baseline: middle;"  x="'+(strX+(t_width*t_detail[i].total/t_maxMoney))+'" y="'+(strY-(b_height*(t_detail.length-i))+(b_height/2))+'" fill="#000000" >'+'$'+FormatNumber(t_detail[i].total)+'</text>';
                            	}else{
                            		tmpPath += '<text text-anchor="start" style="dominant-baseline: middle;"  x="'+(strX+3+(t_width*t_detail[i].total/t_maxMoney))+'" y="'+(strY-(b_height*(t_detail.length-i))+(b_height/2))+'" fill="#000000" >'+'$'+FormatNumber(t_detail[i].total)+'</text>';
                            	}
                            }
                            
                            if(obj.data('info').value.previous==true){
								tmpPath += '<text class="href" id="prev" text-anchor="end" x="' + (objWidth-o_w) + '" y="' + (objHeight-o_h+10) + '" fill="#0000FF" style="font-size:12px;font-weight: bold;text-decoration:underline;">回上一層</text>';
								tmpPath += '<text class="href" id="home" x="' + (o_w) + '" y="' + (objHeight-o_h+10) + '" fill="#0000FF"  style="font-size:12px;font-weight: bold;text-decoration:underline;">回最上層</text>';
							}
							
                            obj.width(objWidth).height(objHeight).html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph2">' + tmpPath + '</svg> ');
							$('.graph2').css('width',objWidth+'px');
                            $('.graph2').css('height',objHeight+'px');
                            
                            obj.children('svg').find('rect').click(function(e) {
                            	$('#Chartid').val(obj.attr('id'));
                            	if($(this).attr('id').indexOf('Barchart2_')>-1){
									var n = $(this).attr('id').replace('Barchart2_', '');
									$('#Charttext').val(t_detail[n].text);
									//select 重新帶入--------------------------
									$('#DataSelect').text('');
									var t_dselect='';
									var t_select='';
									if(obj.attr('id')=='Chart1'){
										t_dselect=DC1Dselect.split(',');
										t_select=C1Dselect.split(',');
									}else if(obj.attr('id')=='Chart2'){
										t_dselect=DC2Dselect.split(',');
										t_select=C2Dselect.split(',');
									}else if(obj.attr('id')=='Chart3'){
										t_dselect=DC3Dselect.split(',');
										t_select=C3Dselect.split(',');
									}else if(obj.attr('id')=='Chart4'){
										t_dselect=DC4Dselect.split(',');
										t_select=C4Dselect.split(',');
									}else if(obj.attr('id')=='Chart5'){
										t_dselect=DC5Dselect.split(',');
										t_select=C5Dselect.split(',');
									}else if(obj.attr('id')=='Chart6'){
										t_dselect=DC6Dselect.split(',');
										t_select=C6Dselect.split(',');
									}
									var t_stmp='@選取欄位',t_tmp='';
									for(var i=0;i<t_dselect.length;i++){
										t_tmp=t_dselect[i];
										for(var j=0;j<t_select.length;j++){
											if(t_tmp==t_select[j]){
												t_tmp='';
												break;
											}
										}
										if(t_tmp.length>0)
											t_stmp=t_stmp+','+t_tmp;
									}
									q_cmbParse("DataSelect",t_stmp);
									//select--------------------------------
									$('#downChart').css('top',e.pageY).css('left',e.pageX).show();
								}else{
									$('#downChart').hide();
								}
                            });
                            
                            obj.children('svg').find('.href').click(function(e) {
								if($(this).attr('id')=='prev'){
									Chartprev(obj.attr('id'));
								}
								if($(this).attr('id')=='home'){
									Charthome(obj.attr('id'));
								}
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
                
                //----------------------------------------------------------------------------------------------
                //----------------------------------------------------------------------------------------------
                //長條(直)
                $.fn.barChart2 = function(value) {
                    $(this).data('info', {
                        value : value,
                        maxMoney : 0,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            var maxtotal = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                            	if(maxtotal<=obj.data('info').value.data[i].total1){
                            		maxtotal=obj.data('info').value.data[i].total1;
                            	}
                            	if(maxtotal<=obj.data('info').value.data[i].total2){
                            		maxtotal=obj.data('info').value.data[i].total2;
                            	}
                            }
                            obj.data('info').maxMoney=Math.ceil(maxtotal/Math.pow(10,((maxtotal).toString().length-2)))*Math.pow(10,((maxtotal).toString().length-2));
                            obj.data('info').refresh(obj);
                        },
                        refresh : function(obj) {
                        	obj.html('');
                            var tmpPath = '';
                            var t_detail = obj.data('info').value.data;
                            var t_title = obj.data('info').value.title;
                            var t_title2 = obj.data('info').value.title2;
                            var t_ltitle = obj.data('info').value.ltitle;
                            var t_btitle = obj.data('info').value.btitle;
                            var t_btitle1 = obj.data('info').value.btitle1;
                            var t_btitle2 = obj.data('info').value.btitle2;
                            
                             //背景
                            var objWidth = 500;
                            var objHeight = 400;
                            var tmpPath = '<rect id="back" x="0" y="0" width="' + objWidth + '" height="' + objHeight + '" style="fill:#FFFFFF;stroke-width:1;stroke:rgb(0,0,0)"/>';
							var o_w=50; //左右邊界
                            var o_h=20;//上下邊界
							var t_h=50;//抬頭留空
							var lt_w=30; //左抬頭 留空
                            var ln_w=60; //左標題 留空
                            var bt_w=55; //下抬頭 留空
                            var bn_w=35; //下標題 留空
                            
                            //抬頭
                            tmpPath += '<text id="text_title" x="' + (o_h + 25) + '" y="' + (o_h +10) + '" fill="#000000" style="font-size:24px;font-weight: bold;" >' + t_title + '</text>';
                            tmpPath += '<text id="text_title2" x="' + (o_h + 45) + '" y="' + (o_h +35) + '" fill="#000000" style="font-size:18px;" >' + t_title2 + '</text>';
                            
                            var t_maxMoney=obj.data('info').maxMoney;
                            var t_ny=0; //分段
                            var strX=o_w+lt_w+ln_w;
                            var strY=objHeight-o_h-bt_w-bn_w;
                            var t_width=objWidth-(o_w*2)-lt_w-ln_w;
                            var t_height=objHeight-(o_h*2)-bt_w-bn_w-t_h;
                            
                            //X軸
                            tmpPath += '<line x1="' + strX + '" y1="' + strY + '" x2="' + (strX + t_width) + '" y2="' + strY + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            //Y軸
                            tmpPath += '<line x1="' + strX + '" y1="' + strY + '" x2="' + strX + '" y2="' + (strY-t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            
                            tmpPath += '<text id="textltitle" text-anchor="middle"  x="' + (strX-ln_w-lt_w) + '" y="' + (strY-(t_height/2)) + '" fill="#000000" style="writing-mode: tb;" >' + t_ltitle + '</text>';
                            tmpPath += '<text id="textbtitle" text-anchor="middle"  x="' + (strX+(t_width/2)) + '" y="' + (strY+bn_w+10) + '" fill="#000000" >' + t_btitle + '</text>';
                            
                            tmpPath += '<text text-anchor="end"  x="'+(strX-5)+'" y="'+(strY)+'" fill="#000000" >0</text>';
                            
                            var x_f=5,x_t=10;
                            while(t_maxMoney/x_f>10 && t_maxMoney/x_t>10){
                            	x_f=x_f*10;
                            	x_t=x_t*10;
                            }
                            t_ny=t_maxMoney/(x_f<=10?x_f:x_t);
                            
                            var t_tmpmoney=round(t_maxMoney/t_ny,0);
                            var t_theight=round(t_height/t_ny,0);
                            for (var i=1; i<=t_ny; i++){
                            	tmpPath += '<line x1="' + (strX+5) + '" y1="' + (strY-(t_theight*i))  + '" x2="' + (strX-5) + '" y2="' + (strY-(t_theight*i)) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								tmpPath += '<text text-anchor="end"  x="'+(strX-10)+'" y="'+(strY-(t_theight*i)+5)+'" fill="#000000" >'+FormatNumber(t_tmpmoney*i)+'</text>';
                            }
                            
                            //符號說明
                            var t_color1=getRndColor();
							tmpPath += '<rect id="blockLogo1" x="'+(strX+10)+'" y="'+(strY+bn_w+20)+'" width="20" height="20" fill="'+t_color1+'"/>';
							tmpPath += '<text id="blockLogo2" x="'+(strX+40)+'" y="'+(strY+bn_w+30)+'" style="dominant-baseline: middle;" fill="black">'+t_btitle1+'</text>';
							var t_color2=getRndColor();
							tmpPath += '<rect x="'+(strX+10+(t_width/2))+'" y="'+(strY+bn_w+20)+'" width="20" height="20" fill="'+t_color2+'"/>';
							tmpPath += '<text x="'+(strX+40+(t_width/2))+'" y="'+(strY+bn_w+30)+'" style="dominant-baseline: middle;" fill="black">'+t_btitle2+'</text>';
                            
                            
                            var b_weight=round(t_width/t_detail.length,0);//長條寬度
                            
                            for (var i = 0; i < t_detail.length; i++) {
                            	//下標題
                            	tmpPath += '<text text-anchor="middle" style="dominant-baseline: middle;"  x="'+(strX+(b_weight*i)+(b_weight/2))+'" y="'+(strY+15)+'" fill="#000000" >'+t_detail[i].text+'</text>';
                            	
                            	//長條圖
                            	tmpPath += '<rect id="Barchart_t1_'+i+'" x="'+(strX+(b_weight*i)+5)+'" y="'+(strY-1-(t_height*t_detail[i].total1/t_maxMoney))+'" width="'+((b_weight/2)-5)+'" height="'+(t_height*t_detail[i].total1/t_maxMoney)+'" fill="'+t_color1+'"/>';
                            	tmpPath += '<rect id="Barchart_t2_'+i+'" x="'+(strX+(b_weight*i)+(b_weight/2))+'" y="'+(strY-1-(t_height*t_detail[i].total2/t_maxMoney))+'" width="'+((b_weight/2)-5)+'" height="'+(t_height*t_detail[i].total2/t_maxMoney)+'" fill="'+t_color2+'"/>';
                            }
                            //分開寫避免被圖型覆蓋
                            for (var i = 0; i < t_detail.length; i++) {
                            	//金額
                            	if(t_detail[i].total1>0){
                            		tmpPath += '<text text-anchor="start" style="dominant-baseline: middle;"  x="'+(strX+(b_weight*i)+5)+'" y="'+(strY-10-(t_height*t_detail[i].total1/t_maxMoney))+'" fill="#000000" >'+'$'+FormatNumber(t_detail[i].total1)+'</text>';
                            	}
                            	if(t_detail[i].total2>0){
                            		tmpPath += '<text text-anchor="start" style="dominant-baseline: middle;"  x="'+(strX+(b_weight*i)+(b_weight/2))+'" y="'+(strY-10-(t_height*t_detail[i].total2/t_maxMoney))+'" fill="#000000" >'+'$'+FormatNumber(t_detail[i].total2)+'</text>';
                            	}
                            }
                            
                            if(obj.data('info').value.previous==true){
								tmpPath += '<text class="href" id="prev" text-anchor="end" x="' + (objWidth-o_w) + '" y="' + (objHeight-o_h+10) + '" fill="#0000FF" style="font-size:12px;font-weight: bold;text-decoration:underline;">回上一層</text>';
								tmpPath += '<text class="href" id="home" x="' + (o_w) + '" y="' + (objHeight-o_h+10) + '" fill="#0000FF"  style="font-size:12px;font-weight: bold;text-decoration:underline;">回最上層</text>';
							}
                            
                            obj.width(objWidth).height(objHeight).html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph3">' + tmpPath + '</svg> ');
							$('.graph3').css('width',objWidth+'px');
                            $('.graph3').css('height',objHeight+'px');
                            
                            obj.children('svg').find('rect').click(function(e) {
                            	$('#Chartid').val(obj.attr('id'));
                            	if($(this).attr('id').indexOf('Barchart_t1')>-1 || $(this).attr('id').indexOf('Barchart_t2')>-1){
									var n = $(this).attr('id').replace('Barchart_t1_', '').replace('Barchart_t2_', '');
									$('#Charttext').val(t_detail[n].text);
									//select 重新帶入--------------------------
									$('#DataSelect').text('');
									var t_dselect='';
									var t_select='';
									if(obj.attr('id')=='Chart1'){
										t_dselect=DC1Dselect.split(',');
										t_select=C1Dselect.split(',');
									}else if(obj.attr('id')=='Chart2'){
										t_dselect=DC2Dselect.split(',');
										t_select=C2Dselect.split(',');
									}else if(obj.attr('id')=='Chart3'){
										t_dselect=DC3Dselect.split(',');
										t_select=C3Dselect.split(',');
									}else if(obj.attr('id')=='Chart4'){
										t_dselect=DC4Dselect.split(',');
										t_select=C4Dselect.split(',');
									}else if(obj.attr('id')=='Chart5'){
										t_dselect=DC5Dselect.split(',');
										t_select=C5Dselect.split(',');
									}else if(obj.attr('id')=='Chart6'){
										t_dselect=DC6Dselect.split(',');
										t_select=C6Dselect.split(',');
									}
									var t_stmp='@選取欄位',t_tmp='';
									for(var i=0;i<t_dselect.length;i++){
										t_tmp=t_dselect[i];
										for(var j=0;j<t_select.length;j++){
											if(t_tmp==t_select[j]){
												t_tmp='';
												break;
											}
										}
										if(t_tmp.length>0)
											t_stmp=t_stmp+','+t_tmp;
									}
									q_cmbParse("DataSelect",t_stmp);
									//select--------------------------------
									$('#downChart').css('top',e.pageY).css('left',e.pageX).show();
								}else{
									$('#downChart').hide();
								}
                            });
                            
                            obj.children('svg').find('.href').click(function(e) {
								if($(this).attr('id')=='prev'){
									Chartprev(obj.attr('id'));
								}
								if($(this).attr('id')=='home'){
									Charthome(obj.attr('id'));
								}
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
                //----------------------------------------------------------------------------------------------
                //----------------------------------------------------------------------------------------------
                //圓餅
                $.fn.pieChart = function(value) {
                    $(this).data('info', {
                        value : value,
                        fillColor : value.color,
                        strokeColor : ["#000000"],
                        focusfillColor : "#FFEEFE",
                        focusIndex : -1,
                        init : function(obj) {
                            //總金額
                            var t_total = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                t_total += obj.data('info').value.data[i].total;
                            }
                            //計算比例
                            var tmpDegree = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                obj.data('info').value.data[i].rate = obj.data('info').value.data[i].total / t_total;
                                obj.data('info').value.data[i].degree = 2 * Math.PI * obj.data('info').value.data[i].rate;
                                obj.data('info').value.data[i].bDegree = tmpDegree;
                                tmpDegree += obj.data('info').value.data[i].degree;
                                obj.data('info').value.data[i].eDegree = tmpDegree;
                                obj.data('info').value.data[i].fillColor = obj.data('info').fillColor[i % obj.data('info').fillColor.length];
                                obj.data('info').value.data[i].strokeColor = obj.data('info').strokeColor[i % obj.data('info').strokeColor.length];
                            }
                            obj.data('info').refresh(obj);
                        },
                        refresh : function(obj) {
                            obj.html('');
                            var tmpPath = '', shiftX, shiftY, degree, fillColor, strokeColor;
                            var x = obj.data('info').value.x;
                            var y = obj.data('info').value.y;
                            var radius = obj.data('info').value.radius;
                            var xbranch = 0, ybranch = 0;
                            var t_title = obj.data('info').value.title;
                            var t_title2 = obj.data('info').value.title2;
                            var t_detail = obj.data('info').value.data;
                            
                            var o_w=25; //左右邊界
                            var o_h=20;//上下邊界
							var t_h=50;//抬頭留空
							var bi_h=20;//圖與說明中間留空
                            var bt_h=Math.ceil((obj.data('info').value.data.length/2))*25; //下說明 留空
                            
                            var objWidth = (x*2)+(o_w*2)+t_h;
                            var objHeight = (y*2)+(o_h*2)+bt_h+bi_h;
                            
                            //背景
                            var tmpPath = '<rect id="back" x="0" y="0" width="' + objWidth + '" height="' + objHeight + '" style="fill:#FFFFFF;stroke-width:1;stroke:rgb(0,0,0)"/>';
                            
                            //抬頭
                            tmpPath += '<text id="text_title" x="' + (o_h + 25) + '" y="' + (o_h +10) + '" fill="#000000" style="font-size:24px;font-weight: bold;" >' + t_title + '</text>';
                            tmpPath += '<text id="text_title2" x="' + (o_h + 45) + '" y="' + (o_h +35) + '" fill="#000000" style="font-size:18px;" >' + t_title2 + '</text>';
                            
                            //畫圓
                            for ( i = 0; i < t_detail.length; i++) {
                                if (i == obj.data('info').focusIndex) {
                                    shiftX = Math.round(10 * Math.cos(t_detail[i].bDegree + t_detail[i].degree / 2), 0);
                                    shiftY = Math.round(10 * Math.sin(t_detail[i].bDegree + t_detail[i].degree / 2), 0);
                                    fillColor = '"' + obj.data('info').focusfillColor + '"';
                                    strokeColor = '"' + t_detail[i].strokeColor + '"';
                                } else {
                                    shiftX = o_w;
                                    shiftY = o_h+t_h;
                                    fillColor = '"' + t_detail[i].fillColor + '"';
                                    strokeColor = '"' + t_detail[i].strokeColor + '"';
                                }
                                degree = Math.round(t_detail[i].degree * 360 / (2 * Math.PI), 0);
                                t_detail[i].currentFillColor = fillColor;
                                t_detail[i].currentStrokeColor = strokeColor;
                                t_detail[i].point1 = [x + shiftX, y + shiftY];
                                t_detail[i].point2 = [x + shiftX + Math.round(radius * Math.cos(t_detail[i].bDegree), 0), y + shiftY + Math.round(radius * Math.sin(t_detail[i].bDegree), 0)];
                                t_detail[i].point3 = [x + shiftX + Math.round(radius * Math.cos(t_detail[i].eDegree), 0), y + shiftY + Math.round(radius * Math.sin(t_detail[i].eDegree), 0)];

                                var pointLogo = [o_w + 20+((i%2)*(objWidth/2)), (objHeight-bt_h-o_h)+(Math.floor((i/2))*25)];
                                var pointText = [o_w + 20+((i%2)*(objWidth/2))+30, (objHeight-bt_h-o_h)+(Math.floor((i/2))*25)+10];
                                tmpPath += '<rect class="blockLogo" id="blockLogo_' + i + '" width="10" height="10" x="' + pointLogo[0] + '" y="' + pointLogo[1] + '" fill=' + fillColor + ' stroke=' + strokeColor + '/>';
                                tmpPath += '<text class="blockText" id="blockText_' + i + '" x="' + pointText[0] + '" y="' + pointText[1] + '" fill="#000000">' + t_detail[i].text + '</text>';
                                
                                if (degree != 360){
                                    tmpPath += '<path class="block" id="block_' + i + '" d="M' + t_detail[i].point1[0] + ' ' + t_detail[i].point1[1] + ' L' + t_detail[i].point2[0] + ' ' + t_detail[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + (degree > 180 ? ' 1 1 ' : ' 0 1 ') + t_detail[i].point3[0] + ' ' + t_detail[i].point3[1] + ' Z" fill=' + t_detail[i].currentFillColor + ' stroke=' + t_detail[i].currentStrokeColor + '/>';
                                }else{
                                    tmpPath += '<circle class="block" id="block_' + i + '" cx="' + x + '" cy="' + y + '" r="' + radius + '" fill=' + t_detail[i].currentFillColor + ' stroke=' + t_detail[i].currentStrokeColor + '/>';
                                   }
                            }
                            
                            //圖標題
							for ( i = 0; i < t_detail.length; i++) {
								var degree = Math.round(t_detail[i].degree * 360 / (2 * Math.PI), 0);
								if (degree != 360 && degree > 10){
									tmpPath += '<text class="blockText" id="imgText_' + i 
									+ '" x="' + (t_detail[i].point1[0] -((t_detail[i].point1[0]-t_detail[i].point3[0])/2)+(Math.round(degree/180*radius * Math.cos(t_detail[i].bDegree), 0) ))
									+ '" y="' + (t_detail[i].point1[1] -(((t_detail[i].point1[1]-t_detail[i].point3[1])/2))+(Math.round(degree/180*radius * Math.sin(t_detail[i].bDegree), 0)))
									+ '" fill="#000000">'+ t_detail[i].value + '</text>';
								}
							}
                            
                            if(obj.data('info').value.previous==true){
								tmpPath += '<text class="href" id="prev" text-anchor="end" x="' + (objWidth-o_w) + '" y="' + (objHeight-o_h+10) + '" fill="#0000FF" style="font-size:12px;font-weight: bold;text-decoration:underline;">回上一層</text>';
								tmpPath += '<text class="href" id="home" x="' + (o_w) + '" y="' + (objHeight-o_h+10) + '" fill="#0000FF"  style="font-size:12px;font-weight: bold;text-decoration:underline;">回最上層</text>';
							}
                            
                            obj.width(objWidth).height(objHeight).append('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph4">' + tmpPath + '</svg> ');
                            
                            for ( i = 0; i < t_detail.length; i++) {
                                obj.children('svg').find('.block').eq(i).data('info', {
                                    index : i
                                });
                                obj.children('svg').find('.blockLogo').eq(i).data('info', {
                                    index : i
                                });
                                obj.children('svg').find('.blockText').eq(i).data('info', {
                                    index : i
                                });
                            }
                            
                            $('.graph4').css('width',objWidth+'px');
                            $('.graph4').css('height',objHeight+'px');
                            
                            obj.children('svg').find('path').click(function(e) {
                            	$('#Chartid').val(obj.attr('id'));
								var n = $(this).attr('id').replace('block_', '');
								$('#Charttext').val(t_detail[n].text);
								//select 重新帶入--------------------------
									$('#DataSelect').text('');
									var t_dselect='';
									var t_select='';
									if(obj.attr('id')=='Chart1'){
										t_dselect=DC1Dselect.split(',');
										t_select=C1Dselect.split(',');
									}else if(obj.attr('id')=='Chart2'){
										t_dselect=DC2Dselect.split(',');
										t_select=C2Dselect.split(',');
									}else if(obj.attr('id')=='Chart3'){
										t_dselect=DC3Dselect.split(',');
										t_select=C3Dselect.split(',');
									}else if(obj.attr('id')=='Chart4'){
										t_dselect=DC4Dselect.split(',');
										t_select=C4Dselect.split(',');
									}else if(obj.attr('id')=='Chart5'){
										t_dselect=DC5Dselect.split(',');
										t_select=C5Dselect.split(',');
									}else if(obj.attr('id')=='Chart6'){
										t_dselect=DC6Dselect.split(',');
										t_select=C6Dselect.split(',');
									}
									var t_stmp='@選取欄位',t_tmp='';
									for(var i=0;i<t_dselect.length;i++){
										t_tmp=t_dselect[i];
										for(var j=0;j<t_select.length;j++){
											if(t_tmp==t_select[j]){
												t_tmp='';
												break;
											}
										}
										if(t_tmp.length>0)
											t_stmp=t_stmp+','+t_tmp;
									}
									q_cmbParse("DataSelect",t_stmp);
									//select--------------------------------
								$('#downChart').css('top',e.pageY).css('left',e.pageX).show();
                            });
                            obj.children('svg').find('rect').click(function(e) {
								$('#downChart').hide();
                            });
                            
                            obj.children('svg').find('.href').click(function(e) {
								if($(this).attr('id')=='prev'){
									Chartprev(obj.attr('id'));
								}
								if($(this).attr('id')=='home'){
									Charthome(obj.attr('id'));
								}
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
                
                //----------------------------------------------------------------------------------------------
            })($);

            function FormatNumber(n) {
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:1260px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div style="float: left;width: 100%;">
				<a>日期區間：</a>
				<input id="txtBmon" type="text" style="font-size: medium;width: 85px;">
				<a>~</a>
				<input id="txtEmon" type="text" style="font-size: medium;width: 85px;">
				<a>儀表板：</a>
				<select id="DashboardSelect" style="font-size: large;">
					<option value="">請選取儀表板</option>
					<option value="sale">銷售活動儀表板</option>
					<option value="service">客戶服務績效儀表板</option>
					<option value="manager">客戶服務經理儀表板</option>
					<!--<option value="namea">客戶服務代表社交儀表板</option>-->
					<option value="marketing">行銷儀表板</option>
					<!--<option value="namea">行銷社交儀表板</option>-->
				</select>
			</div>
			<div id='Loading'> </div>
			<div id='Chart1'  style="float: left;display: none;"> </div>
			<div id='Chart2' style="float: left;display: none;"> </div>
			<div id='Chart3' style="float: left;display: none;"> </div>
			<div id='Chart4' style="float: left;display: none;"> </div>
			<div id='Chart5' style="float: left;display: none;"> </div>
			<div id='Chart6' style="float: left;display: none;"> </div>
			<div id="downChart" style="display: none;position:absolute;width: 200;border: 1px solid gray;background-color: #FFFFFF;">
				<table>
					<tr>
						<td>
							<select id="DataSelect" style="width: 150px;font-size: medium;">
								<option value="">選取欄位</option>
								<option value="cust">客戶</option>
								<option value="total">金額</option>
							</select>
							<input id="Chartid" type="hidden">
							<input id="Charttext" type="hidden">
						</td>
					</tr>
					<tr>
						<td>
							<select id="ChartSelect" style="font-size: medium;">
								<option value="">選取圖型</option>
								<option value="traChart">漏斗</option>
								<option value="barChart">橫長條</option>
								<option value="barChart2">直長條</option>
								<option value="pieChart">圓餅</option>
							</select>
							<input id="ChartChange" type="button" value="顯示" style="font-size: medium;">
						</td>
					</tr>
				</table>
			</div>
			<!--<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
			<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
			<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
			<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
			<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>-->
		</div>
	</body>
</html>

