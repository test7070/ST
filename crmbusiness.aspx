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
            
            var q_name = "crmbusiness";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var bbmNum = [['txtMoney',10,0,1],['txtPossibility',10,0,1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //brwCount2 = 15;
            
            aPop = new Array(
            	['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            	,['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']
            	,['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtNamea', 'sss_b.aspx']
            );
       
            $(document).ready(function() {
				q_desc = 1;
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
                $('#txtNoa').focus
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }
			
			var z_cno='';
			var z_acomp='';
            function mainPost() {
                bbmMask = [['txtDatea', r_picd],['txtEdatea', r_picd]];
                q_mask(bbmMask);
				q_cmbParse("cmbStage", ",潛在機會,初步接洽,需求確認,建議/報價,談判協商,成交,失敗");
				
				q_gt('acomp', '', 0, 0, 0, "");
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

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'acomp':
                		var as = _q_appendData("acomp", "", true);
                		if(as[0]!=undefined){
                			z_cno=as[0].noa;
							z_acomp=as[0].acomp;
                		}
                		break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('crmbusiness_s.aspx', q_name + '_s', "500px", "320px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
	            $('#txtDatea').val(q_date());
	            $('#txtCno').val(z_cno);
	            $('#txtAcomp').val(z_acomp);
	            $('#txtEdatea').val(q_date());
	            
	            var timeDate= new Date();
	            $('#txtSssno').val(r_userno);
	            $('#txtNamea').val(r_name);
                $('#txtDatea').focus();
                $('#txtEdatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
				//q_box('', '', "95%", "95%", q_getMsg("popPrint"));
            }
            
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            function btnOk() {
               $('#txtDatea').val($.trim($('#txtDatea').val()));
               var t_err = '';
            	t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')] ]);
            	
	            if( t_err.length > 0) {
	                alert(t_err);
	                return;
	            }
	            
	            if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_crmbusiness') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);	
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
                width: 400px; 
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
                width: 620px;
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
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:260px; color:black;"><a id='vewTheme'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='theme' style="text-align: left;">~theme</td>
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
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStage' class="lbl"> </a></td>
						<td><select id="cmbStage" class="txt c1"> </select></td>
						<td><span> </span><a id="lblPossibility" class="lbl"> </a></td>
						<td><input id="txtPossibility" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTheme' class="lbl"> </a></td>
						<td colspan="3"><input id="txtTheme"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td ><input id="txtCno" type="text" class="txt c1" /></td>
						<td colspan="2"><input id="txtAcomp" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td ><input id="txtCustno" type="text" class="txt c1" /></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td ><input id="txtSalesno" type="text" class="txt c1" /></td>
						<td><input id="txtNamea" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDescribe" class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtDescribe" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSituation" class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtSituation" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustneed" class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtCustneed" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSuggest" class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtSuggest" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEdatea' class="lbl"> </a></td>
						<td><input id="txtEdatea"  type="text" class="txt c1" /></td>
						<td class="reparation"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="reparation"><input id="txtMoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
