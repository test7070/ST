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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 't';
            var q_name = "salyear";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var q_readonlyt = ['txtNamea'];
            var bbmNum = [];
            var bbsNum = [['txtBseniority', 3, 0, 1], ['txtEseniority', 3, 0, 1], ['txtPersonal', 10, 1, 1], ['txtSick', 10, 1, 1], ['txtMenstruation', 10, 1, 1], ['txtOther', 10, 1, 1]];
            var bbtNum = [['txtMaternity', 10, 1, 1], ['txtMarital', 10, 1, 1], ['txtFuneral', 10, 1, 1], ['txtOther', 10, 1, 1]];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(['txtSssno__', 'btnSssno__', 'sss', 'noa,namea', 'txtSssno__,txtNamea__', 'sss_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                brwCount2 = 3
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)

            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtNoa', '999']];
                q_mask(bbmMask);
                
                $('#btnImport').click(function() {
                	var t_where = "where=^^ 1=1 ^^ stop=1";
                	if(!emp($('#txtNoa').val())){
                		t_where = "where=^^ noa<'"+$('#txtNoa').val()+"' ^^ stop=1";
                	}
                    q_gt('salyear', t_where, 0, 0, 0, "salyear_import", r_accy);
				});
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }
			
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'salyear_import':
                		var as = _q_appendData("salyear", "", true);
                		var ass = _q_appendData("salyears", "", true);
                		var ast = _q_appendData("salyeart", "", true);
                		
                		q_gridAddRow(bbsHtm, 'tbbs', 'txtBseniority,txtEseniority,txtPersonal,txtSick,txtOther', ass.length, ass
                		, 'bseniority,eseniority,personal,sick,other', '');
                		q_gridAddRow(bbtHtm, 'tbbt', 'txtSssno,txtNamea,txtMaternity,txtMarital,txtFuneral,txtOther,txtMemo', ast.length, ast
                		, 'sssno,namea,maternity,marital,funeral,other,memo', '');
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtNoa').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                //q_box('salyear_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    }
                }
                _bbsAssign();
            }
            
            function bbtAssign() {
                for (var j = 0; j < q_bbtCount; j++) {
                    if (!$('#btnMinut__' + j).hasClass('isAssign')) {
                        
                    }
                }
                _bbtAssign();
            }

            function btnIns() {
            	q_readonly = ['txtWorker','txtWorker2'];
                _btnIns();
                $('#txtNoa').val(q_date().substr(0, 3));
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
				q_readonly = ['txtNoa','txtWorker','txtWorker2'];
                _btnModi();
            }

            function btnPrint() {
                //q_box("z_salyear.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'salvaca', "95%", "95%", q_getMsg("popSalvaca"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['bseniority']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();

                return true;
            }

            function sum() {
                var t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!emp($('#txtSssno_' + j).val()))
                        t_total++;
                }
                $('#txtTotal').val(t_total);
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
                sum();
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
                width: 28%;
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
                width: 70%;
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
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 47%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
            }
            .txt.c7 {
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
                width: 100%;
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

            .tbbs .td1 {
                width: 8%;
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
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left;  width:120px;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:15%"><a id='vewChk'> </a></td>
						<td align="center" style="width:85%"><a id='vewNoa'> </a></td>

					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 500px;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr>
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td class="td3"> </td>
						<td class="td4"><input id="btnImport" type="button" /></td>
						<td class="td5"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 600px;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width: 30px;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td align="center" style="width: 120px;"><a id='lblSeniority'> </a></td>
					<td align="center" style="width: 100px;"><a id='lblPersonal'> </a></td>
					<td align="center" style="width: 100px;"><a id='lblSick'> </a></td>
					<td align="center" style="width: 100px;"><a id='lblMenstruation'> </a></td>
					<td align="center" style="width: 100px;"><a id='lblOther'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td>
						<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td >
						<input class="txt c2" id="txtBseniority.*" type="text" />
						<a style="float: left;">~</a>
						<input class="txt c2" id="txtEseniority.*" type="text" />
					</td>
					<td ><input class="txt num c1" id="txtPersonal.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtSick.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtMenstruation.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtOther.*" type="text" /></td>
				</tr>
			</table>
		</div>
		<div id="dbbt" style="width: 900px;">
			<table id="tbbt" class='tbbt' border="1" cellpadding='2' cellspacing='1'>
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:30px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td align="center" style="width:120px;"><a id='lblSssno'> </a></td>
					<td align="center" style="width:120px;"><a id='lblNamea'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMaternity'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMarital'> </a></td>
					<td align="center" style="width:100px;"><a id='lblFuneral'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOthers'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemo'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td>
						<input id="txtSssno..*" type="text" class="txt c5"/>
						<input id="btnSssno..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					</td>					
					<td><input id="txtNamea..*" type="text" class="txt c1"/></td>
					<td><input id="txtMaternity..*" type="text" class="txt num c1"/></td>
					<td><input id="txtMarital..*" type="text" class="txt num c1"/></td>
					<td><input id="txtFuneral..*" type="text" class="txt num c1"/></td>
					<td><input id="txtOther..*" type="text" class="txt num c1"/></td>
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
