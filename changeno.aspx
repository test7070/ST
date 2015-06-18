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
				,['txtOrgproductno', '', 'ucc', 'noa,product', 'txtOrgproductno', 'ucc_b.aspx']
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
                
                $('#btnModi').hide();
                $('#btnDele').hide();
                $('#btnPrint').hide();
                $('#btnSeek').hide(); 
                
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
                	case 'checkCustno_btnOk':
                		var as = _q_appendData("cust", "", true);
                		db_cust=true;
                		if (as[0] != undefined){
                			alert('客戶 '+as[0].noa+' '+as[0].comp+' 已存在!!');
                			chg_cust=false;  
                		}else{
                			chg_cust=true;  
                		}
                		break;
                	case 'checkUcc_btnOk':
                		var as = _q_appendData("ucc", "", true);
                		db_ucc=true;
                		if (as[0] != undefined){
                			alert('物品 '+as[0].noa+' '+as[0].product+' 已存在!!');
            				chg_ucc=false;
                		}else{
                			chg_ucc=true;
                		}
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                } 
                
                if(chg_cust && db_cust && chg_ucc && db_ucc){
                	$('#txtDatea').val(q_date());
	            	var timeDate= new Date();
					var tHours = timeDate.getHours();
					var tMinutes = timeDate.getMinutes();
					$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
                	q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
                	
                	if(!emp($('#txtChgcustno').val())){
                		var t_paras = $('#txtOrgcustno').val()+ ';'+$('#txtChgcustno').val();
						q_func('qtxt.query.custno_change', 'changeno.txt,custno_change,' + t_paras);
					}
					if(!emp($('#txtChgproductno').val())){
						var t_paras = $('#txtOrgproductno').val()+ ';'+$('#txtChgproductno').val();
						q_func('qtxt.query.uccno_change', 'changeno.txt,uccno_change,' + t_paras);
					}
					chg_cust=false;  
	            	chg_ucc=false;
	            	db_cust=false;
	            	db_ucc=false;
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
            
            //判斷是否可變更
            var chg_cust=false;
            var chg_ucc=false;
            //判斷是否已查詢資料是否已重複
            var db_cust=false;
            var db_ucc=false;
            function btnOk() {  
            	chg_cust=false;  
            	chg_ucc=false;
            	db_cust=false;
            	db_ucc=false;
            	//檢查資料
            	if(emp($('#txtOrgcustno').val()) && emp($('#txtChgcustno').val())
            	&& emp($('#txtOrgproductno').val()) && emp($('#txtChgproductno').val())){	
            		alert('請輸入變更資料!!'); 
            		return;
            	}
            	if((!emp($('#txtOrgcustno').val()) && !emp($('#txtChgcustno').val()))
            	|| (!emp($('#txtOrgproductno').val()) && !emp($('#txtChgproductno').val()))
            	){
            		if(!emp($('#txtChgcustno').val())){
            			t_where = "where=^^ noa='" + $('#txtChgcustno').val() + "'^^";
						q_gt('cust', t_where, 0, 0, 0, "checkCustno_btnOk", r_accy);
            		}else{
            			chg_cust=true;
            			db_cust=true;
            		}
            		if(!emp($('#txtChgproductno').val())){
            			t_where = "where=^^ noa='" + $('#txtChgproductno').val() + "'^^";
						q_gt('ucc', t_where, 0, 0, 0, "checkUcc_btnOk", r_accy);
            		}else{
            			chg_ucc=true;
            			db_ucc=true;
            		}
            	}else{
            		alert('變更資料輸入錯誤!!'); 
            		return;
            	}
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                        <td><input id="txtDatea" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblTimea" class="lbl"> </a></td>
                        <td><input id="txtTimea" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblOrgcustno" class="lbl"> </a></td>
                        <td><input id="txtOrgcustno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblChgcustno" class="lbl"> </a></td>
                        <td><input id="txtChgcustno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblOrgproductno" class="lbl"> </a></td>
                        <td><input id="txtOrgproductno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblChgproductno" class="lbl"> </a></td>
                        <td><input id="txtChgproductno" type="text" class="txt c1"/></td>
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
