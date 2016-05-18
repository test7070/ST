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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message)
			}

			q_tables = 's';
			var q_name = "modfixcs";
			var q_readonly = ['txtNoa', 'txtModnoa', /*'txtMech',*/ 'txtWorker', 'txtWorker2'
			,'textNob','textCode','textDetail'];
			var q_readonlys = ['txtNob','txtCode','txtDetail'];
			var bbmNum = [];
			var bbsNum = [['txtWeight',15,1,1], ['txtMount',15,0,1], ['txtFixmount',15,0,1], ['txtBottom',15,2,1], ['txtBebottom',15,2,1], ['txtEnbottom',15,2,1], 
						  ['txtLastloss',15,1,1], ['txtLoss',15,1,1], ['txtBrepair',15,1,1], ['txtErepair',15,1,1]];
			var bbmMask = [];
			var bbsMask = [];
			var pNoq =1;
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 3;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			q_desc = 1;
					
			aPop = new Array(		
			
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}
			
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea',r_picd],
							['textBdate',r_picd],['textEdate',r_picd],['textBtime','99:99'],['textEtime','99:99'],
							['textBdate2',r_picd],['textEdate2',r_picd],['textBtime2','99:99'],['textEtime2','99:99'],
							['textBdate3',r_picd],['textEdate3',r_picd],['textBtime3','99:99'],['textEtime3','99:99'],
							['textBdate4',r_picd],['textEdate4',r_picd],['textBtime4','99:99'],['textEtime4','99:99']
				];
				q_mask(bbmMask);				
				bbsMask = [['txtBdate',r_picd],['txtEdate',r_picd],['txtBtime','99:99'],['txtEtime','99:99'],
						   ['txtBdate2',r_picd],['txtEdate2',r_picd],['txtBtime2','99:99'],['txtEtime2','99:99'],
						   ['txtBdate3',r_picd],['txtEdate3',r_picd],['txtBtime3','99:99'],['txtEtime3','99:99'],
						   ['txtBdate4',r_picd],['txtEdate4',r_picd],['txtBtime4','99:99'],['txtEtime4','99:99']];
				
				var t_way=',傳統車床(研磨),CNC車修';
				var t_worktype=',正工,加班';
					
				
				$('#btnIn').click(function(){				
					if(!emp($('#txtInnoa').val()) && (q_cur == 1 || q_cur == 2)){
						//q_gt('modfix', "where=^^noa='"+$('#txtInnoa').val()+"'^^", 0, 0, 0, "ins_modfixs");
						
						//1050225 判斷是否已領用 有可能會直接入庫後直接領料不會維修
						q_gt('modout', "where=^^fixnoa='"+$('#txtInnoa').val()+"' ^^", 0, 0, 0, "check_modout",r_accy,1);
						var as = _q_appendData("modout", "", true);
						if (as[0] != undefined) {
							alert('模具入庫單【'+$('#txtInnoa').val()+'】已領用【'+as[0].noa+'】!!');
							return;
						}
						//1050224 用load 處理
						var t_where="where=^^a.noa='"+$('#txtInnoa').val()+"' order by a.nob^^"
						var t_where1="where[1]=^^nob=a.nob and noa!='"+$('#txtNoa').val()+"' and datea<'"+$('#txtDatea').val()+"'^^"
						q_gt('modfixc_modfixs', t_where+t_where1, 0, 0, 0, "modfixc_modfixs",r_accy,1);
						
						var as = _q_appendData("modfixs", "", true);
						//清除表身
						for(var i=0; i<q_bbsCount; i++){
							$('#btnMinus_'+i).click();
						}
						q_gridAddRow(bbsHtm, 'tbbs', 'txtNob,txtCode,txtDetail,txtFrame,txtMount,txtWeight,txtBottom,txtBebottom,txtBrepair,txtLastloss'
						, as.length, as, 'nob,code1,detail1,frame1,mount1,weight1,bottom,enbottom,erepair,loss', 'txtNob');
						
					}	
				});
				
				//結案若被勾選則不得再更動bbm資料
				$('#chkEnda').click(function(){				
					if($('#chkEnda').prop("checked")){
						$("#txtInnoa").css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
						$("#txtMechno").css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
						$("#txtDatea").css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');					   
					}else{
						$("#txtInnoa").css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
						$("#txtMechno").css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
						$("#txtDatea").css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');						
					}
				});
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
			
			var t_indate = '';
			var t_data1 = new Array();
			var t_data2 = new Array();
			var t_data3 = new Array();
			function q_gtPost(t_name) {
				switch (t_name) {
					/*case 'ins_modfixs':
					var as = _q_appendData("modfixs", "", true);
					if (as[0] != undefined) {
							t_data1 = as;
					}
						var str = '';
						var isexist = 0;
						var pos = 0;
						for(var i=0; i<q_bbsCount; i++){//bbs最後一列之行數
							if($('#txtNob_'+i).val().length>0)
								pos = i+1;
						}
						$.each(as, function(index, elm){//判斷modfixs.nob是否已存在於bbs內:isexist->y:1,n:0
							isexist = 0;
							for(var i=0; i<q_bbsCount ;i++){							
								if(elm.nob == $('#txtNob_'+i).val()){								
									isexist = 1;				
								}
							}
							if(isexist == 0){//bbs插入該筆未存在資料列													
								q_bbs_addrow('bbs',pos++,0);
								$('#txtNob_'+(pos-1)).val(elm.nob);
								$('#txtCode_'+(pos-1)).val(elm.code1);
								$('#txtDetail_'+(pos-1)).val(elm.detail1);
								$('#txtFrame_'+(pos-1)).val(elm.frame1);
								$('#txtMount_'+(pos-1)).val(elm.mount1);
								$('#txtWeight_'+(pos-1)).val(elm.weight1);
							}
						});
						sum();
						q_gt('modfixc', 0, 0, 0, 0, "modfixcs");
						break;
					case 'modfixcs':
						var as = _q_appendData("modfixcs", "", true);
						if (as[0] != undefined) {
							t_data2 = as;
						}
						q_gt('model', "where=^^noa='"+$('#txtModnoa').val()+"'^^", 0, 0, 0, "models");
						break;
					case 'models':
						var as = _q_appendData("models", "", true);
						if (as[0] != undefined) {
							t_data3 = as;
						}
						getLast();
						break;*/
					case 'modfix':
						var as = _q_appendData("modfix", "", true);
						if (as[0] != undefined) {
							t_indate = as[0].datea;
						}
						break;					
					case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                   		 break;  	
				}
			}
			
			//取前一次圖檔底徑、車修後底徑、磨耗作為本次圖檔底徑、車修前底徑、前次磨耗
			/*function getLast(){
				var btm,ebtm,erep,loss,noa;
			  	for(var i=0; i<t_data1.length; i++){	
			  		btm  = '';
			  		ebtm = '';
			  		erep = '';
			  		loss = '';
			  		noa  = '';		  		  		
			  		for(var j=0; j<t_data2.length; j++){//從modfixcs找相同nob且noa最大者視為前一次
			  			if(t_data1[i].nob==t_data2[j].nob && t_data2[j].noa>noa){		  				
			  				btm  = t_data2[j].bottom;
			  				ebtm = t_data2[j].enbottom;
			  				erep = t_data2[j].erepair;
			  				loss = t_data2[j].loss;
			  				noa  = t_data2[j].noa;
			  			}
			  		}//j-loop
			  		if(btm == ''){//若圖檔底徑為空則取models.bottom
			  			for(var j=0; j<t_data3.length; j++){
				  			if(t_data1[i].nob==t_data3[j].productno ){	  				
				  				btm  = t_data3[j].bottom;				  				
				  			}
				  		}//j-loop	
			  		}			  				  			
			  		$('#txtBottom_'+i).val(btm);
			  		$('#txtBebottom_'+i).val(ebtm);
			  		$('#txtBrepair_'+i).val(erep);
			  		$('#txtLastloss_'+i).val(loss);
			  	}//i-loop
			}*/
			
			function btnOk() {
				t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}			
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);	
				
				//檢查維修日期(modfixc.datea)>入庫日期(modfix.datea)?
				var t_date = trim($('#txtDatea').val());
				if(t_date < t_indate){
					alert('維修日期錯誤:\n　　維修日期('+t_date+')早於入庫日期('+t_indate+')');
					return;
				}			
				
				var t_noa = trim($('#txtNoa').val());
			    var t_date = trim($('#txtDatea').val());
			    if (t_noa.length == 0 || t_noa == "AUTO")
			    	q_gtnoa(q_name, replaceAll(q_getPara('sys.key_modfixc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
			    else
			    	wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('modfixc_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function changeWay(n,pos){
				var way = $('#cmbWay'+n+"_"+pos).val();
				$('#cmbMech'+n+"_"+pos).text('');
				switch(way){
					case "傳統車床(研磨)":
						q_cmbParse("cmbMech"+n+"_"+pos,'F01,F02,F03,F05,鑽床,銑床,插床');
						break;
					case "CNC車修":
						q_cmbParse("cmbMech"+n+"_"+pos,'G01,G02');	
						break;
					}	
			}
			
			function changecombWay(n){
				var way = $('#combWay'+n).val();
				$('#combMech'+n).text('');
				switch(way){
					case "傳統車床(研磨)":
						q_cmbParse("combMech"+n,'F01,F02,F03,F05,鑽床,銑床,插床');
						break;
					case "CNC車修":
						q_cmbParse("combMech"+n,'G01,G02');	
						break;
					}	
			}
			
			function sum() {		
				var innsum = 0;
				var fixsum = 0;
				for (var i=0; i<q_bbsCount; i++){
					innsum = innsum + dec($('#txtMount_'+i).val());
					fixsum = fixsum + dec($('#txtFixmount_'+i).val());
				}
				$('#textInnsum').val(innsum+' ');
				$('#textFixsum').val(fixsum+' ');			
			}
    		
			function bbsAssign() {
				//結案若被勾選則不得再更動bbs資料
				$('#chkEnda').click(function(){		
					if($('#chkEnda').prop("checked")){
						lockBbs();											    
					}else{		
						unlockBbs();									    									
					}	
				});
				$('#chkFixed').click(function(){		
					if($('#chkFixed').prop("checked")){
						for(var j = 0; j < q_bbsCount; j++)
							$('.ishide_'+j).show();										    
					}else{		
						for(var j = 0; j < q_bbsCount; j++){
							if(($('#txtMount_'+j).val()!="") && ($('#txtFixmount_'+j).val()!="") && ($('#txtFixmount_'+j).val()==$('#txtMount_'+j).val()))
								$('.ishide_'+j).hide();
						}									    									
					}	
				});
			
				for (var j = 0; j < q_bbsCount; j++) {
					//計算數量
					$('#txtMount_'+j).change(function(){
						sum();
					});
					//計算維修數量
					$('#txtFixmount_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if($('#txtFixmount_'+b_seq).val() > $('#txtMount_'+b_seq).val()){
							alert('維修數量大於入庫數量!');
							lock();
						}else{
							sum();
						}
					});
					
					//依據研磨方式改變機台選項
					changeWay("",j);
					changeWay("2",j);
					changeWay("3",j);
					changeWay("4",j);

					$('#cmbWay_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){
							changeWay("",b_seq);
						}	
					});
										
					$('#cmbWay2_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){
							changeWay("2",b_seq);
						}	
					});
					
					$('#cmbWay3_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){
							changeWay("3",b_seq);
						}	
					});
					
					$('#cmbWay4_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){
							changeWay("4",b_seq);
						}	
					});
					
					$('#cmbMech_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
					});
					
					$('#cmbMech2_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
					});
					
					//已維修(數量=維修數量)不顯示 2015/11/20
					if(($('#txtMount_'+j).val()!="") && ($('#txtFixmount_'+j).val()!="") && ($('#txtFixmount_'+j).val()==$('#txtMount_'+j).val()) && $('#chkFixed').prop("checked")==false){
						$('.ishide_'+j).hide();
					}
					
					//自動抓取第一筆資料 1050328 拿掉	
					/*$('#cmbWay_0').change(function(){
						$("#cmbMech_0").empty();
						changeWay("",0);					
						for (var i=1; i<q_bbsCount; i++){
							$('#cmbWay_'+i).val($('#cmbWay_0').val());
							$("#cmbMech_"+i).empty();
							changeWay("",i);
						}
					});
					$('#cmbWay2_0').change(function(){
						$("#cmbMech2_0").empty();
						changeWay("2",0);					
						for (var i=1; i<q_bbsCount; i++){
							$('#cmbWay2_'+i).val($('#cmbWay2_0').val());
							$("#cmbMech2_"+i).empty();
							changeWay("2",i);
						}
					});
					$('#txtBdate_0').blur(function(){	
						$('#txtEdate_0').val($('#txtBdate_0').val());			
						for (var i=1; i<q_bbsCount; i++){
							$('#txtBdate_'+i).val($('#txtBdate_0').val());
							$('#txtEdate_'+i).val($('#txtBdate_0').val());
						}
					});
					$('#txtBdate2_0').blur(function(){	
						$('#txtEdate2_0').val($('#txtBdate2_0').val());			
						for (var i=1; i<q_bbsCount; i++){
							$('#txtBdate2_'+i).val($('#txtBdate2_0').val());
							$('#txtEdate2_'+i).val($('#txtBdate2_0').val());
						}
					});			
					$('#txtWorker_0').change(function(){				
						for (var i=1; i<q_bbsCount; i++){
							$('#txtWorker_'+i).val($('#txtWorker_0').val());
						}
					});
					$('#txtWorker2_0').change(function(){				
						for (var i=1; i<q_bbsCount; i++){
							$('#txtWorker2_'+i).val($('#txtWorker2_0').val());
						}
					});*/
					
					//磨耗=補正前-補正後,車修後底徑=圖檔底徑+補正後
					$('#txtBrepair_'+j).change(function(){	
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;		
						$('#txtLoss_'+b_seq).val(q_sub($('#txtBrepair_'+b_seq).val(),$('#txtErepair_'+b_seq).val()));
					});
					$('#txtErepair_'+j).change(function(){	
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;		
						$('#txtLoss_'+b_seq).val(q_sub($('#txtBrepair_'+b_seq).val(),$('#txtErepair_'+b_seq).val()));
						$('#txtEnbottom_'+b_seq).val(q_add($('#txtBottom_'+b_seq).val(),$('#txtErepair_'+b_seq).val()));
					});
					$('#txtBottom_'+j).change(function(){	
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;		
						$('#txtEnbottom_'+b_seq).val(q_add($('#txtBottom_'+b_seq).val(),$('#txtErepair_'+b_seq).val()));
					})		
				}				
				_bbsAssign();
				
				$("[name='sel']").each(function(index) {
	            	$(this).click(function() {
	            		var n=$(this).attr('id').split('_')[($(this).attr('id').split('_').length-1)];
	            		$('#textB_seq').val(n);
	            		//讀取lbl
	            		$('#bbs_detail a').each(function(index) {
							var t_lbl=$(this).attr('id');
							if(t_lbl!=undefined){
								if(t_lbl.substring(0,4)=='labl'){
									t_lbl='lbl'+t_lbl.substring(4,t_lbl.length);
								}
								$(this).text($('#'+t_lbl).text());
							}
						});
	            		//讀取txt
	            		$("#bbs_detail [type='text'] ").each(function(index) {
							var t_txt=$(this).attr('id');
							if(t_txt!=undefined && t_txt!='textB_seq'){
								if(t_txt.substring(0,4)=='text'){
									t_txt='txt'+t_txt.substring(4,t_txt.length);
									$(this).val($('#'+t_txt+'_'+n).val());
								}
							}
						});
						//讀取check
						$("#bbs_detail [type='checkbox'] ").each(function(index) {
							var t_chk=$(this).attr('id');
							if(t_chk!=undefined){
								if(t_chk.substring(0,4)=='chek'){
									t_chk='chk'+t_chk.substring(4,t_chk.length);
									$(this).prop('checked',$('#'+t_chk+'_'+n).prop('checked'));
								}
							}
						});
						//讀取select
						$("#bbs_detail select ").each(function(index) {
							var t_sel=$(this).attr('id');
							if(t_sel!=undefined){
								if(t_sel.substring(0,4)=='comb'){
									t_sel='cmb'+t_sel.substring(4,t_sel.length);
									$(this).val($('#'+t_sel+'_'+n).val());
									
									t_sel=$(this).attr('id');
									if(t_sel.substring(0,7)=='combWay'){
										var wayx=t_sel.substring(7,8);
										changecombWay(wayx);
									}
								}
							}
						});
						//輸入數字
						$("#bbs_detail .num").each(function() {
							$(this).keyup(function(e) {
								if(e.keyCode>=37 && e.keyCode<=40)
									return;
								var tmp=$(this).val();
								tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
								$(this).val(tmp);
							});
							$(this).focusin(function() {
								$(this).select();
							});
						});
						
						$("#bbs_detail select ").each(function() {
							$(this).change(function() {
								t_sel=$(this).attr('id');
								if(t_sel.substring(0,7)=='combWay'){
									var wayx=t_sel.substring(7,8);
									changecombWay(wayx);
								}
							});
						});
						
						//下一格
						SeekF=[];
						$("#bbs_detail [type='text'] ").each(function() {
							SeekF.push($(this).attr('id'));
						});
						
						SeekF.push('btndiv_detail_save');
						$("#bbs_detail [type='text'] ").each(function() {
							$(this).bind('keydown', function(event) {
								keypress_bbm(event, $(this), SeekF, 'btndiv_detail_save');
							});
						});
						
						if(n=='0')
							$('.divway2').show();
						else
							$('.divway2').hide();
						
	            		$('#div_detail').show();
	            		$('#btnInput').attr('disabled', 'disabled');
					});
	            });
	            
	            $('#btndiv_detail_save').click(function() {
	            	if(q_cur==1 || q_cur==2){
		            	var n=$('#textB_seq').val();
		            	//txt
		            	$("#bbs_detail [type='text'] ").each(function(index) {
							var t_txt=$(this).attr('id');
							if(t_txt!=undefined && t_txt!='textB_seq'){
								if(t_txt.substring(0,4)=='text'){
									t_txt='txt'+t_txt.substring(4,t_txt.length);
									$('#'+t_txt+'_'+n).val($(this).val());
								}
							}
						});
						//check
						$("#bbs_detail [type='checkbox'] ").each(function(index) {
							var t_chk=$(this).attr('id');
							if(t_chk!=undefined){
								if(t_chk.substring(0,4)=='chek'){
									t_chk='chk'+t_chk.substring(4,t_chk.length);
									$('#'+t_chk+'_'+n).prop('checked',$(this).prop('checked'));
								}
							}
						});
						
						$("#bbs_detail select ").each(function(index) {
							var t_sel=$(this).attr('id');
							if(t_sel!=undefined ){
								if(t_sel.substring(0,4)=='comb'){
									t_sel='cmb'+t_sel.substring(4,t_sel.length);
									$('#'+t_sel+'_'+n).val($(this).val());
									
									if(t_sel.substring(0,6)=='cmbWay'){
										var wayx=t_sel.substring(6,7);
										changeWay(wayx,n);
									}
								}
							}
						});
						sum();
	            	}
	            	$('#div_detail').hide();
	            	$("[name='sel']").prop('checked',false)
	            	$('#btnInput').removeAttr('disabled');
				});
				$('#btndiv_detail_close').click(function() {
					$('#div_detail').hide();
					$("[name='sel']").prop('checked',false)
					$('#btnInput').removeAttr('disabled');
				});
			}			
			
			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				refreshBbm();
				refreshBbs();
			}

			function btnModi() {			
				_btnModi();
				refreshBbm();
				refreshBbs();
			}

			function btnPrint() {
				q_box('z_modfixc_rs.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['nob']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
						
				if($('#chkEnda').prop("checked")){
					$("#txtInnoa").css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtMechno").css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtDatea").css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
				
				q_gt('modfix', "where=^^ noa='" + trim($('#txtInnoa').val()) + "' ^^", 0, 0, 0, "");
				
				refreshBbm();
				refreshBbs();	
				sum();
				$('#btndiv_detail_close').click();
			}

			function refreshBbm() {
				$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				$('#textInnsum').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');	
				$('#textFixsum').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
			}
			
			function refreshBbs(){
				for (var i = 0; i < q_bbsCount; i++) {
            		if($("#txtBdate2_"+i).val()!=''|| $("#txtEdate2_"+i).val()!=''){
            			$("#cmbWay2_"+i).css("display", "block");
						$("#cmbMech2_"+i).css("display", "block");
						$("#cmbWorktype2_"+i).css("display", "block");
						$("#txtBdate2_"+i).css("display", "block");
						$("#mark1_"+i).css("display", "block").css('background', '#cad3ff');
						$("#txtBtime2_"+i).css("display", "block");
						$("#txtEdate2_"+i).css("display", "block");
						$("#mark2_"+i).css("display", "block").css('background', '#cad3ff');
						$("#txtEtime2_"+i).css("display", "block");
						$("#txtWorker2_"+i).css("display", "block");
            		}
            	}
            	
            	//1050223 第二行以下的第二次不顯示
            	$('.way2').each(function(index) {
					var n=$(this).attr('id').split('_')[1];
					if(n>'0'){
						$(this).hide();
					}
				});
            	
            	if(q_cur == 1 || q_cur == 2){
            		if($('#chkEnda').prop("checked")){
						lockBbs();									    
					}else{		
						unlockBbs();								    									
					}		
	            }            	
			}
					
			function lockBbs(){
				for(var i=0; i<q_bbsCount; i++){
					$("#btnSec_"+i).attr('disabled', 'disabled'); 
					$("#cmbWay_"+i).attr('disabled', 'disabled'); 
					$("#cmbWay2_"+i).attr('disabled', 'disabled');
					$("#cmbWay3_"+i).attr('disabled', 'disabled'); 
					$("#cmbWay4_"+i).attr('disabled', 'disabled');  
					$("#cmbMech_"+i).attr('disabled', 'disabled');
					$("#cmbMech2_"+i).attr('disabled', 'disabled');
					$("#cmbMech3_"+i).attr('disabled', 'disabled');
					$("#cmbMech4_"+i).attr('disabled', 'disabled');
					$("#cmbWorktype_"+i).attr('disabled', 'disabled');
					$("#cmbWorktype2_"+i).attr('disabled', 'disabled');
					$("#cmbWorktype3_"+i).attr('disabled', 'disabled');
					$("#cmbWorktype4_"+i).attr('disabled', 'disabled'); 
					$("#txtFrame_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtWeight_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');	
					$("#txtMount_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');	
					$("#txtFixmount_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');	
					$("#txtBottom_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBebottom_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEnbottom_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtLastloss_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtLoss_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBrepair_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtErepair_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBdate_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBtime_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEdate_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEtime_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBdate2_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBtime2_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEdate2_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEtime2_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBdate3_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBtime3_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEdate3_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEtime3_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBdate4_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBtime4_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEdate4_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEtime4_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtWorker_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtWorker2_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtWorker3_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtWorker4_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtMemo_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');					
				}
			}
			function unlockBbs(){			
				for(var i=0; i<q_bbsCount; i++){
					$("#btnSec_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWay_"+i).removeAttr('disabled', 'disabled'); 
					$("#cmbWay2_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWay3_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWay4_"+i).removeAttr('disabled', 'disabled'); 
					$("#cmbMech_"+i).removeAttr('disabled', 'disabled');
					$("#cmbMech2_"+i).removeAttr('disabled', 'disabled');
					$("#cmbMech3_"+i).removeAttr('disabled', 'disabled');
					$("#cmbMech4_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWorktype_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWorktype2_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWorktype3_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWorktype4_"+i).removeAttr('disabled', 'disabled');
					$("#txtFrame_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtWeight_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');	
					$("#txtMount_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');	
					$("#txtFixmount_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');	
					$("#txtBottom_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBebottom_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEnbottom_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtLastloss_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtLoss_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBrepair_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtErepair_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBdate_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBtime_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEdate_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEtime_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBdate2_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBtime2_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEdate2_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEtime2_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBdate3_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBtime3_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEdate3_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEtime3_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBdate4_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBtime4_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEdate4_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEtime4_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtWorker_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtWorker2_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtWorker3_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtWorker4_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtMemo_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');	
				}
			}
		
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				
				 if (t_para) {
					$("#bbs_detail [type='text'] ").attr('disabled', 'disabled');
					$("#bbs_detail select ").attr('disabled', 'disabled');
				}else{
					$("#bbs_detail [type='text'] ").removeAttr('disabled');
					$("#bbs_detail select ").removeAttr('disabled');
				}
				
				if(q_cur==1 || q_cur==2){
                	if(r_rank < 9 && $('#chkEnda').prop('checked')){
                		$('#chkEnda').attr('disabled', 'disabled');
                	}
                }
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				border-width: 0px;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 5px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 1000px;
				/*margin: -1px;
				/*border: 1px black solid;*/
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 43px;
			}
			.tbbm tr td {
				width: 10%;
			}
			.tbbm .tdZ {
				width: 1%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 95%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
				
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.dbbs {
				width: 1260px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"], select {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			#bbs_detail a{
				float:right;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMech'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="mech" style="text-align: center;">~mech</td>
						
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl" > </a></td>
						<td><input id="txtNoa" type="text" class="txt  c1" /></td>
						<td><span> </span><a id="lblMech" class="lbl"> </a></td>
						<td><input id="txtMech" type="text" class="txt  c1" /></td>
						<td><span> </span><a id="lblTggno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno"  type="text" style="width:34%;"/>
							<input id="txtTgg"  type="text" style="width:66%; color:green;"/>						
						</td>							
					</tr>	
					<tr>	
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
					</tr>	
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style="width:2250px;">
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" class="bbsdetail" style="width: 26px;"><a id='vewSel'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDatea_s' > </a></td>
					<td align="center" style="width:100px;"><a id='lblDunit_s' > </a></td>
					<td align="center" style="width:80px;"><a id='lblTmark_s' > </a></td>
					<td align="center" style="width:165px;"><a id='lblNob_s' > </a></td>
					<td align="center" style="width:165px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblCode_s'> </a></td>
					<td align="center" style="width:165px;"><a id='lblDetail_s'> </a></td>
					<td align="center" style="width:70px;"><a id='lblAnnex_s' > </a></td>
					<td align="center" style="width:165px;"><a id='lblDgdetail_s' > </a></td>
					<td align="center" style="width:165px;"><a id='lblSwdetail_s' > </a></td>
					<td align="center" style="width:335px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;' class="ishide.*">
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size:medium; font-weight:bold; width:90%;" value="-"/>
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td class="bbsdetail"><input name="sel"  id="radSel.*" type="radio" /></td>
					<td><input id="txtDatea.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtDunit.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtTmark.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtNob.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtProduct.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtCode.*" type="text"  style="width:93%;"/></td>
					<td><input id="txtDetail.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtAnnex.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtDgdetail.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtSwdetail.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1" style="width:99%;"/></td>	
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		
	</body>
</html>