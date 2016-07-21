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
			var q_name = "modfixc";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2','textNob','textCode','textDetail','txtFrame','textInnsum','textFixsum'];
			var q_readonlys = ['txtNob','txtCode','txtDetail','txtFrame'];
			var bbmNum = [['txtFrame',10,0,0]];
			var bbsNum = [['txtWeight',15,1,1], ['txtMount',15,0,1], ['txtFixmount',15,0,1], ['txtBottom',15,2,1], ['txtBebottom',15,2,1], ['txtEnbottom',15,2,1], 
						  ['txtLastloss',15,1,1], ['txtLoss',15,1,1], ['txtBrepair',15,1,1], ['txtErepair',15,1,1],['txtFrame',10,0,0]];
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
				['txtInnoa','lblInnoa','modfix','noa,modnoa,frame,mechno,mech','txtInnoa,txtModnoa,txtFrame,txtMechno,txtMech','modfix_b.aspx'],
				['txtModnoa','lblModnoa','model','noa,frame','txtModnoa,txtFrame','model_b2.aspx'],
				//['txtFrame','lblFrame','modfix','noa,modnoa,frame,mechno,mech','txtInnoa,txtModnoa,txtFrame,txtMechno,txtMech','modfix_b.aspx'],
				['txtMechno','lblMechno','mech','noa,mech','txtMechno,txtMech','mech_b.aspx']
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
				
				q_cmbParse("cmbWay",t_way,'s');
				q_cmbParse("cmbWay2",t_way,'s');
				q_cmbParse("cmbWay3",t_way,'s');
				q_cmbParse("cmbWay4",t_way,'s');
				q_cmbParse("cmbWorktype",t_worktype,'s');
				q_cmbParse("cmbWorktype2",t_worktype,'s');
				q_cmbParse("cmbWorktype3",t_worktype,'s');
				q_cmbParse("cmbWorktype4",t_worktype,'s');
				
				//bbs_detail
				q_cmbParse("combWay",t_way);
				q_cmbParse("combWay2",t_way);
				q_cmbParse("combWay3",t_way);
				q_cmbParse("combWay4",t_way);
				q_cmbParse("combWorktype",t_worktype);
				q_cmbParse("combWorktype2",t_worktype);
				q_cmbParse("combWorktype3",t_worktype);
				q_cmbParse("combWorktype4",t_worktype);	
				
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
						var t_where="where=^^a.noa='"+$('#txtInnoa').val()+"' order by a.noa,a.noq^^"
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
						$("#txtMech").css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					}else{
						$("#txtInnoa").css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
						$("#txtMechno").css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
						$("#txtMech").css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
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
						break;
					case 'modfix':
						var as = _q_appendData("modfix", "", true);
						if (as[0] != undefined) {
							t_indate = as[0].datea;
						}
						break;*/					
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
				t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')],['txtModnoa', q_getMsg('lblModnoa')],['txtInnoa', q_getMsg('lblInnoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				q_gt('modfix', "where=^^ noa='" + trim($('#txtInnoa').val()) + "' ^^", 0, 0, 0, "",r_accy,1);
				var as = _q_appendData("modfix", "", true);
				if (as[0] != undefined) {
					t_indate = as[0].datea;
				}else{
					alert('入庫單號不存在!!');
					return;
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);	
				
				//檢查維修日期(modfixc.datea)>入庫日期(modfix.datea)?
				var t_date = trim($('#txtDatea').val());
				if(t_date < t_indate){
					alert('維修日期錯誤!!\n維修日期('+t_date+')早於入庫日期('+t_indate+')');
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
							lockbbs();
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
						if(dec($('#txtErepair_'+b_seq).val())!=0){
							$('#cmbWay_'+b_seq).val('CNC車修').change();
						}else if(dec($('#txtBrepair_'+b_seq).val())!=0){
							$('#cmbWay_'+b_seq).val('傳統車床(研磨)').change();
						}
					});
					$('#txtErepair_'+j).change(function(){	
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;		
						$('#txtLoss_'+b_seq).val(q_sub($('#txtBrepair_'+b_seq).val(),$('#txtErepair_'+b_seq).val()));
						$('#txtEnbottom_'+b_seq).val(q_add($('#txtBottom_'+b_seq).val(),$('#txtErepair_'+b_seq).val()));
						if(dec($('#txtErepair_'+b_seq).val())!=0){
							$('#cmbWay_'+b_seq).val('CNC車修').change();
						}else if(dec($('#txtBrepair_'+b_seq).val())!=0){
							$('#cmbWay_'+b_seq).val('傳統車床(研磨)').change();
						}
					});
					
					$('#txtBottom_'+j).change(function(){	
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;		
						$('#txtEnbottom_'+b_seq).val(q_add($('#txtBottom_'+b_seq).val(),$('#txtErepair_'+b_seq).val()));
					});
					
					$('#cmbWorktype_'+j).change(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(dec($('#textTimea').val())>0 
						&& emp($('#txtBdate_'+b_seq).val()) && emp($('#txtBtime_'+b_seq).val())
						&& !emp($('#txtEdate_'+(b_seq-1)).val()) && !emp($('#txtEtime_'+(b_seq-1)).val())
						&& b_seq>0){
							var t_year=dec($('#txtEdate_'+(b_seq-1)).val().substr(0,r_len));
							var t_mon=dec($('#txtEdate_'+(b_seq-1)).val().substr(r_len+1,2))-1;
							var t_days=dec($('#txtEdate_'+(b_seq-1)).val().substr(r_lenm+1,2));
							var t_hour=dec($('#txtEtime_'+(b_seq-1)).val().substr(0,2));
							var t_minu=dec($('#txtEtime_'+(b_seq-1)).val().substr(3,2));
							var t_times=dec($('#textTimea').val());
							if(r_len==3){
								t_year=t_year+1911
							}
							var t_date=new Date(t_year, t_mon, t_days,t_hour,t_minu);
							t_date.setMinutes(t_date.getMinutes() + t_times);
							
							t_year=('0000'+(t_date.getFullYear()-(r_len==3?1911:0)).toString()).slice(r_len==3?-3:-4);
							t_mon=('00'+(t_date.getMonth()+1).toString()).slice(-2);
							t_days=('00'+t_date.getDate().toString()).slice(-2);
							t_hour=('00'+t_date.getHours().toString()).slice(-2);
							t_minu=('00'+t_date.getMinutes().toString()).slice(-2);
							
							$('#txtBdate_'+b_seq).val($('#txtEdate_'+(b_seq-1)).val());
							$('#txtBtime_'+b_seq).val($('#txtEtime_'+(b_seq-1)).val());
							$('#txtEdate_'+b_seq).val(t_year+'/'+t_mon+'/'+t_days);
							$('#txtEtime_'+b_seq).val(t_hour+':'+t_minu);
						}
					});
					
					$('#cmbWorktype3_'+j).change(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(dec($('#textTimea').val())>0 
						&& emp($('#txtBdate3_'+b_seq).val()) && emp($('#txtBtime3_'+b_seq).val())
						&& !emp($('#txtEdate3_'+(b_seq-1)).val()) && !emp($('#txtEtime3_'+(b_seq-1)).val())
						&& b_seq>0){
							var t_year=dec($('#txtEdate3_'+(b_seq-1)).val().substr(0,r_len));
							var t_mon=dec($('#txtEdate3_'+(b_seq-1)).val().substr(r_len+1,2))-1;
							var t_days=dec($('#txtEdate3_'+(b_seq-1)).val().substr(r_lenm+1,2));
							var t_hour=dec($('#txtEtime3_'+(b_seq-1)).val().substr(0,2));
							var t_minu=dec($('#txtEtime3_'+(b_seq-1)).val().substr(3,2));
							var t_times=dec($('#textTimea').val());
							if(r_len==3){
								t_year=t_year+1911
							}
							var t_date=new Date(t_year, t_mon, t_days,t_hour,t_minu);
							t_date.setMinutes(t_date.getMinutes() + t_times);
							
							t_year=('0000'+(t_date.getFullYear()-(r_len==3?1911:0)).toString()).slice(r_len==3?-3:-4);
							t_mon=('00'+(t_date.getMonth()+1).toString()).slice(-2);
							t_days=('00'+t_date.getDate().toString()).slice(-2);
							t_hour=('00'+t_date.getHours().toString()).slice(-2);
							t_minu=('00'+t_date.getMinutes().toString()).slice(-2);
							
							$('#txtBdate3_'+b_seq).val($('#txtEdate3_'+(b_seq-1)).val());
							$('#txtBtime3_'+b_seq).val($('#txtEtime3_'+(b_seq-1)).val());
							$('#txtEdate3_'+b_seq).val(t_year+'/'+t_mon+'/'+t_days);
							$('#txtEtime3_'+b_seq).val(t_hour+':'+t_minu);
						}
					});
					
					$('#cmbWorktype4_'+j).change(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(dec($('#textTimea').val())>0 
						&& emp($('#txtBdate4_'+b_seq).val()) && emp($('#txtBtime4_'+b_seq).val())
						&& !emp($('#txtEdate4_'+(b_seq-1)).val()) && !emp($('#txtEtime4_'+(b_seq-1)).val())
						&& b_seq>0){
							var t_year=dec($('#txtEdate4_'+(b_seq-1)).val().substr(0,r_len));
							var t_mon=dec($('#txtEdate4_'+(b_seq-1)).val().substr(r_len+1,2))-1;
							var t_days=dec($('#txtEdate4_'+(b_seq-1)).val().substr(r_lenm+1,2));
							var t_hour=dec($('#txtEtime4_'+(b_seq-1)).val().substr(0,2));
							var t_minu=dec($('#txtEtime4_'+(b_seq-1)).val().substr(3,2));
							var t_times=dec($('#textTimea').val());
							if(r_len==3){
								t_year=t_year+1911
							}
							var t_date=new Date(t_year, t_mon, t_days,t_hour,t_minu);
							t_date.setMinutes(t_date.getMinutes() + t_times);
							
							t_year=('0000'+(t_date.getFullYear()-(r_len==3?1911:0)).toString()).slice(r_len==3?-3:-4);
							t_mon=('00'+(t_date.getMonth()+1).toString()).slice(-2);
							t_days=('00'+t_date.getDate().toString()).slice(-2);
							t_hour=('00'+t_date.getHours().toString()).slice(-2);
							t_minu=('00'+t_date.getMinutes().toString()).slice(-2);
							
							$('#txtBdate4_'+b_seq).val($('#txtEdate4_'+(b_seq-1)).val());
							$('#txtBtime4_'+b_seq).val($('#txtEtime4_'+(b_seq-1)).val());
							$('#txtEdate4_'+b_seq).val(t_year+'/'+t_mon+'/'+t_days);
							$('#txtEtime4_'+b_seq).val(t_hour+':'+t_minu);
						}
					});
					
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
				refreshBbs();
			}

			function btnModi() {			
				_btnModi();
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
					$("#txtMech").css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
				
				refreshBbs();	
				sum();
				$('#btndiv_detail_close').click();
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
				
				if(q_cur=='2'){
					$('#txtDatea').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}else{
					$('#txtDatea').css('color', '');
				}
				
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
			
			function q_popPost(s1) {
				switch (s1) {
					case 'txtModnoa':
						//排除已被維修或領用的入庫單
						q_gt('modfix', "where=^^modnoa='"+$('#txtModnoa').val()+"' and not exists (select * from modfixc where noa=modfix.noa and noa!='"+$('#txtNoa').val()+"') and not exists (select * from modout where noa=modfix.noa) ^^ stop=1 ", 0, 0, 0, "getinnoa",r_accy,1);
						var as = _q_appendData("modfix", "", true);
						if (as[0] != undefined) {
							$('#txtInnoa').val(as[0].noa);
							$('#txtFrame').val(as[0].frame);
							$('#txtMechno').val(as[0].mechno);
							$('#txtMech').val(as[0].mech);
							t_indate = as[0].datea;
						}else{
							alert('模具編號無入庫單可進行維修!!');
						}
						
						//清除表身
						for(var i=0; i<q_bbsCount; i++){
							$('#btnMinus_'+i).click();
						}
						break;
					case 'txtInnoa':
						//清除表身
						for(var i=0; i<q_bbsCount; i++){
							$('#btnMinus_'+i).click();
						}
						break;
				}
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
						<td><span> </span><a id='lblInnoa' class="lbl btn" > </a></td>
						<td><input id="txtInnoa" type="text" class="txt  c1" /></td>
						<td><span> </span><a id='lblModnoa' class="lbl " > </a></td>
						<td><input id="txtModnoa" type="text" class="txt  c1" /></td>
						<td><span> </span><a id='lblFrame' class="lbl"> </a></td>
						<td><input id="txtFrame" type="text" class="txt c1"/></td>	
						<td><span> </span><a id='lblNoa' class="lbl " > </a></td>
						<td><input id="txtNoa" type="text" class="txt c1" /></td>						
					</tr>
						<td><span> </span><a id="lblMechno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtMechno"  type="text" style="width:34%;"/>
							<input id="txtMech"  type="text" style="width:66%;"/>						
						</td>	
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1" /></td>
						<td><span> </span><a id='lblSum' class="lbl"> </a></td>
						<td>
							<input id="textInnsum"  type="text"  class="num c1" style="width:50%"/>
							<input id="textFixsum"  type="text"  class="num c1" style="width:50%"/>
						</td>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td align="center"><input id="btnIn" type="button" style="width: 80px"/></td>
						<td align="right">
							<input id="chkFixed" type="checkbox" disabled="disabled">
							<span> </span><a id="lblFixed">已維修</a>
						</td>
						<td align="left">
							<input id="chkEnda" type="checkbox" disabled="disabled">
							<span> </span><a id="lblEnda">結案</a>
						</td>
						<td><input id="textTimea" style="width: 50px;text-align: right;">/分</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style="width:2250px;">
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" class="bbsdetail" style="width: 26px;"><a id='vewSel'> </a></td>
					<td align="center" style="width:165px;"><a id='lblNob_s' > </a></td>
					<td style="display: none;" align="center" style="width:200px;"><a id='lblModel_s'> </a></td>
					<td style="display: none;" align="center" style="width:200px;"><a id='lblWheel_s'> </a></td>
					<td align="center" style="width:74px;"><a id='lblCode_s'> </a></td>
					<td align="center" style="width:165px;"><a id='lblDetail_s'> </a></td>
					<td align="center" style="width:35px;"><a id='lblFrame_s'> </a></td>	
					<td align="center" style="width:80px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblFixmount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblBottom_s'> </a></td>			
					<td align="center" style="width:60px;"><a id='lblBebottom_s'> </a></td>
					<td align="center" style="width:75px;"><a id='lblLastloss_s'> </a></td>
					<td align="center" style="width:60px;"><a id='lblBrepair_s'> </a></td>
					<td align="center" style="width:60px;"><a id='lblErepair_s'> </a></td>
					<td align="center" style="width:60px;"><a id='lblLoss_s'> </a></td>
					<td align="center" style="width:60px;"><a id='lblEnbottom_s'> </a></td>
					<td align="center" style="width:185px;"><a id='lblWay_s'> </a></td>
					<td align="center" style="width:61px;"><a id='lblMech_s'> </a></td>
					<td align="center" style="width:61px;"><a id='lblWorktype_s'> </a></td>
					<td align="center" style="width:155px;"><a id='lblBdate_s'> </a></td>
					<td align="center" style="width:156px;"><a id='lblEdate_s'> </a></td>
					<td align="center" style="width:87px;"><a id='lblWorker_s'> </a></td>
					<td align="center" style="width:335px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;' class="ishide.*">
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size:medium; font-weight:bold; width:90%;" value="-"/>
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td class="bbsdetail"><input name="sel"  id="radSel.*" type="radio" /></td>
					<td><input id="txtNob.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td style="display: none;"><input id="txtModel.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td style="display: none;"><input id="txtWheel.*" type="text"  style="width:95%;"/></td>
					<td><input id="txtCode.*" type="text"  style="width:93%;"/></td>
					<td><input id="txtDetail.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtFrame.*" type="text" class="txt c1" style="width:88%;"/></td>					
					<td><input id="txtWeight.*" type="text" class="num c1" style="width:94%;"/></td>
					<td><input id="txtMount.*" type="text" class="num c1" style="width:93%;"/></td>		
					<td><input id="txtFixmount.*" type="text" class="num c1" style="width:93%;"/></td>
					<td><input id="txtBottom.*" type="text" class="num c1" style="width:95%;"/></td>				
					<td><input id="txtBebottom.*" type="text" class="num c1" style="width:93%;"/></td>
					<td><input id="txtLastloss.*" type="text" class="num c1" style="width:93%;"/></td>
					<td><input id="txtBrepair.*" type="text" class="num c1" style="width:93%;"/></td>
					<td><input id="txtErepair.*" type="text" class="num c1" style="width:93%;"/></td>
					<td><input id="txtLoss.*" type="text" class="num c1" style="width:93%;"/></td>
					<td><input id="txtEnbottom.*" type="text" class="num c1" style="width:93%;"/></td>
					<td colspan="6">
						<span style="width:45px; color:#003377; margin-top:5px; float:left; text-align:center; font-weight:bold; font-size:9pt ">第1次</span>
						<select id="cmbWay.*" class="txt c1" style="float:left;width:140px;"> </select>
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>	
						<select id="cmbMech.*" class="txt c1" style="width:62.5px;"> </select>
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>	
						<select id="cmbWorktype.*" class="txt c1" style="width:62.5px;"> </select>
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>	
						<input id="txtBdate.*" type="text" class="txt c1 a" style="width:82px;" />
						<span style="width:13px; float:left; text-align:center">-</span>
						<input id="txtBtime.*" type="text" class="txt c1 a" style="width:53px;" />
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>				
						<input id="txtEdate.*" type="text" class="txt c1 a" style="width:82px;"/>
						<span style="width:13px; float:left;text-align:center">-</span>
						<input id="txtEtime.*" type="text" class="txt c1 a" style="width:53px;" />
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>						
						<input id="txtWorker.*" type="text" class="txt c1" style="width:82px;"/>
						
						<span style="width:45px; color:#003377; margin-top:5px; float:left; text-align:center; font-weight:bold; font-size:9pt "> </span>
						<select id="cmbWay3.*" class="txt c1" style="float:left;width:140px;"> </select>
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>	
						<select id="cmbMech3.*" class="txt c1" style="width:62.5px;"> </select>
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>	
						<select id="cmbWorktype3.*" class="txt c1" style="width:62.5px;"> </select>
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>	
						<input id="txtBdate3.*" type="text" class="txt c1 a" style="width:82px;" />
						<span style="width:13px; float:left; text-align:center">-</span>
						<input id="txtBtime3.*" type="text" class="txt c1 a" style="width:53px;" />
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>				
						<input id="txtEdate3.*" type="text" class="txt c1 a" style="width:82px;"/>
						<span style="width:13px; float:left;text-align:center">-</span>
						<input id="txtEtime3.*" type="text" class="txt c1 a" style="width:53px;" />
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>						
						<input id="txtWorker3.*" type="text" class="txt c1" style="width:82px;"/>
						
						<span style="width:45px; color:#003377; margin-top:5px; float:left; text-align:center; font-weight:bold; font-size:9pt "> </span>
						<select id="cmbWay4.*" class="txt c1" style="float:left;width:140px;"> </select>
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>	
						<select id="cmbMech4.*" class="txt c1" style="width:62.5px;"> </select>
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>	
						<select id="cmbWorktype4.*" class="txt c1" style="width:62.5px;"> </select>
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>	
						<input id="txtBdate4.*" type="text" class="txt c1 a" style="width:82px;" />
						<span style="width:13px; float:left; text-align:center">-</span>
						<input id="txtBtime4.*" type="text" class="txt c1 a" style="width:53px;" />
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>				
						<input id="txtEdate4.*" type="text" class="txt c1 a" style="width:82px;"/>
						<span style="width:13px; float:left;text-align:center">-</span>
						<input id="txtEtime4.*" type="text" class="txt c1 a" style="width:53px;" />
						<span style="width:3px; float:left; text-align:center">&nbsp;</span>						
						<input id="txtWorker4.*" type="text" class="txt c1" style="width:82px;"/>
						
						<span id="spanseq.*" style="width:45px; color:#003377; margin-top:5px; float:left; text-align:center; font-weight:bold; font-size:9pt;" class="way2">第2次</span>
						<select id="cmbWay2.*" class="txt c1 way2" style="width:140px;"> </select>
						<span id="spanspec3.*" style="width:3px; float:left; text-align:center" class="way2">&nbsp;</span>	
						<select id="cmbMech2.*" class="txt c1 way2" style="width:62.5px;"> </select>
						<span id="spanspec4.*" style="width:3px; float:left; text-align:center" class="way2">&nbsp;</span>	
						<select id="cmbWorktype2.*" class="txt c1 way2" style="width:62.5px;"> </select>
						<span id="spanspec5.*" style="width:3px; float:left; text-align:center" class="way2">&nbsp;</span>	
						<input id="txtBdate2.*" type="text" class="txt c1 a way2" style="width:82px;" />
						<span id="spandash1.*" style="width:13px; float:left; text-align:center" class="way2">-</span>
						<input id="txtBtime2.*" type="text" class="txt c1 a way2" style="width:53px;" />
						<span id="spanspec1.*" style="width:3px; float:left; text-align:center" class="way2">&nbsp;</span>					
						<input id="txtEdate2.*" type="text" class="txt c1 a way2" style="width:82px;"/>
						<span id="spandash2.*" style="width:13px; float:left;text-align:center" class="way2">-</span>
						<input id="txtEtime2.*" type="text" class="txt c1 a way2" style="width:53px;" />
						<span id="spanspec2.*" style="width:3px; float:left; text-align:center" class="way2">&nbsp;</span>						
						<input id="txtWorker2.*" type="text" class="txt c1 way2" style="width:82px;"/>			
					</td>
					<td><input id="txtMemo.*" type="text" class="txt c1" style="width:99%;"/></td>	
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		
		<div id="div_detail" style="position:absolute; top:80px; left:260px;width:1000px; background-color: bisque;border: 1px solid gray;display:none;">
			<table id="bbs_detail" width="1000px;">
				<tr style="height: 1px;">
					<td style="width: 100px;"> </td>
					<td style="width: 100px;"> </td>
					<td style="width: 100px;"> </td>
					<td style="width: 100px;"> </td>
					<td style="width: 150px;"> </td>
					<td style="width: 150px;"> </td>
					<td style="width: 100px;"> </td>
					<td style="width: 100px;"> </td>
					<td style="width: 10px;"> </td>
				</tr>
				<tr>
					<td><a id="lablNob_s"> </a></td>
					<td colspan="2">
						<input class="txt c1" id="textNob" type="text" />
						<input id="textB_seq" type="hidden" />
					</td>
					<td><a id='lablCode_s'> </a></td>
					<td><input class="txt c1" id="textCode" type="text" /></td>
					<td><a id='lablDetail_s'> </a></td>
					<td colspan="2"><input class="txt c1" id="textDetail" type="text" /></td>
				</tr>
				<tr>
					<td><a id="lablFrame_s"> </a></td>
					<td><input class="txt c1" id="textFrame" type="text" /></td>
					<td><a id="lablWeight_s"> </a></td>
					<td><input class="txt num c1" id="textWeight" type="text" /></td>
				</tr>
				<tr>
					<td><a id="lablMount_s"> </a></td>
					<td><input class="txt num c1" id="textMount" type="text" /></td>
					<td><a id="lablFixmount_s"> </a></td>
					<td><input class="txt num c1" id="textFixmount" type="text" /></td>
					<td><a id="lablBottom_s"> </a></td>
					<td><input class="txt num c1" id="textBottom" type="text" /></td>
				</tr>
				<tr>
					<td><a id="lablBebottom_s"> </a></td>
					<td><input class="txt num c1" id="textBebottom" type="text" /></td>
					<td><a id="lablLastloss_s"> </a></td>
					<td><input class="txt num c1" id="textLastloss" type="text" /></td>
					<td><a id="lablBrepair_s"> </a></td>
					<td><input class="txt num c1" id="textBrepair" type="text" /></td>
				</tr>
				<tr>
					<td><a id="lablErepair_s"> </a></td>
					<td><input class="txt num c1" id="textErepair" type="text" /></td>
					<td><a id="lablLoss_s"> </a></td>
					<td><input class="txt num c1" id="textLoss" type="text" /></td>
					<td><a id="lablEnbottom_s"> </a></td>
					<td><input class="txt num c1" id="textEnbottom" type="text" /></td>
				</tr>
				<tr style="text-align: center;">
					<td> </td>
					<td><a id="lablWay_s" style="float: none;"> </a></td>
					<td><a id="lablMech_s" style="float: none;"> </a></td>
					<td><a id="lablWorktype_s" style="float: none;"> </a></td>
					<td><a id="lablBdate_s" style="float: none;"> </a></td>
					<td><a id="lablEdate_s" style="float: none;"> </a></td>
					<td><a id="lablWorker_s" style="float: none;"> </a></td>
				</tr>
				<tr>
					<td><a>第1次</a></td>
					<td><select id="combWay" class="txt c1"> </select></td>
					<td><select id="combMech" class="txt c1"> </select></td>
					<td><select id="combWorktype" class="txt c1"> </select></td>
					<td>
						<input class="txt c1" id="textBdate" type="text" style="width: 80px;"/>
						<span style="width:13px; float:left; text-align:center">-</span>
						<input class="txt c1" id="textBtime" type="text" style="width: 50px;"/>
					</td>
					<td>
						<input class="txt c1" id="textEdate" type="text" style="width: 80px;"/>
						<span style="width:13px; float:left; text-align:center">-</span>
						<input class="txt c1" id="textEtime" type="text" style="width: 50px;"/>
					</td>
					<td><input class="txt c1" id="textWorker" type="text" /></td>
				</tr>
				<tr>
					<td> </td>
					<td><select id="combWay3" class="txt c1"> </select></td>
					<td><select id="combMech3" class="txt c1"> </select></td>
					<td><select id="combWorktype3" class="txt c1"> </select></td>
					<td>
						<input class="txt c1" id="textBdate3" type="text" style="width: 80px;"/>
						<span style="width:13px; float:left; text-align:center">-</span>
						<input class="txt c1" id="textBtime3" type="text" style="width: 50px;"/>
					</td>
					<td>
						<input class="txt c1" id="textEdate3" type="text" style="width: 80px;"/>
						<span style="width:13px; float:left; text-align:center">-</span>
						<input class="txt c1" id="textEtime3" type="text" style="width: 50px;"/>
					</td>
					<td><input class="txt c1" id="textWorker3" type="text" /></td>
				</tr>
				<tr>
					<td> </td>
					<td><select id="combWay4" class="txt c1"> </select></td>
					<td><select id="combMech4" class="txt c1"> </select></td>
					<td><select id="combWorktype4" class="txt c1"> </select></td>
					<td>
						<input class="txt c1" id="textBdate4" type="text" style="width: 80px;"/>
						<span style="width:13px; float:left; text-align:center">-</span>
						<input class="txt c1" id="textBtime4" type="text" style="width: 50px;"/>
					</td>
					<td>
						<input class="txt c1" id="textEdate4" type="text" style="width: 80px;"/>
						<span style="width:13px; float:left; text-align:center">-</span>
						<input class="txt c1" id="textEtime4" type="text" style="width: 50px;"/>
					</td>
					<td><input class="txt c1" id="textWorker4" type="text" /></td>
				</tr>
				<tr class="divway2">
					<td><a>第2次</a></td>
					<td><select id="combWay2" class="txt c1"> </select></td>
					<td><select id="combMech2" class="txt c1"> </select></td>
					<td><select id="combWorktype2" class="txt c1"> </select></td>
					<td>
						<input class="txt c1" id="textBdate2" type="text" style="width: 80px;"/>
						<span style="width:13px; float:left; text-align:center">-</span>
						<input class="txt c1" id="textBtime2" type="text" style="width: 50px;"/>
					</td>
					<td>
						<input class="txt c1" id="textEdate2" type="text" style="width: 80px;"/>
						<span style="width:13px; float:left; text-align:center">-</span>
						<input class="txt c1" id="textEtime2" type="text" style="width: 50px;"/>
					</td>
					<td><input class="txt c1" id="textWorker2" type="text" /></td>
				</tr>
				<tr>
					<td><a id="lablMemo_s"> </a></td>
					<td colspan="7"><input class="txt c1" id="textMemo" type="text" /></td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: center;"><input id="btndiv_detail_save" type="button" style="width: auto;font-size: medium;text-align: center;" value="確定"/></td>
					<td colspan="4" style="text-align: center;"><input id="btndiv_detail_close" type="button" style="width: auto;font-size: medium;text-align: center;"  value="關閉"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>