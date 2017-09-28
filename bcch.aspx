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

            q_tables = 's';
            var q_name = "bcch";
            var decbbs = ['price', 'sprice'];
            var decbbm = [];
            var q_readonly = ['txtNoa','txtBccname','txtTgg','txtUnit'];
            var q_readonlys = ['txtChkname', 'txtQdate', 'txtQday', 'txtQtime'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            //ajaxPath = "";
            aPop = new Array(
            	['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'], 
            	['txtBccno', 'lblBcc', 'bcc', 'noa,product,unit,memo', 'txtBccno,txtBccname,txtUnit,txtMemo', 'bcc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
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

                $('#txtTggno').focus();

            }///  end Main()

            function mainPost() {
                bbsMask = [['txtDatea', r_picd], ['txtOdate', r_picd], ['txtQdate', r_picd]];
                bbsNum = [['txtPrice', 10, q_getPara('rc2.pricePrecision'), 1], ['txtSprice', 15, q_getPara('rc2.pricePrecision'), 1], ['txtQday', 5, 0, 1]];

                q_getFormat();
                q_mask(bbmMask);
            }

            function q_boxClose(s2) {
                var ret;
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

                $('#txtWorker').val(r_name)
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_bcch') + q_date(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('bcch_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
                for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                    $('#btnMinus_' + j).click(function() {
                        btnMinus($(this).attr('id'));
                    });
                } //j
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                //$('#txtDatea').val(q_date());
                $('#txtTggno').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProductno').focus();
                
                $('#txtTggno').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
                $('#txtBccno').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
                $('#lblTggk').css('display', 'inline').text($('#lblTgg').text());
				$('#lblBcck').css('display', 'inline').text($('#lblBcc').text());
				$('#lblTgg').css('display', 'none');
				$('#lblBcc').css('display', 'none');
                
            }

            function btnPrint() {
				q_box("z_bcch.aspx", 'bcch', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                if(as['unit']=='')
                	as['unit'] = abbm2['unit'];
                if(as['memo']=='')
                	as['memo'] = abbm2['memo'];
                
                as['tggno'] = abbm2['tggno'];
                as['tgg'] = abbm2['tgg'];
                as['bccno'] = abbm2['bccno'];
                as['bccname'] = abbm2['bccname'];

                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                } // j

            }

            function refresh(recno) {
                _refresh(recno);
				$('#lblTgg').css('display', 'inline');
				$('#lblBcc').css('display', 'inline');
				$('#lblTggk').css('display', 'none');
				$('#lblBcck').css('display', 'none');
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==2){
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtQdate_'+i).val()) || !emp($('#txtChkname_'+i).val())){
							$('#txtDatea_'+i).css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtPrice_'+i).css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtSprice_'+i).css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtOdate_'+i).css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#btnMinus_'+i).attr('disabled','disabled');
						}
                	} // j
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
                width: 90%;
                float: left;
            }
            .txt.c2 {
                width: 14%;
                float: left;
            }
            .txt.c3 {
                width: 26%;
                float: left;
            }
            .txt.c4 {
                width: 25%;
                float: left;
            }
            .txt.c5 {
                width: 65%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
            }
            .txt.c7 {
                width: 98%;
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
		<div class="dview" id="dview" style="float: left;  width:32%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk'> </a></td>
					<td align="center" style="width:25%"><a id='vewTgg'> </a></td>
					<td align="center" style="width:25%"><a id='vewBccname'> </a></td>
				</tr>
				<tr>
					<td >
					<input id="chkBrow.*" type="checkbox" style=' '/>
					</td>
					<td align="center" id='tgg'>~tgg</td>
					<td align="center" id='bccname'>~bccname</td>
				</tr>
			</table>
		</div>
		<div class='dbbm' style="width: 68%;float:left">
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr class="tr1">
					<td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
					<td class="td2"><input id="txtNoa"  type="text" class="txt c7"/></td>
					<td class='td3'> </td>
					<td class="td4"> </td>
					<td class="td5"> </td>
					<td class="td6"> </td>
				</tr>
				<tr class="tr2">
					<td class='td1'><span> </span><a id="lblTgg" class="lbl btn"> </a><a id="lblTggk" class="lbl btn"> </a></td>
					<td class="td2" colspan="2">
						<input id="txtTggno" type="text" class="txt c4"/>
						<input id="txtTgg"type="text" class="txt c5"/>
					</td>
				</tr>
				<tr class="tr3">
					<td class='td4'><span> </span><a id="lblBcc" class="lbl btn"> </a><a id="lblBcck" class="lbl btn"> </a></td>
					<td class="td5" colspan="2">
						<input id="txtBccno" type="text"  class="txt c4"/>
						<input  id="txtBccname" type="text" class="txt c5"/>
					</td>
					<td class='td4'><span> </span><a id="lblUnit" class="lbl"> </a></td>
					<td class="td5"><input id="txtUnit" type="text"  class="txt c5"/></td>
				</tr>
				<tr class="tr4">
					<td class='td1'><span> </span><a id="lblMemo" class="lbl"> </a></td>
					<td class="td2" colspan="5"><input id="txtMemo"  type="text" class="txt c7"/>
					</td>
				</tr>
			</table>
		</div>
		<div class='dbbs' style="width: 100%;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center"><a id='lblDatea'> </a></td>
					<td align="center"><a id='lblPrice'> </a></td>
					<td align="center"><a id='lblSprice'> </a></td>
					<td align="center"><a id='lblOdate'> </a></td>
					<td align="center"><a id='lblChkname'> </a></td>
					<td align="center"><a id='lblQdate'> </a></td>
					<td align="center"><a id='lblQtime'> </a></td>
					<td align="center"><a id='lblQday'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
					<td ><input class="txt c1" id="txtDatea.*"type="text" /></td>
					<td ><input class="txt c1 num" id="txtPrice.*" type="text"/></td>
					<td ><input class="txt c1 num" id="txtSprice.*"type="text" /></td>
					<td ><input class="txt c1" id="txtOdate.*" type="text" /></td>
					<td ><input class="txt c1" id="txtChkname.*" type="text" /></td>
					<td ><input class="txt c1" id="txtQdate.*" type="text" /></td>
					<td ><input class="txt c1" id="txtQtime.*" type="text" /></td>
					<td>
						<input class="txt c1 num" id="txtQday.*" type="text" />
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden"/>
						<input id="txtUnit.*" type="hidden" />
						<input id="txtMemo.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
