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
            var q_name = "ordp";
            var q_readonly = ['txtNoa','txtDatea','txtWorker', 'txtWorker2', 'txtWorkgno'];
            var q_readonlys = ['txtNoq'];
            var q_readonlyt = ['txtNo2','txtNoq'];
            var bbmNum = [];
            var bbsNum = [];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //q_xchg = 1;
            brwCount2 = 10;

            aPop = new Array(['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', 'tgg_b.aspx']
            	,['txtBtggno', 'btnBtggno', 'tgg', 'noa,comp', 'txtBtggno,txtBtgg', 'tgg_b.aspx']
            	,['txtEtggno', 'btnEtggno', 'tgg', 'noa,comp', 'txtEtggno,txtEtgg', 'tgg_b.aspx']
            	,['txtBproductno', 'btnBproductno', 'ucc', 'noa,product', 'txtBproductno,txtBproduct', 'ucc_b.aspx']
            	,['txtEproductno', 'btnEproductno', 'ucc', 'noa,product', 'txtEproductno,txtEproduct', 'ucc_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'no2'];
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
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                
                $('#txtBtggno').bind('contextmenu', function(e) {
					/*滑鼠右鍵*/
					e.preventDefault();					
					$('#btnBtggno').click();
				}); 
                $('#txtEtggno').bind('contextmenu', function(e) {
					/*滑鼠右鍵*/
					e.preventDefault();					
					$('#btnEtggno').click();
				}); 
				$('#txtBproductno').bind('contextmenu', function(e) {
					/*滑鼠右鍵*/
					e.preventDefault();					
					$('#btnBproductno').click();
				}); 
                $('#txtEproductno').bind('contextmenu', function(e) {
					/*滑鼠右鍵*/
					e.preventDefault();					
					$('#btnEproductno').click();
				}); 
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                    break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                refresh(q_recno);    
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
                q_box('ordp_s.aspx', q_name + '_s', "520px", "520px", q_getMsg("popSeek"));
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
                q_box("z_ordp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'ordp', "95%", "95%", m_print);
            }
            function btnOk() {
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }               
                //BBS不存在,刪除BBT
                for(var j=0;j<q_bbtCount;j++){
                    t_noq = $('#txtNoq__'+j).val();
                    t_namea = $('#txtNamea__'+j).val();
                    t_isexist = false;
                    for(var i=0;i<q_bbsCount;i++){
                        if(t_noq==$('#txtNoq_'+i).val()){
                            t_isexist = true;
                            break;
                        }
                    }
                    if(!t_isexist){
                        $('#txtOrdbaccy__'+j).val('');
                        $('#txtOrdbno__'+j).val('');
                        $('#txtNo3__'+j).val('');
                        $('#txtMount__'+j).val('');
                        $('#txtPrice__'+j).val('');
                        $('#txtMemo__'+j).val('');
                    }
                }
                
                sum();
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }   
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordp') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
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
            function bbtSave(as) {
                /*if (!as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }*/
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                if (q_cur > 0 && q_cur < 4)
                    sum();
                
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
               
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace(/(.*_+)(.*)/, '$2');
							$('#btnProductno_'+n).click();
						}); 
						$('#txtTggno_' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace(/(.*_+)(.*)/, '$2');
							$('#btnTggno_'+n).click();
						});  
                    }
                }
                _bbsAssign();
            }

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtOrdbno__' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace(/(.*_+)(.*)/, '$2');
							var t_accy = $.trim($('#txtOrdbaccy__'+n).val());
							var t_noa = $.trim($(this).val());
							if(t_accy>0 && t_noa.length>0)
								q_box("ordb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" +t_noa+"';" + t_accy, 'ordb', "95%", "95%", m_print);
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

            function q_popPost(id) {
                switch (id) {
                    default:
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
                width: 650px;
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
                width: 100%;
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
                width: 70%;
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
            #InterestWindows{
                display:none;
                width:20%;
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
        <div id='dmain'>
            <div class="dview" id="dview" >
                <table class="tview" id="tview" >
                    <tr>
                        <td style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:35%"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:60%"><a id='vewNoa'> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='noa'>~noa</td>
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
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td><input id="txtNoa" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblDatea' class="lbl"> </a></td>
                        <td><input id="txtDatea" type="text" class="txt c1"/></td>
                    </tr>
                    <tr style="background-color: tan;">
                        <td><span> </span><a id='lblKind' class="lbl"> </a></td>
                        <td><select id="cmbKind" class="txt c1"> </select></td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr style="background-color: tan;">
                        <td><span> </span><a id='lblTgg' class="lbl"> </a></td>
                        <td colspan="3">
                        	<input id="btnBtggno" type="button" style="display:none;"/>
                        	<input id="txtBtggno" type="text" class="txt" style="float:left;width:20%;"/>
                        	<input id="txtBtgg" type="text" class="txt" style="float:left;width:20%;"/>
                        	<span style="float:left;width:20px;display:block;">～</span>
                        	<input id="btnBtggno" type="button" style="display:none;"/>
                        	<input id="txtEtggno" type="text" class="txt" style="float:left;width:20%;"/>
                    		<input id="txtEtgg" type="text" class="txt" style="float:left;width:20%;"/>
                    	</td>
                    	<td class="tdZ"> </td>
                    </tr>
                    <tr style="background-color: tan;">
                        <td><span> </span><a id='lblProduct' class="lbl"> </a></td>
                        <td colspan="3">
                        	<input id="btnBproductno" type="button" style="display:none;"/>
                        	<input id="txtBproductno" type="text" class="txt" style="float:left;width:20%;"/>
                        	<input id="txtBproduct" type="text" class="txt" style="float:left;width:20%;"/>
                        	<span style="float:left;width:20px;display:block;">～</span>
                        	<input id="btnBproductno" type="button" style="display:none;"/>
                        	<input id="txtEproductno" type="text" class="txt" style="float:left;width:20%;"/>
                    		<input id="txtEproduct" type="text" class="txt" style="float:left;width:20%;"/>
                    	</td>
                    	<td class="tdZ"> </td>
                    </tr>
                    <tr style="background-color: tan;">
                        <td><span> </span><a id='lblOdate' class="lbl"> </a></td>
                        <td colspan="3">
                        	<input id="txtBodate" type="text" class="txt" style="float:left;width:20%;"/>
                        	<span style="float:left;width:20px;display:block;">～</span>
                        	<input id="txtEodate" type="text" class="txt" style="float:left;width:20%;"/>
                    	</td>
                    	<td class="tdZ"> </td>
                    </tr>
                    <tr style="background-color: tan;">
                        <td><span> </span><a id='lblOrdbno' class="lbl"> </a></td>
                        <td><input id="txtOrdbno" type="text" class="txt c1"/></td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr style="background-color: tan;">
                        <td><span> </span><a id='lblLdate' class="lbl"> </a></td>
                        <td colspan="3">
                        	<input id="txtBldate" type="text" class="txt" style="float:left;width:20%;"/>
                        	<span style="float:left;width:20px;display:block;">～</span>
                        	<input id="txtEldate" type="text" class="txt" style="float:left;width:20%;"/>
                    	</td>
                    	<td class="tdZ"> </td>
                    </tr>
                    <tr style="background-color: tan;">
                        <td><span> </span><a id='lblOptiona' class="lbl"> </a></td>
                        <td><select id="cmbOptiona" class="txt c1"> </select></td>
                        <td> </td>
                        <td><input id="btnImport" type="button" class="txt c1"/> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                        <td><input id="txtWorker2" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblMemo' class='lbl'> </a></td>
                        <td colspan='3'><input id="txtMemo" type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
            <div class='dbbs'>
                <table id="tbbs" class='tbbs'>
                    <tr style='color:white; background:#003366;' >
                        <td style="width:20px;">
                        <input id="btnPlus" type="button" style="font-size: medium; font-weight: bold; width:90%; display:none;" value="＋"/>
                        </td>
                        <td style="width:20px;"> </td>
                        <td align="center" style="width:100px;"><a id='lblTggno_s'> </a></td>
                        <td align="center" style="width:160px;"><a id='lblTgg_s'> </a></td>
                        <td align="center" style="width:160px;"><a id='lblProductno_s'> </a></td>
                        <td align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblSpec_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblUnit_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
                    </tr>
                    <tr style='background:#cad3ff;'>
                        <td align="center">
                        <input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="－"/>
                        <input id="txtNoq.*" type="text" style="display: none;"/>
                        </td>
                        <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                        <td>
                        	<input id="txtTggno.*" type="text" style="float:left;width:95%;"/>
                        	<input type="button" id="btnTggno.*" style="display:none;"/>
                        </td>
                        <td><input id="txtTgg.*" type="text" style="float:left;width:95%;"/></td>
                        <td>
                        	<input id="txtProductno.*" type="text" style="float:left;width:95%;"/>
                        	<input type="button" id="btnProductno.*" style="display:none;"/>
                        </td>
                        <td><input id="txtProduct.*" type="text" style="float:left;width:95%;"/></td>
                        <td><input id="txtSpec.*" type="text" style="float:left;width:95%;"/></td>
                        <td><input id="txtUnit.*" type="text" style="float:left;width:95%;"/></td>
                        <td><input id="txtMount.*" type="text" style="float:left;width:95%;text-align: right;"/></td>
                        <td><input id="txtPrice.*" type="text" style="float:left;width:95%;text-align: right;"/></td>
                        <td><input id="txtMoney.*" type="text" style="float:left;width:95%;text-align: right;"/></td>
                        <td><input id="txtMemo.*" type="text"style="float:left;width:95%;"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <input id="q_sys" type="hidden" />
        <div id="dbbt">
            <table id="tbbt" >
                <tbody>
                    <tr class="head" style="color:white; background:#003366;">
                        <td style="width:20px;">
                            <input id="btnPlut" type="button" style="display:none;font-size: medium; font-weight: bold;" value="＋"/>
                        </td>
                        <td style="width:20px;"> </td>
                        <td align="center" style="width:150px;"><a id='lblOrdbno_t'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblMount_t'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblPrice_t'> </a></td>
                        <td align="center" style="width:200px;"><a id='lblMemo_t'> </a></td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btnMinut..*"  type="button" style="display:none;font-size: medium; font-weight: bold;" value="－"/>
                            <input id="txtNo2..*" type="text" style="display:none;"/>
                            <input id="txtNoq..*" type="text" style="display:none;"/>
                        </td>
                        <td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                        <td>
                        	<input id="txtOrdbaccy..*" type="text" style="width:95%;"/>
                        	<input id="txtOrdbno..*" type="text" style="width:95%;"/>
                        	<input id="txtNo3..*" type="text" style="width:95%;"/>
                    	</td>
                        <td><input id="txtMount..*" type="text" style="width:95%;"/></td>
                        <td><input id="txtPrice..*" type="text" style="width:95%;"/></td>
                        <td><input id="txtMemo..*" type="text" style="width:95%;"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>