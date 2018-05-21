<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
            var q_name = "quaw";
            var q_readonly = ['txtNoa','txtProduct','txtSpec','txtUnit','txtWorker','txtWorker2','textTotal','txtPackwayno'];
            var q_readonlys = [];
            var q_readonlyt = [];
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
            brwCount2 = 5;
            q_copy=1;

            aPop = new Array();

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
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
	            bbmNum = [
	            	['txtPrice1', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice2', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice3', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice4', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice5', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice6', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice7', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice8', 15, q_getPara('vcc.pricePrecision'), 1, 1]
	            ];
	            bbsNum = [
	            	['txtMount', 15, q_getPara('vcc.mountPrecision'), 1, 1],
	            	['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtLoss', 15, 2, 1, 1],
	            	['txtPrice1', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice2', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice3', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice4', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice5', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice6', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice7', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice8', 15, q_getPara('vcc.pricePrecision'), 1, 1]
	            ];
	            bbtNum = [
	            	['txtMount', 15, q_getPara('vcc.mountPrecision'), 1, 1],
	            	['txtUmount', 15, q_getPara('vcc.mountPrecision'), 1, 1],
	            	['txtGen', 15, q_getPara('vcc.mountPrecision'), 1, 1],
	            	['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtLoss', 15, 2, 1, 1],
	            	['txtPrice1', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice2', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice3', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice4', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice5', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice6', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice7', 15, q_getPara('vcc.pricePrecision'), 1, 1],
	            	['txtPrice8', 15, q_getPara('vcc.pricePrecision'), 1, 1]
	            ];
	            bbmMask = [['txtMon',r_picm]];
	            bbsMask = [];
	            bbtMask = [];
                q_mask(bbmMask);
                
                aPop = new Array(
                	['txtProductno', 'lblProduct', 'uca', 'noa,product,spec,unit', 'txtProductno,txtProduct,txtSpec,txtUnit', 'uca_b.aspx'],
                	['txtProductno_', '', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', ''],
                	['txtMechno__', '', 'mech', 'noa,mech', 'txtMechno__,txtMech__', 'mech_b.aspx'],
                	['txtProcessno__', '', 'process', 'noa,process', 'txtProcessno__,txtProcess__', 'process_b.aspx'],
                	['txtGroupbno__', '', 'uccgb', 'noa,namea', 'txtGroupbno__,txtGroupb__', 'uccgb_b.aspx']
                );
				
				$('#btnQuawu').click(function() {
					if(q_cur!=1 && q_cur!=2 && !emp($('#txtNoa').val()))
						q_box("quawu.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'quawu', "80%", "95%", q_getMsg("btnQuawu"));
				});
				
				$('#btnUcc').click(function() {
					if(q_cur==1 || q_cur==2){
						if(!emp($('#txtProductno').val())){
							Lock(1);
							q_func('qtxt.query.bomucc', 'bom.txt,bomucc,' + encodeURI($('#txtProductno').val()));
						}
					}
				});
				
				$('#lblPackwayno').click(function() {
					var t_where = "noa='" + $('#txtProductno').val() + "'";
					q_box("pack2_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack2b', "95%", "95%", '包裝方式');
				});
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.bomucc':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_'+i).click();	
							}
							
							q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtPrice,txtLoss,txtMemo', as.length, as
							, 'productno,product,unit,mount,price,loss,memo', 'txtProductno,txtProduct');
						}
						q_func('qtxt.query.bomucct', 'bom.txt,bomucct,' + encodeURI($('#txtProductno').val()));
						break;
					case 'qtxt.query.bomucct':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for (var i = 0; i < q_bbtCount; i++) {
								$('#btnMinut__'+i).click();	
							}
							
							for (var i = 0; i < as.length; i++) {
								as[i]._mount=1;	
							}
							
							q_gridAddRow(bbtHtm, 'tbbt', 'txtProcessno,txtProcess,txtMount,txtUmount,txtPrice', as.length, as
							, 'processno,process,_mount,mount,price', 'txtProcessno,txtProcess,txtGroupbno,txtGroupb');
						}
						
						q_func('qtxt.query.bomucagroupb', 'bom.txt,bomucagroupb,' + encodeURI($('#txtProductno').val()));
						
						break;
					case 'qtxt.query.bomucagroupb':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for (var i = 0; i < q_bbtCount; i++) {
								if(!emp($('#txtGroupb__'+i).val()))
									$('#btnMinut__'+i).click();	
							}
							
							for (var i = 0; i < as.length; i++) {
								if(as[i].groupbno.substr(0,1)!='1'){
									as.splice(i, 1);
                                    i--;
								}	
							}
							
							q_gridAddRow(bbtHtm, 'tbbt', 'txtGroupbno,txtGroupb', as.length, as
							, 'groupbno,namea', 'txtProcessno,txtProcess,txtGroupbno,txtGroupb');
						}
						
						Unlock(1);
						break;
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
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'pack2b':
                		if(q_cur==1 || q_cur==2){
	                		ret = getb_ret();
							if (ret != undefined) {
								$('#txtPackwayno').val(ret[0].packway);
								//$('#txtPackway').val(ret[0].pack);
								
								for (var i = 0; i < q_bbsCount; i++) {
									//內包裝材1
									if($('#txtProduct_'+i).val().toUpperCase()=='[PK1]'){
										$('#txtProductno_'+i).val(ret[0].pk1no);
										$('#txtProduct_'+i).val(ret[0].pk1);
									}
									//內包裝材2
									if($('#txtProduct_'+i).val().toUpperCase()=='[PK2]'){
										$('#txtProductno_'+i).val(ret[0].pk2no);
										$('#txtProduct_'+i).val(ret[0].pk2);
									}
									//外包裝材
									if($('#txtProduct_'+i).val().toUpperCase()=='[PK3]'){
										$('#txtProductno_'+i).val(ret[0].pk3no);
										$('#txtProduct_'+i).val(ret[0].pk3);
									}
								}
							}
						}
                		break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('quaw_s.aspx', q_name + '_s', "500px", "250px", q_getMsg("popSeek"));
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
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box('z_quaw.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function btnOk() {
                var t_err = q_chkEmpField([['txtMon', q_getMsg('lblMon')],['txtProductno', q_getMsg('lblProduct')]]);
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
                var t_pno = trim($('#txtProductno').val());
                
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', '')+t_pno);
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            
            function bbtSave(as) {
                if (!as['mechno'] && !as['mech'] && !as['processno'] && !as['process'] && !as['groupbno'] && !as['groupb']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                sum();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                if(q_cur==2){
                	$('#txtMon').attr('disabled', 'disabled');
                	$('#txtProductno').attr('disabled', 'disabled');
                	$('#lblProduct').hide();
                	$('#lblXproduct').show();
                }else{
                	$('#lblProduct').show();
                	$('#lblXproduct').hide();	
                }
                sum();
                
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum()
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
                    	$('#txtMount_'+i).change(function() {sum();});
                    	$('#txtPrice_'+i).change(function() {sum();});
                    }
                }
                _bbsAssign();
                sum()
            }

            function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    }
                }
                _bbtAssign();
            }

            function sum() {
            	var t_total=0;
                for (var i = 0; i < q_bbsCount; i++) {
                	t_total=q_add(t_total,q_mul(dec($('#txtMount_'+i).val()),dec($('#txtPrice_'+i).val())));
                }
                $('#textTotal').val(FormatNumber(t_total));
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
            
            function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
                width: 1280px;
            }
            .dview {
                float: left;
                width: 350px;
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
                width: 910px;
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
                width: 1680px;
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
                width: 2180px;
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
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewMon'> </a></td>
						<td style="width:230px; color:black;"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='mon' style="text-align: center;">~mon</td>
						<td id='product,50' style="text-align: center;">~product,50</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td style="width:110px;"> </td>
						<td style="width:110px;"> </td>
						<td style="width:110px;"> </td>
						<td style="width:110px;"> </td>
						<td style="width:110px;"> </td>
						<td style="width:110px;"> </td>
						<td style="width:110px;"> </td>
						<td style="width:110px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span>
							<a id="lblProduct" class="lbl btn"> </a>
							<a id="lblXproduct" class="lbl" style="display: none;"> </a>
						</td>
						<td><input id="txtProductno" type="text" class="txt c1"/></td>
						<td colspan="3"><input id="txtProduct" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblPackwayno" class="lbl btn"> </a></td>
						<td><input id="txtPackwayno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSpec" class="lbl"> </a></td>
						<td><input id="txtSpec" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblUnit" class="lbl"> </a></td>
						<td><input id="txtUnit" type="text" class="txt c1"/></td>
						<td><input id="btnUcc" type="button" style="float: right;"></td>
					</tr>
					<tr style="background: beige;">
						<td><span> </span><a id="lblPrice1" class="lbl"> </a></td>
						<td><input id="txtPrice1" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblPrice2" class="lbl"> </a></td>
						<td><input id="txtPrice2" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblPrice3" class="lbl"> </a></td>
						<td><input id="txtPrice3" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblPrice4" class="lbl"> </a></td>
						<td><input id="txtPrice4" type="text" class="txt num c1"/></td>
						<td> </td>
					</tr>
					<tr style="background: beige;">
						<td><span> </span><a id="lblPrice5" class="lbl"> </a></td>
						<td><input id="txtPrice5" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblPrice6" class="lbl"> </a></td>
						<td><input id="txtPrice6" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblPrice7" class="lbl"> </a></td>
						<td><input id="txtPrice7" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblPrice8" class="lbl"> </a></td>
						<td><input id="txtPrice8" type="text" class="txt num c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="textTotal" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><input id="btnQuawu" type="button" style="float: right;"></td>
						<td><input id="txtNoa" type="hidden" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:100px;"><a id='lblProductno_s'> </a></td>
					<td style="width:200px;"><a id='lblProduct_s'> </a></td>
					<td style="width:50px;"><a id='lblUnit_s'> </a></td>
					<td style="width:100px;"><a id='lblMount_s'> </a></td>
					<td style="width:100px;"><a id='lblPrice_s'> </a></td>
					<td style="width:100px;"><a id='lblLoss_s'> </a></td>
					<td style="width:100px;"><a id='lblPrice1_s'> </a></td>
					<td style="width:100px;"><a id='lblPrice2_s'> </a></td>
					<td style="width:100px;"><a id='lblPrice3_s'> </a></td>
					<td style="width:100px;"><a id='lblPrice4_s'> </a></td>
					<td style="width:100px;"><a id='lblPrice5_s'> </a></td>
					<td style="width:100px;"><a id='lblPrice6_s'> </a></td>
					<td style="width:100px;"><a id='lblPrice7_s'> </a></td>
					<td style="width:100px;"><a id='lblPrice8_s'> </a></td>
					<td style="width:200px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLoss.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice1.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice2.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice3.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice4.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice5.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice6.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice7.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice8.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt'>
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:100px;"><a id='lblMechno_t'> </a></td>
					<td style="width:150px;"><a id='lblMech_t'> </a></td>
					<td style="width:100px;"><a id='lblProcessno_t'> </a></td>
					<td style="width:150px;"><a id='lblProcess_t'> </a></td>
					<td style="width:100px;"><a id='lblMount_t'> </a></td>
					<td style="width:100px;"><a id='lblUmount_t'> </a></td>
					<td style="width:100px;"><a id='lblPrice_t'> </a></td>
					<td style="width:100px;"><a id='lblGen_t'> </a></td>
					<td style="width:100px;"><a id='lblGroupbno_t'> </a></td>
					<td style="width:150px;"><a id='lblGroupb_t'> </a></td>
					<td style="width:100px;"><a id='lblPrice1_t'> </a></td>
					<td style="width:100px;"><a id='lblPrice2_t'> </a></td>
					<td style="width:100px;"><a id='lblPrice3_t'> </a></td>
					<td style="width:100px;"><a id='lblPrice4_t'> </a></td>
					<td style="width:100px;"><a id='lblPrice5_t'> </a></td>
					<td style="width:100px;"><a id='lblPrice6_t'> </a></td>
					<td style="width:100px;"><a id='lblPrice7_t'> </a></td>
					<td style="width:100px;"><a id='lblPrice8_t'> </a></td>
					<td style="width:200px;"><a id='lblMemo_t'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><input id="txtMechno..*" type="text" class="txt c1"/></td>
					<td><input id="txtMech..*" type="text" class="txt c1"/></td>
					<td><input id="txtProcessno..*" type="text" class="txt c1"/></td>
					<td><input id="txtProcess..*" type="text" class="txt c1"/></td>
					<td><input id="txtMount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUmount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGen..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGroupbno..*" type="text" class="txt c1"/></td>
					<td><input id="txtGroupb..*" type="text" class="txt c1"/></td>
					<td><input id="txtPrice1..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice2..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice3..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice4..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice5..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice6..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice7..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice8..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>