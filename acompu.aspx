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

            var q_name = "acompu";
            var q_readonly = ['txtNoa'];
            var bbmNum = [['txtDcount',2,0,1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array();

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                $('#txtNoa').focus();

                //一個公司只有一個acompu
                $('#dview').hide();
                //不用新增、查詢、列印、翻頁
                $('#btnIns').hide();
                $('#btnSeek').hide();
                $('#btnPrint').hide();
                $('#btnPrevPage').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnNextPage').hide();
                $('#q_menu').hide();
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
                bbmMask = [];
                q_mask(bbmMask);
				q_gt('taxport', '', 0, 0, 0, "");
				
				q_cmbParse("cmbReason", ('').concat(new Array('  @無重複申報情形', '01@申報單位發現錯誤主動更正', '02@稽徵機關發現錯誤更正')));
				q_cmbParse("cmbTax2type", ('').concat(new Array('1@逐張計算後再加總', '02@彙總後一次折算')));
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            var ucam_as;
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'taxport':
                		var as = _q_appendData("taxport", "", true);
		                var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' +as[i].noa+'.'+as[i].taxport;
						}
						q_cmbParse("cmbTaxport", t_item);
						if (abbm[q_recno] != undefined)
							$("#cmbTaxport").val(abbm[q_recno].taxport);
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
            }

            function btnIns() {
                _btnIns();
                $('#txtLcno').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtLcno').focus();
            }

            function btnPrint() {

            }

            function btnOk() {
            	$('#txtTaxportname').val(replaceAll($('#cmbTaxport').find("option:selected").text(),$('#cmbTaxport').val()+'.',''));
                if (q_cur == 1) {
                    var t_key = q_getHref();
                    if (t_key[1] != undefined)
                        $('#txtNoa').val(t_key[1]);
                    wrServer($('#txtNoa').val());
                } else {
                    wrServer($('#txtNoa').val());
                }
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (abbm[0] == undefined && t_para)
                    btnIns();
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
                width: 0px;
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
                width: 1100px;
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
                width: 1100px;
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
                width: 99%;
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

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .trX {
                background: #FF88C2;
            }
            .trY {
                background: #66FF66;
            }
            .trZ {
                background: #FFAA33;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;" >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewNoa'></a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id=''>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td><input id="txtNoa" type="hidden" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTaxport" class="lbl"> </a></td>
						<td>
							<select id="cmbTaxport" class="txt c1"> </select>
							<input id="txtTaxportname"  type="hidden"/>
						</td>
						<td><span> </span><a id='lblIsheadoffice' class="lbl"> </a></td>
						<td><input id="chkIsheadoffice" type="checkbox"/> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTaxno' class="lbl"> </a></td>
						<td><input id="txtTaxno"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblHouseno' class="lbl"> </a></td>
						<td><input id="txtHouseno"  type="text" class="txt c1" /></td>
					</tr>
					<tr >
						<td><span> </span><a id='lblIsaccagent' class="lbl"> </a></td>
						<td><input id="chkIsaccagent" type="checkbox"/> </td>
						<td><span> </span><a id='lblAcccomp' class="lbl"> </a></td>
						<td><input id="txtAcccomp"  type="text" class="txt c1" /></td>
					</tr>
					<tr >
						<td><span> </span><a id='lblAccconn' class="lbl"> </a></td>
						<td><input id="txtAccconn"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblAcctel' class="lbl"> </a></td>
						<td><input id="txtAcctel"  type="text" class="txt c1" /></td>
					</tr>
					<tr >
						<td><span> </span><a id='lblAccserial' class="lbl"> </a></td>
						<td><input id="txtAccserial"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblAccemail' class="lbl"> </a></td>
						<td><input id="txtAccemail"  type="text" class="txt c1" /></td>
					</tr>
					<tr >
						<td><span> </span><a id='lblAccaddr' class="lbl"> </a></td>
						<td colspan="3"><input id="txtAccaddr"  type="text" class="txt c1" /></td>
					</tr>
					<tr >
						<td><span> </span><a id='lblDcount' class="lbl"> </a></td>
						<td><input id="txtDcount"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblReason' class="lbl"> </a></td>
						<td>	<select id="cmbReason" class="txt c1"> </select></td>
					</tr>
					<tr >
						<td><span> </span><a id='lblIslisted' class="lbl"> </a></td>
						<td><input id="chkIslisted" type="checkbox"/> </td>
						<td><span> </span><a id='lblIsfinancial' class="lbl"> </a></td>
						<td><input id="chkIsfinancial" type="checkbox"/> </td>
					</tr>
					<tr >
						<td><span> </span><a id='lblTax2type' class="lbl"> </a></td>
						<td>	<select id="cmbTax2type" class="txt c1"> </select></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
