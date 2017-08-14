<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            q_tables = 's';
            var q_name = "eipman";
            var q_readonly = ['txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 8;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtSno_', 'btnSno_', 'sss', 'noa,namea', '0txtSno_,txtNamea_', 'sss_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
                // 1=Last  0=Top
            }

            function mainPost() {
                bbmMask = [];
                q_mask(bbmMask);
                q_gt('part', '', 0, 0, 0, "");
                q_cmbParse("cmbAct", q_getPara('eip.act'), 's');

                $('#txtNoa').change(function(e) {
                    $(this).val($.trim($(this).val()));
                    if ($(this).val().length > 0) {
                        t_where = "where=^^ noa='" + $(this).val() + "'^^";
                        q_gt('eipman', t_where, 0, 0, 0, "checkEipmanno_change", r_accy);
                    }
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'sssall':
                        b_ret = getb_ret();
                        ///  q_box() 執行後，選取的資料
                        if (!b_ret || b_ret.length == 0){
                        	b_pop='';
                        	return;	
                        }
                        //q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea', b_ret.length, b_ret, 'noa,namea', 'txtSno,txtNamea');
                        
                        var n=box_n;
                        box_n='';
                        var t_sssno = '', t_namea='';
						for (var i = 0; i < b_ret.length; i++) {
							t_sssno=t_sssno+(t_sssno.length>0?';':'')+b_ret[i].noa;
							t_namea=t_namea+(t_namea.length>0?';':'')+b_ret[i].namea;
							
						}
						$('#txtSno_' + n).val(t_sssno);
						$('#txtNamea_' + n).val(t_namea);
						
						if(b_ret.length>1 && $('#cmbAct_'+n).val()=='簽核'){
							$('#cmbAct_'+n).val('會簽');
						}
                        
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop='';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            var t_item = "@,All@全部";
                            var t_item2 = ",All-All@全部(全選)";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                                t_item2 = t_item2 + (t_item2.length > 0 ? ',' : '') + as[i].noa + '-All@' + as[i].part + '(全選)';
                            }
                            q_cmbParse("combPartno", t_item + t_item2, 's');
                        }
                        break;
                    case 'sssall':
                        var as = _q_appendData("sssall", "", true);
                        //q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea', as.length, as, 'noa,namea', 'txtSno,txtNamea');
                        break;
                    case 'checkEipmanno_change':
                        var as = _q_appendData("eipman", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
                        }
                        break;
                    case 'checkEipmanno_btnOk':
                        var as = _q_appendData("eipman", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
                            Unlock();
                            return;
                        } else {
                            wrServer($('#txtNoa').val());
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
                if(t_name.indexOf('getsssall_')>-1){
                	var n=t_name.split('_')[1];
					var as = _q_appendData("sssall", "", true);
					var t_sssno = '', t_namea='';
					for (var i = 0; i < as.length; i++) {
						t_sssno=t_sssno+(t_sssno.length>0?';':'')+as[i].noa;
						t_namea=t_namea+(t_namea.length>0?';':'')+as[i].namea;
						
					}
					$('#txtSno_' + n).val(t_sssno);
					$('#txtNamea_' + n).val(t_namea);
                }
                
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('eipman_s.aspx', q_name + '_s', "500px", "320px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $("#combPartno_" + i).change(function() {
                        	t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                            combtodo($(this),b_seq);
                        });
                    }
                }
                _bbsAssign();

            }
			
			var box_n='';
            function combtodo(do_object,n) {
                if ((q_cur == 1 || q_cur == 2) && do_object.val() != '') {
                    t_where = '';
                    choice_check = do_object.val();
                    choice_check = choice_check.split('-');
                    if (choice_check[0] != 'All') {
                        t_where = "partno='" + choice_check[0] + "'";
                    }
                    if (choice_check[1] == 'All') {
                        if (choice_check[0] != 'All') {
                            t_where = "where=^^ " + t_where + " ^^";
                        }
                        q_gt('sssall', t_where, 0, 0, 0, "getsssall_"+n, r_accy);
                    } else {
                    	box_n=n;
                        q_box("sssall_check_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'sssall', "50%", "650px", q_getMsg('popSssallcheck'));
                    }
                }
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
                refreshBbm();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtMemo').focus();
                refreshBbm();
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
                Lock();
                $('#txtNoa').val($.trim($('#txtNoa').val()));

                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtNamea', q_getMsg('lblNamea')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock();
                    return;
                }
                
                //檢查簽核是否多人
                var ismore=false;
                for (var i = 0; i < q_bbsCount; i++) {
                	if($('#cmbAct_'+i).val()=='簽核'){
                		var t_sssno=$('#txtSno_'+i).val().split(';');
                		if(t_sssno.length>1){
                			ismore=true;
                			alert('簽核不可多個核准人!!')
                			break;
                		}
                	}
                }
                if(ismore){
                	Unlock();
                    return;
                }

                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else {
                    $('#txtWorker2').val(r_name);
                }

                if (q_cur == 1) {
                    t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    q_gt('eipman', t_where, 0, 0, 0, "checkEipmanno_btnOk", r_accy);
                } else {
                    wrServer($('#txtNoa').val());
                }

                /*var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                 if (s1.length == 0 || s1 == "AUTO")
                 q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
                 else
                 wrServer(s1);
                 */
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['sno'] && !as['namea']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();

                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
            }

            function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }

                for (var i = 0; i < q_bbsCount; i++) {
                    if (q_cur == 1 || q_cur == 2) {
                        $('#combPartno_' + i).removeAttr('disabled');
                        $('#combPartno_' + i).css('background-color', 'rgb(255, 255, 255)');
                    } else {
                        $('#combPartno_' + i).attr('disabled', 'disabled');
                        $('#combPartno_' + i).css('background-color', 'rgb(237, 237, 238)');
                    }
                }

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
                width: 1000px;
            }
            .dview {
                float: left;
                width: 1000px;
            }
            .tview {
                width: 100%;
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
            .dbbm {
                float: left;
                width: 1000px;
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
            .txt.c1 {
                width: 99%;
                float: left;
            }
            .txt.c2 {
                width: 15%;
                float: left;
            }
            .txt.c3 {
                width: 85%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }
            .dbbs {
                float: left;
                width: 800px;
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
            .dbbs tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                cursor: pointer;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }

            select {
                font-size: medium;
            }

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left; " >
				<table class="tview" id="tview" border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:3%"><a id='vewChk'> </a></td>
						<td align="center" style="width:13%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:17%"><a id='vewNamea'> </a></td>
						<td align="center" style="width:65%"><a id='vewMemo'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='namea'>~namea</td>
						<td align="center" id="memo">~memo</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 165px"> </td>
						<td style="width: 165px"> </td>
						<td style="width: 165px"> </td>
						<td style="width: 165px"> </td>
						<td style="width: 165px"> </td>
						<td style="width: 165px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td colspan="3"><input id="txtNamea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
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
					<td style="width:40px;"><a id='lblNo_s'> </a></td>
					<td style="width:150px;"><a id='lblPart_s'> </a></td>
					<td style="width:200px;"><a id='lblSno_s'> </a></td>
					<td style="width:240px;"><a id='lblNamea_s'> </a></td>
					<td style="width:150px;"><a id='lblAct_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input type="button" id="btnMinus.*" style="font-size: medium; font-weight: bold;" value="－"/>
						<input type="text" id="txtNoq.*" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><select id="combPartno.*" class="txt c1"> </select></td>
					<td>
						<input type="text" id="txtSno.*" class="txt c1" style="width: 80%;"/>
						<input type="button" id="btnSno.*" style="font-size: medium; font-weight: bold;" value="."/>
					</td>
					<td><input type="text" id="txtNamea.*" class="txt c1" /></td>
					<td><select id="cmbAct.*" class="txt c1"> </select></td>
				</tr>
			</table>
		</div>
		<iframe id="xdownload" style="display:none;"></iframe>
		<input id="q_sys" type="hidden" />
	</body>
</html>
