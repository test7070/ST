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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1
            q_tables = 's';
            var q_name = "vccw";
            var q_readonly = ['txtNoa', 'txtWorker','txtWorker2', 'txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtSales','txtAddr','txtCardeal'];
            var q_readonlys = ['txtNo2','txtTotal', 'txtOrdewno', 'txtVccewno','txtStore'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 11;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(
            	['txtBccno_', 'btnBccno_', 'bcc', 'noa,product,unit', 'txtBccno_,txtBccname_,txtUnit_', 'bcc_b.aspx'],
            	['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,nick,paytype,trantype,tel,fax,zip_comp,addr_fact', 'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
            );
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
                q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
            });
            
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }
            
            function sum() {
				var t1 = 0, t_unit, t_mount=0, t_weight = 0,t_weights = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
					t_mount = q_float('txtMount_' + j);
					t_weight = q_float('txtWeight_' + j);
					t_weights = q_add(t_weights,q_float('txtWeight_' + j));
					if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'M2' || t_unit == 'M' || t_unit == '批' || t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
						$('#txtTotal_' + j).val(round(q_mul(q_float('txtPrice_' + j), dec(t_weight)), 0));
					}else{
						$('#txtTotal_' + j).val(round(q_mul(q_float('txtPrice_' + j), dec(t_mount)), 0));
					}
					t1 = q_add(t1, dec(q_float('txtTotal_' + j)));
				}
				$('#txtMoney').val(round(t1, 0));
				q_tr('txtWeight', t_weights);
				
				var t_money=round(t1, 0);
				var t_total = round(t1, 0);
				var t_tax = 0;
				var t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				
				switch ($('#cmbTaxtype').val()) {
						case '1':
							// 應稅
							t_tax = round(q_mul(t_money, t_taxrate), 0);
							t_total = q_add(t_money, t_tax);
							break;
						case '2':
							//零稅率
							t_tax = 0;
							t_total = q_add(t_money, t_tax);
							break;
						case '3':
							// 內含
							t_tax = q_sub(t_money, round(q_div(t_money, q_add(1, t_taxrate)), 0));
							t_total = t_money;
							t_money = q_sub(t_total, t_tax);
							break;
						case '4':
							// 免稅
							t_tax = 0;
							t_total = q_add(t_money, t_tax);
							break;
						case '5':
							// 自定
							$('#txtTax').attr('readonly', false);
							$('#txtTax').css('background-color', 'white').css('color', 'black');
							t_tax = round(q_float('txtTax'), 0);
							t_total = q_add(t_money, t_tax);
							break;
						case '6':
							// 作廢-清空資料
							t_money = 0, t_tax = 0, t_total = 0;
							break;
						default:
					}
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
				q_tr('txtTotalus',FormatNumber(round(q_mul(q_float('txtTotal'), q_float('txtFloata')), 0)));
			}

            function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd]];
				bbmNum = [['txtMoney', 15, 0, 1],['txtTax', 15, 0, 1],['txtTotal', 15, 0, 1],['txtFloata', 15, 4, 1],['txtTotalus', 15, 4, 1],['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1]];
				bbsNum = [['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 10, q_getPara('vcc.mountPrecision'), 1], ['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1]	, ['txtTotal', 10, 0, 1]];
				q_cmbParse("cmbStype", q_getPara('ordew.stype'));
				q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                
                //指送地址列表
                var t_where = "where=^^ 1=1 group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				
				$('#txtAddr').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				
				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				
				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
				
				$('#txtFloata').change(function() {
					sum();
				});
				
				$('#btnVccewimport').click(function(){
					var vccewno = $('#txtVccewno').val();
					var t_where = " isnull(a.enda,0)=0 and a.noa+'-'+a.noq not in (select vccewno from vccws where noa !='"+$('#txtNoa').val()+"')";
					t_where += q_sqlPara2('a.noa', vccewno);
					t_where += q_sqlPara2('c.custno', $('#txtCustno').val());
					q_box("vccw_vccew_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccw_vccew', "95%", "95%", $('#btnVccewimport').val());
				});
				
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'vccw_vccew':
                		if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}
							
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdewno,txtNo2,txtBccno,txtBccname,txtUnit,txtMount,txtWeight,txtPrice,txtStoreno,txtStore,txtVccewno,txtMemo'
							, b_ret.length, b_ret, 'ordewno,no2,bccno,bccname,unit,mount,weight,price,storeno,store,vccewno,memo', 'txtBccno');
							
							if (b_ret[0].vccewno != undefined) {
								$('#txtCno').val(b_ret[0].cno);
								$('#txtAcomp').val(b_ret[0].acomp);
								$('#txtCustno').val(b_ret[0].custno);
								$('#txtComp').val(b_ret[0].comp);
								$('#txtPost').val(b_ret[0].post);
								$('#txtAddr').val(b_ret[0].addr);
								$('#txtPost2').val(b_ret[0].zip_post);
								$('#txtAddr2').val(b_ret[0].addr_post);
								$('#txtPaytype').val(b_ret[0].paytype);
								$('#cmbTrantype').val(b_ret[0].trantype);
								$('#txtTel').val(b_ret[0].tel);
								$('#txtFax').val(b_ret[0].fax);
								$('#txtSalesno').val(b_ret[0].salesno);
								$('#txtSales').val(b_ret[0].sales);
								$('#txtCardealno').val(b_ret[0].cardealno);
								$('#txtCardeal').val(b_ret[0].cardeal);
								$('#txtCarno').val(b_ret[0].carno);
								$('#cmbTaxtype').val(b_ret[0].taxtype);
								$('#cmbCoin').val(b_ret[0].coin);
								$('#txtFloata').val(b_ret[0].floata);
							}
							
							sum();
						}     	
                		break;
                    case q_name + '_s':
                        q_boxClose2(s2);                   
                        break;
                }
                b_pop = '';
            }
			
			var focus_addr = '';
			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
            	var t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
						if($('#chkCancel').prop('checked'))
							$('#chkCancel_'+j).prop('checked','true')
					}
				}
				
                if(q_cur==1)
                	$('#txtWorker').val(r_name);
                else
                	$('#txtWorker2').val(r_name);
                	
                sum();
                	
               	var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vccw') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('vccw_s.aspx', q_name + '_s', "500px", "430px", q_getMsg("popSeek"));
            }
            
            function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}
            
            function bbsAssign() {           
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')){
                    	$('#txtUnit_' + j).focusout(function() {sum();});
						$('#txtWeight_' + j).focusout(function () { sum(); });
						$('#txtPrice_' + j).focusout(function() {sum();});
						$('#txtMount_' + j).focusout(function() {sum();});
						$('#txtTotal_' + j).focusout(function() {sum();});
                    } 
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#chkIsproj').attr('checked', true);
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                
                var t_where = "where=^^ 1=1 group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                sum();
                
                if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' group by post,addr ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
            }

            function btnPrint() {
                q_box("z_vccwp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'vccw', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if ( !as['bccname']&& !as['bccno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['custno'] = abbm2['custno'];
                as['comp'] = abbm2['comp'];
                as['datea'] = abbm2['datea'];
                as['mon'] = abbm2['mon'];
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
            
            function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' group by post,addr^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
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
            }
            .dview {
                float: left;
                width: 28%;
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
                width: 72%;
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
                /*width: 10%;*/
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 48%;
                float: left;
            }
            .txt.c3 {
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
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"],select {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:1%; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:30%; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:39%; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:39%; color:black;"><a id='vewCust'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="comp,4" style="text-align: center;">~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td class="td1" style="width: 108px;"> </td>
						<td class="td2" style="width: 108px;"> </td>
						<td class="td3" style="width: 108px;"> </td>
						<td class="td4" style="width: 108px;"> </td>
						<td class="td5" style="width: 108px;"> </td>
						<td class="td6" style="width: 108px;"> </td>
						<td class="td7" style="width: 108px;"> </td>
						<td class="td8" style="width: 108px;"> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td> </td>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td> </td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCno" class="lbl btn"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/> </td>
						<td><input id="txtAcomp" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblVccewno" class="lbl"> </a></td>
						<td><input id="txtVccewno"  type="text" class="txt c1"/></td>
						<td><input id="btnVccewimport" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td><select id="combPaytype" class="txt c1" onchange='combPaytype_chg()' > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan='2'><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan="2"><input id="txtFax" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td><input id="txtPost" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr" type="text" class="txt c1"/></td>
						<!--<td><span> </span><a id="lblOrdewno" class="lbl"> </a></td>
						<td><input id="txtOrdewno"  type="text" class="txt c1"/></td>
						<td><input id="btnOrdewimport" type="button"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td><input id="txtPost2" type="text" class="txt c1"/></td>
						<td colspan='4'>
							<input id="txtAddr2" type="text" class="txt c1" style="width: 410px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" class="txt c2"/>
							<input id="txtSales" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td ><select id="cmbTrantype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td><input id="txtCardealno"  type="text" class="txt c1"/></td>
						<td ><input id="txtCardeal"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td><input id="txtCarno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td colspan='2'><input id="txtMoney" type="text" class="txt c1" style="text-align: center;"/></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1"/></td>
						<td><select id="cmbTaxtype" class="txt c1" onchange='sum()' > </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1"> </select></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td colspan='2'><input id="txtTotalus" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td colspan='2'><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td colspan='2'><input id="txtWorker2" type="text" class="txt c1" /></td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class='lbl'> </a></td>
						<td colspan='7'>
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1540px;">
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:31px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:160px;"><a id='lblOrdewno_s'> </a></td>
					<td align="center" style="width:60px;"><a id='lblNo2_s'> </a></td>
					<td align="center" style="width:160px;"><a id='lblBccno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblBccname_s'> </a></td>
					<td align="center" style="width:55px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblStoreno_s'> </a></td>
					<td align="center" style="width:170px;"><a id='lblVccewno_s'> </a></td>
					<td align="center" style="width:175px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;width:1%;" /></td>
					<td><input id="txtOrdewno.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtNo2.*" type="text" class="txt c1"/>
						<input id="recno.*" type="hidden" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td align="center">
						<input class="txt" id="txtBccno.*" maxlength='30' type="text" style="width:83%;" />
						<input class="btn" id="btnBccno.*" type="button" value='.' style="width:1%;font-weight: bold;" />
					</td>
					<td><input class="txt c1" id="txtBccname.*" type="text" /></td>
					<td align="center"><input class="txt c1" id="txtUnit.*" type="text"/></td>
					<td><input class="txt num c1" id="txtMount.*" type="text" /></td>
					<td><input class="txt num c1" id="txtWeight.*" type="text" /></td>
					<td><input class="txt num c1" id="txtPrice.*" type="text" /></td>
					<td><input class="txt num c1" id="txtTotal.*" type="text" /></td>
					<td>
						<input id="txtStoreno.*" type="text" class="txt c1" style="width: 75%"/>
						<input class="btn"  id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtStore.*" type="text" class="txt c1"/>
					</td>
					<td><input class="txt c1" id="txtVccewno.*" type="text" /></td>
					<td><input class="txt c1" id="txtMemo.*" type="text" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
