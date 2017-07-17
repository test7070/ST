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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">    
            var q_name = "quawx";
            var q_readonly = ['txtNoa'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 20;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }

            function mainPost() {
            	bbmNum = [
            		['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice1', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice2', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice3', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice4', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice5', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice6', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice7', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice8', 15, q_getPara('vcc.pricePrecision'), 1, 1]
	            ];
            	bbmMask = [['txtMon', r_picm]];
                q_mask(bbmMask);
                
                aPop = new Array(
                	['txtMechno', 'lblMech', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx']
                );
                
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;

                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('quawx_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtMon').val(q_date().substr(0,r_lenm));
                $('#txtMon').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtMon').focus();
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
                var t_err = q_chkEmpField([['txtMon', q_getMsg('lblMon')],['txtMechno', q_getMsg('lblMech')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else {
                    $('#txtWorker2').val(r_name);
                }

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtMon').val());
                var t_mech = trim($('#txtMechno').val());
                
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', '')+t_mech);
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==2){
                	$('#txtMon').attr('disabled', 'disabled');
                	$('#txtMechno').attr('disabled', 'disabled');
                	$('#lblMech').hide();
                	$('#lblXmech').show();
                }else{
                	$('#lblMech').show();
                	$('#lblXmech').hide();
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 300px;
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
            .dbbm {
                float: left;
                width: 900px;
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
                width: 60%;
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

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:30%"><a id='vewMon'> </a></td>
						<td align="center" style="width:60%"><a id='vewMech'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='mon'>~mon</td>
						<td align="center" id='mech'>~mech</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height: 1px;">
						<td style="width: 110px;"> </td>
						<td style="width: 115px;"> </td>
						<td style="width: 110px;"> </td>
						<td style="width: 115px;"> </td>
						<td style="width: 110px;"> </td>
						<td style="width: 115px;"> </td>
						<td style="width: 110px;"> </td>
						<td style="width: 115px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMech' class="lbl btn"> </a>
							<a id="lblXmech" class="lbl" style="display: none;"> </a>
						</td>
						<td><input id="txtMechno"  type="text" class="txt c1" /></td>
						<td colspan="2"><input id="txtMech"  type="text" class="txt c1" /></td>
						<td><input id="txtNoa"  type="hidden" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice1' class="lbl"> </a></td>
						<td><input id="txtPrice1"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblPrice2' class="lbl"> </a></td>
						<td><input id="txtPrice2"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblPrice3' class="lbl"> </a></td>
						<td><input id="txtPrice3"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblPrice4' class="lbl"> </a></td>
						<td><input id="txtPrice4"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice5' class="lbl"> </a></td>
						<td><input id="txtPrice5"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblPrice6' class="lbl"> </a></td>
						<td><input id="txtPrice6"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblPrice7' class="lbl"> </a></td>
						<td><input id="txtPrice7"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblPrice8' class="lbl"> </a></td>
						<td><input id="txtPrice8"  type="text" class="txt num c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
