<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
            this.errorHandler = null;

            q_tables = 't';
            var q_name = "workv";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = ['txtPmount','txtAvgkg'];
            var q_readonlyt = [];
            var bbmNum = [];
            var bbsNum = [['txtMount',10,2,1],['txtWeight',10,2,1],['txtLengthb',10,0,1]];
            var bbtNum = [];
            var bbmMask = [['txtDatea','999/99/99']];
            var bbsMask = [['txtDatea','999/99/99']];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 6;

            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtCustno_', 'btnCust_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx']
            	,['textSssno___0', '', 'sss', 'noa,namea', 'textSssno___0,textNamea___0', 'sss_b.aspx']
            	,['textSssno___1', '', 'sss', 'noa,namea', 'textSssno___1,textNamea___1', 'sss_b.aspx']
            	,['textSssno___2', '', 'sss', 'noa,namea', 'textSssno___2,textNamea___2', 'sss_b.aspx']
            	,['textSssno___3', '', 'sss', 'noa,namea', 'textSssno___3,textNamea___3', 'sss_b.aspx']
            	,['textSssno___4', '', 'sss', 'noa,namea', 'textSssno___4,textNamea___4', 'sss_b.aspx']);
			
			var z_mech = new Array();
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'no2'];
                q_brwCount();
                q_gt('mech', "", 0, 0, 0, 'mech'); 
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#tmp').find('input').focusout(function(e) {
                	var n = $('input[name=radioSel]:checked').attr('id').replace('radioSel_', '');
                	t_pmount = 0;
                	t_maxNo2 = 0;
                	for(var i=0;i<q_bbtCount;i++){
                		t_no2 = parseInt($('#txtNo2__'+i).val())
                		t_maxNo2 = t_no2>t_maxNo2?t_no2:t_maxNo2;
                	}
                	//------------------------------------------
                	
                	for(var i=0;i<5;i++){
                		t_noq = $('#textNoq___'+i).val();
                		t_no2 = $('#textNo2___'+i).val();
                		t_sssno = $('#textSssno___'+i).val();
                		t_namea = $('#textNamea___'+i).val();
                		if(t_sssno.length>0 || t_namea.length>0){
                			t_pmount ++;	
                		}
                		if(t_noq.length==0 && t_no2.length==0 && t_sssno==0 && t_namea==0){
                			continue;
                		}else if(t_noq.length>0 && t_no2.length>0){
                			for(var j=0;j<q_bbtCount;j++){
                				if(t_noq == $('#txtNoq__'+j).val() && t_no2 == $('#txtNo2__'+j).val()){
                					$('#txtSssno__'+j).val(t_sssno);
                					$('#txtNamea__'+j).val(t_namea);
                					if(t_sssno==0 && t_namea==0){
                						$('#txtNoq__'+j).val('');
                						$('#txtNo2__'+j).val('');
                					}
                					break;
                				}
        					}
                		}else{
                			t_maxNo2++; 
                			t_noq = t_noq = $('#txtNoq_'+n).val();
                			isAdd = false;
                			for(var j=0;j<q_bbtCount;j++){
                				if($('#txtNo2__'+j).val().length==0){
                					isAdd = true;
                					$('#textNoq___'+i).val(t_noq);
                					$('#textNo2___'+i).val(('000'+t_maxNo2).replace(/[0-9]*([0-9][0-9][0-9])/,'$1'));
                					
                					$('#txtNo2__'+j).val(('000'+t_maxNo2).replace(/[0-9]*([0-9][0-9][0-9])/,'$1'));
                					$('#txtNoq__'+j).val(t_noq);
                					$('#txtSssno__'+j).val(t_sssno);
                					$('#txtNamea__'+j).val(t_namea);  
                					            					
                					break;
                				}	
                			}
                			if(!isAdd){
                				$('#textNoq___'+i).val(t_noq);
            					$('#textNo2___'+i).val(('000'+t_maxNo2).replace(/[0-9]*([0-9][0-9][0-9])/,'$1'));
                				var m = q_bbtCount;
                				$('#btnPlut').click();

                				$('#txtNo2__'+m).val(('000'+t_maxNo2).replace(/[0-9]*([0-9][0-9][0-9])/,'$1'));
                				$('#txtNoq__'+m).val(t_noq);
                				$('#txtSssno__'+m).val(t_sssno);
            					$('#txtNamea__'+m).val(t_namea);
    
                			}      	        	              			
                		}
                	}
                	$('#txtPmount_'+n).val(t_pmount);
                });
            }
            function getBbsNoq(strN){
            	for(var i=0;i<q_bbsCount;i++){
            		
            	}
            	
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {            	
                    default:
                        break;
                }
            }
			function q_popPost(id) {
                switch (id) {         
                    default:
                    	try{
                    		if(id.substring(0,12)=='textSssno___'){
                    			$(id).focusout();
                    		}
                    	}catch(e){
                    		
                    	}
                        break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'mech':
                		var as = _q_appendData("mech", "", true);
                		if (as[0] != undefined) {
                			z_mech = new Array();
	                		for(var i=0;i<as.length;i++){
	                			z_mech.push({noa:as[i].noa,mech:as[i].mech})
	                		}
                		}
                		q_gt(q_name, q_content, q_sqlCount, 1);
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	try{
                    		var t_para = JSON.parse(t_name);
                    		if(t_para.action=="data_workj"){
                    			var as = _q_appendData("workj", "", true);
                    			var ar = _q_appendData("workjs", "", true);
		                		if (as[0] != undefined) {
		                			var n = t_para.n;
		                			var string = {A:1,B:2,C:3,D:4,E:5,F:6,G:7,H:8,I:9,J:10,K:11,L:12,M:13,N:14,O:15,P:16,Q:17,R:18,S:19,T:20,U:21,V:22,W:23,X:24,Y:25,Z:26};
		                			var t_noa = t_para.uno.substring(0,11);
		                			var t_noq = t_para.uno.substring(12,15);
									
									$('#txtCustno_'+n).val(as[0].custno);
		                			$('#txtCust_'+n).val(as[0].cust);	
									for(var i=0;i<ar.length;i++){
										if(ar[i].noq == t_noq){
											$('#txtProductno_'+n).val(ar[i].productno);	
				                			$('#txtProduct_'+n).val(ar[i].product);	
				                			$('#txtLengthb_'+n).val(ar[i].lengthb);
				                			t_cmount = ar[i].cmount.split(',');
				                			t_cweight = ar[i].cweight.split(',');
				                			$('#txtMemo').val()
				                			$('#txtMount_'+n).val(t_cmount[string[t_para.uno.substring(15,16)]-1]);
		                					$('#txtWeight_'+n).val(t_cweight[string[t_para.uno.substring(15,16)]-1]);
		                					t_mechno = eval('ar[i].mech'+t_para.uno.substring(18,19));
		                					$('#txtMechno_'+n).val(t_mechno);
		                					for(var j=0;j<z_mech.length;j++){
		                						if(z_mech[j].noa == t_mechno){
		                							$('#txtMech_'+n).val(z_mech[j].mech);
		                							break;
		                						}
		                					}	
		                					sum();                					
											break;	
										}
									}		
		                		}
							}
                    	}catch(e){
                    		alert(e.Message);
                    	}
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('workv_s.aspx', q_name + '_s', "550px", "440px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('input[name=radioSel]').first().click();
            }

            function btnModi() {
            	_btnModi();
            	$('#txtDatea').focus();
            	$('input[name=radioSel]').first().click();
            }

            function btnPrint() {
                q_box("z_workvp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'workv', "95%", "95%", m_print);
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                $('#tmp').find('input').first().focusout();
                	
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workv') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['uno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                $('input[name=radioSel]').first().click();
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                    $('#tmp').find('input').attr('disabled','disabled');
                } else {	
                    $('#txtDatea').datepicker();
                    $('#tmp').find('input').removeAttr('disabled');
                    
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }
            /*function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }
            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlut(org_htm, dest_tag, afield);
            }*/
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtUno_'+i).focusout(function(e) {
							var n = $(this).attr('id').replace('txtUno_', '');
							var t_uno = $(this).val();
							if(t_uno.length==19)
								q_gt('workj', "where=^^noa='"+t_uno.substring(0,11)+"'^^", 0, 0, 0, JSON.stringify({action:"data_workj",n:n,uno:t_uno}));				
						});
                    	$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                        $('#txtCustno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtCustno_', '');
                            $('#btnCust_'+n).click();
                        });
                        $('#radioSel_'+i).click(function(e){
                        	//--------- 確保Noq都有值
                        	var t_maxNoq = 0;
                        	for(var i = 0;i<q_bbsCount;i++){
                        		t_noq = parseInt($('#txtNoq_'+i).val());
                        		t_maxNoq = t_noq>t_maxNoq?t_noq:t_maxNoq;
                        	}
                        	for(var i = 0;i<q_bbsCount;i++){
                        		if($('#txtNoq_'+i).val().length==0){
                        			t_maxNoq ++;
                        			$('#txtNoq_'+i).val( ('000'+t_maxNoq).replace(/[0-9]*([0-9][0-9][0-9])/,'$1'));
                        		}	
                        	}
							//-------------------------------------------------------------- 
							                    	
                        	var n = $(this).attr('id').replace('radioSel_', '');
                        	var t_noq = $('#txtNoq_'+n).val(); 
                        	var m=0
                        	$('#tmp').find('input').val('');//清空再填值
                        	for(var i=0;i<q_bbtCount;i++){
                        		if(t_noq == $('#txtNoq__'+i).val()){
                        			$('#textNoq___'+m).val($('#txtNoq__'+i).val());
                        			$('#textNo2___'+m).val($('#txtNo2__'+i).val());
                        			$('#textSssno___'+m).val($('#txtSssno__'+i).val());
                        			$('#textNamea___'+m).val($('#txtNamea__'+i).val());
                        			m++;
                        		}
                        	}
                        });
                        $('#txtLengthb_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight_'+i).change(function(e){
                    		sum();
                    	});
                    }
                }
                _bbsAssign();
            }
			
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    }
                }
                _bbtAssign();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;

                for(var i=0;i<q_bbsCount;i++){
                	t_weights = q_float('txtWeight_'+i);
                	t_pmounts = q_float('txtPmount_'+i);  	
                	t_avgkg = t_pmounts=0?0:round(q_div(t_weights,t_pmounts),2);
                          
                	$('#txtAvgkg_'+i).val(t_avgkg);
                }
                
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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 150px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 800px;
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
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 130%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1700px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 1700px;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 1500px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td >
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3" rowspan="2"><textarea id="txtMemo" class="txt c1" rows="3"></textarea></td>
					</tr>
					<tr></tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:20px;"> </td>
					<td style="width:180px;"><a id='lbl_uno'>條碼批號</a></td>
					<td style="width:80px;"><a id='lbl_datea'>日期</a></td>
					<td style="width:100px;"><a id='lbl_cust'>客戶</a></td>
					<td style="width:100px;"><a id='lbl_product'>品名</a></td>
					<td style="width:80px;"><a id='lbl_length'>長度</a></td>
					<td style="width:80px;"><a id='lbl_weight'>重量</a></td>
					<td style="width:80px;"><a id='lbl_mount'>數量</a></td>
					<td style="width:80px;"><a id='lbl_pmount'>人數</a></td>
					<td style="width:100px;"><a id='lbl_mech'>機台</a></td>
					<td style="width:80px;"><a id='lbl_avgkg'>平均每人KG</a></td>
					<td style="width:100px;"><a id='lbl_memo'>備註</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><input id="radioSel.*" type="radio" name="radioSel"/></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					
					<td><input class="txt" id="txtUno.*" type="text" style="width:95%;" title=""/></td>
					
					<td><input class="txt" id="txtDatea.*" type="text" style="width:95%;" title=""/></td>
					<td>
						<input class="txt" id="txtCustno.*" type="text" style="width:35%; float:left;"/>
						<input class="txt" id="txtCust.*" type="text" style="width:60%;float:left;"/>
						<input id="btnCust.*" type="button" style="display:none;float:left;"/>
					</td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:35%; float:left;"/>
						<input class="txt" id="txtProduct.*" type="text" style="width:60%;float:left;"/>
						<input id="btnProduct.*" type="button" style="display:none;float:left;"/>
					</td>
					<td><input class="txt num" id="txtLengthb.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtWeight.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtMount.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtPmount.*" type="text" style="width:95%;" title=""/></td>
					<td>
						<input class="txt" id="txtMechno.*" type="text" style="width:35%; float:left;"/>
						<input class="txt" id="txtMech.*" type="text" style="width:60%;float:left;"/>
						<input id="btnMech.*" type="button" style="display:none;float:left;"/>
					</td>
					<td><input class="txt num" id="txtAvgkg.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt" id="txtMemo.*" type="text" style="width:95%;" title=""/></td>
				</tr>
			</table>
		</div>
		<div>
			<table id="tmp" style="background: pink;">
				<tr style="color:white; background:#003366;">
					<td style="width:20px;"></td>
					<td style="width:200px; text-align: center;">員工編號</td>
					<td style="width:200px; text-align: center;">名稱</td>
				</tr>
				<tr>
					<td align="center">1
						<input type="text" id="textNoq___0" style="display:none;"/>
						<input type="text" id="textNo2___0" style="display:none;"/>
						<input type="button" id="buttonSss___0" style="display:none;"/>
					</td>
					<td><input type="text" id="textSssno___0" class="textSssno" style="width:95%;"/></td>
					<td><input type="text" id="textNamea___0" style="width:95%;"/></td>
				</tr>
				<tr>
					<td align="center">2
						<input type="text" id="textNoq___1" style="display:none;"/>
						<input type="text" id="textNo2___1" style="display:none;"/>
						<input type="button" id="buttonSss___1" style="display:none;"/>
					</td>
					<td><input type="text" id="textSssno___1" class="textSssno" style="width:95%;"/></td>
					<td><input type="text" id="textNamea___1" style="width:95%;"/></td>
				</tr>
				<tr>
					<td align="center">3
						<input type="text" id="textNoq___2" style="display:none;"/>
						<input type="text" id="textNo2___2" style="display:none;"/>
						<input type="button" id="buttonSss___2" style="display:none;"/>
					</td>
					<td><input type="text" id="textSssno___2" class="textSssno" style="width:95%;"/></td>
					<td><input type="text" id="textNamea___2" style="width:95%;"/></td>
				</tr>
				<tr>
					<td align="center">4
						<input type="text" id="textNoq___3" style="display:none;"/>
						<input type="text" id="textNo2___3" style="display:none;"/>
						<input type="button" id="buttonSss___3" style="display:none;"/>
					</td>
					<td><input type="text" id="textSssno___3" class="textSssno" style="width:95%;"/></td>
					<td><input type="text" id="textNamea___3" style="width:95%;"/></td>
				</tr>
				<tr>
					<td align="center">5
						<input type="text" id="textNoq___4" style="display:none;"/>
						<input type="text" id="textNo2___4" style="display:none;"/>
						<input type="button" id="buttonSss___4" style="display:none;"/>
					</td>
					<td><input type="text" id="textSssno___4" class="textSssno" style="width:95%;"/></td>
					<td><input type="text" id="textNamea___4" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="display:none;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"></td>
						<td style="width:100px; text-align: center;">Noq</td>
						<td style="width:100px; text-align: center;">No2</td>
						<td style="width:200px; text-align: center;">Sssno</td>
						<td style="width:200px; text-align: center;">Namea</td>
					</tr>
					<tr class="detail">
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input class="txt" id="txtNoq..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtNo2..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtSssno..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtNamea..*" type="text" style="width:95%;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
