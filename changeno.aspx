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
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "changeno";
            var q_readonly = ['txtNoa','txtDatea','txtTimea','txtWorker'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 15;
            aPop = new Array(
				['txtOrgcustno', '', 'cust', 'noa,comp', 'txtOrgcustno', 'cust_b.aspx']
				,['txtOrgproductno', '', 'ucaucc', 'noa,product', 'txtOrgproductno', 'ucaucc_b.aspx']
				,['txtOrgpartno', '', 'part', 'noa,part', 'txtOrgpartno', 'part_b.aspx']
				,['txtOrgtggno', '', 'tgg', 'noa,comp', 'txtOrgtggno', 'tgg_b.aspx']
				,['txtOrgstationno', '', 'station', 'noa,station', 'txtOrgstationno', 'station_b.aspx']
				,['txtOrgacc1', '', 'acc', 'acc1,acc2', 'txtOrgacc1', 'acc_b.aspx']
			);

            $(document).ready(function() {
                bbmKey = ['noa'];
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
                q_mask(bbmMask);
                q_cmbParse("cmbTypea",'cust@客戶編號,tgg@廠商編號,part@部門編號,product@物品編號,station@工作線別編號,acc1@會計科目,sss@員工編號');
                $('#btnModi').hide();
                $('#btnDele').hide();
                $('#btnPrint').hide();
                $('#btnSeek').hide(); 
                
                $('#cmbTypea').change(function() {
                	chgtrshow();
                });
                
            }
            
            function chgtrshow() {
            	var trchg=$('#cmbTypea').val();
            	$('.chg').hide();
                $('.'+trchg).show();
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }  
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                } 
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
            }
            
            function btnIns() {
                _btnIns();
                $('#txtDatea').val(q_date());
            	var timeDate= new Date();
				var tHours = timeDate.getHours();
				var tMinutes = timeDate.getMinutes();
				$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
				$('#txtWorker').val(r_name);
                $('#txtOrgcustno').focus();
            }

            function btnModi() {
            }

            function btnPrint() {
            }
            
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            
            function btnOk() {
            	//檢查資料
            	if(emp($('#txtOrgcustno').val()) && emp($('#txtChgcustno').val())
	            	&& emp($('#txtOrgproductno').val()) && emp($('#txtChgproductno').val())
	            	&& emp($('#txtOrgpartno').val()) && emp($('#txtChgpartno').val())
	            	&& emp($('#txtOrgtggno').val()) && emp($('#txtChgtggno').val())
	            	&& emp($('#txtOrgstationno').val()) && emp($('#txtChgstationno').val())
	            	&& emp($('#txtOrgacc1').val()) && emp($('#txtChgacc1').val())
	            	&& emp($('#txtOrgsssno').val()) && emp($('#txtChgsssno').val())
            	){	
            		alert('請輸入變更資料!!'); 
            		return;
            	}
            	
            	switch($('#cmbTypea').val()) {
            		case 'cust'://客戶編號
            			if(!emp($('#txtOrgcustno').val()) && !emp($('#txtChgcustno').val())){
            				var t_where = "where=^^ noa='" + $('#txtChgcustno').val() + "'^^";
							q_gt('cust', t_where, 0, 0, 0, "checkCustno_btnOk", r_accy,1);
							var as = _q_appendData("cust", "", true);
	                		if (as[0] != undefined){
	                			alert('客戶編號'+as[0].noa+' '+as[0].comp+' 已存在!!');
	                		}else{
	                			var t_where = "where=^^ noa='" + $('#txtChgcustno').val() + "'^^";
								q_gt('cust_2s', t_where, 0, 0, 0, "checkCust_2s_btnOk", r_accy,1);
								var as2 = _q_appendData("cust_2s", "", true);
		                		if (as2[0] != undefined){
		                			alert('客戶編號【'+as[0].noa+'】帳款資料存在禁止編號異動!!');
		                		}else{
		                			//存檔變動
		                			$('#txtDatea').val(q_date());
					            	var timeDate= new Date();
									var tHours = timeDate.getHours();
									var tMinutes = timeDate.getMinutes();
									$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
				                	q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
				                	
				                	var t_paras = $('#txtOrgcustno').val()+ ';'+$('#txtChgcustno').val()+';'+q_getPara('sys.project').toUpperCase();
									q_func('qtxt.query.custno_change', 'changeno.txt,custno_change,' + t_paras);
		                		}
	                		}
            			}else{
            				alert('請輸入要變動的客戶編號!!'); 
            			}
            			break;
            		case 'tgg'://廠商編號
            			if(!emp($('#txtOrgtggno').val()) && !emp($('#txtChgtggno').val())){
            				var t_where = "where=^^ noa='" + $('#txtChgtggno').val() + "'^^";
							q_gt('tgg', t_where, 0, 0, 0, "checkTggno_btnOk", r_accy,1);
							var as = _q_appendData("tgg", "", true);
	                		if (as[0] != undefined){
	                			alert('廠商編號'+as[0].noa+' '+as[0].comp+' 已存在!!');
	                		}else{
	                			var t_where = "where=^^ noa='" + $('#txtChgtggno').val() + "'^^";
								q_gt('tgg_2s', t_where, 0, 0, 0, "checkTgg_2s_btnOk", r_accy,1);
								var as2 = _q_appendData("tgg_2s", "", true);
		                		if (as2[0] != undefined){
		                			alert('廠商編號【'+as[0].noa+'】帳款資料存在禁止編號異動!!');
		                		}else{
		                			//存檔變動
		                			$('#txtDatea').val(q_date());
					            	var timeDate= new Date();
									var tHours = timeDate.getHours();
									var tMinutes = timeDate.getMinutes();
									$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
				                	q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
				                	
				                	var t_paras = $('#txtOrgtggno').val()+ ';'+$('#txtChgtggno').val()+';'+q_getPara('sys.project').toUpperCase();
									q_func('qtxt.query.tggno_change', 'changeno.txt,tggno_change,' + t_paras);
		                		}
	                		}
            			}else{
            				alert('請輸入要變動的廠商編號!!'); 
            			}
            			break;
            		case 'product'://物品編號
            			if(!emp($('#txtOrgproductno').val()) && !emp($('#txtChgproductno').val())){
            				var t_where = "where=^^ noa='" + $('#txtChgproductno').val() + "'^^";
							q_gt('ucc', t_where, 0, 0, 0, "checkUcc_btnOk", r_accy,1);
							var as = _q_appendData("ucc", "", true);
	                		if (as[0] != undefined){
	                			alert('物品編號 '+as[0].noa+' '+as[0].product+' 已存在!!');
	                		}else{
	                			//檢查uca
	                			var t_where = "where=^^ noa='" + $('#txtChgproductno').val() + "'^^";
								q_gt('uca', t_where, 0, 0, 0, "checkUca_btnOk", r_accy,1);
								var as2 = _q_appendData("uca", "", true);
								if (as2[0] != undefined){
									alert('物品編號 '+as2[0].noa+' '+as2[0].product+' 已存在!!');
								}else{
									//存檔變動
		                			$('#txtDatea').val(q_date());
					            	var timeDate= new Date();
									var tHours = timeDate.getHours();
									var tMinutes = timeDate.getMinutes();
									$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
				                	q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
		                	
									var t_paras = $('#txtOrgproductno').val()+ ';'+$('#txtChgproductno').val()+';'+q_getPara('sys.project').toUpperCase();
									q_func('qtxt.query.uccno_change', 'changeno.txt,uccno_change,' + t_paras);
								}
	                		}
            			}else{
            				alert('請輸入要變動的物品編號!!'); 
            			}
            			break;
            		case 'part'://部門
            			if(!emp($('#txtOrgpartno').val()) && !emp($('#txtChgpartno').val())){
            				var t_where = "where=^^ noa='" + $('#txtChgpartno').val() + "'^^";
							q_gt('part', t_where, 0, 0, 0, "checkPart_btnOk", r_accy,1);
							var as = _q_appendData("part", "", true);
	                		if (as[0] != undefined){
	                			alert('部門編號 '+as[0].noa+' '+as[0].part+' 已存在!!');
	                		}else{
	                			//存檔變動
	                			$('#txtDatea').val(q_date());
				            	var timeDate= new Date();
								var tHours = timeDate.getHours();
								var tMinutes = timeDate.getMinutes();
								$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
			                	q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
	                	
								var t_paras = $('#txtOrgpartno').val()+ ';'+$('#txtChgpartno').val()+';'+q_getPara('sys.project').toUpperCase();
								q_func('qtxt.query.partno_change', 'changeno.txt,partno_change,' + t_paras);
	                		}
            			}else{
            				alert('請輸入要變動的部門編號!!'); 
            			}
            			break;
            		case 'station'://工作線別
            			if(!emp($('#txtOrgstationno').val()) && !emp($('#txtChgstationno').val())){
            				var t_where = "where=^^ noa='" + $('#txtChgstationno').val() + "'^^";
							q_gt('station', t_where, 0, 0, 0, "checkStation_btnOk", r_accy,1);
							var as = _q_appendData("station", "", true);
	                		if (as[0] != undefined){
	                			alert('工作線別編號 '+as[0].noa+' '+as[0].station+' 已存在!!');
	                		}else{
	                			//存檔變動
	                			$('#txtDatea').val(q_date());
				            	var timeDate= new Date();
								var tHours = timeDate.getHours();
								var tMinutes = timeDate.getMinutes();
								$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
			                	q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
	                	
								var t_paras = $('#txtOrgstationno').val()+ ';'+$('#txtChgstationno').val()+';'+q_getPara('sys.project').toUpperCase();
								q_func('qtxt.query.stationno_change', 'changeno.txt,stationno_change,' + t_paras);
	                		}
            			}else{
            				alert('請輸入要變動的工作線別編號!!'); 
            			}
            			break;
            		case 'acc1'://會計科目
            			if(!emp($('#txtOrgacc1').val()) && !emp($('#txtChgacc1').val())){
            				var t_where = "where=^^ acc1='" + $('#txtChgacc1').val() + "'^^";
							q_gt('acc', t_where, 0, 0, 0, "checkAcc1_btnOk", r_accy,1);
							var as = _q_appendData("acc", "", true);
	                		if (as[0] != undefined){
	                			alert('會計科目 '+as[0].acc1+' '+as[0].acc2+' 已存在!!');
	                		}else{
	                			//存檔變動
	                			$('#txtDatea').val(q_date());
				            	var timeDate= new Date();
								var tHours = timeDate.getHours();
								var tMinutes = timeDate.getMinutes();
								$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
			                	q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
	                	
								var t_paras = $('#txtOrgacc1').val()+ ';'+$('#txtChgacc1').val()+';'+q_getPara('sys.project').toUpperCase();
								q_func('qtxt.query.acc1_change', 'changeno.txt,acc1_change,' + t_paras);
	                		}
            			}else{
            				alert('請輸入要變動的會計科目編號!!'); 
            			}
            			break;
            		case 'sss'://員工編號
            			if(!emp($('#txtOrgsssno').val()) && !emp($('#txtChgsssno').val())){
            				var t_where = "where=^^ noa='" + $('#txtChgsssno').val() + "'^^";
							q_gt('sss', t_where, 0, 0, 0, "checkSssno_btnOk", r_accy,1);
							var as = _q_appendData("sss", "", true);
	                		if (as[0] != undefined){
	                			alert('員工編號'+as[0].noa+' '+as[0].namea+' 已存在!!');
	                		}else{
	                			var t_where = "where=^^ noa='" + $('#txtChgsssno').val() + "'^^";
								q_gt('labase', t_where, 0, 0, 0, "checkLabase_btnOk", r_accy,1);
								var as2 = _q_appendData("labase", "", true);
		                		if (as2[0] != undefined){
		                			alert('勞健保員工編號【'+as[0].noa+' '+as[0].namea+'】已存在!!');
		                		}else{
		                			//存檔變動
		                			$('#txtDatea').val(q_date());
					            	var timeDate= new Date();
									var tHours = timeDate.getHours();
									var tMinutes = timeDate.getMinutes();
									$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
				                	q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
				                	
				                	var t_paras = $('#txtOrgsssno').val()+ ';'+$('#txtChgsssno').val()+';'+q_getPara('sys.project').toUpperCase();
									q_func('qtxt.query.sssno_change', 'changeno.txt,sssno_change,' + t_paras);
		                		}
	                		}
            			}else{
            				alert('請輸入要變動的員工編號!!'); 
            			}
            			break;
					default:
						alert('變更資料輸入錯誤!!'); 
            	}
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                chgtrshow();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                chgtrshow();
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
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
            
            function q_popPost(id) {
                switch (id) {
                	case 'txtOrgcustno':
                		$('#txtChgcustno').focus();
                		break;
                	case 'txtOrgproductno':
                		$('#txtChgproductno').focus();
                		break;
                	case 'txtOrgtggno':
                		$('#txtChgtggno').focus();
                		break;
                	case 'txtOrgpartno':
                		$('#txtChgpartno').focus();
                		break;
                	case 'txtOrgstationno':
                		$('#txtChgstationno').focus();
                		break;
                	case 'txtOrgacc1':
                		$('#txtChgacc1').focus();
                		break;
                    default:
                        break;
                }
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.custno_change':
                		var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			if(as[0].mess=='success'){
		                		alert('客戶編號更新成功!!。');
							}else
								alert('客戶編號更新失敗，請聯絡工程師!!。');
						}else{
							alert('客戶編號更新失敗，請聯絡工程師!!。');
						}
                		break;
                	case 'qtxt.query.tggno_change':
                		var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			if(as[0].mess=='success'){
		                		alert('廠商編號更新成功!!。');
							}else
								alert('廠商編號更新失敗，請聯絡工程師!!。');
						}else{
							alert('廠商編號更新失敗，請聯絡工程師!!。');
						}
                		break;
                	case 'qtxt.query.uccno_change':
                		var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			if(as[0].mess=='success'){
		                		alert('物品編號更新成功!!。');
							}else
								alert('物品編號更新失敗，請聯絡工程師!!。');
						}else{
							alert('物品編號更新失敗，請聯絡工程師!!。');
						}
                		break;
                	case 'qtxt.query.partno_change':
                		var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			if(as[0].mess=='success'){
		                		alert('部門編號更新成功!!。');
							}else
								alert('部門編號更新失敗，請聯絡工程師!!。');
						}else{
							alert('部門編號更新失敗，請聯絡工程師!!。');
						}
                		break;
                	case 'qtxt.query.stationno_change':
                		var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			if(as[0].mess=='success'){
		                		alert('工作線別編號更新成功!!。');
							}else
								alert('工作線別編號更新失敗，請聯絡工程師!!。');
						}else{
							alert('工作線別編號更新失敗，請聯絡工程師!!。');
						}
                		break;
                	case 'qtxt.query.acc1_change':
                		var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] != undefined) {
                			if(as[0].mess=='success'){
		                		alert('會計科目更新成功!!。');
							}else
								alert('會計科目更新失敗，請聯絡工程師!!。');
						}else{
							alert('會計科目更新失敗，請聯絡工程師!!。');
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
                width: 250px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
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
                width: 700px;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
                        <td align="center" style="width:120px; color:black;"><a id="vewNoa"> </a></td>
                    </tr>
                    <tr>
                        <td ><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="datea" style="text-align: center;">~datea</td>
                        <td id="noa" style="text-align: center;">~noa</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td><input id="txtNoa"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblTypea" class="lbl"> </a></td>
                        <td><select id="cmbTypea" class="txt c1"> </select></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                        <td><input id="txtDatea" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblTimea" class="lbl"> </a></td>
                        <td><input id="txtTimea" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="cust chg" style="display:none;">
                        <td><span> </span><a id="lblOrgcustno" class="lbl"> </a></td>
                        <td><input id="txtOrgcustno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblChgcustno" class="lbl"> </a></td>
                        <td><input id="txtChgcustno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="product chg" style="display:none;">
                        <td><span> </span><a id="lblOrgproductno" class="lbl"> </a></td>
                        <td><input id="txtOrgproductno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblChgproductno" class="lbl"> </a></td>
                        <td><input id="txtChgproductno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="part chg" style="display:none;">
                        <td><span> </span><a id="lblOrgpartno" class="lbl"> </a></td>
                        <td><input id="txtOrgpartno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblChgpartno" class="lbl"> </a></td>
                        <td><input id="txtChgpartno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tgg chg" style="display:none;">
                        <td><span> </span><a id="lblOrgtggno" class="lbl"> </a></td>
                        <td><input id="txtOrgtggno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblChgtggno" class="lbl"> </a></td>
                        <td><input id="txtChgtggno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="station chg" style="display:none;">
                        <td><span> </span><a id="lblOrgstationno" class="lbl"> </a></td>
                        <td><input id="txtOrgstationno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblChgstationno" class="lbl"> </a></td>
                        <td><input id="txtChgstationno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="acc1 chg" style="display:none;">
                        <td><span> </span><a id="lblOrgacc1" class="lbl"> </a></td>
                        <td><input id="txtOrgacc1" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblChgacc1" class="lbl"> </a></td>
                        <td><input id="txtChgacc1" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="sss chg" style="display:none;">
                        <td><span> </span><a id="lblOrgsssno" class="lbl"> </a></td>
                        <td><input id="txtOrgsssno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblChgsssno" class="lbl"> </a></td>
                        <td><input id="txtChgsssno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker" class="lbl"> </a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
