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
			var DayName = ['週日','週一','週二','週三','週四','週五','週六'];
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
			}
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_cub_na');
			});
			
			var clickIndex = -1;
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_cub_na',
					options : [{
						type : '0',//[1]
						name : 'accy',
						value : r_accy
					},{
						type : '0', //[2]
						name : 'rlen',
						value : r_len
					},{
						type : '0',//[3]
						name : 'rsaturday',
						value : q_getPara('sys.saturday')
					},{
						type : '0',//[4]
						name : 'rproject',
						value : q_getPara('sys.project').toUpperCase()
					}, {
						type : '1', //[5][6]
						name : 'xdate'
					}, {
						type : '2', //[7][8]
						name : 'xprocno',
						dbf : 'process',
						index : 'noa,process',
						src : 'process_b.aspx'
					}, {
						type : '2', //[9][10]
						name : 'xpno',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '8', //[11]
						name : 'xshowover',
						value : ('1@只顯示超負荷').split(',')
					}, {
						type : '8', //[12]
						name : 'xshownowork',
						value : ('1@未完工').split(',')
					}, {
						type : '8', //[13]
						name : 'xshowdiff',
						value : ('1@僅顯示差異>+-0.5').split(',')
					}]
				});
				
				q_langShow();
				q_popAssign();
				q_getFormat();
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                $('#q_report').click(function(){
					var ChartShowIndex = [0,1];
					var parent=document.getElementById("chart");
					if($('#q_report').data('info').radioIndex != clickIndex){
						$('#frameReport').html('');
						$('#chart').html('');
						var t_index = $('#q_report').data('info').radioIndex;
						if($.inArray(t_index,ChartShowIndex) !== -1){
							$('.prt').hide();
							$('#chart,#chartCtrl').show();
							if(parent.innerHTML.indexOf('q_acDiv')==-1){
								var newDiv = document.createElement("Div");
								newDiv.id="q_acDiv";
								parent.appendChild(newDiv);
							}
						}else{
							$('.prt').show();
							$('#chart,#chartCtrl').hide();
							if(parent.innerHTML.indexOf('q_acDiv')>-1){
								var child=document.getElementById("q_acDiv");
								parent.removeChild(child);
							}
						}
						clickIndex = $('#q_report').data('info').radioIndex;
					}
				});
                
				$('#txtXdate1').datepicker().mask(r_picd);
				$('#txtXdate2').datepicker().mask(r_picd);
				
				$('#txtXdate1').val(q_date());
				$('#txtXdate2').val(q_cdn(q_date(),15));
				
				$('#btnAuth').click(function(e) {
					btnAuthority(q_name);
				});
				
				$('#btnCopy').click(function(e) {
					var clipboard = new Clipboard('#btnCopy');
				});
				
				$("#btnRun").click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					var txtreport = $('#q_report').data('info').reportData[t_index].report;
					
					var t_raccy=encodeURI(r_accy);
					var t_rlen=encodeURI(r_len);
					var t_rsaturday=emp(q_getPara('sys.saturday'))?'0':encodeURI(q_getPara('sys.saturday'));
					var t_rproject=encodeURI(q_getPara('sys.project').toUpperCase());
					
					if(emp($('#txtXdate1').val())){
						$('#txtXdate1').val(q_date());
					}
					if(emp($('#txtXdate2').val())){
						$('#txtXdate2').val(q_cdn(q_date(),15));
					}
					var t_xbdate=encodeURI($('#txtXdate1').val());
					var t_xedate=encodeURI($('#txtXdate2').val());
					var t_xbprocno=emp($('#txtXprocno1a').val())?'#non':encodeURI($('#txtXprocno1a').val());
					var t_xeprocno=emp($('#txtXprocno2a').val())?'#non':encodeURI($('#txtXprocno2a').val());
					var t_xbpno=emp($('#txtXpno1a').val())?'#non':encodeURI($('#txtXpno1a').val());
					var t_xepno=emp($('#txtXpno2a').val())?'#non':encodeURI($('#txtXpno2a').val());
					
					var t_xshowover=$('#chkXshowover input[type="checkbox"]').prop('checked')?encodeURI('1'):'#non';
					var t_xshownowork=$('#chkXshownowork input[type="checkbox"]').prop('checked')?encodeURI('1'):'#non';
					var t_xshowdiff=$('#chkXshowdiff input[type="checkbox"]').prop('checked')?encodeURI('1'):'#non';
					
					Lock();
					q_func('qtxt.query.'+txtreport,'z_cub_na.txt,'+txtreport+','+
							t_raccy + ';' +
							t_rlen + ';' +
							t_rsaturday + ';' +
							t_rproject + ';' +
							t_xbdate + ';' +
							t_xedate + ';' +
							t_xbprocno + ';' +
							t_xeprocno + ';' +
							t_xbpno + ';' +
							t_xepno + ';'+
							t_xshowover + ';'+
							t_xshownowork + ';'+
							t_xshowdiff
					);
					
				});
				
				var t_index = $('#q_report').data('info').radioIndex;
				$('#q_report').find('span.radio').eq(t_index).parent().click();	
			}
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.z_cub_na01':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var t_bdate = $.trim($('#txtXdate1').val());
							var t_edate = $.trim($('#txtXdate2').val());
							t_bdate = (t_bdate.length>=9?t_bdate:q_date());
							var t_bADdate = r_len==3?(dec(t_bdate.substring(0,3))+1911)+t_bdate.substr(3):t_bdate;
							var t_edate = $.trim($('#txtXdate2').val());
							t_edate = (t_edate.length>=9?t_edate:q_date());
							var t_eADdate = r_len==3?(dec(t_edate.substring(0,3))+1911)+t_edate.substr(3):t_edate;
							var t_xshowover='0';
							if($('#chkXshowover input[type="checkbox"]').prop('checked'))
								t_xshowover='1';
							var myStartDate = new Date(t_bADdate);
							var myEndDate = new Date(t_eADdate);
							var DiffDays = ((myEndDate - myStartDate)/ 86400000);
							var DateList = [];
							var DateObj = [];
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								if((new Date(thisADday).getDay())!=0){
									DateList.push(thisDay);
									DateObj.push({
										datea:thisDay,
										mount:0
									});
								}
							}
							var TL = [];
							var OutHtml= '<table id="tTable" border="1px" cellpadding="0" cellspacing="0">';
							for(var i=0;i<as.length;i++){
								var isFind = false;
								for(var j=0;j<TL.length;j++){
									if((as[i].processno==TL[j].processno)){
										TL[j].rate = q_add(dec(TL[j].rate),dec(as[i].mount));
										TL[j].days = q_add(dec(TL[j].days),1);
										isFind = true;
										break;
									}
								}
								if(!isFind){
									TL.push({
										processno : as[i].processno,
										process : as[i].process,
										gen : (dec(as[i].gen)==0?8:dec(as[i].gen)),
										rate : dec(as[i].mount),
										days : 1,
										datea : []
									});
								}
							}
							for(var k=0;k<TL.length;k++){
								for(var j=0;j<DateList.length;j++){
									var thisDateGen = TL[k].gen;
									for(var i=0;i<as.length;i++){
										if((as[i].processno==TL[k].processno) && (as[i].datea==DateList[j])){
											thisDateGen = as[i].gen;
											break;
										}
									}
									TL[k].datea.push([DateList[j],0,thisDateGen]);
								}
							}
							for(var k=0;k<as.length;k++){
								isFind = false;
								for(var j=0;j<TL.length;j++){
									if(isFind) break;
									if((as[k].processno==TL[j].processno)){
										var TLDatea = TL[j].datea;
										for(var h=0;h<TLDatea.length;h++){
											if(as[k].datea==TLDatea[h][0]){
												TLDatea[h][1] = dec(TLDatea[h][1])+dec(as[k].mount);
												isFind = true;
												break;
											}
										}
									}
								}
							}
							
							OutHtml += '<tr>';
							OutHtml += "<td class='tTitle' style='width:240px;' colspan='2' rowspan='2'>製程</td>" +
									   "<td class='tTitle' style='width:60px;' rowspan='2'>日產能</td>" +
									   "<td class='tTitle' style='width:80px;' rowspan='2'>稼動率</td>";
							var tmpTd = '<tr>';
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
								tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
							}
							OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
							tmpTd += "</tr>"
							OutHtml += '</tr>' + tmpTd;
							var ATotal = 0;
							for(var k=0;k<TL.length;k++){
								OutHtml += '<tr>';
								OutHtml += "<td class='Lproduct' style='width:120px;'>" + TL[k].processno + "</td><td class='Lproduct' style='width:120px;'>" + TL[k].process + "</td>" +
										   "<td class='num'>" + TL[k].gen + "</td>" 
										   +"<td class='num'>" + (dec(TL[k].gen)==0?0:round(q_mul(q_div(TL[k].rate,q_mul(TL[k].gen,DateList.length)),100),3)) + "</td>";
								var TTD = TL[k].datea;
								var tTotal = 0;
								for(var j=0;j<TTD.length;j++){
									var thisValue = round(TTD[j][1],3);
									if(t_xshowover=='1'){
										thisValue = (thisValue==0?'':thisValue);
									}
									var thisGen = dec(TTD[j][2]);
									tTotal = q_add(tTotal,round(TTD[j][1],3));
									DateObj[j].mount = q_add(dec(DateObj[j].mount),round(TTD[j][1],3));
									OutHtml += "<td class='num'"+(thisValue>(thisGen+1)?' style="color:red;"':'')+"><font title='日產能:"+thisGen+"'>"
									+"<a "+(thisValue>(thisGen+1)?"style='color:red;'":"")+" >" 
									+(round(thisValue,0)==0 && thisValue>0?round(thisValue,2):Zerospaec(round(thisValue,1))) + "</font></td>";
									//106/07/05 負荷大於1才顯示紅色
								}
								ATotal = q_add(ATotal,tTotal);
								OutHtml += "<td class='num'>" + (round(tTotal,0)==0 && tTotal>0?round(tTotal,2):Zerospaec(round(tTotal,1))) + "</td>";
								OutHtml += '</tr>';
								
								if(k%20==0 && k!=0){
									OutHtml += '<tr>';
									OutHtml += "<td class='tTitle' style='width:240px;' colspan='2' rowspan='2'>製程</td>" +
											   "<td class='tTitle' style='width:60px;' rowspan='2'>日產能</td>" +
											   "<td class='tTitle' style='width:80px;' rowspan='2'>稼動率</td>";
									tmpTd = '<tr>';
									for(var j=0;j<DateList.length;j++){
										var thisDay = DateList[j];
										var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
										OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
										tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
									}
									OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
									tmpTd += "</tr>"
									OutHtml += '</tr>' + tmpTd;
								}
							}
							OutHtml += "<tr><td colspan='4' class='tTotal num'>總計：</td>";
							for(var k=0;k<DateObj.length;k++){
								OutHtml += "<td class='tTotal num'>" + (round(DateObj[k].mount,0)==0 && DateObj[k].mount>0?round(DateObj[k].mount,2):Zerospaec(round(DateObj[k].mount,0))) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + (round(ATotal,0)==0 && ATotal>0?round(ATotal,2):Zerospaec(round(ATotal,1))) + "</td>";
							OutHtml += "</table>"
							var t_totalWidth = 0;
							t_totalWidth = 670+((70+2)*(DateObj.length+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
						break;
					case 'qtxt.query.z_cub_na02':
						var as = _q_appendData('tmp0','',true,true);
						if($('#chkXshownowork input[type="checkbox"]').prop('checked')){
							for ( i = 0; i < as.length; i++) {
								if(as[i].ivalue<=0){
									as.splice(i, 1);
									i--;
								}	
							}
						}
						
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							//106/08/25 顯示週小計
							var showatotal=$("#chkXshowatotal [type=checkbox]").prop('checked');
							var t_bdate = $.trim($('#txtXdate1').val());
							var t_edate = $.trim($('#txtXdate2').val());
							t_bdate = (t_bdate.length>=9?t_bdate:q_date());
							var t_bADdate = r_len==3?(dec(t_bdate.substring(0,3))+1911)+t_bdate.substr(3):t_bdate;
							var t_edate = $.trim($('#txtXdate2').val());
							t_edate = (t_edate.length>=9?t_edate:q_date());
							var t_eADdate = r_len==3?(dec(t_edate.substring(0,3))+1911)+t_edate.substr(3):t_edate;
							var myStartDate = new Date(t_bADdate);
							var myEndDate = new Date(t_eADdate);
							var DiffDays = ((myEndDate - myStartDate)/ 86400000);
							var DateList = [];
							var DateObj = [];
							
							var t_xshownowork='0';
							if($('#chkXshownowork input[type="checkbox"]').prop('checked'))
								t_xshownowork='1';
							
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								if((new Date(thisADday).getDay())!=0){
									DateList.push(thisDay);
									DateObj.push({
										datea:thisDay,
										value:0,
										ivalue:0,
										stotal:0,
										itotal:0
									});
								}else{
									//禮拜日 當成周小計欄
									if(j!=0 && showatotal){
										DateList.push('週小計');
										DateObj.push({
											datea:'週小計',
											value:0,
											ivalue:0,
											stotal:0,
											itotal:0
										});
									}
								}
							}
							var TL = [];
							var OutHtml= '<table id="tTable" border="1px" cellpadding="0" cellspacing="0">';
							for(var i=0;i<as.length;i++){
								var isFind = false;
								for(var j=0;j<TL.length;j++){
									if((as[i].processno==TL[j].processno) && (as[i].productno==TL[j].productno)){
										isFind = true;
									}
								}
								if(!isFind){
									TL.push({
										processno : as[i].processno,
										process : as[i].process,
										productno : as[i].productno,
										product : as[i].product,
										gen : as[i].gen,
										datea : []
									});
								}
							}
							for(var k=0;k<TL.length;k++){
								for(var j=0;j<DateList.length;j++){
									TL[k].datea.push([DateList[j],0,0]);
								}
							}
							for(var k=0;k<as.length;k++){
								isFind = false;
								for(var j=0;j<TL.length;j++){
									if(isFind) break;
									if((as[k].processno==TL[j].processno) && (as[k].productno==TL[j].productno)){
										var TLDatea = TL[j].datea;
										for(var h=0;h<TLDatea.length;h++){
											if(as[k].datea==TLDatea[h][0]){
												TLDatea[h][1] = dec(TLDatea[h][1])+dec(as[k].value);
												TLDatea[h][2] = dec(TLDatea[h][2])+dec(as[k].ivalue);
												isFind = true;
												break;
											}
										}
									}
								}
							}
							OutHtml += '<tr>';
							OutHtml += "<td class='tTitle' style='width:370px;' colspan='2' rowspan='2'>物品</td>" +
									   "<td class='tTitle' style='width:210px;' colspan='2' rowspan='2'>製程</td>" +
									   "<td class='tTitle' style='width:100px;' rowspan='2'>需工時</td>";
									   
							t_xshownowork='';//目前不使用
							if(t_xshownowork=='1')
								OutHtml += "<td class='tTitle' style='width:100px;' rowspan='2'> </td>";
								
							var tmpTd = '<tr>';
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								if(thisDay=='週小計'){
									OutHtml += "<td class='tTitle' style='width:80px;' rowspan='2'>"+thisDay+"</td>";
									if(t_xshownowork=='1')
										OutHtml += "<td class='tTitle' style='width:100px;' rowspan='2'> </td>";
								}else{
									var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
									OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
									tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
								}
							}
							OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
							tmpTd += "</tr>"
							OutHtml += '</tr>' + tmpTd;
							var ATotal = 0,wtotal=0;
							var iATotal = 0,iwtotal=0;
							var t_processno='#non';
							var t_process='#non';
							var rowline=0;
							for(var k=0;k<TL.length;k++){
								//插入工作線別小計
								if(t_processno!='#non' && t_processno!=TL[k].processno && showatotal){
									OutHtml += "<tr><td colspan='2' class='sTotal num'></td>";
									OutHtml += "<td class='sTotal processno'>" + t_processno + "</td><td class='sTotal process'>" + t_process + "</td>" ;
									OutHtml += "<td class='sTotal num'>小計：</td>";
									if(t_xshownowork=='1')
										OutHtml += "<td class='sTotal num'>製造數量<br><a style='color:red;'>未完工數</a></td>"
									var stotla=0,itotla=0;
									for(var c=0;c<DateObj.length;c++){
										if(t_xshownowork=='1')
											OutHtml += "<td class='sTotal num'>" + Zerospaec(round(DateObj[c].stotal,3)) +"<BR><a style='color:red;'>"+Zerospaec(round(DateObj[c].itotal,3)) + "</a></td>";
										else
											OutHtml += "<td class='sTotal num'>" + Zerospaec(round(DateObj[c].stotal,3)) + "</td>";
										
										if(DateObj[c].datea!='週小計'){
											stotla=q_add(stotla,round(DateObj[c].stotal,3));
											itotla=q_add(itotla,round(DateObj[c].itotal,3));
										}else{
											if(t_xshownowork=='1')
												OutHtml += "<td class='sTotal num'>製造數量<br><a style='color:red;'>未完工數</a></td>"
										}
										DateObj[c].stotal=0;
										DateObj[c].itotal=0;
									}
									if(t_xshownowork=='1'){
										OutHtml += "<td class='sTotal num'>" + (round(stotla,0)==0 && stotla>0?round(stotla,2):Zerospaec(round(stotla,0)))+"<BR><a style='color:red;'>"+(round(itotla,0)==0 && itotla>0?round(itotla,2):Zerospaec(round(itotla,0))) + "</a></td></tr>";
									}else{
										OutHtml += "<td class='sTotal num'>" + (round(stotla,0)==0 && stotla>0?round(stotla,2):Zerospaec(round(stotla,0))) + "</td></tr>";
									}
									rowline++;
								}
								
								if(rowline/20>1){
									OutHtml += '<tr>';
									OutHtml += "<td class='tTitle' style='width:370px;' colspan='2' rowspan='2'>物品</td>" +
											   "<td class='tTitle' style='width:210px;' colspan='2' rowspan='2'>製程</td>" +
											   "<td class='tTitle' style='width:100px;' rowspan='2'>需工時</td>";
									if(t_xshownowork=='1')
										OutHtml += "<td class='tTitle' style='width:100px;' rowspan='2'> </td>";
									
									tmpTd = '<tr>';
									for(var j=0;j<DateList.length;j++){
										var thisDay = DateList[j];
										if(thisDay=='週小計'){
											OutHtml += "<td class='tTitle' style='width:80px;' rowspan='2'>"+thisDay+"</td>";
											if(t_xshownowork=='1')
												OutHtml += "<td class='tTitle' style='width:100px;' rowspan='2'> </td>";
										}else{
											var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
											OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
											tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
										}
									}
									OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
									tmpTd += "</tr>"
									OutHtml += '</tr>' + tmpTd;
									rowline=0;
								}
								
								OutHtml += '<tr>';
								OutHtml += "<td class='Lproduct' style='width:150px;'>" + TL[k].productno + "</td><td class='Lproduct' style='width:220px;'>" + TL[k].product + "</td>" +
										   "<td class='Lproduct' style='width:120px;'>" + TL[k].processno + "</td><td class='Lproduct' style='width:120px;'>" + TL[k].process + "</td>" +
										   "<td class='num'>" + TL[k].gen + "</td>";
								if(t_xshownowork=='1')
									OutHtml += "<td class='num'>製造數量<br><a style='color:red;'>未完工數</a></td>";
									
								var TTD = TL[k].datea;
								var tTotal = 0,itTotal = 0;
								wtotal=0,iwtotal=0;
								for(var j=0;j<TTD.length;j++){
									if(TTD[j][0]=='週小計'){
										if(t_xshownowork=='1'){
											OutHtml += "<td class='num'>" + (round(wtotal,0)==0 && wtotal>0?round(wtotal,2):Zerospaec(round(wtotal,0))) +"<br><a style='color:red;'>"+(round(iwtotal,0)==0 && iwtotal>0?round(iwtotal,2):Zerospaec(round(iwtotal,0))) + "</a></td>";
										}else{
											OutHtml += "<td class='num'>" + (round(wtotal,0)==0 && wtotal>0?round(wtotal,2):Zerospaec(round(wtotal,0))) + "</td>";
										}
										if(t_xshownowork=='1')
											OutHtml += "<td class='num'>製造數量<br><a style='color:red;'>未完工數</a></td>";
											
										DateObj[j].value = q_add(dec(DateObj[j].value),wtotal);
										DateObj[j].stotal = q_add(dec(DateObj[j].stotal),wtotal);
										
										DateObj[j].ivalue = q_add(dec(DateObj[j].ivalue),iwtotal);
										DateObj[j].itotal = q_add(dec(DateObj[j].itotal),iwtotal);
										
									}else{
										wtotal= q_add(wtotal,round(TTD[j][1],3));
										tTotal = q_add(tTotal,round(TTD[j][1],3));
										DateObj[j].value = q_add(dec(DateObj[j].value),round(TTD[j][1],3));
										DateObj[j].stotal = q_add(dec(DateObj[j].stotal),round(TTD[j][1],3));
										
										iwtotal= q_add(iwtotal,round(TTD[j][2],3));
										itTotal = q_add(itTotal,round(TTD[j][2],3));
										DateObj[j].ivalue = q_add(dec(DateObj[j].ivalue),round(TTD[j][2],3));
										DateObj[j].itotal = q_add(dec(DateObj[j].itotal),round(TTD[j][2],3));
										
										if(t_xshownowork=='1'){
											OutHtml += "<td class='num'>" + (round(TTD[j][1],0)==0 && TTD[j][1]>0?round(TTD[j][1],2):Zerospaec(round(TTD[j][1],0))) +"<BR><a style='color:red;'>"+(round(TTD[j][2],0)==0 && TTD[j][2]>0?round(TTD[j][2],2):Zerospaec(round(TTD[j][2],0))) + "</a></td>";
										}else{
											OutHtml += "<td class='num'>" + (round(TTD[j][1],0)==0 && TTD[j][1]>0?round(TTD[j][1],2):Zerospaec(round(TTD[j][1],0))) + "</td>";
										}
									}
								}
								ATotal = q_add(ATotal,tTotal);
								iATotal = q_add(iATotal,itTotal);
								if(t_xshownowork=='1'){
									OutHtml += "<td class='num'>" + (round(tTotal,0)==0 && tTotal>0?round(tTotal,2):Zerospaec(round(tTotal,0))) +"<BR><a style='color:red;'>"+(round(itTotal,0)==0 && itTotal>0?round(itTotal,2):Zerospaec(round(itTotal,0))) + "</a></td>";
								}else{
									OutHtml += "<td class='num'>" + (round(tTotal,0)==0 && tTotal>0?round(tTotal,2):Zerospaec(round(tTotal,0))) + "</td>";
								}
								OutHtml += '</tr>';
								
								t_processno=TL[k].processno;
								t_process=TL[k].process;
								rowline++;
							}
							//插入最後一筆工作線別小計
							if(t_processno!='#non' && showatotal){
								OutHtml += "<tr><td colspan='2' class='sTotal num'></td>";
								OutHtml += "<td class='sTotal processno'>" + t_processno + "</td><td class='sTotal process'>" + t_process + "</td>" ;
								OutHtml += "<td class='sTotal num'>小計：</td>";
								if(t_xshownowork=='1')
									OutHtml += "<td class='sTotal num'>製造數量<br><a style='color:red;'>未完工數</a></td>"
								var stotla=0,itotla=0;
								for(var c=0;c<DateObj.length;c++){
									if(t_xshownowork=='1'){
										OutHtml += "<td class='sTotal num'>" + (round(DateObj[c].stotal,0)==0 && DateObj[c].stotal>0?round(DateObj[c].stotal,2):Zerospaec(round(DateObj[c].stotal,0))) +"<BR><a style='color:red;'>" +(round(DateObj[c].itotal,0)==0 && DateObj[c].itotal>0?round(DateObj[c].itotal,2):Zerospaec(round(DateObj[c].itotal,0))) + "</a></td>";
									}else{
										OutHtml += "<td class='sTotal num'>" + (round(DateObj[c].stotal,0)==0 && DateObj[c].stotal>0?round(DateObj[c].stotal,2):Zerospaec(round(DateObj[c].stotal,0))) + "</td>";
									}
									if(DateObj[c].datea!='週小計'){
											itotla=q_add(itotla,round(DateObj[c].itotal,3));
											stotla=q_add(stotla,round(DateObj[c].stotal,3));
									}else{
										if(t_xshownowork=='1')
											OutHtml += "<td class='sTotal num'>製造數量<br><a style='color:red;'>未完工數</a></td>"
									}
									DateObj[c].stotal=0;
									DateObj[c].itotal=0;
								}
								if(t_xshownowork=='1'){
									OutHtml += "<td class='sTotal num'>" + (round(stotla,0)==0 && stotla>0?round(stotla,2):Zerospaec(round(stotla,0)))+"<BR><a style='color:red;'>"+(round(itotla,0)==0 && itotla>0?round(itotla,2):Zerospaec(round(itotla,0))) + "</a></td></tr>";
								}else{
									OutHtml += "<td class='sTotal num'>" + (round(stotla,0)==0 && stotla>0?round(stotla,2):Zerospaec(round(stotla,0))) + "</td></tr>";
								}
							}
							
							OutHtml += "<tr><td colspan='5' class='tTotal num'>總計：</td>";
							if(t_xshownowork=='1')
								OutHtml += "<td class='tTotal num'>製造數量<br><a style='color:red;'>未完工數</a></td>"
							for(var k=0;k<DateObj.length;k++){
								if(t_xshownowork=='1'){
									OutHtml += "<td class='tTotal num'>" + (round(DateObj[k].value,0)==0 && DateObj[k].value>0?round(DateObj[k].value,2):Zerospaec(round(DateObj[k].value,0)))+"<BR><a style='color:red;'>"+(round(DateObj[k].ivalue,0)==0 && DateObj[k].ivalue>0?round(DateObj[k].ivalue,2):Zerospaec(round(DateObj[k].ivalue,0))) + "</a></td>";
								}else{
									OutHtml += "<td class='tTotal num'>" + (round(DateObj[k].value,0)==0 && DateObj[k].value>0?round(DateObj[k].value,2):Zerospaec(round(DateObj[k].value,0))) + "</td>";
								}
								if(DateObj[k].datea=='週小計'){
									if(t_xshownowork=='1')
										OutHtml += "<td class='tTotal num'>製造數量<br><a style='color:red;'>未完工數</a></td>"
								}
							}
							if(t_xshownowork=='1'){
								OutHtml += "<td class='tTotal num'>" + (round(ATotal,0)==0 && ATotal>0?round(ATotal,2):Zerospaec(round(ATotal,0)))+"<BR><a style='color:red;'>" +(round(iATotal,0)==0 && iATotal>0?round(iATotal,2):Zerospaec(round(iATotal,0)))+ "</a></td>";
							}else{
								OutHtml += "<td class='tTotal num'>" + (round(ATotal,0)==0 && ATotal>0?round(ATotal,2):Zerospaec(round(ATotal,0))) + "</td>";
							}
							OutHtml += "</table>"
							var t_totalWidth = 0;
							t_totalWidth = 690+((70+2)*(DateObj.length+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
						break;
				}
				Unlock();
			}
			
			function q_boxClose(s2) {
			}
			function q_gtPost(s2) {
			}
			
			function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
            
			function Zerospaec(n) {
            	if(dec(n)==0){
            		return '';
            	}else{
            		return n;
            	}
            }
		</script>
		<style type="text/css">
			#tTable{
				table-layout: fixed;
			}
			#chgTitle:nth-child(even){
				background-color:#CEFFC6;
			}
			.tTitle{
				text-align:center;
				background: #FF9;
			}
			.tTotal{
				text-align:right;
				background: #CFF;
			}
			.sTotal{
				background: #DFD;
			}
			.center{
				text-align:center;
			}
			.Lproduct{
				text-align:left;
				padding-left:3px;
			}
			.num{
				text-align:right;
				padding-right:2px;
			}
			.tWidth_Station{
				padding-left:2px;
				width:100px;
			}
			.tWidth{
				width:70px;
			}
			
		</style>
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
			<div id="chartCtrl" style="display:inline-block;width:2000px;">
				<input type="button" id="btnRun" style="float:left; width:80px;font-size: medium;" value="執行"/>
				<input type="button" id="btnAuth" style="float:left; width:80px;font-size: medium;" value="權限"/>
				<input type="button" id="btnCopy" style="float:left; width:120px;font-size: medium;" value="複製到剪貼簿" data-clipboard-target="#chart"/>
			</div>
			<div id="chart">
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>