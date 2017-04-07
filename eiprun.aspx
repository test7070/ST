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
			aPop = new Array(['txtAddsno', '', 'sss', 'noa,namea', 'txtAddsno,txtAddnamea', 'sss_b.aspx']);
			
			function eiprunsign() {};
			
            eiprunsign.prototype = {
                data : null,
                tbCount : 20,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='eiprunsign_table'>";
                    string+='<tr id="eiprunsign_header">';
                    string+='<td id="eiprunsign_hide" align="center" style="width:55px;display:none;"></td>';
                    string+='<td id="eiprunsign_datea" onclick="eiprunsign.sort(\'datea\',false)" title="簽核日期" align="center" style="width:100px; ">簽核日期</td>';
                    string+='<td id="eiprunsign_noa" onclick="eiprunsign.sort(\'noa\',false)" title="簽核單號" align="center" style="width:120px;">簽核單號</td>';
                    string+='<td id="eiprunsign_memo" onclick="eiprunsign.sort(\'memo\',false)" title="簽核內容" align="center" style="width:350px; ">簽核內容</td>';
                    string+='<td id="eiprunsign_astatus" onclick="eiprunsign.sort(\'astatus\',false)" title="狀態" align="center" style="width:200px;">簽核狀態</td>';
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
                        string+='<td id="eiprunsign_noa'+i+'" class="eiprunsignnoa" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunsign_memo'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunsign_astatus'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunsign_schedule'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunsign_bnamea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunsign_act'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='</tr>';
                    }
                    string+='</table>';
                    
                    $('#eiprun').append(string);
                    string='';
                    string+='<input id="btneiprunsign_previous" onclick="eiprunsign.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string+='<input id="btneiprunsign_next" onclick="eiprunsign.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string+='<input id="textEiprunCurPage" onchange="eiprunsign.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
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
                            $('#eiprunsign_schedule' + i).text(this.data[n+i]['schedule']);
                            
                        } else {
                            $('#btnEipsignHide_' + i).attr('disabled', 'disabled');
                            $('#eiprunsign_datea' + i).text('');
                            $('#eiprunsign_memo' + i).text('');
                            $('#eiprunsign_astatus' + i).text('');
                            $('#eiprunsign_bnamea' + i).text('');
                            $('#eiprunsign_act' + i).text('');
                            $('#eiprunsign_noa' + i).text('');
                            $('#eiprunsign_schedule' + i).text('');
                        }
                    }
                }
            };
            
            function eiprunssign() {};
			
            eiprunssign.prototype = {
                data : null,
                tbCount : 20,
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
                    string+='<td id="eiprunssign_datea" onclick="eiprunsign.sort(\'datea\',false)" title="簽核日期" align="center" style="width:100px; ">簽核日期</td>';
                    string+='<td id="eiprunsign_noa" onclick="eiprunsign.sort(\'noa\',false)" title="簽核單號" align="center" style="width:150px;">簽核單號</td>';
                    string+='<td id="eiprunssign_namea" onclick="eiprunsign.sort(\'namea\',false)" title="發文者" align="center" style="width:100px; ">發文者</td>';
                    string+='<td id="eiprunssign_memo" onclick="eiprunsign.sort(\'memo\',false)" title="簽核內容" align="center" style="width:350px; ">簽核內容</td>';
                    string+='<td id="eiprunssign_file" title="附件" align="center" style="width:50px; ">附件</td>';
                    string+='</tr>';
                    
                    var t_color = ['white','aliceblue'];
                    for(var i=0;i<this.tbCount;i++){
                        string+='<tr id="eiprunssign_tr'+i+'">';
                        string+='<td id="eiprunssign_signok'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eiprunsign_ok" id="btnEipsignOk_'+i+'" type="button" value="核準" style=" width: 50px;" /></td>';
                        string+='<td id="eiprunssign_signadd'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eiprunsign_add" id="btnEipsignAdd_'+i+'" type="button" value="加簽" style=" width: 50px;" /></td>';
                        string+='<td id="eiprunssign_signbreak'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"><input class="eiprunsign_break" id="btnEipsignBreak_'+i+'" type="button" value="退回" style=" width: 50px;" /></td>';
                        string+='<td id="eiprunssign_datea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunssign_noa'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunssign_noq'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                        string+='<td id="eiprunssign_namea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunssign_memo'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunssign_file'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="eiprunssign_filename'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                        string+='<td id="eiprunssign_files'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+';display:none;"></td>';
                        string+='</tr>';
                    }
                    string+='</table>';
                    
                    $('#eipruns').append(string);
                    string='';
                    string+='<input id="btneiprunssign_previous" onclick="eiprunssign.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string+='<input id="btneiprunssign_next" onclick="eiprunssign.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string+='<input id="textEiprunsCurPage" onchange="eiprunssign.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
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
						var tmemo='#non';
						
						var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						
						if(confirm("確定要核准【"+$('#eiprunssign_noa'+n).text()+"】簽核?"))
							q_func('qtxt.query.signok_'+n, 'eip.txt,signok,'+$('#eiprunssign_noa'+n).text()+';'+$('#eiprunssign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate);
					});
					
					$('.eiprunsign_break').unbind('click');
					$('.eiprunsign_break').click(function(e) {
                        var n=$(this).attr('id').replace('btnEipsignBreak_','')
                        
                        if($('#eiprunssign_noa'+n).text()=='' && $('#eiprunssign_noq'+n).text()=='')
							return;
							
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
						
						$('#issignadd_div').show();
						$('#issignadd_div').css('top',e.pageY);
						$('#issignadd_div').css('left',e.pageX);
						$('#txtAddnoa').val($('#eiprunssign_noa'+n).text());
						$('#txtAddnamea').val($('#eiprunssign_noq'+n).text());
						
						/*var tmemo='#non';
						var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						
						if(confirm("確定要加簽【"+$('#eiprunssign_noa'+n).text()+"】簽核?"))
							q_func('qtxt.query.signok_'+n, 'eip.txt,signok,'+$('#eiprunssign_noa'+n).text()+';'+$('#eiprunssign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate);
						*/
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
                            if(this.data[n+i]['filename'].length>0){
                            	t_filehtml="<a id='lblDownload_"+n+"' class='lbl btn signdownload'>下載</a>";
                            }
                            $('#eiprunssign_file' + i).html(t_filehtml);
                            $('#eiprunssign_filename' + i).text(this.data[n+i]['filename']);
                            $('#eiprunssign_files' + i).text(this.data[n+i]['files']);
                            $('#eiprunssign_noa' + i).text(this.data[n+i]['noa']);
                            $('#eiprunssign_noq' + i).text(this.data[n+i]['noq']);
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
                        }
                    }
                    
                    $('.signdownload').unbind('click');
                    $('.signdownload').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownload_','')
                        
						if($('#eiprunssign_filename'+n).text().length>0 && $('#eiprunssign_files'+n).text().length>0)
							$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#eiprunssign_filename'+n).text()+'&TempName='+$('#eiprunssign_files'+n).text());
							
					});
                }
            };
            
            function eipruntsign() {};
			
            eipruntsign.prototype = {
                data : null,
                tbCount : 20,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='eipruntsign_table'>";
                    string+='<tr id="eipruntsign_header">';
                    string+='<td id="eipruntsign_signok" title="確認" align="center" style="width:55px;">確認</td>';
                    string+='<td id="eipruntsign_datea" onclick="eiprunsign.sort(\'datea\',false)" title="簽核日期" align="center" style="width:100px; ">簽核日期</td>';
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
                    string+='<input id="textEipruntCurPage" onchange="eipruntsign.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
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
							q_func('qtxt.query.signok_'+n, 'eip.txt,signok,'+$('#eipruntsign_noa'+n).text()+';'+$('#eipruntsign_noq'+n).text()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate);
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
                            if(this.data[n+i]['filename'].length>0){
                            	t_filehtml="<a id='lblDownload_"+n+"' class='lbl btn signtdownload'>下載</a>";
                            }
                            $('#eipruntsign_file' + i).html(t_filehtml);
                            $('#eipruntsign_filename' + i).text(this.data[n+i]['filename']);
                            $('#eipruntsign_files' + i).text(this.data[n+i]['files']);
                            $('#eipruntsign_noa' + i).text(this.data[n+i]['noa']);
                            $('#eipruntsign_noq' + i).text(this.data[n+i]['noq']);
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
                        }
                    }
                    
                    $('.signtdownload').unbind('click');
                    $('.signtdownload').click(function(e) {
                        var n=$(this).attr('id').replace('lblDownload_','')
                        
						if($('#eipruntsign_filename'+n).text().length>0 && $('#eipruntsign_files'+n).text().length>0)
							$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#eipruntsign_filename'+n).text()+'&TempName='+$('#eipruntsign_files'+n).text());
							
					});
                }
            };
            
            function eipflowsign() {};
			
            eipflowsign.prototype = {
                data : null,
                tbCount : 20,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='eipflowsign_table'>";
                    string+='<tr id="eipflowsign_header">';
                    string+='<td id="eipflowsign_datea" onclick="eipflowsign.sort(\'datea\',false)" title="建檔日期" align="center" style="width:100px; ">建檔日期</td>';
                    string+='<td id="eipflowsign_noa" onclick="eipflowsign.sort(\'noa\',false)" title="簽核單號" align="center" style="width:120px;">簽核單號</td>';
                    string+='<td id="eipflowsign_memo" onclick="eipflowsign.sort(\'memo\',false)" title="簽核內容" align="center" style="width:350px; ">簽核內容</td>';
                    string+='<td id="eipflowsign_file" title="附件" align="center" style="width:50px; ">附件</td>';
                    string+='</tr>';
                    
                    var t_color = ['white','aliceblue'];
                    for(var i=0;i<this.tbCount;i++){
                        string+='<tr id="eipflowsign_tr'+i+'">';
                        string+='<td id="eipflowsign_datea'+i+'" style="text-align: center;background-color:'+t_color[i%t_color.length]+'"></td>';
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
                    string+='<input id="textEipflowCurPage" onchange="eipflowsign.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
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
                            	t_filehtml="<a id='lblDownload_"+n+"' class='lbl btn signflowdownload'>下載</a>";
                            }
                            $('#eipflowsign_file' + i).html(t_filehtml);
                            $('#eipflowsign_filename' + i).text(this.data[n+i]['filename']);
                            $('#eipflowsign_files' + i).text(this.data[n+i]['files']);
                            
                        } else {
                            $('#eipflowsign_datea' + i).text('');
                            $('#eipflowsign_memo' + i).text('');
                            $('#eipflowsign_noa' + i).text('');
                            $('#eipflowsign_file' + i).html('');
                            $('#eipflowsign_filename' + i).text('');
                            $('#eipflowsign_files' + i).text('');
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
            
            eiprunsign = new eiprunsign();
            eiprunssign = new eiprunssign();
            eipruntsign = new eipruntsign();
            eipflowsign = new eipflowsign();
            
			$(document).ready(function() {
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
                
                eiprunsign.load();
                eiprunssign.load();
                eipruntsign.load();
                eipflowsign.load();
			});
			
			function q_gfPost() {
				q_getFormat();
                q_langShow();
                q_popAssign();
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
				
				//載入初始資料
				q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name);
				
				
				
				$('#btnAddok').click(function() {
					if(!emp($('#txtAddnoa').val()) && !emp($('#txtAddnoq').val())){
						if(!emp($('#txtAddsno').val())){
							var tmemo='#non';
							var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
							var t_isreturn=$('#txtAddisreturn').prop('checked').toString();
							var t_namea=$('#txtAddnamea').val();
							if(t_namea.length==0)
								var t_namea='#non';
								
							if(confirm("確定要核准【"+$('#txtAddnoa').val()+"】簽核，並加簽給"+$('#txtAddnamea').val()+"?"))
								q_func('qtxt.query.signadd_'+n, 'eip.txt,signadd,'+$('#txtAddnoa').val()+';'+$('#txtAddnoq').val()+';'+tmemo+';'+r_userno+';'+r_name+';'+tdate
								+';'+$('#txtAddsno').val()+';'+t_namea+';'+t_isreturn);
							
							
							$('#txtAddsno').val('');
							$('#txtAddnamea').val('');
						}else{
							alert('加簽人員編號禁止空白!!');
						}
					}
				});
				
				$('#btnAddclose').click(function() {
					$('#txtAddsno').val('');
					$('#txtAddnamea').val('');
					$('#issignadd_div').hide();
				});
            }
            
            function q_gtPost(t_name) {
				switch (t_name) {
					case 'eipflow':
						var as = _q_appendData("eipflow", "", true);
                        eipflowsign.init(as);
                        if(as.length>0){
                        	$('#btnNosign').val('草稿('+as.length+')');
                        }else{
                        	$('#btnNosign').val('草稿');
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
                        	for(var i=0; i<as.length;i++){
                        		if(as[i].typea=='1'){
                        			a_eiprunsign.push(as[i]);
                        		}else if(as[i].typea=='2'){
                        			a_eiprunssign.push(as[i]);
                        		}else{
                        			a_eipruntsign.push(as[i])
                        		}
                        	}
                        	eiprunsign.init(a_eiprunsign);
                        	if(a_eiprunsign.length>0){
                        		$('#btnIssign').val('簽核中('+a_eiprunsign.length+')');
                        	}else{
                        		$('#btnIssign').val('簽核中');
                        	}
                        	eiprunssign.init(a_eiprunssign);
                        	if(a_eiprunssign.length>0){
                        		$('#btnWaitsign').val('待簽核('+a_eiprunssign.length+')');
                        	}else{
                        		$('#btnWaitsign').val('待簽核');
                        	}
                        	eipruntsign.init(a_eipruntsign);
                        	if(a_eipruntsign.length>0){
                        		$('#btnTalksign').val('知會/交辦('+a_eipruntsign.length+')');
                        	}else{
                        		$('#btnTalksign').val('知會/交辦');
                        	}
                        }
                        
                        q_gt('eipflow', 'where=^^issign=0^^', 0, 0, 0, "");
                        
                      break;
                }
                if(t_func.indexOf('qtxt.query.signhide_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signhide_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert(as[0].t_err);
						//重新載入資料
						q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name);
					}else{
						alert('隱藏簽核失敗!!');
					}
                }
                if(t_func.indexOf('qtxt.query.signrestart_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signrestart_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert(as[0].t_err);
						//重新載入資料
						q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name);
					}else{
						alert('重送簽核失敗!!');
					}
                }
                if(t_func.indexOf('qtxt.query.signok_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signok_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert(as[0].t_err);
						//重新載入資料
						q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name);
					}else{
						alert('簽核核准失敗!!');
					}
                }
                if(t_func.indexOf('qtxt.query.signbreak_')>-1){
                	var n=replaceAll(t_func,'qtxt.query.signbreak_','');
                	var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						alert(as[0].t_err);
						//重新載入資料
						q_func('qtxt.query.eipsign', 'eip.txt,sign,'+r_userno+';'+r_name);
					}else{
						alert('簽核退回失敗!!');
					}
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
            
		</style>
	</head>
	<body style="background: lightcyan;">
		<div id='q_menu'> </div>
		<div id='q_acDiv'> </div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>
		<a id='logout' class="lbl" style="color: coral;cursor: pointer;font-weight: bolder;float: right;">登出</a>
		<BR>
		<input id="btnNosign" type="button" value="草稿">
		<input id="btnIssign" type="button" value="簽核中">
		<input id="btnWaitsign" type="button" value="待簽核">
		<input id="btnTalksign" type="button" value="知會">
		<div id="nosign_div" style="display: none;text-align: center;" class="signdiv" >
			<a style="color: blue;font-size: 20px;font-weight: bold;">草稿</a>
			<div id="eipflow" style="float:left;width:100%;height:750px;overflow:auto;position: relative;"> </div> 
			<div id="eipflow_control" style="width:100%;float: left;"> </div>
		</div>
		<div id="issign_div" style="text-align: center;" class="signdiv">
			<a style="color: blue;font-size: 20px;font-weight: bold;">送審簽核</a>
			<div id="eiprun" style="float:left;width:100%;height:750px;overflow:auto;position: relative;"> </div> 
			<div id="eiprun_control" style="width:100%;float: left;"> </div>
		</div>
		<div id="waitsign_div" style="display: none;text-align: center;" class="signdiv">
			<a style="color: blue;font-size: 20px;font-weight: bold;">待簽核</a>
			<div id="eipruns" style="float:left;width:100%;height:750px;overflow:auto;position: relative;"> </div> 
			<div id="eipruns_control" style="width:100%;float: left;"> </div>
		</div>
		<div id="talksign_div" style="display: none;text-align: center;" class="signdiv">
			<a style="color: blue;font-size: 20px;font-weight: bold;">知會/交辦</a>
			<div id="eiprunt" style="float:left;width:100%;height:750px;overflow:auto;position: relative;"> </div> 
			<div id="eiprunt_control" style="width:100%;float: left;"> </div>
		</div>
		<div id="issignadd_div" style="position:absolute; top:300px; left:400px;width:300px;;display: none;" class="signdiv">
			<table style="width:100%;background-color:aliceblue" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="width: 150px;" align="center">加簽人員編號</td>
					<td style="width: 150px;" align="center">
						<input id="txtAddsno" type="text" style="width: 98%;">
						<input id="txtAddnoa" type="hidden">
						<input id="txtAddnoq" type="hidden">
					</td>
				</tr>
				<tr>
					<td align="center">加簽人員姓名</td>
					<td align="center"><input id="txtAddnamea" type="text"  style="width: 98%;"></td>
				</tr>
				
				<tr>
					<td align="center">回傳確認</td>
					<td align="left"><input id="txtAddisreturn" type="checkbox"></td>
				</tr>
				<tr>
					<td align="center" colspan='2'>
						<input id="btnAddok" type="button" value="加簽">
						<input id="btnAddclose" type="button" value="取消">
					</td>
				</tr>
			</table>
		</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
	</body>
</html>