<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "eiprun";
			aPop = new Array(
				['txtAddsno', '', 'sss', 'noa,namea', 'txtAddsno,txtAddnamea', 'sss_b.aspx'],
				['seiprun_sssno', '', 'sss', 'noa,namea', 'seiprun_sssno,seiprun_namea', 'sss_b.aspx']
			);
			
			function eiprunsign() {};
			
            eiprunsign.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='eiprunsign_table'>";
                   string+='<tr id="eiprunsign_header">';
                   string+='<td id="eiprunsign_hide" align="center" style="width:55px;display:none;"></td>';
                   string+='<td id="eiprunsign_datea" onclick="eiprunsign.sort(\'datea\',false)" title="發文日期" align="center" style="width:90px; ">發文日期</td>';
                   string+='<td id="eiprunsign_important" title="重要性" align="center" style="width:60px; ">重要性</td>';
                   string+='<td id="eiprunsign_noa" onclick="eiprunsign.sort(\'noa\',false)" title="簽核單號" align="center" style="width:120px;">簽核單號</td>';
                   string+='<td id="eiprunsign_memo" onclick="eiprunsign.sort(\'memo\',false)" title="簽核內容" align="center" style="width:300px; ">簽核內容</td>';
                   string+='<td id="eiprunsign_astatus" onclick="eiprunsign.sort(\'astatus\',false)" title="狀態" align="center" style="width:200px;">簽核狀態</td>';
                   string+='<td id="eiprunsign_file" title="附件" align="center" style="width:50px;">附件</td>';
                   string+='<td id="eiprunsign_schedule" title="進度" align="center" style="width:50px;">進度</td>';
                   string+='<td id="eiprunsign_bnamea" onclick="eiprunsign.sort(\'astatus\',false)" title="等待核可人" align="center" style="width:300px;">等待核可人</td>';
                   string+='<td id="eiprunsign_act" onclick="eiprunsign.sort(\'astatus\',false)" title="需核可動作" align="center" style="width:50px;">需核可動作</td>';
                   string+='</tr>';
                    
                    var t_color = ['white','aliceblue'];
                    for(var i=0;i<this.tbCount;i++){
                       string+='<tr id="eiprunsign_tr'+i+'">';
                       string+='<td id="eiprunsign_hide'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"><input class="eiprunsign_hide" id="btnEipsignHide_'+i+'" type="button" value="隱藏" style=" width: 50px;" /></td>';
                       string+='<td id="eiprunsign_restart'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"><input class="eiprunsign_restart" id="btnEipsignRestart_'+i+'" type="button" value="重送" style=" width: 50px;" /></td>';
                       string+='<td id="eiprunsign_datea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunsign_important'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunsign_noa'+i+'" class="eiprunsignnoa" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunsign_memo'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunsign_astatus'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunsign_file'+i+'" class="eiprunsignschedule" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunsign_filename'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eiprunsign_files'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eiprunsign_schedule'+i+'" class="eiprunsignschedule" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunsign_bnamea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunsign_act'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='</tr>';
                    }
                   string+='</table>';
                    
                    $('#eiprun').append(string);
                   string='';
                   string+='<input id="btneiprunsign_previous" onclick="eiprunsign.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                   string+='<input id="btneiprunsign_next" onclick="eiprunsign.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                   string+='<input id="textEiprunCurPage" onchange="eiprunsign.page(parseInt($(this).val()))" type="text" readonly="readonly" style="float:left;width:100px;text-align: right;"/>';
                   string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                   string+='<input id="textEiprunTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#eiprun_control').append(string);
                },
                init : function(obj) {
                	$('.eiprunsign_hide').unbind('click');
                	$('.eiprunsign_hide').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsignHide_','')
                        
                        if($('#eiprunsign_noa'+n).text()=='')
							return;
							
						if(confirm("確定要隱藏簽核【"+$('#eiprunsign_noa'+n).text()+"】的資料(將不會再顯示)?"))
							q_func('qtxt.query.signhide_'+n, 'eip.txt,signhide,'+$('#eiprunsign_noa'+n).text()+';'+r_userno+';'+r_name);
							
					});
					
					$('.eiprunsign_restart').unbind('click');
					$('.eiprunsign_restart').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsignRestart_','')
                        
                        if($('#eiprunsign_noa'+n).text()=='')
							return;
							
						if(confirm("確定要重送簽核【"+$('#eiprunsign_noa'+n).text()+"】?"))
							q_func('qtxt.query.signrestart_'+n, 'eip.txt,signrestart,'+$('#eiprunsign_noa'+n).text()+';'+r_userno+';'+r_name);
							
					});
					
					$('.eiprunsignnoa').unbind('click');
					$('.eiprunsignnoa').click(function(e) {
                        var n=$(this).attr('id').replace('eiprunsign_noa','')
                        
                        if($('#eiprunsign_noa'+n).text()=='')
							return;
						
						var t_where="noa='"+$('#eiprunsign_noa'+n).text()+"'";
						q_box("eipflow.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'eipflow', "95%", "95%", '簽核流程');
							
					});
					
					$('.eiprunsignschedule').unbind('click');
					$('.eiprunsignschedule').click(function(e) {
                        var n=$(this).attr('id').replace('eiprunsign_schedule','')
                        
                        if($('#eiprunsign_noa'+n).text()=='')
							return;
						
						q_func('qtxt.query.signdetail_'+n, 'eip.txt,signdetail,'+$('#eiprunsign_noa'+n).text()+';'+r_userno+';'+r_name);
					});
                    
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['noa'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textEiprunTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
               sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[eiprunsign.curIndex] == undefined ? "0" : a[eiprunsign.curIndex]);
                            var n = parseFloat(b[eiprunsign.curIndex] == undefined ? "0" : b[eiprunsign.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[eiprunsign.curIndex] == undefined ? "" : a[eiprunsign.curIndex];
                            var n = b[eiprunsign.curIndex] == undefined ? "" : b[eiprunsign.curIndex];
                            if (m == n) {
                                if (a['noa'] > b['noa'])
                                    return 1;
                                if (a['noa'] < b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m > n)
                                    return 1;
                                if (m < n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage >= this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textEiprunCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textEiprunCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textEiprunCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textEiprunCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                        	$('#btnEipsignHide_' + i).removeAttr('disabled');
                            $('#eiprunsign_datea' + i).text(this.data[n+i]['datea']);
                            $('#eiprunsign_memo' + i).text(this.data[n+i]['memo']);
                            $('#eiprunsign_astatus' + i).text(this.data[n+i]['astatus']);
                            $('#eiprunsign_bnamea' + i).text(this.data[n+i]['bnamea']);
                            $('#eiprunsign_act' + i).text(this.data[n+i]['act']);
                            $('#eiprunsign_noa' + i).text(this.data[n+i]['noa']);
                            
                            var t_filehtml='';
                            if(dec(this.data[n+i]['filetnum'])>0){
                            	t_filehtml="<a id='lblDownloaddetail_"+i+"' class='lbl btn signdownloaddetail'>顯示</a>";
                            }else{
	                            if(this.data[n+i]['filename'].length>0){
	                            	t_filehtml="<a id='lblDownload_"+i+"' class='lbl btn signdownload'>下載</a>";
	                            }
                            }
                            $('#eiprunsign_file' + i).html(t_filehtml);
                            $('#eiprunsign_filename' + i).text(this.data[n+i]['filename']);
                            $('#eiprunsign_files' + i).text(this.data[n+i]['files']);
                            
                            $('#eiprunsign_schedule' + i).text(this.data[n+i]['schedule']);
                            $('#eiprunsign_important' + i).text(this.data[n+i]['important']);
                            
                        } else {
                            $('#btnEipsignHide_' + i).attr('disabled', 'disabled');
                            $('#eiprunsign_datea' + i).text('');
                            $('#eiprunsign_memo' + i).text('');
                            $('#eiprunsign_astatus' + i).text('');
                            $('#eiprunsign_bnamea' + i).text('');
                            $('#eiprunsign_act' + i).text('');
                            $('#eiprunsign_noa' + i).text('');
                            $('#eiprunsign_file' + i).html('');
                            $('#eiprunsign_filename' + i).text('');
                            $('#eiprunsign_files' + i).text('');
                            $('#eiprunsign_schedule' + i).text('');
                            $('#eiprunsign_important' + i).text('');
                        }
                    }
                    
                    $('.signdownload').unbind('click');
                    $('.signdownload').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownload_','')
                        
						if($('#eiprunsign_filename'+n).text().length>0 && $('#eiprunsign_files'+n).text().length>0)
							$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#eiprunsign_filename'+n).text()+'&TempName='+$('#eiprunsign_files'+n).text());
							
					});
					
					$('.signdownloaddetail').unbind('click');
					$('.signdownloaddetail').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownloaddetail_','')
                        
                        if($('#eiprunsign_noa'+n).text()=='')
							return;
						
						q_gt('eipflowt', "where=^^noa='"+$('#eiprunsign_noa'+n).text()+"'^^", 0, 0, 0, "getflowt",r_accy,1);
						var as = _q_appendData("eipflowt", "", true);
						
						var rowslength=document.getElementById("downloaddetail_table").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("downloaddetail_table").deleteRow(1);
						}
						
						if($('#eiprunsign_files'+n).text().length>0 && $('#eiprunsign_filename'+n).text().length>0){
							var tr = document.createElement("tr");
							tr.id = "dd_00";
							tr.innerHTML = "<td align='center'>"+$('#eiprunsign_namea'+n).text()+"</td>";
							tr.innerHTML += "<td align='center'><a id='lblDowndetails_00' class='lbl btn downdetails'>"+$('#eiprunsign_filename'+n).text()+"</a></td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfilename_00'>"+$('#eiprunsign_filename'+n).text()+"</td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfiles_00'>"+$('#eiprunsign_files'+n).text()+"</td>";
							tr.innerHTML += "<td>簽核附件</td>";
							var tmp = document.getElementById("downloaddetail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						
						for (var i = 0; i < as.length; i++) {
							var tr = document.createElement("tr");
							tr.id = "dd_"+i;
							tr.innerHTML = "<td align='center'>"+as[i].upname+"</td>";
							tr.innerHTML += "<td align='center'><a id='lblDowndetails_"+i+"' class='lbl btn downdetails'>"+as[i].filesname+"</a></td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfilename_"+i+"'>"+as[i].filesname+"</td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfiles_"+i+"'>"+as[i].files+"</td>";
							tr.innerHTML += "<td>"+as[i].memo+"</td>";
							var tmp = document.getElementById("downloaddetail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						
						$('#downdetails').unbind('click');
						$('.downdetails').click(function(e) {
							var xn=$(this).attr('id').replace('lblDowndetails_','')
							
							if($('#downdetailfilename_'+xn).text().length>0 && $('#downdetailfiles_'+xn).text().length>0)
								$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#downdetailfilename_'+xn).text()+'&TempName='+$('#downdetailfiles_'+xn).text());
						});
						
						$('#downloaddetail_div').css('top',$('#lblDownloaddetail_'+n).offset().top+30);
						$('#downloaddetail_div').css('left',$('#lblDownloaddetail_'+n).offset().left-350);
						$('#downloaddetail_div').show();
					});
                }
            };
            
            function eiprunssign() {};
			
            eiprunssign.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='eiprunssign_table'>";
                   string+='<tr id="eiprunssign_header">';
                   string+='<td id="eiprunssign_signok" title="核準" align="center" style="width:55px;">核準</td>';
                   string+='<td id="eiprunssign_signok" title="加簽" align="center" style="width:55px;">加簽</td>';
                   string+='<td id="eiprunssign_signbreak" title="退回" align="center" style="width:55px;">退回</td>';
                   string+='<td id="eiprunssign_datea" onclick="eiprunsign.sort(\'datea\',false)" title="發文日期" align="center" style="width:90px; ">發文日期</td>';
                   string+='<td id="eiprunssign_important" title="重要性" align="center" style="width:60px; ">重要性</td>';
                   string+='<td id="eiprunsign_noa" onclick="eiprunsign.sort(\'noa\',false)" title="簽核單號" align="center" style="width:150px;">簽核單號</td>';
                   string+='<td id="eiprunssign_namea" onclick="eiprunsign.sort(\'namea\',false)" title="發文者" align="center" style="width:100px; ">發文者</td>';
                   string+='<td id="eiprunssign_memo" onclick="eiprunsign.sort(\'memo\',false)" title="簽核內容" align="center" style="width:350px; ">簽核內容</td>';
                   string+='<td id="eiprunssign_file" title="附件" align="center" style="width:50px; ">附件</td>';
                   string+='<td id="eiprunssign_schedule" title="進度" align="center" style="width:50px; ">進度</td>';
                   string+='</tr>';
                    
                    var t_color = ['white','aliceblue'];
                    for(var i=0;i<this.tbCount;i++){
                       string+='<tr id="eiprunssign_tr'+i+'">';
                       string+='<td id="eiprunssign_signok'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eiprunsign_ok" id="btnEipsignOk_'+i+'" type="button" value="核準" style=" width: 50px;" /></td>';
                       string+='<td id="eiprunssign_signadd'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eiprunsign_add" id="btnEipsignAdd_'+i+'" type="button" value="加簽" style=" width: 50px;" /></td>';
                       string+='<td id="eiprunssign_signbreak'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eiprunsign_break" id="btnEipsignBreak_'+i+'" type="button" value="退回" style=" width: 50px;" /></td>';
                       string+='<td id="eiprunssign_datea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunssign_important'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunssign_noa'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunssign_noq'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eiprunssign_namea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunssign_memo'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunssign_file'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunssign_filename'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eiprunssign_files'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eiprunssign_schedule'+i+'" class="eiprunssignschedule" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='</tr>';
                    }
                   string+='</table>';
                    
                    $('#eipruns').append(string);
                   string='';
                   string+='<input id="btneiprunssign_previous" onclick="eiprunssign.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                   string+='<input id="btneiprunssign_next" onclick="eiprunssign.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                   string+='<input id="textEiprunsCurPage" onchange="eiprunssign.page(parseInt($(this).val()))" type="text" readonly="readonly" style="float:left;width:100px;text-align: right;"/>';
                   string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                   string+='<input id="textEiprunsTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#eipruns_control').append(string);
                },
                init : function(obj) {
                	$('.eiprunsign_ok').unbind('click');
                    $('.eiprunsign_ok').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsignOk_','')
                        
                        if($('#eiprunssign_noa'+n).text()=='' && $('#eiprunssign_noq'+n).text()=='')
							return;
						
						$('#issignadd_div').hide();
						$('#issignok_div').show();
						$('#issignok_div').css('top',e.pageY);
						$('#issignok_div').css('left',e.pageX);
						$('#txtSignnoa').val($('#eiprunssign_noa'+n).text());
						$('#txtSignnoq').val($('#eiprunssign_noq'+n).text());
						$('#txtSigntypea').val('核準');
						
						/*var tmemo=prompt("意見","");
							if(tmemo===null){
								tmemo='';
							}
							if(tmemo.length==0){
								tmemo='#non';
							}
							
							var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
							
							if(confirm("確定要核准【"+$('#eiprunssign_noa'+n).text()+"】簽核?"))
								q_func('qtxt.query.signok', 'eip.txt,signok,'+$('#eiprunssign_noa'+n).text()+';'+$('#eiprunssign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate+';#non;#non;#non');
						*/
					});
					
					$('.eiprunsign_break').unbind('click');
					$('.eiprunsign_break').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsignBreak_','')
                        
                        if($('#eiprunssign_noa'+n).text()=='' && $('#eiprunssign_noq'+n).text()=='')
							return;
						
						$('#issignadd_div').hide();
						$('#issignok_div').hide();
						
						var tmemo=prompt("退回原因","");
						if(tmemo===null){
							tmemo='';
						}
						if(tmemo.length==0){
							tmemo='#non';
						}
						var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						
						if(confirm("確定要退回【"+$('#eiprunssign_noa'+n).text()+"】簽核?"))
							q_func('qtxt.query.signbreak_'+n, 'eip.txt,signbreak,'+$('#eiprunssign_noa'+n).text()+';'+$('#eiprunssign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate);
							
					});
					
					$('.eiprunsign_add').unbind('click');
					$('.eiprunsign_add').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsignAdd_','')
                        
                        if($('#eiprunssign_noa'+n).text()=='' && $('#eiprunssign_noq'+n).text()=='')
							return;
						
						$('#issignok_div').hide();
						$('#issignadd_div').show();
						$('#issignadd_div').css('top',e.pageY);
						$('#issignadd_div').css('left',e.pageX);
						$('#txtAddnoa').val($('#eiprunssign_noa'+n).text());
						$('#txtAddnoq').val($('#eiprunssign_noq'+n).text());
						
						/*var tmemo='#non';
						var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						
						if(confirm("確定要加簽【"+$('#eiprunssign_noa'+n).text()+"】簽核?"))
							q_func('qtxt.query.signok', 'eip.txt,signok,'+$('#eiprunssign_noa'+n).text()+';'+$('#eiprunssign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate);
						*/
					});
					
					$('.eiprunssignschedule').unbind('click');
					$('.eiprunssignschedule').click(function(e) {
                        var n=$(this).attr('id').replace('eiprunssign_schedule','')
                        
                        if($('#eiprunssign_noa'+n).text()=='')
							return;
						
						q_func('qtxt.query.signsdetail_'+n, 'eip.txt,signdetail,'+$('#eiprunssign_noa'+n).text()+';'+r_userno+';'+r_name);
					});
                    
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['noa'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textEiprunsTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
               sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[eiprunssign.curIndex] == undefined ? "0" : a[eiprunssign.curIndex]);
                            var n = parseFloat(b[eiprunssign.curIndex] == undefined ? "0" : b[eiprunssign.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[eiprunssign.curIndex] == undefined ? "" : a[eiprunssign.curIndex];
                            var n = b[eiprunssign.curIndex] == undefined ? "" : b[eiprunssign.curIndex];
                            if (m == n) {
                                if (a['noa'] > b['noa'])
                                    return 1;
                                if (a['noa'] < b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m > n)
                                    return 1;
                                if (m < n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage >= this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textEiprunsCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textEiprunsCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textEiprunsCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textEiprunsCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                        	$('#btnEipsignOk_' + i).removeAttr('disabled');
                        	$('#btnEipsignAdd_' + i).removeAttr('disabled');
                        	$('#btnEipsignBreak_' + i).removeAttr('disabled');
                            $('#eiprunssign_datea' + i).text(this.data[n+i]['datea']);
                            $('#eiprunssign_memo' + i).text(this.data[n+i]['memo']);
                            $('#eiprunssign_namea' + i).text(this.data[n+i]['namea']);
                            
                            var t_filehtml='';
                            if(dec(this.data[n+i]['filetnum'])>0){
                            	t_filehtml="<a id='lblDownloaddetail_"+i+"' class='lbl btn signsdownloaddetail'>顯示</a>";
                            }else{
	                            if(this.data[n+i]['filename'].length>0){
	                            	t_filehtml="<a id='lblDownload_"+i+"' class='lbl btn signsdownload'>下載</a>";
	                            }
                            }
                            $('#eiprunssign_file' + i).html(t_filehtml);
                            $('#eiprunssign_filename' + i).text(this.data[n+i]['filename']);
                            $('#eiprunssign_files' + i).text(this.data[n+i]['files']);
                            $('#eiprunssign_noa' + i).text(this.data[n+i]['noa']);
                            $('#eiprunssign_noq' + i).text(this.data[n+i]['noq']);
                            $('#eiprunssign_schedule' + i).text(this.data[n+i]['schedule']);
                            $('#eiprunssign_important' + i).text(this.data[n+i]['important']);
                        } else {
                        	$('#btnEipsignOk_' + i).attr('disabled', 'disabled');
                        	$('#btnEipsignAdd_' + i).attr('disabled', 'disabled');
                        	$('#btnEipsignBreak_' + i).attr('disabled', 'disabled');
                            $('#eiprunssign_datea' + i).text('');
                            $('#eiprunssign_memo' + i).text('');
                            $('#eiprunssign_namea' + i).text('');
                            $('#eiprunssign_file' + i).html('');
                            $('#eiprunssign_filename' + i).text('');
                            $('#eiprunssign_files' + i).text('');
                            $('#eiprunssign_noa' + i).text('');
                            $('#eiprunssign_noq' + i).text('');
                            $('#eiprunssign_schedule' + i).text('');
                            $('#eiprunssign_important' + i).text('');
                        }
                    }
                    
                    $('.signsdownload').unbind('click');
                    $('.signsdownload').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownload_','')
                        
						if($('#eiprunssign_filename'+n).text().length>0 && $('#eiprunssign_files'+n).text().length>0)
							$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#eiprunssign_filename'+n).text()+'&TempName='+$('#eiprunssign_files'+n).text());
							
					});
					
					$('.signsdownloaddetail').unbind('click');
					$('.signsdownloaddetail').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownloaddetail_','')
                        
                        if($('#eiprunssign_noa'+n).text()=='')
							return;
						
						q_gt('eipflowt', "where=^^noa='"+$('#eiprunssign_noa'+n).text()+"'^^", 0, 0, 0, "getflowt",r_accy,1);
						var as = _q_appendData("eipflowt", "", true);
						
						var rowslength=document.getElementById("downloaddetail_table").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("downloaddetail_table").deleteRow(1);
						}
						
						if($('#eiprunssign_files'+n).text().length>0 && $('#eiprunssign_filename'+n).text().length>0){
							var tr = document.createElement("tr");
							tr.id = "dd_00";
							tr.innerHTML = "<td align='center'>"+$('#eiprunssign_namea'+n).text()+"</td>";
							tr.innerHTML += "<td align='center'><a id='lblDowndetails_00' class='lbl btn downdetails'>"+$('#eiprunssign_filename'+n).text()+"</a></td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfilename_00'>"+$('#eiprunssign_filename'+n).text()+"</td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfiles_00'>"+$('#eiprunssign_files'+n).text()+"</td>";
							tr.innerHTML += "<td>簽核附件</td>";
							var tmp = document.getElementById("downloaddetail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						
						for (var i = 0; i < as.length; i++) {
							var tr = document.createElement("tr");
							tr.id = "dd_"+i;
							tr.innerHTML = "<td align='center'>"+as[i].upname+"</td>";
							tr.innerHTML += "<td align='center'><a id='lblDowndetails_"+i+"' class='lbl btn downdetails'>"+as[i].filesname+"</a></td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfilename_"+i+"'>"+as[i].filesname+"</td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfiles_"+i+"'>"+as[i].files+"</td>";
							tr.innerHTML += "<td>"+as[i].memo+"</td>";
							var tmp = document.getElementById("downloaddetail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						
						$('#downdetails').unbind('click');
						$('.downdetails').click(function(e) {
							var xn=$(this).attr('id').replace('lblDowndetails_','')
							
							if($('#downdetailfilename_'+xn).text().length>0 && $('#downdetailfiles_'+xn).text().length>0)
								$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#downdetailfilename_'+xn).text()+'&TempName='+$('#downdetailfiles_'+xn).text());
						});
						
						$('#downloaddetail_div').css('top',$('#lblDownloaddetail_'+n).offset().top+30);
						$('#downloaddetail_div').css('left',$('#lblDownloaddetail_'+n).offset().left-350);
						$('#downloaddetail_div').show();
					});
                }
            };
            
            function eipruntsign() {};
			
            eipruntsign.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='eipruntsign_table'>";
                   string+='<tr id="eipruntsign_header">';
                   string+='<td id="eipruntsign_signok" title="確認" align="center" style="width:55px;">確認</td>';
                   string+='<td id="eipruntsign_datea" onclick="eiprunsign.sort(\'datea\',false)" title="發文日期" align="center" style="width:90px; ">發文日期</td>';
                   string+='<td id="eipruntsign_important" title="重要性" align="center" style="width:60px; ">重要性</td>';
                   string+='<td id="eiprunsign_noa" onclick="eiprunsign.sort(\'noa\',false)" title="簽核單號" align="center" style="width:150px;">簽核單號</td>';
                   string+='<td id="eipruntsign_namea" onclick="eiprunsign.sort(\'namea\',false)" title="發文者" align="center" style="width:100px; ">發文者</td>';
                   string+='<td id="eipruntsign_memo" onclick="eiprunsign.sort(\'memo\',false)" title="簽核內容" align="center" style="width:350px; ">簽核內容</td>';
                   string+='<td id="eipruntsign_file" title="附件" align="center" style="width:50px; ">附件</td>';
                   string+='</tr>';
                    
                    var t_color = ['white','aliceblue'];
                    for(var i=0;i<this.tbCount;i++){
                       string+='<tr id="eipruntsign_tr'+i+'">';
                       string+='<td id="eipruntsign_signok'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eipruntsign_ok" id="btnEipsigntOk_'+i+'" type="button" value="確認" style=" width: 50px;" /></td>';
                       string+='<td id="eipruntsign_datea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipruntsign_important'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipruntsign_noa'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipruntsign_noq'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eipruntsign_namea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipruntsign_memo'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipruntsign_file'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipruntsign_filename'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eipruntsign_files'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='</tr>';
                    }
                   string+='</table>';
                    
                    $('#eiprunt').append(string);
                   string='';
                   string+='<input id="btneipruntsign_previous" onclick="eipruntsign.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                   string+='<input id="btneipruntsign_next" onclick="eipruntsign.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                   string+='<input id="textEipruntCurPage" onchange="eipruntsign.page(parseInt($(this).val()))" type="text" readonly="readonly" style="float:left;width:100px;text-align: right;"/>';
                   string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                   string+='<input id="textEipruntTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#eiprunt_control').append(string);
                },
                init : function(obj) {
                	$('.eipruntsign_ok').unbind('click');
                    $('.eipruntsign_ok').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsigntOk_','')
                        
                        if($('#eipruntsign_noa'+n).text()=='' && $('#eipruntsign_noq'+n).text()=='')
							return;
						var tmemo='#non';
						
						var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						
						if(confirm("已確認過【"+$('#eipruntsign_noa'+n).text()+"】簽核?"))
							q_func('qtxt.query.signok', 'eip.txt,signok,'+$('#eipruntsign_noa'+n).text()+';'+$('#eipruntsign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate+';#non;#non;#non');
					});
					
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['noa'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textEipruntTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
               sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[eipruntsign.curIndex] == undefined ? "0" : a[eipruntsign.curIndex]);
                            var n = parseFloat(b[eipruntsign.curIndex] == undefined ? "0" : b[eipruntsign.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[eipruntsign.curIndex] == undefined ? "" : a[eipruntsign.curIndex];
                            var n = b[eipruntsign.curIndex] == undefined ? "" : b[eipruntsign.curIndex];
                            if (m == n) {
                                if (a['noa'] > b['noa'])
                                    return 1;
                                if (a['noa'] < b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m > n)
                                    return 1;
                                if (m < n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage >= this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textEipruntCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textEipruntCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textEipruntCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textEipruntCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                        	$('#btnEipsigntOk_' + i).removeAttr('disabled');
                            $('#eipruntsign_datea' + i).text(this.data[n+i]['datea']);
                            $('#eipruntsign_memo' + i).text(this.data[n+i]['memo']);
                            $('#eipruntsign_namea' + i).text(this.data[n+i]['namea']);
                                                        
                            var t_filehtml='';
                            if(dec(this.data[n+i]['filetnum'])>0){
                            	t_filehtml="<a id='lblDownloaddetail_"+i+"' class='lbl btn signtdownloaddetail'>顯示</a>";
                            }else{
	                            if(this.data[n+i]['filename'].length>0){
	                            	t_filehtml="<a id='lblDownload_"+i+"' class='lbl btn signtdownload'>下載</a>";
	                            }
                            }
                            
                            $('#eipruntsign_file' + i).html(t_filehtml);
                            $('#eipruntsign_filename' + i).text(this.data[n+i]['filename']);
                            $('#eipruntsign_files' + i).text(this.data[n+i]['files']);
                            $('#eipruntsign_noa' + i).text(this.data[n+i]['noa']);
                            $('#eipruntsign_noq' + i).text(this.data[n+i]['noq']);
                            $('#eipruntsign_important' + i).text(this.data[n+i]['important']);
                        } else {
                        	$('#btnEipsigntOk_' + i).attr('disabled', 'disabled');
                            $('#eipruntsign_datea' + i).text('');
                            $('#eipruntsign_memo' + i).text('');
                            $('#eipruntsign_namea' + i).text('');
                            $('#eipruntsign_file' + i).html('');
                            $('#eipruntsign_filename' + i).text('');
                            $('#eipruntsign_files' + i).text('');
                            $('#eipruntsign_noa' + i).text('');
                            $('#eipruntsign_noq' + i).text('');
                            $('#eipruntsign_important' + i).text('');
                        }
                    }
                    
                    $('.signtdownload').unbind('click');
                    $('.signtdownload').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownload_','')
                        
						if($('#eipruntsign_filename'+n).text().length>0 && $('#eipruntsign_files'+n).text().length>0)
							$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#eipruntsign_filename'+n).text()+'&TempName='+$('#eipruntsign_files'+n).text());
							
					});
					
					$('.signtdownloaddetail').unbind('click');
					$('.signtdownloaddetail').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownloaddetail_','')
                        
                        if($('#eipruntsign_noa'+n).text()=='')
							return;
						
						q_gt('eipflowt', "where=^^noa='"+$('#eipruntsign_noa'+n).text()+"'^^", 0, 0, 0, "getflowt",r_accy,1);
						var as = _q_appendData("eipflowt", "", true);
						
						var rowslength=document.getElementById("downloaddetail_table").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("downloaddetail_table").deleteRow(1);
						}
						
						if($('#eipruntsign_files'+n).text().length>0 && $('#eipruntsign_filename'+n).text().length>0){
							var tr = document.createElement("tr");
							tr.id = "dd_00";
							tr.innerHTML = "<td align='center'>"+$('#eipruntsign_namea'+n).text()+"</td>";
							tr.innerHTML += "<td align='center'><a id='lblDowndetails_00' class='lbl btn downdetails'>"+$('#eipruntsign_filename'+n).text()+"</a></td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfilename_00'>"+$('#eipruntsign_filename'+n).text()+"</td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfiles_00'>"+$('#eipruntsign_files'+n).text()+"</td>";
							tr.innerHTML += "<td>簽核附件</td>";
							var tmp = document.getElementById("downloaddetail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						
						for (var i = 0; i < as.length; i++) {
							var tr = document.createElement("tr");
							tr.id = "dd_"+i;
							tr.innerHTML = "<td align='center'>"+as[i].upname+"</td>";
							tr.innerHTML += "<td align='center'><a id='lblDowndetails_"+i+"' class='lbl btn downdetails'>"+as[i].filesname+"</a></td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfilename_"+i+"'>"+as[i].filesname+"</td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfiles_"+i+"'>"+as[i].files+"</td>";
							tr.innerHTML += "<td>"+as[i].memo+"</td>";
							var tmp = document.getElementById("downloaddetail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						
						$('#downdetails').unbind('click');
						$('.downdetails').click(function(e) {
							var xn=$(this).attr('id').replace('lblDowndetails_','')
							
							if($('#downdetailfilename_'+xn).text().length>0 && $('#downdetailfiles_'+xn).text().length>0)
								$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#downdetailfilename_'+xn).text()+'&TempName='+$('#downdetailfiles_'+xn).text());
						});
						
						$('#downloaddetail_div').css('top',$('#lblDownloaddetail_'+n).offset().top+30);
						$('#downloaddetail_div').css('left',$('#lblDownloaddetail_'+n).offset().left-350);
						$('#downloaddetail_div').show();
					});
                }
            };
            
            
            function eiprunusign() {};
			
            eiprunusign.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='eiprunusign_table'>";
                   string+='<tr id="eiprunusign_header">';
                   string+='<td id="eiprunusign_signok" title="完成" align="center" style="width:55px;">完成</td>';
                   string+='<td id="eiprunusign_signok" title="加簽" align="center" style="width:55px;">加簽</td>';
                   string+='<td id="eiprunusign_signbreak" title="退回" align="center" style="width:55px;">退回</td>';
                   string+='<td id="eiprunusign_datea" onclick="eiprunsign.sort(\'datea\',false)" title="發文日期" align="center" style="width:90px; ">發文日期</td>';
                   string+='<td id="eiprunusign_important" title="重要性" align="center" style="width:60px; ">重要性</td>';
                   string+='<td id="eiprunsign_noa" onclick="eiprunsign.sort(\'noa\',false)" title="簽核單號" align="center" style="width:150px;">簽核單號</td>';
                   string+='<td id="eiprunusign_namea" onclick="eiprunsign.sort(\'namea\',false)" title="發文者" align="center" style="width:100px; ">發文者</td>';
                   string+='<td id="eiprunusign_memo" onclick="eiprunsign.sort(\'memo\',false)" title="簽核內容" align="center" style="width:350px; ">簽核內容</td>';
                   string+='<td id="eiprunusign_file" title="附件" align="center" style="width:50px; ">附件</td>';
                   string+='<td id="eiprunusign_schedule" title="進度" align="center" style="width:50px; ">進度</td>';
                   string+='</tr>';
                    
                    var t_color = ['white','aliceblue'];
                    for(var i=0;i<this.tbCount;i++){
                       string+='<tr id="eiprunusign_tr'+i+'">';
                       string+='<td id="eiprunusign_signok'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eiprunusign_ok" id="btnEipsignuOk_'+i+'" type="button" value="完成" style=" width: 50px;" /></td>';
                       string+='<td id="eiprunusign_signadd'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eiprunusign_add" id="btnEipsignuAdd_'+i+'" type="button" value="加簽" style=" width: 50px;" /></td>';
                       string+='<td id="eiprunusign_signbreak'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eiprunusign_break" id="btnEipsignuBreak_'+i+'" type="button" value="退回" style=" width: 50px;" /></td>';
                       string+='<td id="eiprunusign_datea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunusign_important'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunusign_noa'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunusign_noq'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eiprunusign_namea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunusign_memo'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunusign_file'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eiprunusign_filename'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eiprunusign_files'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eiprunusign_schedule'+i+'" class="eiprunusignschedule" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='</tr>';
                    }
                   string+='</table>';
                    
                    $('#eiprunu').append(string);
                   string='';
                   string+='<input id="btneiprunusign_previous" onclick="eiprunusign.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                   string+='<input id="btneiprunusign_next" onclick="eiprunusign.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                   string+='<input id="textEiprunuCurPage" onchange="eiprunusign.page(parseInt($(this).val()))" type="text" readonly="readonly" style="float:left;width:100px;text-align: right;"/>';
                   string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                   string+='<input id="textEiprunuTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#eiprunu_control').append(string);
                },
                init : function(obj) {
                	$('.eiprunusign_ok').unbind('click');
                    $('.eiprunusign_ok').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsignuOk_','')
                        
                        if($('#eiprunusign_noa'+n).text()=='' && $('#eiprunusign_noq'+n).text()=='')
							return;
						
						$('#issignadd_div').hide();
						$('#issignok_div').show();
						$('#issignok_div').css('top',e.pageY);
						$('#issignok_div').css('left',e.pageX);
						$('#txtSignnoa').val($('#eiprunusign_noa'+n).text());
						$('#txtSignnoq').val($('#eiprunusign_noq'+n).text());
						$('#txtSigntypea').val('交辦');
							
						/*var tmemo=prompt("意見","");
						if(tmemo===null){
							tmemo='';
						}
						if(tmemo.length==0){
							tmemo='#non';
						}
						
						var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						
						if(confirm("是否已處理完【"+$('#eiprunusign_noa'+n).text()+"】簽核?"))
							q_func('qtxt.query.signok', 'eip.txt,signok,'+$('#eiprunusign_noa'+n).text()+';'+$('#eiprunusign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate+';#non;#non;#non');
						*/
					});
					
					$('.eiprunusign_break').unbind('click');
					$('.eiprunusign_break').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsignuBreak_','')
                        
                        if($('#eiprunusign_noa'+n).text()=='' && $('#eiprunusign_noq'+n).text()=='')
							return;
							
						var tmemo=prompt("退回原因","");
						if(tmemo===null){
							tmemo='';
						}
						if(tmemo.length==0){
							tmemo='#non';
						}
						var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						
						if(confirm("確定要退回【"+$('#eiprunusign_noa'+n).text()+"】簽核?"))
							q_func('qtxt.query.signbreak_'+n, 'eip.txt,signbreak,'+$('#eiprunusign_noa'+n).text()+';'+$('#eiprunusign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate);
							
					});
					
					$('.eiprunusign_add').unbind('click');
					$('.eiprunusign_add').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsignuAdd_','')
                        
                        if($('#eiprunusign_noa'+n).text()=='' && $('#eiprunusign_noq'+n).text()=='')
							return;
						
						$('#issignok_div').hide();
						$('#issignadd_div').show();
						$('#issignadd_div').css('top',e.pageY);
						$('#issignadd_div').css('left',e.pageX);
						$('#txtAddnoa').val($('#eiprunusign_noa'+n).text());
						$('#txtAddnoq').val($('#eiprunusign_noq'+n).text());
						
						/*var tmemo='#non';
						var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						
						if(confirm("確定要加簽【"+$('#eiprunusign_noa'+n).text()+"】簽核?"))
							q_func('qtxt.query.signok', 'eip.txt,signok,'+$('#eiprunusign_noa'+n).text()+';'+$('#eiprunusign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate);
						*/
					});
					
					$('.eiprunusignschedule').unbind('click');
					$('.eiprunusignschedule').click(function(e) {
                        var n=$(this).attr('id').replace('eiprunusign_schedule','')
                        
                        if($('#eiprunusign_noa'+n).text()=='')
							return;
						
						q_func('qtxt.query.signtdetail_'+n, 'eip.txt,signdetail,'+$('#eiprunusign_noa'+n).text()+';'+r_userno+';'+r_name);
					});
                    
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['noa'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textEiprunuTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
               sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[eiprunusign.curIndex] == undefined ? "0" : a[eiprunusign.curIndex]);
                            var n = parseFloat(b[eiprunusign.curIndex] == undefined ? "0" : b[eiprunusign.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[eiprunusign.curIndex] == undefined ? "" : a[eiprunusign.curIndex];
                            var n = b[eiprunusign.curIndex] == undefined ? "" : b[eiprunusign.curIndex];
                            if (m == n) {
                                if (a['noa'] > b['noa'])
                                    return 1;
                                if (a['noa'] < b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m > n)
                                    return 1;
                                if (m < n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage >= this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textEiprunuCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textEiprunuCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textEiprunuCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textEiprunuCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                        	$('#btnEipsignuOk_' + i).removeAttr('disabled');
                        	$('#btnEipsignuAdd_' + i).removeAttr('disabled');
                        	$('#btnEipsignuBreak_' + i).removeAttr('disabled');
                            $('#eiprunusign_datea' + i).text(this.data[n+i]['datea']);
                            $('#eiprunusign_memo' + i).text(this.data[n+i]['memo']);
                            $('#eiprunusign_namea' + i).text(this.data[n+i]['namea']);
                                                        
                            var t_filehtml='';
                            if(dec(this.data[n+i]['filetnum'])>0){
                            	t_filehtml="<a id='lblDownloaddetail_"+i+"' class='lbl btn signudownloaddetail'>顯示</a>";
                            }else{
	                            if(this.data[n+i]['filename'].length>0){
	                            	t_filehtml="<a id='lblDownload_"+i+"' class='lbl btn signudownload'>下載</a>";
	                            }
                            }
                            
                            $('#eiprunusign_file' + i).html(t_filehtml);
                            $('#eiprunusign_filename' + i).text(this.data[n+i]['filename']);
                            $('#eiprunusign_files' + i).text(this.data[n+i]['files']);
                            $('#eiprunusign_noa' + i).text(this.data[n+i]['noa']);
                            $('#eiprunusign_noq' + i).text(this.data[n+i]['noq']);
                            $('#eiprunusign_schedule' + i).text(this.data[n+i]['schedule']);
                            $('#eiprunusign_important' + i).text(this.data[n+i]['important']);
                        } else {
                        	$('#btnEipsignuOk_' + i).attr('disabled', 'disabled');
                        	$('#btnEipsignuAdd_' + i).attr('disabled', 'disabled');
                        	$('#btnEipsignuBreak_' + i).attr('disabled', 'disabled');
                            $('#eiprunusign_datea' + i).text('');
                            $('#eiprunusign_memo' + i).text('');
                            $('#eiprunusign_namea' + i).text('');
                            $('#eiprunusign_file' + i).html('');
                            $('#eiprunusign_filename' + i).text('');
                            $('#eiprunusign_files' + i).text('');
                            $('#eiprunusign_noa' + i).text('');
                            $('#eiprunusign_noq' + i).text('');
                            $('#eiprunusign_schedule' + i).text('');
                            $('#eiprunusign_important' + i).text('');
                        }
                    }
                    
                    $('.signudownload').unbind('click');
                    $('.signudownload').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownload_','')
                        
						if($('#eiprunusign_filename'+n).text().length>0 && $('#eiprunusign_files'+n).text().length>0)
							$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#eiprunusign_filename'+n).text()+'&TempName='+$('#eiprunusign_files'+n).text());
							
					});
					
					$('.signudownloaddetail').unbind('click');
					$('.signudownloaddetail').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownloaddetail_','')
                        
                        if($('#eiprunusign_noa'+n).text()=='')
							return;
						
						q_gt('eipflowt', "where=^^noa='"+$('#eiprunusign_noa'+n).text()+"'^^", 0, 0, 0, "getflowt",r_accy,1);
						var as = _q_appendData("eipflowt", "", true);
						
						var rowslength=document.getElementById("downloaddetail_table").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("downloaddetail_table").deleteRow(1);
						}
						
						if($('#eiprunusign_files'+n).text().length>0 && $('#eiprunusign_filename'+n).text().length>0){
							var tr = document.createElement("tr");
							tr.id = "dd_00";
							tr.innerHTML = "<td align='center'>"+$('#eiprunusign_namea'+n).text()+"</td>";
							tr.innerHTML += "<td align='center'><a id='lblDowndetails_00' class='lbl btn downdetails'>"+$('#eiprunusign_filename'+n).text()+"</a></td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfilename_00'>"+$('#eiprunusign_filename'+n).text()+"</td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfiles_00'>"+$('#eiprunusign_files'+n).text()+"</td>";
							tr.innerHTML += "<td>簽核附件</td>";
							var tmp = document.getElementById("downloaddetail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						
						for (var i = 0; i < as.length; i++) {
							var tr = document.createElement("tr");
							tr.id = "dd_"+i;
							tr.innerHTML = "<td align='center'>"+as[i].upname+"</td>";
							tr.innerHTML += "<td align='center'><a id='lblDowndetails_"+i+"' class='lbl btn downdetails'>"+as[i].filesname+"</a></td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfilename_"+i+"'>"+as[i].filesname+"</td>";
							tr.innerHTML += "<td style='display:none;' id='downdetailfiles_"+i+"'>"+as[i].files+"</td>";
							tr.innerHTML += "<td>"+as[i].memo+"</td>";
							var tmp = document.getElementById("downloaddetail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						
						$('#downdetails').unbind('click');
						$('.downdetails').click(function(e) {
							var xn=$(this).attr('id').replace('lblDowndetails_','')
							
							if($('#downdetailfilename_'+xn).text().length>0 && $('#downdetailfiles_'+xn).text().length>0)
								$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#downdetailfilename_'+xn).text()+'&TempName='+$('#downdetailfiles_'+xn).text());
						});
						
						$('#downloaddetail_div').css('top',$('#lblDownloaddetail_'+n).offset().top+30);
						$('#downloaddetail_div').css('left',$('#lblDownloaddetail_'+n).offset().left-350);
						$('#downloaddetail_div').show();
					});
                }
            };
            
            function eipflowsign() {};
			
            eipflowsign.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='eipflowsign_table'>";
                   string+='<tr id="eipflowsign_header">';
                   string+='<td id="eipflowsign_datea" onclick="eipflowsign.sort(\'datea\',false)" title="建檔日期" align="center" style="width:100px; ">建檔日期</td>';
                   string+='<td id="eipflowsign_important" title="重要性" align="center" style="width:60px; ">重要性</td>';
                   string+='<td id="eipflowsign_noa" onclick="eipflowsign.sort(\'noa\',false)" title="簽核單號" align="center" style="width:120px;">簽核單號</td>';
                   string+='<td id="eipflowsign_memo" onclick="eipflowsign.sort(\'memo\',false)" title="簽核內容" align="center" style="width:350px; ">簽核內容</td>';
                   string+='<td id="eipflowsign_file" title="附件" align="center" style="width:50px; ">附件</td>';
                   string+='</tr>';
                    
                    var t_color = ['white','aliceblue'];
                    for(var i=0;i<this.tbCount;i++){
                       string+='<tr id="eipflowsign_tr'+i+'">';
                       string+='<td id="eipflowsign_datea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipflowsign_important'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipflowsign_noa'+i+'" class="eipflowsignnoa" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipflowsign_memo'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipflowsign_file'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipflowsign_filename'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='<td id="eipflowsign_files'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='</tr>';
                    }
                   string+='</table>';
                    
                    $('#eipflow').append(string);
                   string='';
                   string+='<input id="btneipflowsign_previous" onclick="eipflowsign.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                   string+='<input id="btneipflowsign_next" onclick="eipflowsign.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                   string+='<input id="textEipflowCurPage" onchange="eipflowsign.page(parseInt($(this).val()))" type="text" readonly="readonly" style="float:left;width:100px;text-align: right;"/>';
                   string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                   string+='<input id="textEipflowTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#eipflow_control').append(string);
                },
                init : function(obj) {
					$('.eipflowsignnoa').unbind('click');
					$('.eipflowsignnoa').click(function(e) {
                        var n=$(this).attr('id').replace('eipflowsign_noa','')
                        
                        if($('#eipflowsign_noa'+n).text()=='')
							return;
						
						var t_where="noa='"+$('#eipflowsign_noa'+n).text()+"'";
						q_box("eipflow.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'eipflow', "95%", "95%", '簽核流程');
							
					});
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['noa'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textEipflowTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
               sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[eipflowsign.curIndex] == undefined ? "0" : a[eipflowsign.curIndex]);
                            var n = parseFloat(b[eipflowsign.curIndex] == undefined ? "0" : b[eipflowsign.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[eipflowsign.curIndex] == undefined ? "" : a[eipflowsign.curIndex];
                            var n = b[eipflowsign.curIndex] == undefined ? "" : b[eipflowsign.curIndex];
                            if (m == n) {
                                if (a['noa'] > b['noa'])
                                    return 1;
                                if (a['noa'] < b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m > n)
                                    return 1;
                                if (m < n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage >= this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textEipflowCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textEipflowCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textEipflowCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textEipflowCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                            $('#eipflowsign_datea' + i).text(this.data[n+i]['datea']);
                            $('#eipflowsign_memo' + i).text(this.data[n+i]['memo']);
                            $('#eipflowsign_noa' + i).text(this.data[n+i]['noa']);
                            var t_filehtml='';
                            if(this.data[n+i]['filename'].length>0){
                            	t_filehtml="<a id='lblDownload_"+i+"' class='lbl btn signflowdownload'>下載</a>";
                            }
                            $('#eipflowsign_file' + i).html(t_filehtml);
                            $('#eipflowsign_filename' + i).text(this.data[n+i]['filename']);
                            $('#eipflowsign_files' + i).text(this.data[n+i]['files']);
                            $('#eipflowsign_important' + i).text(this.data[n+i]['important']);
                        } else {
                            $('#eipflowsign_datea' + i).text('');
                            $('#eipflowsign_memo' + i).text('');
                            $('#eipflowsign_noa' + i).text('');
                            $('#eipflowsign_file' + i).html('');
                            $('#eipflowsign_filename' + i).text('');
                            $('#eipflowsign_files' + i).text('');
                            $('#eipflowsign_important' + i).text('');
                        }
                    }
                    
                    $('.signflowdownload').unbind('click');
                    $('.signflowdownload').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownload_','')
                        
						if($('#eipflowsign_filename'+n).text().length>0 && $('#eipflowsign_files'+n).text().length>0)
							$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#eipflowsign_filename'+n).text()+'&TempName='+$('#eipflowsign_files'+n).text());
							
					});
                }
            };
            
            function eipform() {};
			
            eipform.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='eipform_table'>";
                   string+='<tr id="eipform_header">';
                   string+='<td id="eipform_formname" onclick="eipform.sort(\'formname\',false)" title="表單名稱" align="center" style="width:200px; ">表單名稱</td>';
                   string+='<td id="eipform_memo" onclick="eipform.sort(\'memo\',false)" title="備註" align="center" style="width:350px; ">備註</td>';
                   string+='<td id="eipform_file" title="附件" align="center" style="width:50px; ">預覽</td>';
                   string+='</tr>';
                    
                    var t_color = ['white','aliceblue'];
                    for(var i=0;i<this.tbCount;i++){
                       string+='<tr id="eipform_tr'+i+'">';
                       string+='<td id="eipform_formname'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipform_memo'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipform_file'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                       string+='<td id="eipform_files'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                       string+='</tr>';
                    }
                   string+='</table>';
                    
                    $('#eipform').append(string);
                   string='';
                   string+='<input id="btneipform_previous" onclick="eipform.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                   string+='<input id="btneipform_next" onclick="eipform.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                   string+='<input id="textEipformCurPage" onchange="eipform.page(parseInt($(this).val()))" type="text" readonly="readonly" style="float:left;width:100px;text-align: right;"/>';
                   string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                   string+='<input id="textEipformTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#eipform_control').append(string);
                },
                init : function(obj) {
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['noa'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textEipformTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
               sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[eipform.curIndex] == undefined ? "0" : a[eipform.curIndex]);
                            var n = parseFloat(b[eipform.curIndex] == undefined ? "0" : b[eipform.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[eipform.curIndex] == undefined ? "" : a[eipform.curIndex];
                            var n = b[eipform.curIndex] == undefined ? "" : b[eipform.curIndex];
                            if (m == n) {
                                if (a['noa'] > b['noa'])
                                    return 1;
                                if (a['noa'] < b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m > n)
                                    return 1;
                                if (m < n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage >= this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textEipformCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textEipformCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textEipformCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textEipformCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                            $('#eipform_formname' + i).text(this.data[n+i]['formname']);
                            $('#eipform_memo' + i).text(this.data[n+i]['memo']);
                            var t_filehtml='';
                            if(this.data[n+i]['files'].length>0){
                            	t_filehtml="<a id='lblDownload_"+i+"' class='lbl btn signformdownload'>預覽</a>";
                            }
                            $('#eipform_file' + i).html(t_filehtml);
                            $('#eipform_files' + i).text(this.data[n+i]['files']);
                        } else {
                            $('#eipform_formname' + i).text('');
                            $('#eipform_memo' + i).text('');
                            $('#eipform_file' + i).html('');
                            $('#eipform_files' + i).text('');
                        }
                    }
                    
                    $('.signformdownload').unbind('click');
                    $('.signformdownload').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownload_','')
                        
						if($('#eipform_files'+n).text().length>0){
							var extindex = $('#eipform_files'+n).text().lastIndexOf('.');
							if(extindex>=0){
								ext = $('#eipform_files'+n).text().substring(extindex,$('#eipform_files'+n).text().length);
							}
							if(ext.toUpperCase() == '.DOC' || ext.toUpperCase() == '.DOCX')
								q_func( 'eip.wordConvert.files_'+n , $('#eipform_files'+n).text()+',htm,eipform,'+$('#txtNoa').val())
							else
								$('#xdownload').attr('src','eipform_download.aspx?FileName='+$('#eipform_files'+n).text()+'&TempName='+$('#eipform_files'+n).text());
						}
							
					});
                }
            };
            
            eiprunsign = new eiprunsign();
            eiprunssign = new eiprunssign();
            eipruntsign = new eipruntsign();
            eiprunusign = new eiprunusign();
            eipflowsign = new eipflowsign();
            eipform = new eipform();
            
			$(document).ready(function() {
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
                
                eiprunsign.load();
                eiprunssign.load();
                eipruntsign.load();
                eiprunusign.load();
                eipflowsign.load();
                eipform.load();
                
                var _showTab = 1;
				$('.eip_tab').each(function(){
					// 目前的頁籤區塊
					var $tab = $(this);
			 
					// 當 li 頁籤被點擊時...
					// 若要改成滑鼠移到 li 頁籤就切換時, 把 click 改成 mouseover
					$('ul.tabs li', $tab).click(function() {
						// 找出 li 中的超連結 href(#id)
						var $this = $(this),
							_clickTab = $this.find('a').attr('href');
						// 把目前點擊到的 li 頁籤加上 .active
						// 並把兄弟元素中有 .active 的都移除 class
						$this.addClass('active').siblings('.active').removeClass('active');
						// 淡入相對應的內容並隱藏兄弟元素
						$(_clickTab).stop(false, true).fadeIn().siblings().hide();
			 
						return false;
					}).find('a').focus(function(){
						this.blur();
					});
					
					var $defaultLi = $('ul.tabs li', $tab).eq(_showTab).addClass('active');
					$($defaultLi.find('a').attr('href')).siblings().hide();
				});
                
			});
			
			function q_gfPost() {
				q_getFormat();
                q_langShow();
                q_popAssign();
                
                $('#seiprun_bdate').mask(r_picd);
                $('#seiprun_edate').mask(r_picd);
                
                q_cur=2;
                
                document.title='EIP簽核作業';
								
				//登出
				$('#logout').click(function() {
					q_logout(q_idr);
				});
				
				$('#btnNosign').click(function() {
					$('.signdiv').hide();
					$('#nosign_div').show();
				});
				
				$('#btnIssign').click(function() {
					$('.signdiv').hide();
					$('#issign_div').show();
				});
				
				$('#btnWaitsign').click(function() {
					$('.signdiv').hide();
					$('#waitsign_div').show();
				});
				
				$('#btnTalksign').click(function() {
					$('.signdiv').hide();
					$('#talksign_div').show();
				});
				
				$('#btnWorksign').click(function() {
					$('.signdiv').hide();
					$('#worksign_div').show();
				});
				
				//載入初始資料
				q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name+';'+r_rank+';#non;#non;#non;#non;#non;#non;#non');
				
				$('#btnEiprun_search').click(function() {
					var t_bdate=$('#seiprun_bdate').val();
					var t_edate=$('#seiprun_edate').val();
					var t_noa=$('#seiprun_noa').val();
					var t_enda=$('#seiprun_enda').val();
					var t_sssno=$('#seiprun_sssno').val();
					var t_important=$('#seiprun_important').val();
					if(t_bdate.length==0){t_bdate='#non'}
					if(t_edate.length==0){t_edate='#non'}
					if(t_noa.length==0){t_noa='#non'}
					if(t_enda.length==0){t_enda='#non'}
					if(t_sssno.length==0){t_sssno='#non'}
					if(t_important.length==0){t_important='#non'}
					
					q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name+';'+r_rank+';1;'
					+t_bdate+';'+t_edate+';'+t_noa+';'+t_enda+';'+t_sssno+';'+t_important);
				});
				
				$('#btnSignok').click(function() {
					if(!emp($('#txtSignnoa').val()) && !emp($('#txtSignnoq').val())){
						var file = $('#btnSignflie')[0].files[0];
						var filename='#non';
						var files='#non';
						var filememo=!emp($('#txtSignfilememo').val())?$('#txtSignfilememo').val():'#non';
						var tmemo=$('#txtSignmemo').val();
						if(tmemo.length==0){
							tmemo='#non';
						}
						var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						
						if($('#txtSigntypea').val()=='核準'){
							if(confirm("確定要核准【"+$('#txtSignnoa').val()+"】簽核?")){
								if(file){
									Lock(1);
									var ext = '';
									var extindex = file.name.lastIndexOf('.');
									if(extindex>=0){
										ext = file.name.substring(extindex,file.name.length);
									}
									filename=file.name;
									files=file.name+'_'+Date.now().toString()+ext;
								
									fr = new FileReader();
									fr.fileName = files;
								    fr.readAsDataURL(file);
								    fr.onprogress = function(e){
										if ( e.lengthComputable ) { 
											var per = Math.round( (e.loaded * 100) / e.total) ; 
											$('#FileList').children().last().find('progress').eq(0).attr('value',per);
										}; 
									}
									fr.onloadstart = function(e){
										$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
									}
									fr.onloadend = function(e){
										$('#FileList').children().last().find('progress').eq(0).attr('value',100);
										console.log(fr.fileName+':'+fr.result.length);
										var oReq = new XMLHttpRequest();
										oReq.upload.addEventListener("progress",function(e) {
											if (e.lengthComputable) {
												percentComplete = Math.round((e.loaded / e.total) * 100,0);
												$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
											}
										}, false);
										oReq.upload.addEventListener("load",function(e) {
											Unlock(1);
										}, false);
										oReq.upload.addEventListener("error",function(e) {
											alert("資料上傳發生錯誤!");
										}, false);
											
										oReq.timeout = 360000;
										oReq.ontimeout = function () { alert("Timed out!!!"); }
										oReq.open("POST", 'eipflow_upload.aspx', true);
										oReq.setRequestHeader("Content-type", "text/plain");
										oReq.setRequestHeader("FileName", escape(fr.fileName));
										oReq.send(fr.result);//oReq.send(e.target.result);
									};
									Unlock(1);
								}
								q_func('qtxt.query.signok', 'eip.txt,signok,'+$('#txtSignnoa').val()+';'+$('#txtSignnoq').val()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate+';'+filename+';'+files+';'+filememo);
							}
						}
						if($('#txtSigntypea').val()=='交辦'){
							if(confirm("是否已處理完【"+$('#txtSignnoa').val()+"】簽核?")){
								if(file){
									Lock(1);
									var ext = '';
									var extindex = file.name.lastIndexOf('.');
									if(extindex>=0){
										ext = file.name.substring(extindex,file.name.length);
									}
									filename=file.name;
									files=file.name+'_'+Date.now().toString()+ext;
								
									fr = new FileReader();
									fr.fileName = files;
								    fr.readAsDataURL(file);
								    fr.onprogress = function(e){
										if ( e.lengthComputable ) { 
											var per = Math.round( (e.loaded * 100) / e.total) ; 
											$('#FileList').children().last().find('progress').eq(0).attr('value',per);
										}; 
									}
									fr.onloadstart = function(e){
										$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
									}
									fr.onloadend = function(e){
										$('#FileList').children().last().find('progress').eq(0).attr('value',100);
										console.log(fr.fileName+':'+fr.result.length);
										var oReq = new XMLHttpRequest();
										oReq.upload.addEventListener("progress",function(e) {
											if (e.lengthComputable) {
												percentComplete = Math.round((e.loaded / e.total) * 100,0);
												$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
											}
										}, false);
										oReq.upload.addEventListener("load",function(e) {
											Unlock(1);
										}, false);
										oReq.upload.addEventListener("error",function(e) {
											alert("資料上傳發生錯誤!");
										}, false);
											
										oReq.timeout = 360000;
										oReq.ontimeout = function () { alert("Timed out!!!"); }
										oReq.open("POST", 'eipflow_upload.aspx', true);
										oReq.setRequestHeader("Content-type", "text/plain");
										oReq.setRequestHeader("FileName", escape(fr.fileName));
										oReq.send(fr.result);//oReq.send(e.target.result);
									};
									Unlock(1);
								}
								q_func('qtxt.query.signok', 'eip.txt,signok,'+$('#txtSignnoa').val()+';'+$('#txtSignnoq').val()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate+';'+filename+';'+files+';'+filememo);
							}
						}
						
						$('#txtSignmemo').val('');
						$('#txtSignnoa').val('');
						$('#txtSignnoq').val('');
						$('#btnSignflie').val('');
						$('#txtSignfilememo').val('');
						$('#txtSigntypea').val('');
					}
				});
				
				$('#btnSignclose').click(function() {
					$('#txtSignmemo').val('');
					$('#txtSignnoa').val('');
					$('#txtSignnoq').val('');
					$('#btnSignflie').val('');
					$('#txtSignfilememo').val('');
					$('#txtSigntypea').val('');
					$('#issignok_div').hide();
				});
				
				$('#btnAddok').click(function() {
					if(!emp($('#txtAddnoa').val()) && !emp($('#txtAddnoq').val())){
						var file = $('#btnAddflie')[0].files[0];
						var filename='#non';
						var files='#non';
						var filememo=!emp($('#txtAddfilememo').val())?$('#txtAddfilememo').val():'#non';
						if(!emp($('#txtAddsno').val())){
							var tmemo=$('#txtAddmemo').val();
							var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
							var t_isreturn=$('#txtAddisreturn').prop('checked').toString();
							var t_namea=$('#txtAddnamea').val();
							if(t_namea.length==0)
								var t_namea='#non';
							if(tmemo.length==0)
								var tmemo='#non';
								
							if(confirm("確定要核准【"+$('#txtAddnoa').val()+"】簽核，並加簽給"+$('#txtAddnamea').val()+"?")){
								if(file){
									Lock(1);
									var ext = '';
									var extindex = file.name.lastIndexOf('.');
									if(extindex>=0){
										ext = file.name.substring(extindex,file.name.length);
									}
									filename=file.name;
									files=file.name+'_'+Date.now().toString()+ext;
									
									fr = new FileReader();
									fr.fileName = files;
								    fr.readAsDataURL(file);
								    fr.onprogress = function(e){
										if ( e.lengthComputable ) { 
											var per = Math.round( (e.loaded * 100) / e.total) ; 
											$('#FileList').children().last().find('progress').eq(0).attr('value',per);
										}; 
									}
									fr.onloadstart = function(e){
										$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
									}
									fr.onloadend = function(e){
										$('#FileList').children().last().find('progress').eq(0).attr('value',100);
										console.log(fr.fileName+':'+fr.result.length);
										var oReq = new XMLHttpRequest();
										oReq.upload.addEventListener("progress",function(e) {
											if (e.lengthComputable) {
												percentComplete = Math.round((e.loaded / e.total) * 100,0);
												$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
											}
										}, false);
										oReq.upload.addEventListener("load",function(e) {
											Unlock(1);
										}, false);
										oReq.upload.addEventListener("error",function(e) {
											alert("資料上傳發生錯誤!");
										}, false);
											
										oReq.timeout = 360000;
										oReq.ontimeout = function () { alert("Timed out!!!"); }
										oReq.open("POST", 'eipflow_upload.aspx', true);
										oReq.setRequestHeader("Content-type", "text/plain");
										oReq.setRequestHeader("FileName", escape(fr.fileName));
										oReq.send(fr.result);//oReq.send(e.target.result);
									};
									Unlock(1);
								}
								q_func('qtxt.query.signadd', 'eip.txt,signadd,'+$('#txtAddnoa').val()+';'+$('#txtAddnoq').val()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate
								+';'+$('#txtAddsno').val()+';'+t_namea+';'+t_isreturn+';'+filename+';'+files+';'+filememo);
							}
							
							$('#txtAddnoa').val('');
							$('#txtAddnoq').val('');
							$('#txtAddsno').val('');
							$('#txtAddnamea').val('');
							$('#txtAddmemo').val('');
							$('#txtAddfilememo').val('');
							$('#btnAddflie').val('');
						}else{
							alert('加簽人員編號禁止空白!!');
						}
					}
				});
				
				$('#btnAddclose').click(function() {
					$('#txtAddnoa').val('');
					$('#txtAddnoq').val('');
					$('#txtAddsno').val('');
					$('#txtAddnamea').val('');
					$('#txtAddmemo').val('');
					$('#txtAddfilememo').val('');
					$('#btnAddflie').val('');
					$('#issignadd_div').hide();
				});
				
				$('#btnSignDetailClose').click(function() {
					$('#signdetail_div').hide();
				});
				
				$('#btnDownloaddetailClose').click(function() {
					$('#downloaddetail_div').hide();
				});
            }
            
            var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + s4() + s4();};
			})();
            
            function q_gtPost(t_name) {
				switch (t_name) {
					case 'eipflow':
						var as = _q_appendData("eipflow", "", true);
                        eipflowsign.init(as);
                        if(as.length>0){
                        	$('#nosign_tab').text('草稿('+as.length+')');
                        }else{
                        	$('#nosign_tab').text('草稿');
                        }
                        
                        q_gt('eipform', 'where=^^1=1^^', 0, 0, 0, "");
						break;
					case 'eipform':
						var as = _q_appendData("eipform", "", true);
                        eipform.init(as);
                        if(as.length>0){
                        	$('#form_tab').text('已存檔表單('+as.length+')');
                        }else{
                        	$('#form_tab').text('已存檔表單');
                        }
                        
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			
			function q_funcPost(t_func, result) {
               switch(t_func) {
                	case 'qtxt.query.eipsign':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	var a_eiprunsign=new Array();
                        	var a_eiprunssign=new Array();
                        	var a_eipruntsign=new Array();
                        	var a_eiprunusign=new Array();
                        	for(var i=0; i<as.length;i++){
                        		if(as[i].typea=='1'){
                        			a_eiprunsign.push(as[i]);
                        		}else if(as[i].typea=='2'){ //需簽核
                        			a_eiprunssign.push(as[i]);
                        		}else if (as[i].typea=='3'){ //交辦
                        			a_eiprunusign.push(as[i]);
                        		}else{ //知會
                        			a_eipruntsign.push(as[i])
                        		}
                        	}
                        	
                        	eiprunsign.init(a_eiprunsign);
                        	if(a_eiprunsign.length>0){
                        		$('#issig_tab').text('簽核中('+a_eiprunsign.length+')');
                        	}else{
                        		$('#issig_tab').text('簽核中');
                        	}
                        	
                        	eiprunssign.init(a_eiprunssign);
                        	if(a_eiprunssign.length>0){
                        		$('#waitsign_tab').text('待簽核('+a_eiprunssign.length+')');
                        	}else{
                        		$('#waitsign_tab').text('待簽核');
                        	}
                        	
                        	eiprunusign.init(a_eiprunusign);
                        	if(a_eiprunusign.length>0){
                        		$('#worksign_tab').text('交辦('+a_eiprunusign.length+')');
                        	}else{
                        		$('#worksign_tab').text('交辦');
                        	}
                        	
                        	eipruntsign.init(a_eipruntsign);
                        	if(a_eipruntsign.length>0){
                        		$('#talksign_tab').text('知會('+a_eipruntsign.length+')');
                        	}else{
                        		$('#talksign_tab').text('知會');
                        	}
                        }
                        
                        q_gt('eipflow', 'where=^^issign=0^^', 0, 0, 0, "");
                        $('#issignadd_div').hide();
                        $('#issignok_div').hide();
                        $('#signdetail_div').hide();
                        $('#downloaddetail_div').hide();
						break;
					case 'qtxt.query.signadd':
						var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	alert(as[0].t_err);
                        }else{
                        	alert('簽核加簽失敗!!');
                        }
                        
                        $('#txtAddnoa').val('');
						$('#txtAddnoq').val('');
						$('#txtAddsno').val('');
						$('#txtAddnamea').val('');
						$('#txtAddmemo').val('');
						$('#txtAddfilememo').val('');
						$('#btnAddflie').val('');
						$('#issignadd_div').hide();
						//重新載入資料
						q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name+';'+r_rank+';#non;#non;#non;#non;#non;#non;#non');
						break;
                }
                if(t_func.indexOf('qtxt.query.signhide_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signhide_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert(as[0].t_err);
					}else{
						alert('隱藏簽核失敗!!');
					}
					//重新載入資料
					q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name+';'+r_rank+';#non;#non;#non;#non;#non;#non;#non');
                }
                if(t_func.indexOf('qtxt.query.signrestart_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signrestart_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert(as[0].t_err);
					}else{
						alert('重送簽核失敗!!');
					}
					//重新載入資料
					q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name+';'+r_rank+';#non;#non;#non;#non;#non;#non;#non');
                }
                if(t_func.indexOf('qtxt.query.signok')>-1){
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert(as[0].t_err);
					}else{
						alert('簽核核准失敗!!');
					}
					$('#txtSignmemo').val('');
					$('#txtSignnoa').val('');
					$('#txtSignnoq').val('');
					$('#btnSignflie').val('');
					$('#txtSignfilememo').val('');
					$('#txtSigntypea').val('');
					$('#issignok_div').hide();
					//重新載入資料
					q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name+';'+r_rank+';#non;#non;#non;#non;#non;#non;#non');
                }
                if(t_func.indexOf('qtxt.query.signbreak_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signbreak_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert(as[0].t_err);
					}else{
						alert('簽核退回失敗!!');
					}
					//重新載入資料
					q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name+';'+r_rank+';#non;#non;#non;#non;#non;#non;#non');
                }
                if(t_func.indexOf('qtxt.query.signdetail_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signdetail_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						var rowslength=document.getElementById("signdetail_table").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("signdetail_table").deleteRow(1);
						}
						
						for (var i = 0; i < as.length; i++) {
							var tr = document.createElement("tr");
							tr.id = "sd_"+i;
							tr.innerHTML = "<td align='center'>"+as[i].namea+"</td>";
							tr.innerHTML += "<td align='center'>"+as[i].act+"</td>";
							tr.innerHTML += "<td align='center'>"+as[i].status+"</td>";
							tr.innerHTML += "<td>"+as[i].memo+"</td>";
							var tmp = document.getElementById("detail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						$('#signdetail_div').css('top',$('#eiprunsign_noa'+n).offset().top+30);
						$('#signdetail_div').css('left',$('#eiprunsign_noa'+n).offset().left+150);
						$('#signdetail_div').show();
					}
                }
                
                if(t_func.indexOf('qtxt.query.signsdetail_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signsdetail_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						var rowslength=document.getElementById("signdetail_table").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("signdetail_table").deleteRow(1);
						}
						
						for (var i = 0; i < as.length; i++) {
							var tr = document.createElement("tr");
							tr.id = "sd_"+i;
							tr.innerHTML = "<td align='center'>"+as[i].namea+"</td>";
							tr.innerHTML += "<td align='center'>"+as[i].act+"</td>";
							tr.innerHTML += "<td align='center'>"+as[i].status+"</td>";
							tr.innerHTML += "<td>"+as[i].memo+"</td>";
							var tmp = document.getElementById("detail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						$('#signdetail_div').css('top',$('#eiprunssign_noa'+n).offset().top+30);
						$('#signdetail_div').css('left',$('#eiprunssign_noa'+n).offset().left+150);
						$('#signdetail_div').show();
					}
                }
                
                if(t_func.indexOf('qtxt.query.signtdetail_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signtdetail_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						var rowslength=document.getElementById("signdetail_table").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("signdetail_table").deleteRow(1);
						}
						
						for (var i = 0; i < as.length; i++) {
							var tr = document.createElement("tr");
							tr.id = "sd_"+i;
							tr.innerHTML = "<td align='center'>"+as[i].namea+"</td>";
							tr.innerHTML += "<td align='center'>"+as[i].act+"</td>";
							tr.innerHTML += "<td align='center'>"+as[i].status+"</td>";
							tr.innerHTML += "<td>"+as[i].memo+"</td>";
							var tmp = document.getElementById("detail_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						$('#signdetail_div').css('top',$('#eiprunusign_noa'+n).offset().top+30);
						$('#signdetail_div').css('left',$('#eiprunusign_noa'+n).offset().left+150);
						$('#signdetail_div').show();
					}
                }
                if(t_func.indexOf('eip.wordConvert.files_')>-1){
                	var n=replaceAll(t_func,'eip.wordConvert.files_','');
                	var extindex = $('#eipform_files'+n).text().lastIndexOf('.');
					if(extindex>=0){
						ext = $('#eipform_files'+n).text().substring(extindex,$('#eipform_files'+n).text().length);
					}
					
					var filename=replaceAll($('#eipform_files'+n).text(),ext,'');
					var s1 = location.href;
					var t_path = (s1.substr(7, 5) == 'local' ? xlsPath : s1.substr(0, s1.indexOf('/', 10)) + '/'+q_db+'z/');
					window.open(t_path + "eipform_read.aspx?files="+filename, "_blank", 'directories=no,location=no,menubar=no,resizable=1,scrollbars=1,status=0,toolbar=1');
                }
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			
			#eiprunsign_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #eiprunsign_table tr {
                height: 30px;
            }
            #eiprunsign_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                color: black;
            }
            #eiprunsign_header td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: blue;
                color: white;
            }
            #eiprunsign_table tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
            
            #eiprunssign_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #eiprunssign_table tr {
                height: 30px;
            }
            #eiprunssign_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                color: black;
            }
            #eiprunssign_header td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: blue;
                color: white;
            }
            #eiprunssign_table tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
			
			#eipruntsign_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #eipruntsign_table tr {
                height: 30px;
            }
            #eipruntsign_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                color: black;
            }
            #eipruntsign_header td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: blue;
                color: white;
            }
            #eipruntsign_table tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
			
			
			#eiprunusign_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #eiprunusign_table tr {
                height: 30px;
            }
            #eiprunusign_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                color: black;
            }
            #eiprunusign_header td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: blue;
                color: white;
            }
            #eiprunusign_table tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
			
			#eipflowsign_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #eipflowsign_table tr {
                height: 30px;
            }
            #eipflowsign_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                color: black;
            }
            #eipflowsign_header td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: blue;
                color: white;
            }            
            #eipflowsign_table tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
            
            
			#eipform_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #eipform_table tr {
                height: 30px;
            }
            #eipform_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                color: black;
            }
            #eipform_header td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: blue;
                color: white;
            }            
            #eipform_table tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
			
            ul, li {
				margin: 0;
				padding: 0;
				list-style: none;
			}
			.eip_tab {
				clear: left;
				width: 100%;
			}
			ul.tabs {
				width: 100%;
				height: 32px;
				/*border-bottom: 1px solid #999;*/
				border-left: 1px solid #999;
			}
			ul.tabs li {
				float: left;
				height: 31px;
				line-height: 31px;
				overflow: hidden;
				position: relative;
				margin-bottom: -1px;
				border: 1px solid #999;
				border-left: none;
				background: #e1e1e1;
			}
			ul.tabs li a {
				display: block;
				padding: 0 20px;
				color: #000;
				border: 1px solid #fff;
				text-decoration: none;
			}
			ul.tabs li a:hover {
				background: #ccc;
			}
			ul.tabs li.active  {
				background: #fff;
				border-bottom: 1px solid#fff;
			}
			ul.tabs li.active a:hover {
				background: #fff;
			}
			div.tab_container {
				clear: left;
				width: 100%;
				/*border: 1px solid #999;*/
				border-top: none;
				background: #fff;
			}
			div.tab_container .tab_content {
				padding: 20px;
			}
			div.tab_container .tab_content h2 {
				margin: 0 0 20px;
			}
			
			#downloaddetail_table tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
		</style>
	</head>
	<body style="background: lightcyan;">
		<div id='q_menu'> </div>
		<div id='q_acDiv'> </div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>
		<a id='logout' class="lbl" style="color: coral;cursor: pointer;font-weight: bolder;float: right;">登出</a>
		<BR><BR>
		
		<!--<input id="btnNosign" type="button" style="font-size: 18px;" value="草稿">
		<input id="btnIssign" type="button" style="font-size: 18px;" value="簽核中">
		<input id="btnWaitsign" type="button" style="font-size: 18px;" value="待簽核">
		<input id="btnWorksign" type="button" style="font-size: 18px;" value="交辦">
		<input id="btnTalksign" type="button" style="font-size: 18px;" value="知會">-->
		
		<div class="eip_tab">
			<ul class="tabs">
				<li><a id="nosign_tab" href="#nosign_div">草稿</a></li>
				<li><a id="issig_tab" href="#issign_div">簽核中</a></li>
				<li><a id="waitsign_tab" href="#waitsign_div">待簽核</a></li>
				<li><a id="worksign_tab" href="#worksign_div">交辦</a></li>
				<li><a id="talksign_tab" href="#talksign_div">知會</a></li>
				<li><a id="form_tab" href="#form_div">已存檔表單</a></li>
			</ul>
			<div class="tab_container" style="background: lightcyan;">
				<div id="nosign_div" style="display: none;text-align: center;" class="signdiv" >
					<!--<a style="color: blue;font-size: 20px;font-weight: bold;">草稿</a>-->
					<div id="eipflow"> </div> 
					<br>
					<div id="eipflow_control"> </div>
				</div>
				<div id="issign_div" style="text-align: center;" class="signdiv">
					<!--<a style="color: blue;font-size: 20px;font-weight: bold;">簽核中</a>-->
					<div id="eiprun"> </div> 
					<br>
					<div id="eiprun_control" style="float: left;"> </div>
					<div id="eiprun_search" style="float: left;">
						<table style="width: 1150px;">
							<tr>
								<td style="width: 70px;">發文日期</td>
								<td><input id="seiprun_bdate" type="text" style="width: 80px;">~<input id="seiprun_edate" type="text" style="width: 80px;"></td>
								<td style="width: 70px;">簽核單號</td>
								<td><input id="seiprun_noa" type="text" style="width: 100px;"></td>
								<td style="width: 70px;">重要性</td>
								<td><select id="seiprun_important" style="font-size: medium;"><option value="#non">全部</option><option value="普通">普通</option><option value="重要">重要</option><option value="很重要">很重要</option></select></td>
								<td style="width: 70px;">結案</td>
								<td><select id="seiprun_enda" style="font-size: medium;"><option value="0">未結案</option><option value="1">結案</option><option value="#non">全部</option></select></td>
								<td style="width: 70px;">發文者</td>
								<td><input id="seiprun_sssno" type="text" style="width: 100px;"><input id="seiprun_namea" type="text" style="width: 100px;" disabled="disabled"></td>
								<td><input id="btnEiprun_search" type="button" value="查詢"></td>
							</tr>
						</table>
					</div>
				</div>
				<div id="waitsign_div" style="display: none;text-align: center;" class="signdiv">
					<!--<a style="color: blue;font-size: 20px;font-weight: bold;">待簽核</a>-->
					<div id="eipruns"> </div> 
					<br>
					<div id="eipruns_control"> </div>
				</div>
				<div id="worksign_div" style="display: none;text-align: center;" class="signdiv">
					<!--<a style="color: blue;font-size: 20px;font-weight: bold;">交辦</a>-->
					<div id="eiprunu"> </div> 
					<br>
					<div id="eiprunu_control"> </div>
				</div>
				<div id="talksign_div" style="display: none;text-align: center;" class="signdiv">
					<!--<a style="color: blue;font-size: 20px;font-weight: bold;">知會</a>-->
					<div id="eiprunt"> </div> 
					<br>
					<div id="eiprunt_control"> </div>
				</div>
				<div id="form_div" style="display: none;text-align: center;" class="signdiv">
					<!--<a style="color: blue;font-size: 20px;font-weight: bold;">已存檔表單</a>-->
					<div id="eipform"> </div> 
					<br>
					<div id="eipform_control"> </div>
				</div>
				<div id="issignok_div" style="position:absolute; top:300px; left:400px;width:300px;;display: none;" class="signdiv">
					<table style="width:100%;background-color:aliceblue" border="1" cellpadding='2'  cellspacing='0'>
						<tr>
							<td style="width: 130px;" align="center">意見</td>
							<td style="width: 170px;" align="center">
								<input id="txtSignmemo" type="text" style="width: 98%;">
								<input id="txtSignnoa" type="hidden">
								<input id="txtSignnoq" type="hidden">
							</td>
						</tr>
						<tr>
							<td align="center">附加文件</td>
							<td align="left"><input id="btnSignflie" type="file" value="選擇檔案" style="width: 100%;"></td>
						</tr>
						<tr>
							<td align="center">附加文件說明</td>
							<td align="left"><input id="txtSignfilememo" type="text" style="width: 98%;"></td>
						</tr>
						<tr>
							<td align="center" colspan='2'>
								<input id="btnSignok" type="button" value="確認">
								<input id="btnSignclose" type="button" value="取消">
								<input id="txtSigntypea" type="hidden">
							</td>
						</tr>
					</table>
				</div>
				<div id="issignadd_div" style="position:absolute; top:300px; left:400px;width:300px;;display: none;" class="signdiv">
					<table style="width:100%;background-color:aliceblue" border="1" cellpadding='2'  cellspacing='0'>
						<tr>
							<td style="width: 130px;" align="center">加簽人員編號</td>
							<td style="width: 170px;" align="center">
								<input id="txtAddsno" type="text" style="width: 98%;">
								<input id="txtAddnoa" type="hidden">
								<input id="txtAddnoq" type="hidden">
							</td>
						</tr>
						<tr>
							<td align="center">加簽人員姓名</td>
							<td align="center"><input id="txtAddnamea" type="text" style="width: 98%;"></td>
						</tr>
						<tr>
							<td align="center">加簽原因</td>
							<td align="center"><input id="txtAddmemo" type="text" style="width: 98%;"></td>
						</tr>
						<tr>
							<td align="center">回傳確認</td>
							<td align="left"><input id="txtAddisreturn" type="checkbox"></td>
						</tr>
						<tr>
							<td align="center">附加文件</td>
							<td align="left"><input id="btnAddflie" type="file" value="選擇檔案" style="width: 100%;"></td>
						</tr>
						<tr>
							<td align="center">附加文件說明</td>
							<td align="left"><input id="txtAddfilememo" type="text" style="width: 98%;"></td>
						</tr>
						<tr>
							<td align="center" colspan='2'>
								<input id="btnAddok" type="button" value="加簽">
								<input id="btnAddclose" type="button" value="取消">
							</td>
						</tr>
					</table>
				</div>
				<div id="signdetail_div" style="position:absolute; top:300px; left:400px;width:500px;;display: none;" class="signdiv">
					<table id="signdetail_table" style="width:100%;background-color:aliceblue" border="1" cellpadding='2'  cellspacing='0'>
						<tr id='detail_top'>
							<td style="width: 150px;background-color: lightskyblue;color: white;" align="center">簽核人員</td>
							<td style="width: 60px;background-color: lightskyblue;color: white;" align="center">動作</td>
							<td style="width: 60px;background-color: lightskyblue;color: white;" align="center">決定</td>
							<td style="width: 230px;background-color: lightskyblue;color: white;" align="center">意見</td>
						</tr>
						<tr id='detail_close'>
							<td align="center" colspan='4'>
								<input id="btnSignDetailClose" type="button" value="關閉">
							</td>
						</tr>
					</table>
				</div>
				<div id="downloaddetail_div" style="position:absolute; top:300px; left:400px;width:500px;;display: none;" class="signdiv">
					<table id="downloaddetail_table" style="width:100%;background-color:aliceblue" border="1" cellpadding='2'  cellspacing='0'>
						<tr id='downloaddetail_top'>
							<td style="width: 100px;background-color: lightskyblue;color: white;" align="center">附加人員</td>
							<td style="width: 150px;background-color: lightskyblue;color: white;" align="center">附加檔案</td>
							<td style="width: 250px;background-color: lightskyblue;color: white;" align="center">附加說明</td>
						</tr>
						<tr id='downloaddetail_close'>
							<td align="center" colspan='4'>
								<input id="btnDownloaddetailClose" type="button" value="關閉">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
	</body>
</html>