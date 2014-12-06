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
            var q_name = "ordr";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtDatea','txtOrdbno'];
            var q_readonlys = [];
            var q_readonlyt = [];
            var bbmNum = [['txtBday',10,0,1]];
            var bbsNum = [['txtGmount',10,2,1]];
            var bbtNum = [];
            var bbmMask = [['txtApvdate','999/99/99'],['txtBworkdate','999/99/99'],['txtEworkdate','999/99/99'],['txtDatea','999/99/99']];
            var bbsMask = [['txtWorkdate','999/99/99'],['txtFdate','999/99/99']];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 8;

            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
			
			var z_uccga= new Array(),z_uccgb= new Array(),z_uccgc= new Array();
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('uccga', "", 0, 0, 0, 'uccga');
                
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
                t_uccg = ' @';
                for(var i=0;i<z_uccga.length;i++){
                	t_uccg +=','+z_uccga[i].noa+'@'+z_uccga[i].noa+'. '+z_uccga[i].namea;
                }
                q_cmbParse("cmbUccgano",t_uccg);
                t_uccg = ' @';
                for(var i=0;i<z_uccgb.length;i++){
                	t_uccg +=','+z_uccgb[i].noa+'@'+z_uccgb[i].noa+'. '+z_uccgb[i].namea;
                }
                q_cmbParse("cmbUccgbno",t_uccg);
               	t_uccg = ' @';
                for(var i=0;i<z_uccgc.length;i++){
                	t_uccg +=','+z_uccgc[i].noa+'@'+z_uccgc[i].noa+'. '+z_uccgc[i].namea;
                }
                q_cmbParse("cmbUccgcno",t_uccg);
                //----------------------------------------------------------
                $('#btnImport').click(function(e){
                	var t_noa = $('#txtNoa').val();
                	var t_workgno = $('#txtWorkgno').val();
                	var t_style = $('#txtStyle').val();
                	var t_bworkdate = $('#txtBworkdate').val();
                	var t_eworkdate = $('#txtEworkdate').val();
                	var t_uccgano = $('#cmbUccgano').val();
                	var t_uccgbno = $('#cmbUccgbno').val();
                	var t_uccgcno = $('#cmbUccgcno').val();
					
					var t_string = 'ordr.txt,orda_ordr,' + encodeURI(t_noa) 
                		+ ';' + encodeURI(t_workgno)
                		+ ';' + encodeURI(t_style) 
                		+ ';' + encodeURI(t_bworkdate)
                		+ ';' + encodeURI(t_eworkdate)
                		+ ';' + encodeURI(t_uccgano)
                		+ ';' + encodeURI(t_uccgbno)
                		+ ';' + encodeURI(t_uccgcno);
                	q_func('qtxt.query.orda_ordr', t_string );
                });
                
                $('#btnOrdb').click(function(e){
                	var t_key = q_getPara('sys.key_ordb');
                	var t_noa = $('#txtNoa').val();
                	q_func('qtxt.query.ordr_ordb', 'ordr.txt,ordr_ordb,' + encodeURI(t_key)+';'+ encodeURI(t_noa)); 
                });
                $('#lblOrdbno').click(function(e){
                	q_gt('view_ordb', "where=^^ workgno='"+$('#txtNoa').val()+"'^^", 0, 0, 0, 'view_ordb');
                });
            }
            function checkAll(){
            	$('#tbbs').find('input[type="checkbox"]').prop('checked',$('.checkAll').prop('checked'));
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.orda_ordr':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdano,txtOrdanoq,txtApvmemo,txtProductno,txtProduct,txtSpec,txtUnit,txtWorkdate,txtStyle,txtGmount,txtStkmount,txtSchmount,txtSafemount,txtNetmount,txtFdate,txtFmount,txtMemo,txtWmount'
                        	, as.length, as, 'noa,noq,apvmemo,productno,product,spec,unit,workdate,style,gmount,stkmount,schmount,safemount,netmount,fdate,fmount,memo,wmount', '','');
                        	sum();
                        } else {
                            alert('無資料!');
                        }
                		break;
            		case 'qtxt.query.ordr_ordb':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            if(as[0].msg.length>0){
                            	alert(as[0].msg);
                            }else{
                            	$('#txtOrdbno').val(as[0].ordbno);
                            	abbm[q_recno].ordbno = as[0].ordbno;
                            }	
                        } 
                        Unlock(1);
                		break;
            		case 'qtxt.query.ordr_orda':
                		var as = _q_appendData("tmp0", "", true, true);
                        Unlock(1);
                		break;
                    default:
                        break;
                }
            }
			function q_popPost(id) {
                switch (id) {
                    default:
                        break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'view_ordb':
                		var as = _q_appendData("view_ordb", "", true);
                		if (as[0] != undefined) {
                			t_where = '';
	                		for(var i=0;i<as.length;i++){
	                			t_where += (t_where.length>0?' or ':'')+ " noa='"+as[i].noa+"'" ;
	                		}
	                		q_box("ordb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'ordb'+r_accy, "95%", "95%", q_getMsg("popOrdb"));
                		}
                		break;
                	case 'uccga':
                		var as = _q_appendData("uccga", "", true);
                		if (as[0] != undefined) {
                			z_uccga = new Array();
	                		for(var i=0;i<as.length;i++){
	                			z_uccga.push({noa:as[i].noa,namea:as[i].namea});
	                		}
                		}
                		q_gt('uccgb', "", 0, 0, 0, 'uccgb'); 
                		break;
            		case 'uccgb':
                		var as = _q_appendData("uccgb", "", true);
                		if (as[0] != undefined) {
                			z_uccgb = new Array();
	                		for(var i=0;i<as.length;i++){
	                			z_uccgb.push({noa:as[i].noa,namea:as[i].namea});
	                		}
                		}
                		q_gt('uccgc', "", 0, 0, 0, 'uccgc'); 
                		break;  
            		case 'uccgc':
                		var as = _q_appendData("uccgc", "", true);
                		if (as[0] != undefined) {
                			z_uccgc = new Array();
	                		for(var i=0;i<as.length;i++){
	                			z_uccgc.push({noa:as[i].noa,namea:as[i].namea});
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
                    		if(t_para.action==""){
							}
                    	}catch(e){
                    	}
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Lock(1,{opacity:0});
                var t_noa = $('#txtNoa').val();
				
            	q_func('qtxt.query.ordr_orda', 'ordr.txt,ordr_orda,' + encodeURI(t_noa));
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
                q_box('ordr_s.aspx', q_name + '_s', "550px", "440px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
            	_btnModi();
            	$('#txtDatea').focus();
            }

            function btnPrint() {
                q_box("z_ordrp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'workj', "95%", "95%", m_print);
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtApvdate').val().length == 0 || !q_cd($('#txtApvdate').val())) {
                    alert(q_getMsg('lblApvdate') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordr') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                    $('#btnImport').attr('disabled','disabled');
                    $('#chkApv').attr('disabled','disabled');
                    $('#btnOrdb').removeAttr('disabled');
                } else {	
                    $('#txtDatea').datepicker();
                    $('#btnImport').removeAttr('disabled');
                    $('#chkApv').removeAttr('disabled');
                    $('#btnOrdb').attr('disabled','disabled');
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
                    	$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                    }
                }
                _bbsAssign();
            }
			function imgDisplay(obj){
				$(obj).hide();
			}
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtProductno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno__', '');
                            $('#btnProduct__'+n).click();
                        });
                    }
                }
                _bbtAssign();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
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
                width: 1200px;
            }
            .dview {
                float: left;
                width: 300px;
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
                width: 900px;
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
                width: 1500px;
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
                width: 100%;
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
                width: 1000px;
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
		<div id='dmain' style="overflow:visible;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:150px; color:black;"><a id='vewWorkgno'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='workgno' style="text-align: center;">~workgno</td>
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
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorkgno" class="lbl"> </a></td>
						<td><input id="txtWorkgno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblStyle" class="lbl"> </a></td>
						<td><input id="txtStyle"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorkdate" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtBworkdate"  type="text" style="float:left;width:45%"/>
							<span style="float:left;display:block;width:10%;text-align: center;">～</span>
							<input id="txtEworkdate"  type="text" style="float:left;width:45%"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblUccga" class="lbl"> </a></td>
						<td><select id="cmbUccgano" class="txt c1"></select></td>
						<td><span> </span><a id="lblUccgb" class="lbl"> </a></td>
						<td><select id="cmbUccgbno" class="txt c1"></select></td>
						<td><span> </span><a id="lblUccgc" class="lbl"> </a></td>
						<td><select id="cmbUccgcno" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5" rowspan="2"><textarea id="txtMemo" class="txt c1" rows="3"></textarea></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBday" class="lbl"> </a></td>
						<td><input id="txtBday"  type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblApvdate" class="lbl"> </a></td>
						<td><input id="txtApvdate"  type="text"  class="txt c1"/></td>
						<td></td>
						<td style="text-align: center;"><input id="btnImport" type="button" value="匯入" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdbno" class="lbl btn"> </a></td>
						<td colspan="3"><input id="txtOrdbno" type="text" class="txt c1"/></td>
						<td></td>
						<td><input id="btnOrdb" type="button" value="轉請購單" class="txt c1"/></td>
					</tr>
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
					<td style="width:20px;"><a id='lbl_apv'>核準</a><input id="chkApv" class="checkAll" type="checkbox" onclick="checkAll()"/></td>
					<td style="width:100px;"><a id='lbl_apvmemo'>簽核意見</a></td>
					<td style="width:80px;"><a id='lbl_workdate'>開工日</a></td>
					<td style="width:80px;"><a id='lbl_style'>機型</a></td>
					<td style="width:350px;"><a id='lbl_product'>物品</a></td>
					<td style="width:150px;"><a id='lbl_spec'>規格</a></td>
					<td style="width:50px;"><a id='lbl_unit'>單位</a></td>
					<td style="width:80px;"><a id='lbl_gmount'>毛需求</a></td>
					<td style="width:80px;"><a id='lbl_wmount'>製令未領</a></td>
					<td style="width:80px;"><a id='lbl_stkmount'>庫存量</a></td>
					<td style="width:80px;"><a id='lbl_schmount'>在途量</a></td>
					<td style="width:80px;"><a id='lbl_safemount'>安全存量</a></td>
					<td style="width:80px;"><a id='lbl_netmount'>淨需求量</a></td>
					<td style="width:80px;"><a id='lbl_fdate'>預測日期</a></td>
					<td style="width:80px;"><a id='lbl_fmount'>預測需求</a></td>
					<td style="width:80px;"><a id='lbl_memo'>備註</a></td>
					
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
						<input id="txtOrdano.*" type="text" style="display: none;"/>
						<input id="txtOrdanoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td align="center"><input id="chkApv.*" type="checkbox"/></td>
					<td><input class="txt" id="txtApvmemo.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt" id="txtWorkdate.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt" id="txtStyle.*" type="text" style="width:95%;" title=""/></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:60%; float:left;"/>
						<input class="txt" id="txtProduct.*" type="text" style="width:35%;float:left;"/>
						<input id="btnProduct.*" type="button" style="display:none;">
					</td>
					<td><input class="txt" id="txtSpec.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt" id="txtUnit.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtGmount.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtWmount.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtStkmount.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtSchmount.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtSafemount.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtNetmount.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt" id="txtFdate.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt num" id="txtFmount.*" type="text" style="width:95%;" title=""/></td>
					<td><input class="txt" id="txtMemo.*" type="text" style="width:95%;" title=""/></td>
				</tr>
			</table>
		</div>
		
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="position: absolute;top:280px; left:800px; display:none;width:300px;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="display:none;">
							<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"></td>
					</tr>
					<tr>
						<td style="display:none;">
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
							<input class="txt" id="txtNo2..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
