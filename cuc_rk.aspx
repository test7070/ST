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
            q_tables = 's';
            var q_name = "cuc";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtHours', 10, 0, 1], ['txtMount', 10, 3, 1], ['txtWeight', 10, 3, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            brwCount2 = 6;
            aPop = new Array(['txtMechno', 'lblMechno', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'], ['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx'], ['tx1tCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx'], ['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                bbsMask = [];
                q_mask(bbmMask);
            }

            function q_popPost(s1) {
                switch(s1) {
                    case 'txtMechno':
                        var t_mechno = trim($('#txtMechno').val());
                        if (t_mechno.length > 0) {
                            var t_where = "where=^^ enda=0 and mechno='" + t_mechno + "' ^^";
                            q_gt('view_ordes', t_where, 0, 0, 0, "", r_accy);
                        }
                        break
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'view_ordes':
                        for (var i = 0; i < q_bbsCount; i++) {
                            $('#btnMinus_' + i).click();
                        };
                        var wret = '';
                        var as = _q_appendData("view_ordes", "", true);
                        if (as[0] != undefined) {
                            for (var j = 0; j < as.length; j++) {
                                as[j].mount = as[j].mount - as[j].tdmount;
                            }
                            wret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUdate,txtOrdeno,txtNo2,txtCustno,txtCust,txtProductno,txtProduct,txtRadius,txtWidth,txtDime,txtLengthb,txtMount', as.length, as, 'datea,noa,no2,custno,cust,productno,product,radius,width,dime,lengthb,mount', '');
                        }
                        for (var j = 0; j < wret.length; j++) {
                            $('#txtDatea_' + wret[j]).val(q_date());
                            var t_uno = trim($('#txtUno_' + wret[j]).val());
                            if (emp(t_uno))
                                $('#txtUno_' + wret[j]).val('9999');
                            var t_where = "where=^^ 1=1 and isnull(ordeno,'') != '' and isnull(no2,'') != '' ";
                            t_where += "and ordeno='" + $('#txtOrdeno_' + wret[j]).val() + "'and no2='" + $('#txtNo2_' + wret[j]).val() + "'"
                            t_where += " ^^";
                            q_gt('cucs', t_where, 0, 0, 0, "getUno", r_accy);
                        }
                        break;
                    case 'getUno':
                        var as = _q_appendData("cucs", "", true);
                        if (as[0] != undefined) {
                            for (var i = 0; i < q_bbsCount; i++) {
                                var t_ordeno = $('#txtOrdeno_' + i).val();
                                var t_no2 = $('#txtNo2_' + i).val();
                                if (as[0].ordeno == t_ordeno && as[0].no2 == t_no2) {
                                    $('#txtUno_' + i).val(as[0].uno);
                                }
                            }
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
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
                
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cuc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cuc_rk_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtMount_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount1_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight1_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount2_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight2_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount3_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight3_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount4_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight4_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount5_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtWeight5_'+i).change(function(e){
                    		sum();
                    	});
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
				q_box("z_cuc_rkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'cuc_rk', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['ordeno']) {
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
                overflow: visible;
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
                height: 30%;
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
                width: 70%;
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
            .txt.c2 {
                width: 130%;
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
                width: 1700px;
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
                width: 1700px;
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
                width: 1500px;
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
            .signupXX {font-family: "微軟正黑體","Microsoft JhengHei",sans-serif;
			    padding: 10 10 10 10px;
			    background: #fff;
			    box-shadow: 
			        0px 0px 0px 5px rgba( 255,255,255,0.4 ), 
			        0px 4px 20px rgba( 0,0,0,0.33 );
			    -moz-border-radius: 5px;
			    -webkit-border-radius: 5px;
			    border-radius: 5px;
				margin-top:5px;
				margin-bottom:10px;
			    /*display: table;
			    position: static;*/
				/*width:620px;*/ 
				margin-left:5px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview"  >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:20%"><a id='vewDatea'></a></td>
						<td align="center" style="width:25%"><a id='vewMech'></a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='mech'>~mech</td>
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
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td>
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td>
						<input id="txtDatea"  type="text" class="txt c1"/>
						</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMechno" class="lbl btn"></a></td>
						<td colspan="2">
						<input id="txtMechno"  type="text" class="txt" style="width:30%;"/>
						<input id="txtMech"  type="text" class="txt" style="width:65%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"></a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl"></a></td>
						<td>
						<input id="txtWorker2" type="text" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs signup'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;" rowspan="2">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"></td>
					<td style="width:200px;">生產指示單號</td>
					<td style="width:200px;">製造批號</td>
					<td style="width:120px;">皮膜<BR>編號</td>
					<td style="width:120px;">半成品<BR>進料<BR>重量(KG)</td>
					<td style="width:120px;">SHEET(COIL)規格尺寸</td>
					<td style="width:120px;">作業條件</td>
					<td style="width:120px;">SHEET(COIL)裁剪(分條)尺寸</td>
					<td style="width:120px;">進料數量</td>
					<td style="width:120px;">進料重量</td>
					<td style="width:120px;">裁切數量</td>
					<td style="width:120px;">裁切重量</td>
					<td style="width:120px;">成品片數</td>
					<td style="width:120px;">成品重量</td>
					<td style="width:120px;">待修品片數</td>
					<td style="width:120px;">待修品重量</td>
					<td style="width:120px;">廢料重量(KG)</td>
					<td style="width:120px;">裁剪(包裝)工時(分)</td>
					<td style="width:120px;">COIL編號</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtOrdeno.*" type="text" class="txt c1"/>
						<input id="txtno2.*" type="text" style="display:none;"/>
					</td>
					<td><input id="txtSpec.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtMount.*" type="text" class="txt c1 num" style="display:none;"/>
						<input id="txtWeight.*" type="text" class="txt c1 num"/>
					</td>
					<td><input id="txtSize.*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
					<td><input id="txtSize2.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount1.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight1.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount2.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight2.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount3.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight3.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount4.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight4.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount5.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight5.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWaste.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtHours.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUno.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
