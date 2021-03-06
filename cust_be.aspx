﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			//update date:  2015/11/24
			var q_name = "cust";
			var q_readonly = "";
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 25;
			//ajaxPath = ""; // execute in Root
			aPop = new Array(
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx'],
				['txtGrpno', 'lblGrp', 'cust', 'noa,comp,startdate', 'txtGrpno,txtGrpname,txtStartdate', 'cust_b.aspx'],
				['txtCustno2', 'lblCustno2', 'cust', 'noa,comp', 'txtCustno2,txtCust2', 'cust_b.aspx'],
				['txtZip_fact', 'lblAddr_fact', 'cust', 'team,boss', 'txtZip_fact,txtAddr_fact', '']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				xmlTable = 'conn';
				xmlKey = [['noa', 'noq']];
				xmlDec = [];
				q_popSave(xmlTable);
				// for conn_b.aspx
				q_brwCount();
				q_gt('acomp', "where=^^ 1=1 ^^", 0, 0, 0, "", r_accy);
				$('#txtNoa').focus();
			});
			function currentData() {
			}

			currentData.prototype = {
				data : [],
				/*排除的欄位,新增時不複製*/
				exclude : ['txtUacc1', 'txtUacc2', 'txtUacc3'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in curData.exclude) {
							if (fbbm[i] == curData.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				$('#vewComp').text("客戶簡稱");
				$('#lblComp').text("客戶");
				$('#lblTeam').text("帳號");
				$('#lblGrp').text("介紹人");
				$('#lblUnit').text("第");
        		document.title='客戶資料'
			}

			function mainPost() {
				
        		var t_where='';
        		if (r_rank > 6) {
					 $('.isrank').show();
				}
				
				bbmMask = [['txtChkdate', r_picd], ['txtDueday', '999'], ['txtStartdate', '99'],['txtGetdate', '99']];
				q_mask(bbmMask);
				q_gt('custtype', '', 0, 0, 0, "custtype");
				q_cmbParse("cmbStatus", q_getPara('cust.status'));

				//後面有需要的公司在顯示
				$('#btnUcam').hide();// 嘜頭
				$('#btnCustm').hide();//稅務資料
				if(q_getPara('sys.isport')=='1'){ //外銷
					$('#btnUcam').show();
					$('#btnCustm').val('貿易設定');
					$('#btnCustm').show();
				}
				
				$('#btnUcam').click(function() {
					t_where = "custno='" + $('#txtNoa').val() + "'";
					q_box("ucam_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucam', "95%", "95%", q_getMsg('btnUcam'));
				});
				
				$('#btnConn').click(function() {
					if (q_cur == 1) {
						return;
					} else {
						//104/03/13用 typea 區分客戶(1)與廠商(2)
						t_where = "noa='" + $('#txtNoa').val() + "' and typea='1' ";
						q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('btnConn'));
					}
				});
				
				$('#btnCustm').click(function() {
					if (q_cur == 1) {
						return;
					} else {
						t_where = "noa='" + $('#txtNoa').val() + "'";
						if (q_getPara('sys.project').toUpperCase()=='XY'){
							q_box("custm_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'custm', "600px", "700px", $('#btnCustm').val());
						}else if (q_getPara('sys.project').toUpperCase()=='VU'){
							q_box("custm_vu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'custm', "600px", "700px", $('#btnCustm').val());
						}else{
							q_box("custm_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'custm', "700px", "700px", $('#btnCustm').val());
						}
					}
				});
				
				$('#txtNoa').change(function(e) {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0){
						if ((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())) {
							t_where = "where=^^ noa='" + $(this).val() + "'^^";
							q_gt('cust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
						} else {
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
						}
					}
				}).blur(function() {
					if (q_getPara('sys.project').toUpperCase()=='RB'){//20160120
						if(!emp($(this).val()) && q_cur==1){
							t_where = "where=^^ noa like '" + $(this).val() + "%'^^";
							q_gt('cust', t_where, 0, 0, 0, "MAXCustno", r_accy);
						}
					}
				});
				
				$('#txtUacc4').change(function() {
					var s1 = trim($(this).val());
					if (s1.length > 4 && s1.indexOf('.') < 0)
						$(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
					if (s1.length == 4)
						$(this).val(s1 + '.');

				});
				
				$('#txtUnit').change(function() {
					var s2 = trim($(this).val());
					if (s2.length == 1)
						$(this).val('0'+s2 );
					if (s2.length > 2)
						alert('已超出數值');

				});
				$('#btnUsecrd').click(function(){
					_usecrd_credit = 0;//由usecrd.aspx  覆寫資料
					var t_custno = $('#txtNoa').val();
					var t_where = " noa='"+t_custno+"'";
					q_box("usecrd.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" +t_where, JSON.stringify({action:'usecrd',custno:t_custno}), "95%", "95%", q_getMsg('usecrd'));					
				});
			}
			
			var xy_newnoa=''; 
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
					default:
						try{
							t_para = JSON.parse(b_pop);
							//資料由 usecrd.aspx更新
							if(t_para.action=='usecrd'){
								//abbm[q_recno].credit = _usecrd_credit;
								/*console.log('boxclose usecrd');
								setTimeout(function(){
									q_gt('usecrd', "where=^^noa='"+t_para.custno+"'^^", 0, 0, 0, JSON.stringify({action:"usecrd",custno:t_para.custno}));	
								},1500);*/
							}else{
								
							}
						}catch(e){
							console.log(e.message);
						}
						break;
				}
				b_pop = '';
			}
			
			var r_acomp='';
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'getMaxNoa':
						var t_noa = 'A000';
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							t_noa = as[as.length-1].noa;
						}
						try{
							t_num = parseInt(t_noa.replace('A','')) + 1;
							t_noa = '00'+t_num;
							t_noa = 'A'+t_noa.substring(t_noa.length-3,t_noa.length);
						}catch(e){
							
						}
						wrServer(t_noa);
						Unlock();
						break;
					case 'custtype':
						var as = _q_appendData("custtype", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
							q_cmbParse("cmbTypea", t_item);
							if(abbm[q_recno])
								$("#cmbTypea").val(abbm[q_recno].typea);
						}
						break;
					case 'checkCustno_change':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
						}
						break;
					case 'checkCustno_btnOk':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
							Unlock();
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
					case 'acomp':
						r_acomp = _q_appendData("acomp", "", true);
						var t_where = "where=^^ noa='" + r_userno + "' ^^";
						q_gt('sss', t_where, 0, 0, 0, "", r_accy);
						break;
					case 'sss':
						var as = _q_appendData("sss", "", true);
						var nowhere=false;
						for (var i=0;i<r_acomp.length;i++){
							if(r_acomp[i].acomp.indexOf('智勝')>-1 || r_acomp[i].acomp.indexOf('三泰')>-1){
								nowhere=true;
								break;
							}
						}
						
						if (as[0] == undefined || (as[0].issales == 'false') || (as[0].issales == false) || nowhere ) {
							q_gt(q_name, q_content, q_sqlCount, 1);
						} else {
							q_content = "where=^^ salesno='" + r_userno + "'^^";
							q_gt(q_name, q_content, q_sqlCount, 1);
						}
						break;
					case 'XY_cust_getpy':
						var as = _q_appendData("cust", "", true);
						if(as[0] != undefined){
							var tmp=as[0].Column1;
							//排除特殊字元
							tmp=replaceAll(as[0].Column1,"'","");
							tmp=replaceAll(as[0].Column1," ","");
							tmp=replaceAll(as[0].Column1,".","");
							tmp=replaceAll(as[0].Column1,"(","");
							tmp=replaceAll(as[0].Column1,"+","");
							tmp=replaceAll(as[0].Column1,"-","");
							tmp=replaceAll(as[0].Column1,"*","");
							tmp=replaceAll(as[0].Column1,"/","");
							tmp=replaceAll(as[0].Column1,"~","");
							tmp=replaceAll(as[0].Column1,"!","");
							tmp=replaceAll(as[0].Column1,"@","");
							tmp=replaceAll(as[0].Column1,"#","");
							tmp=replaceAll(as[0].Column1,"$","");
							tmp=replaceAll(as[0].Column1,"%","");
							tmp=replaceAll(as[0].Column1,"^","");
							tmp=replaceAll(as[0].Column1,"&","");
							
							if(tmp.length==1)
								tmp=tmp+'Z';
							
							$('#txtXyNoa1').val(tmp.substr(0,2));
						}
						break;
					case 'MAXCustno':
						var as = _q_appendData("cust", "", true);
						if(as[0] != undefined){
							q_msg($('#txtNoa'), "最後編號："+as[(as.length-1)].noa);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						try{
							t_para = JSON.parse(t_name);
							/*if(t_para.action=='usecrd'){
								var as = _q_appendData("usecrd", "", true);
								t_credit = 0;
								if(as[0] != undefined){
									for(var i=0;i<as.length;i++){
										try{
											if(parseFloat(as[i].credit)>0)
												console.log(as[i].credit);
											t_credit += round(parseFloat(as[i].credit),0);
										}catch(e){
											
										}
									}
								}
								
								$('#txtCredit').val(t_credit);
								abbm[q_recno].credit = t_credit;
								if(t_para.issave){
									Save();
								}
							}else{
								
							}*/
						}catch(e){
							console.log('gtpost:'+e.message);
						}
						break;
				} /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cust_be_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}


			function btnIns() {
				if ($('#Copy').is(':checked')) {
					curData.copy();
				}
				_btnIns();
				if ($('#Copy').is(':checked')) {
					curData.paste();
				}
				
				$('#txtNoa').focus();
				refreshBbm();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				refreshBbm();
				$('#txtComp').focus();
			}

			function btnPrint() {
				q_box("z_label.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";cust=" + $('#txtNoa').val() + ";" + r_accy, 'z_label', "95%", "95%", q_getMsg('popZ_label'));
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.cust':
                        break;
                        
                    case 'qtxt.query.startdate':
                		var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['startdate'] = as[0].startdate;
							$('#txtStartdate').val(as[0].startdate);
						}
                		break;
                    
                    default:
                    	break;
                }
            }

			function q_stPost() {
				if (q_cur == 1 )
					q_func('qtxt.query.cust', 'cust.txt,cust_nhpe_be,' + encodeURI($('#txtNoa').val())+';'+ encodeURI($('#txtComp').val())  ); 
				Unlock();
			}
			
			function btnOk() {
				Lock();
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				/*if (q_cur==1 && !((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val()))) {
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
					Unlock();
					return;
				}*/

				if ($('#txtStartdate').val() > '31') {
					alert(q_getMsg("lblStartdate") + '最大天數為31日');
					Unlock();
					return;
				}
				if ($('#txtGetdate').val() > '31') {
					alert(q_getMsg("lblGetdate") + '最大天數為31日');
					Unlock();
					return;
				}


				if (dec($('#txtGetdate').val()) > 31)
					t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r';
					
				if($('#txtNick').val() == ''){
					$('#txtNick').val($('#txtComp').val().substr(0,2));
				}	
					
				if(q_cur==1)
					$('#txtKdate').val(q_date());
					
				$('#txtWorker').val(r_name);
				
				if(q_getPara('sys.project').toUpperCase() == 'RK'){
					//A流水號 自動編
					t_noa = $.trim($('#txtNoa').val());
			        if (t_noa.length == 0 || t_noa == "AUTO"){
			        	t_where = "where=^^noa like 'A[0-9][0-9][0-9]' ^^";
			        	q_gt('cust', t_where, 0, 0, 0, "getMaxNoa");
			        }
			        else
			            wrServer(t_noa);
				}else{
					Save();	
				}
			}
			function Save(){
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
					q_gt('cust', t_where, 0, 0, 0, "checkCustno_btnOk", r_accy);
				} else {
					wrServer($('#txtNoa').val());
				}
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)/// popSave
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				q_func('qtxt.query.startdate', 'cust.txt,startdate_be,'+ encodeURI($('#txtNoa').val()));
				refreshBbm();
			}

			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
			}

			var vccitopen = true;
			var xyopen = true;
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				refreshBbm();
				if (vccitopen && t_para && window.parent.q_name == 'vcc' && (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)) {
					btnIns();
					vccitopen = false;
					$('#txtNoa').val(window.parent.post_custno);
				}
				if (xyopen && t_para && (window.parent.q_name == 'quat' || window.parent.q_name == 'orde') && q_getPara('sys.project').toUpperCase()=='XY' && window.parent.q_cur==1) {
					btnIns();
					xyopen = false;
				}
				if(t_para){
					$('#btnConn').removeAttr('disabled');
					$('#btnCustm').removeAttr('disabled');
					//$('#btnTmpcustno_xy').removeAttr('disabled');
					//$('#btnUsecrd').attr('disabled', 'disabled');
					
					
				}else{
					$('#btnConn').attr('disabled', 'disabled');
					$('#btnCustm').attr('disabled', 'disabled');
					//$('#btnTmpcustno_xy').attr('disabled', 'disabled');	
					//$('#btnUsecrd').removeAttr('disabled');
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

			function returnparent() {
				if (window.parent.q_name == 'vcc' && (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1) && (window.parent.q_cur==1 || window.parent.q_cur==2)) {
					var wParent = window.parent.document;
					wParent.getElementById("txtCustno").value = $('#txtNoa').val();
					wParent.getElementById("txtComp").value = $('#txtComp').val();
					wParent.getElementById("txtPaytype").value = $('#txtPaytype').val();
					wParent.getElementById("txtTel").value = $('#txtTel').val();
					wParent.getElementById("txtFax").value = $('#txtFax').val();
					wParent.getElementById("cmbTrantype").value = $('#cmbTrantype').val();
					wParent.getElementById("txtZipcode").value = $('#txtZip_comp').val();
					wParent.getElementById("txtAddr").value = $('#txtAddr_comp').val();
					wParent.getElementById("txtSalesno").value = $('#txtSalesno').val();
					wParent.getElementById("txtSales").value = $('#txtSales').val();
					wParent.getElementById("txtSalesno2").value = $('#txtSalesno').val();
					wParent.getElementById("txtSales2").value = $('#txtSales').val();
				}
				if ((window.parent.q_name == 'quat' || window.parent.q_name == 'orde' ) && (q_getPara('sys.project').toUpperCase()=='XY' || q_getPara('sys.project').toUpperCase()=='RB') && window.parent.q_cur==1) {
					var wParent = window.parent.document;
					wParent.getElementById("txtCustno").value = $('#txtNoa').val();
					wParent.getElementById("txtComp").value = $('#txtComp').val();
					wParent.getElementById("txtNick").value = $('#txtNick').val();
					wParent.getElementById("txtPaytype").value = $('#txtPaytype').val();
					wParent.getElementById("txtTel").value = $('#txtTel').val();
					wParent.getElementById("txtFax").value = $('#txtFax').val();
					wParent.getElementById("cmbTrantype").value = $('#cmbTrantype').val();
					wParent.getElementById("txtPost").value = $('#txtZip_comp').val();
					wParent.getElementById("txtAddr").value = $('#txtAddr_comp').val();
					wParent.getElementById("txtSalesno").value = $('#txtSalesno').val();
					wParent.getElementById("txtSales").value = $('#txtSales').val();
				}
			}
			
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 38%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.tview tr {
				height: 26px;
			}
			.dbbm {
				float: left;
				width: 60%;
				margin: -1px;
				border: 1px black solid;
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
				height: 35px;
			}
			.tbbm tr td {
				width: 9%;
			}
			.tbbm .tdZ {
				width: 2%;
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
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.tbbm select {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c4 {
				width: 25%;
				float: left;
			}
			.txt.c6 {
				width: 49%;
				float: left;
			}
			.txt.c7 {
				width: 99%;
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
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body onunload='returnparent()' ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left; width:25%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick' class='it'>~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='5'>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial" type="text" class="txt c1"/></td>
						<td>
							<div style="float:left;">
								<input id="Copy" type="checkbox" />
								<span> </span><a id="lblCopy"> </a>
							</div>
							<span> </span>
							<a id='lblWorker' class="lbl"> </a>
						</td>
						<td>
							<input id="txtKdate" type="text" class="txt c6"/>
							<input id="txtWorker" type="text" class="txt c6"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan='3'>
							<input id="txtComp" type="text" class="txt c7"/>
						</td>
						<td><span> </span><a id='lblNick' class="lbl"> </a></td>
						<td><input id="txtNick" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td><select id="cmbStatus" class="txt c1"> </select></td>
						<td><span> </span><a id='lblStartdate' class="lbl"> </a></td>
						<td><input id="txtStartdate" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td  class="isrank" style="display:none;"><span> </span><a id="lblGrp" class="lbl btn"> </a></td>
						<td  class="isrank" style="display:none;">
							<input id="txtGrpno" type="text" style="float:left; width:40%;"/>
							<input id="txtGrpname" type="text" style="float:left; width:60%;"/>
						</td>
						<td  class="isrank" style="display:none;"><span> </span><a id='lblUnit' class="lbl "></a></td>
						<td  class="isrank" style="display:none;"><input id="txtUnit" type="text" class="txt c4" />條線</td>
						<td  class="isrank" style="display:none;"><span> </span><a id='lblTeam' class="lbl" > </a></td>
						<td  class="isrank" style="display:none;"><input id="txtTeam" type="text" class="txt c1"  /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input id="txtTel" type="text" class="txt c7"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input id="txtFax" type="text" class="txt c7"/></td>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td><input id="txtMobile" type="text" class="txt c1"/></td>
					</tr>
					
					<tr>
						<td><span> </span><a id='lblInvoicetitle' class="lbl"> </a></td>
						<td colspan='3'><input id="txtInvoicetitle" type="text" class="txt c7"/></td>
						<td >
							<input id="chkIsvccmon" type="checkbox"/>
							<span> </span><a id=''>凍結</a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_comp' class="lbl"> </a></td>
						<td><input id="txtZip_comp" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_comp" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_invo' class="lbl"> </a></td>
						<td><input id="txtZip_invo" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_invo" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_home' class="lbl"> </a></td>
						<td><input id="txtZip_home" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_home" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEmail' class="lbl"> </a></td>
						<td colspan='5'><input id="txtEmail" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='5'><textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>