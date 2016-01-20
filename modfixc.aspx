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
			var q_readonly = ['txtNoa', 'txtModnoa', 'txtMech', 'txtWorker', 'txtWorker2'];
			var q_readonlys = ['txtNob','txtCode','txtDetail'];
			var bbmNum = [];
			var bbsNum = [['txtWeight',15,1,0], ['txtMount',15,0,0], ['txtFixmount',15,0,0], ['txtBottom',15,3,0], ['txtBebottom',15,1,0], ['txtEnbottom',15,1,0], 
						  ['txtLastloss',15,1,0], ['txtLoss',15,1,0], ['txtBrepair',15,1,0], ['txtErepair',15,1,0]];
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
				['txtInnoa','lblInnoa','modfix','noa,modnoa,mechno,mech','txtInnoa,txtModnoa,txtMechno,txtMech','modfix_b.aspx'],
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
				bbmMask = [['txtDatea',r_picd]];
				q_mask(bbmMask);				
				bbsMask = [['txtBdate',r_picd+'-99:99'],['txtEdate',r_picd+'-99:99'],['txtBdate2',r_picd+'-99:99'],['txtEdate2',r_picd+'-99:99']];
				
				q_cmbParse("cmbWay",'傳統車床(研磨),CNC車修','s');
				q_cmbParse("cmbWay2",'傳統車床(研磨),CNC車修','s');
				q_cmbParse("cmbWorktype",'正工,加班','s');
				q_cmbParse("cmbWorktype2",'正工,加班','s');							
				
				$('#btnIn').click(function(){				
					if(!emp($('#txtNoa').val()) && (q_cur == 1 || q_cur == 2)){
						q_gt('modfix', "where=^^noa='"+$('#txtInnoa').val()+"'^^", 0, 0, 0, "ins_modfixs");						
					}	
				});
				
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
					case 'ins_modfixs':
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
						$.each(as, function(index, elm){//判斷model.productno是否已存在於bbs內:isexist->y:1,n:0
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
						break;					
					case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                   		 break;  	
				}
			}
			
			function getLast(){
				var btm,ebtm,loss,noa;
			  	for(var i=0; i<t_data1.length; i++){	
			  		btm  = '';
			  		ebtm = '';
			  		loss = '';
			  		noa  = '';		  		  		
			  		for(var j=0; j<t_data2.length; j++){
			  			if(t_data1[i].nob==t_data2[j].nob && t_data2[j].noa>noa){		  				
			  				btm  = t_data2[j].bottom;
			  				ebtm = t_data2[j].enbottom;
			  				loss = t_data2[j].loss;
			  				noa  = t_data2[j].noa;
			  			}
			  		}//j-loop
			  		if(btm == ''){
			  			for(var j=0; j<t_data3.length; j++){
				  			if(t_data1[i].nob==t_data3[j].productno ){	  				
				  				btm  = t_data3[j].bottom;				  				
				  			}
				  		}//j-loop	
			  		}			  				  			
			  		$('#txtBottom_'+i).val(btm);
			  		$('#txtBebottom_'+i).val(ebtm);
			  		$('#txtLastloss_'+i).val(loss);
			  	}//i-loop
			}
			
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
				
				//檢查日期
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
				q_box('modfixc_s.aspx', q_name + '_s', "500px", "40%", q_getMsg("popSeek"));
			}

			function changeWay(n,pos){
				var way = $('#cmbWay'+n+"_"+pos).val();
				switch(way){
					case "傳統車床(研磨)":
						q_cmbParse("cmbMech"+n+"_"+pos,'F01,F02,F03,F05,鑽床,銑床,插床');
						break;
					case "CNC車修":
						q_cmbParse("cmbMech"+n+"_"+pos,'G01,G02');	
						break;
					}	
			}
			
			function bbsAssign() {
				$('#chkEnda').click(function(){		
					if($('#chkEnda').prop("checked")){
						lockBbs();											    
					}else{		
						unlockBbs();									    									
					}	
				});		
				
				for (var j = 0; j < q_bbsCount; j++) {					
					//完成訖時間=完成起時間+30min
					$('#txtBdate_'+j).blur(function(){						
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						var mm,hh,min,hrs;
						mm=$('#txtBdate_'+b_seq).val().substr(13,2);
						hh=$('#txtBdate_'+b_seq).val().substr(10,2);
						min = parseInt(mm)+30 >= 60 ? parseInt(mm)+30-60 : parseInt(mm)+30;
						hrs = parseInt(mm)+30 >= 60 ? parseInt(hh)+1 : parseInt(hh);
						min = min < 10 ? "0"+min : min;
						hrs = hrs < 10 ? "0"+hrs : hrs;
						$('#txtEdate_'+b_seq).val($('#txtBdate_'+b_seq).val().substring(0,9)+'-'+hrs+':'+min);							
					})
					$('#txtBdate2_'+j).blur(function(){						
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						var mm,hh,min,hrs;
						mm=$('#txtBdate2_'+b_seq).val().substr(13,2);
						hh=$('#txtBdate2_'+b_seq).val().substr(10,2);
						min = parseInt(mm)+30 >= 60 ? parseInt(mm)+30-60 : parseInt(mm)+30;
						hrs = parseInt(mm)+30 >= 60 ? parseInt(hh)+1 : parseInt(hh);
						min = min < 10 ? "0"+min : min;
						hrs = hrs < 10 ? "0"+hrs : hrs;
						$('#txtEdate2_'+b_seq).val($('#txtBdate2_'+b_seq).val().substring(0,9)+'-'+hrs+':'+min);
					});
					
					//依據研磨方式改變機台選項
					changeWay("",j);
					changeWay("2",j);

					$('#cmbWay_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){
							$("#cmbMech_"+b_seq).empty();
							changeWay("",b_seq);
						}	
					});
					$('#cmbMech_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){
							$("#txtMech_"+b_seq).val($('#cmbMech_'+b_seq).find("option:selected").text());
						}
					});	
					$("#cmbMech_"+j).val($('#txtMech_'+j).val());	
					
					$('#cmbWay2_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){
							$("#cmbMech2_"+b_seq).empty();
							changeWay("2",b_seq);
						}	
					});
					$('#cmbMech2_'+j).change(function(){
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if (q_cur == 1 || q_cur == 2){
							$("#txtMech2_"+b_seq).val($('#cmbMech2_'+b_seq).find("option:selected").text());
						}
					});	
					$("#cmbMech2_"+j).val($('#txtMech2_'+j).val());
					
					//已維修(數量=維修數量)不顯示 2015/11/20
					if(($('#txtMount_'+j).val()!="") && ($('#txtFixmount_'+j).val()!="") && ($('#txtFixmount_'+j).val()==$('#txtMount_'+j).val())){
						$('.ishide_'+j).hide();
					}
					
					//自動抓取第一筆資料
					$('#cmbWay_0').change(function(){
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
					});
					
					//控制第2次工序顯示
					$('#btnSec_'+j).click(function(){		
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						$("#cmbWay2_"+b_seq).css("display", "block");
						$("#cmbMech2_"+b_seq).css("display", "block");
						$("#cmbWorktype2_"+b_seq).css("display", "block");
						$("#txtBdate2_"+b_seq).css("display", "block");
						$("#txtEdate2_"+b_seq).css("display", "block");
						$("#txtWorker2_"+b_seq).css("display", "block");
					});					
				}				
				_bbsAssign();
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
			}

			function refreshBbm() {
				$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');				
			}
			
			function refreshBbs(){
				for (var i = 0; i < q_bbsCount; i++) {
            		if($("#txtBdate2_"+i).val()!=''|| $("#txtEdate2_"+i).val()!=''|| $("#txtWorker2_"+i).val()!=''){
            			$("#cmbWay2_"+i).css("display", "block");
						$("#cmbMech2_"+i).css("display", "block");
						$("#cmbWorktype2_"+i).css("display", "block");
						$("#txtBdate2_"+i).css("display", "block");
						$("#txtEdate2_"+i).css("display", "block");
						$("#txtWorker2_"+i).css("display", "block");
            		}
            	}
            	
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
					$("#cmbMech_"+i).attr('disabled', 'disabled');
					$("#cmbMech2_"+i).attr('disabled', 'disabled');
					$("#cmbWorktype_"+i).attr('disabled', 'disabled');
					$("#cmbWorktype2_"+i).attr('disabled', 'disabled'); 
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
					$("#txtEdate_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtBdate2_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtEdate2_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtWorker_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtWorker2_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
					$("#txtMemo_"+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');					
				}
			}
			function unlockBbs(){			
				for(var i=0; i<q_bbsCount; i++){
					$("#btnSec_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWay_"+i).removeAttr('disabled', 'disabled'); 
					$("#cmbWay2_"+i).removeAttr('disabled', 'disabled'); 
					$("#cmbMech_"+i).removeAttr('disabled', 'disabled');
					$("#cmbMech2_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWorktype_"+i).removeAttr('disabled', 'disabled');
					$("#cmbWorktype2_"+i).removeAttr('disabled', 'disabled');
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
					$("#txtEdate_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtBdate2_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtEdate2_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtWorker_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtWorker2_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');
					$("#txtMemo_"+i).css('background', 'RGB(255,255,255)').removeAttr('readonly', 'readonly');	
				}
			}
		
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				
				if(q_cur==1 || q_cur==2){
                	if(r_rank < 8){
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
				width: 850px;
				/*margin: -1px;
				 border: 1px black solid;*/
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
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMech'></a></td>
						
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
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInnoa' class="lbl btn" ></a></td>
						<td><input id="txtInnoa" type="text" class="txt  c1" /></td>
						<td><span> </span><a id='lblModnoa' class="lbl " ></a></td>
						<td><input id="txtModnoa" type="text" class="txt  c1" /></td>
						<td><span> </span><a id='lblNoa' class="lbl " ></a></td>
						<td><input id="txtNoa" type="text" class="txt c1" /></td>						
					</tr>
						<td><span> </span><a id="lblMechno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtMechno"  type="text" style="width:34%;"/>
							<input id="txtMech"  type="text" style="width:66%; color:green;"/>						
						</td>	
						<td><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1" /></td>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"></a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td colspan="2" align="right">
							<input id="btnIn" type="Button"/>
							<span> </span><a id="lblEnda">　　　</a>
							<input id="chkEnda" type="checkbox" disabled="disabled">
							<span> </span><a id="lblEnda">結案</a>
						</td>
					</tr>
						
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style="width:2200px;">
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:0.3%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:4%;"><a id='lblNob_s' ></a></td>
					<td style="display: none;" align="center" style="width:5%;"><a id='lblModel_s'></a></td>
					<td style="display: none;" align="center" style="width:5%;"><a id='lblWheel_s'></a></td>
					<td align="center" style="width:1.8%;"><a id='lblCode_s'></a></td>
					<td align="center" style="width:4%;"><a id='lblDetail_s'></a></td>
					<td align="center" style="width:1%;"><a id='lblFrame_s'></a></td>	
					<td align="center" style="width:2%;"><a id='lblWeight_s'></a></td>
					<td align="center" style="width:1%;"><a id='lblMount_s'></a></td>
					<td align="center" style="width:1%;"><a id='lblFixmount_s'></a></td>
					<td align="center" style="width:2%;"><a id='lblBottom_s'></a></td>			
					<td align="center" style="width:1.5%;"><a id='lblBebottom_s'></a></td>
					<td align="center" style="width:1.8%;"><a id='lblLastloss_s'></a></td>
					<td align="center" style="width:1.5%;"><a id='lblBrepair_s'></a></td>
					<td align="center" style="width:1.5%;"><a id='lblErepair_s'></a></td>
					<td align="center" style="width:1.5%;"><a id='lblLoss_s'></a></td>
					<td align="center" style="width:1.5%;"><a id='lblEnbottom_s'></a></td>
					<td align="center" style="width:4%;"><a id='lblWay_s'></a></td>
					<td align="center" style="width:1.5%;"><a id='lblMech_s'></a></td>
					<td align="center" style="width:1.5%;"><a id='lblWorktype_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblBdate_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblEdate_s'></a></td>
					<td align="center" style="width:1.5%;"><a id='lblWorker_s'></a></td>
					<td align="center" style="width:8%;"><a id='lblMemo_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;' class="ishide.*">
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size:medium; font-weight:bold; width:90%;" value="-"/>
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input id="txtNob.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td style="display: none;"><input id="txtModel.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td style="display: none;"><input id="txtWheel.*" type="text"  style="width:95%;"/></td>
					<td><input id="txtCode.*" type="text"  style="width:93%;"/></td>
					<td><input id="txtDetail.*" type="text" class="txt c1" style="width:97%;"/></td>
					<td><input id="txtFrame.*" type="text" class="num c1" style="width:88%;"/></td>					
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
					<td>
						<input id="btnSec.*" type="button" style="text-align:left; font-size:8pt; height:23px; width:23%;" value="第2次"/>
						<input id="txtWay.*" type="text" class="txt c1" style="display:none;"/>
						<select id="cmbWay.*" type="text" class="txt c1" style="float:right;width:77%;"/select>
						<input id="txtWay2.*" type="text" class="txt c1" style="display:none;"/>	
						<select id="cmbWay2.*" type="text" class="txt c1" style="display:none; float:right; width:77%;"/select>						
					</td>
					<td><input id="txtMech.*" type="text" class="txt c1" style="display: none;"/>
						<select id="cmbMech.*" type="text" class="txt c1" style="width:100%;"/select>
						<input id="txtMech2.*" type="text" class="txt c1" style="display:none;"/>	
						<select id="cmbMech2.*" type="text" class="txt c1" style="display:none; width:100%;"/select>
					</td>
					<td>
						<input id="txtWorktype.*" type="text" class="txt c1" style="display:none;"/>
						<select id="cmbWorktype.*" type="text" class="txt c1" style="width:100%;"/select>
						<input id="txtWorktype2.*" type="text" class="txt c1" style="display:none;"/>	
						<select id="cmbWorktype2.*" type="text" class="txt c1" style="display:none; width:100%;"/select>
					</td>
					<td>
						<input id="txtBdate.*" type="text" class="txt c1" style="width:96%;"/>
						<input id="txtBdate2.*" type="text" class="txt c1" style="display: none; width:96%;"/>
					</td>
					<td>
						<input id="txtEdate.*" type="text" class="txt c1" style="width:96%;"/>
						<input id="txtEdate2.*" type="text" class="txt c1" style="display:none; width:96%;"/>
					</td>
					<td>
						<input id="txtWorker.*" type="text" class="txt c1" style="width:93%;"/>
						<input id="txtWorker2.*" type="text" class="txt c1" style="display:none; width:93%;"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1" style="width:99%;"/>
					</td>	
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>