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

            q_tables = 's';
            var q_name = "posta";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtConn', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_desc = 1;
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(
				['txtUseno_', 'btnUseno_', 'cust', 'noa,comp,zip_comp', 'txtUseno_,txtComp_,txtZipcode_', 'cust_b.aspx']
			);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);

            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
                document.title='交寄作業'
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
               	
               	$('#btnInput').click(function() {
					q_box('cust_b2.aspx','cust_be_b2', "600px", "90%", q_getMsg("popSeek"));
                });
                q_popAssign();
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                	case 'cust_be_b2':							
						for (var i = 0; i < b_ret.length; i++) {
								$('#txtUseno_'+i).val(b_ret[i].noa);
								$('#txtComp_'+i).val(b_ret[i].comp);
						}	
                		break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.postavcc':
                        break;
                }
            }
            
            function q_stPost() {
				if (q_cur == 1 || q_cur == 2){ 
					q_func('qtxt.query.postavcc', 'posta.txt,posta_vcc_be,'+r_accy+';'+ encodeURI($('#txtNoa').val())); 
				}
				
			}

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if(q_cur==1 && !emp($('#txtBsno').val()) && q_getPara('sys.project').toUpperCase() == 'XY'){
                	//產生掛號編號
                	var counts=0;
                	for (var j = 0; j < q_bbsCount; j++) {
                		if(emp($('#txtSno_'+j).val()) && (!emp($('#txtUseno_'+j).val()) || !emp($('#txtComp_'+j).val()) || !emp($('#txtZipcode_'+j).val()) || !emp($('#txtAddr_'+j).val()))){
                			var t_no=$('#txtBsno').val().substr(0,6);
                			var t_nos=$('#txtBsno').val().substr(7,$('#txtBsno').val().length);
                			t_no=dec(t_no)+counts;
                			t_no=('000000'+t_no).slice(-6);
                			$('#txtSno_'+j).val(t_no);//+t_nos  1117 不需要出現後面的數字
                			counts++;
                		}
                	}
                }
				
				if(q_cur==1)
                	$('#txtWorker').val(r_name);
                else
                	$('#txtWorker2').val(r_name);

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('posta_s.aspx', q_name + '_s', "550px", "440px", q_getMsg("popSeek"));
            }

            function bbsAssign() {

                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
                    }
                    /*$('#txtUseno_' + i).click(function() {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                    });*/
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                var sInfo = (q_getPara('sys.tel')).toUpperCase();
                var s_tel = sInfo.substring(0, sInfo.indexOf('FAX'));
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date()).focus();
                //預設掛號
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
                var t_where = "noa='" + $('#txtNoa').val() + "'";
                q_box("z_posta.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['useno'] && !as['comp'] && !as['zipcode']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
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
                /// 表身運算式
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
                }
            }
            function FormatNumber(n) {
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 250px;
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
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 760px;
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
                width: 3%;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 61%;
                float: left;
            }
            .txt.c4 {
                width: 25%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 1250px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbs {
                FONT-SIZE: medium;
                COLOR: blue;
                TEXT-ALIGN: left;
                BORDER: 1PX LIGHTGREY SOLID;
                width: 100%;
                height: 98%;
            }
            select {
                font-size: medium;
            }
            .tbbs .td1 {
                width: 4%;
            }
            .tbbs .td2 {
                width: 6%;
            }
            .tbbs .td3 {
                width: 8%;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left;">
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:50%"><a id='vewDatea'>交寄日期</a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='1'  cellspacing='0'>
					<tr class="tr1">
						<td ><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td ><input id="txtNoa" type="text" class="txt c1"/></td>
						<td ><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td ><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td ><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td ><input id="txtWorker" type="text" class="txt c1"/></td>
						<td ><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td ><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td class="td7"><input id="btnInput" type="button" value="客戶匯入" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  style="width:960px;">
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width: 20px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td style="width:25px;"> </td>
					<td align="center" style="width: 150px;">
						<a id='lblSno_s'>掛號號碼</a>
					</td>
					<td align="center" style="width:100px;"><a id='lblUseno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblComp_s'> </a></td>
					<td align="center" style="width:80px;"><a id=''>送貨數量</a></td>
					<td align="center" style="width:100px;"><a id=''>備註</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtSno.*" type="text" class="txt c1" /></td>
					<td>
						<input id="txtUseno.*" type="text" class="txt" style="width:80%;"/>
						<input type="button" id="btnUseno.*" value="." style="width:1%;">
					</td>
					<td><input id="txtComp.*" type="text" class="txt c1"/></td>
					<td><input id="txtConn.*" type="text" class="txt num c1" /></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>