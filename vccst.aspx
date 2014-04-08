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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_desc = 1;
			q_tables = 's';
			var q_name = "vcc";
			var q_readonly = ['txtVccatax', 'txtComp', 'txtAccno', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney', 'txtWeight', 'txtTotal', 'txtTax', 'txtTotalus'];
			var q_readonlys = ['txtTotal', 'txtOrdeno', 'txtNo2', 'txtTheory'];
			var bbmNum = [['txtPrice', 15, 3, 1], ['txtVccatax', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTranmoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtTotalus', 10, 2, 1], ['txtWeight', 10, 3, 1], ['txtFloata', 10, 4, 1]];
			var bbsNum = [['txtPrice', 15, 3, 1], ['txtTotal', 12, 2, 1, 1], ['txtWeight', 10, 3, 1], ['txtMount', 10, 2, 1], ['txtTheory', 12, 3, 1], ['txtGweight', 10, 3, 1], ['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1]];
			var bbmMask = [];
			var bbsMask = [['txtStyle', 'A']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//ajaxPath = "";
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,tel,zip_fact,addr_fact,paytype', 'txtCustno,txtComp,txtNick,txtTel,txtPost,txtAddr,txtPaytype', 'cust_b.aspx'], 
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], 
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], 
				['txtAddr', '', 'view_road', 'memo,zipcode', '0txtAddr,txtPost', 'road_b.aspx'], 
				['txtSpec_', '', 'spec', 'noa,product', '0txtSpec_,txtSpec_', 'spec_b.aspx', '95%', '95%'], 
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_', 'ucc_b.aspx'], 
				['txtUno_', 'btnUno_', 'view_uccc2', 'uno,uno,productno,class,spec,style,product,emount,eweight', '0txtUno_,txtUno_,txtProductno_,txtClass_,txtSpec_,txtStyle_,txtProduct_,txtMount_,txtWeight_', 'uccc_seek_b2.aspx?;;;1=0', '95%', '60%'], 
				['txtStoreno2_', 'btnStoreno2_', 'store', 'noa,store', 'txtStoreno2_,txtStore2_', 'store_b.aspx'], 
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']
			);
			brwCount2 = 12;
			var isinvosystem = false;
			//購買發票系統
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();

				q_gt('ucca', 'stop=1 ', 0, 0, 0, "ucca_invo");
				//判斷是否有買發票系統
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			var t_spec;
			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				$('#cmbTaxtype').val((($('#cmbTaxtype').val()) ? $('#cmbTaxtype').val() : '1'));
				$('#txtMoney').attr('readonly', true);
				$('#txtTax').attr('readonly', true);
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

				var t_mount = 0, t_price = 0, t_money = 0, t_moneyus = 0, t_weight = 0, t_total = 0, t_tax = 0;
				var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
				var t_unit = '';
				var t_float = q_float('txtFloata');
				var t_tranmoney = dec($('#txtTranmoney').val());
				var t_kind = (($('#cmbKind').val()) ? $('#cmbKind').val() : '');
				t_kind = t_kind.substr(0, 1);
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
					t_product = $.trim($('#txtProduct_' + j).val());
					if (t_unit.length == 0 && t_product.length > 0) {
						if (t_product.indexOf('管') > 0)
							t_unit = '支';
						else
							t_unit = 'KG';
						$('#txtUnit_' + j).val(t_unit);
					}
					//---------------------------------------
					if (t_kind == 'A') {
						q_tr('txtDime_' + j, q_float('textSize1_' + j));
						q_tr('txtWidth_' + j, q_float('textSize2_' + j));
						q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
						q_tr('txtRadius_' + j, q_float('textSize4_' + j));
					} else if (t_kind == 'B') {
						q_tr('txtRadius_' + j, q_float('textSize1_' + j));
						q_tr('txtWidth_' + j, q_float('textSize2_' + j));
						q_tr('txtDime_' + j, q_float('textSize3_' + j));
						q_tr('txtLengthb_' + j, q_float('textSize4_' + j));
					} else {//鋼筋、胚
						q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
					}
					getTheory(j);
					//---------------------------------------
					t_weights = q_float('txtWeight_' + j);
					t_prices = q_float('txtPrice_' + j);
					t_mounts = q_float('txtMount_' + j);
					if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'M2' || t_unit == 'M' || t_unit == '批' || t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
						t_moneys = q_mul(t_prices, t_weights);
					} else {
						t_moneys = q_mul(t_prices, t_mounts);
					}
					if (t_float == 0) {
						t_moneys = round(t_moneys, 0);
					} else {
						t_moneyus = q_add(t_moneyus, round(t_moneys, 2));
						t_moneys = round(q_mul(t_moneys, t_float), 0);
					}
					var t_styles = $.trim($('#txtStyle_' + j).val());
					var t_unos = $.trim($('#txtUno_' + j).val());
					var t_dimes = $.trim($('#txtDime_' + j).val());
					if (!(t_styles == '' && t_unos == '' && t_dimes == 0))
						t_weight = q_add(t_weight, t_weights);
					t_mount = q_add(t_mount, t_mounts);
					t_money = q_add(t_money, t_moneys);
					$('#txtTotal_' + j).val(FormatNumber(t_moneys));
				}
				/*t_money = q_add(t_money,t_tranmoney);*/
				t_total = t_money;
				t_tax = 0;
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				if (!isinvosystem) {
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
				}
				t_price = q_float('txtPrice');
				if (t_price != 0) {
					$('#txtTranmoney').val(FormatNumber(round(q_mul(t_weight, t_price), 0)));
				}
				$('#txtWeight').val(FormatNumber(t_weight));
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
				if (t_float == 0)
					$('#txtTotalus').val(0);
				else
					$('#txtTotalus').val(FormatNumber(t_moneyus));
			}

			function mainPost() {// 載入資料完，未 refresh 前
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
				q_cmbParse("cmbStype", q_getPara('vccst.stype'));
				q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				q_gt('spec', '', 0, 0, 0, "", r_accy);
				var t_where = "where=^^ 1=1  group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				//=======================================================
				$("#cmbTypea").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#cmbKind").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				}).click(function(e) {
					size_change();
					sum();
				});
				$("#cmbTaxtype").change(function(e) {
					sum();
				});
				$("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2)
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
				});
				$("#txtPaytype").focus(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				}).click(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				});
				//=====================================================================
				/* 若非本會計年度則無法存檔 */
				$('#txtDatea').focusout(function() {
					if ($(this).val().substr(0, 3) != r_accy) {
						$('#btnOk').attr('disabled', 'disabled');
						alert(q_getMsg('lblDatea') + '非本會計年度。');
					} else {
						$('#btnOk').removeAttr('disabled');
					}
				});
				$('#btnVcceImport').click(function() {
					var t_ordeno = $('#txtOrdeno').val();
					var t_custno = $('#txtCustno').val();
					var t_where = '1=1 ';
					t_where += q_sqlPara2('ordeno', t_ordeno) + q_sqlPara2('custno', t_custno) + " and ((len(gmemo)=0) or gmemo='cubu') and kind='" + $('#cmbKind').val() + "'";
					q_box("vcce_import_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'view_vcce_import', "95%", "95%", q_getMsg('popVcceImport'));
				});
				$('#lblOrdeno').click(function() {
					if (!(q_cur == 1 || q_cur == 2))
						return;
					btnOrdes();
				});
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
				});
				$('#btnImportVcce').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						var t_custno = $('#txtCustno').val();
						if (t_custno.length == 0) {
							alert('請輸入 : 【' + q_getMsg('lblCust') + '】');
						} else {
							t_where = "where=^^ custno='" + t_custno + "' ^^";
							q_gt('view_vcces', t_where, 0, 0, 0, "", r_accy);
						}
					}
				});
				$('#txtFloata').change(function() {
					sum();
				});
				$('#txtTax').change(function() {
					sum();
				});
				$('#txtPrice').change(function() {
					sum();
				});

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
				$('#lblInvono').click(function() {
					if ($('#txtInvono').val().length > 0)
						q_pop('txtInvono', "vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtInvono').val() + "';" + r_accy, 'vcca', 'noa', 'datea', "95%", "95%px", q_getMsg('lblInvono'), true);
				});

				if (isinvosystem) {
					$('.istax').hide();
					$('#txtVccatax').show();
				}

			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				var
				ret;
				switch (b_pop) {
					case 'view_vcce_import':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0) {
								b_pop = '';
								return;
							}
							AddRet = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtOrdeno,txtNo2,txtProductno,txtProduct,txtRadius,txtWidth,txtDime,txtLengthb,txtSpec,txtMount,txtWeight,txtPrice,txtStyle,txtSize', b_ret.length, b_ret, 'uno,ordeno,no2,productno,product,radius,width,dime,lengthb,spec,mount,weight,price,style,size', '');
							//get ordes.price <Start>
							var distinctArray = new Array;
							var inStr = '';
							for (var i = 0; i < b_ret.length; i++) {
								distinctArray.push(b_ret[i].ordeno);
							}
							distinctArray = distinct(distinctArray);
							for (var i = 0; i < distinctArray.length; i++) {
								inStr += "'" + distinctArray[i] + "',";
							}
							inStr = inStr.substring(0, inStr.length - 1);
							if (trim(inStr).length > 0) {
								var t_where = "where=^^ noa in(" + inStr + ") and (isnull(noa,'') != '') ^^";
								q_gt('view_ordes', t_where, 0, 0, 0, "", r_accy);
							}
							//get ordes.price <End>
							/// 最後 aEmpField 不可以有【數字欄位】
							size_change();
						}
						sum();
						break;
					case 'ordes':
						if (q_cur > 0 && q_cur < 4) {//  q_cur： 0 = 瀏覽狀態  1=新增  2=修改 3=刪除  4=查詢
							b_ret = getb_ret();
							///  q_box() 執行後，選取的資料
							if (!b_ret || b_ret.length == 0) {
								b_pop = '';
								return;
							}
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_' + i).click();
							}
							for (var k = 0; k < b_ret.length; k++) {
								var t_notv = dec(b_ret[k].notv);
								var t_mount = dec(b_ret[k].mount);
								var t_weight = dec(b_ret[k].weight);
								var t_kind = trim(b_ret[k].kind).toUpperCase();
								if (t_kind.substring(0, 1) == 'B') {
									if (t_notv != t_mount) {
										t_weight = round(q_mul(q_div(t_weight, t_mount), t_notv), 0);
									}
									t_mount = t_notv;
								} else {
									if (t_notv != t_weight) {
										t_mount = round(q_mul(q_div(t_mount, t_weight), t_notv), 0);
									}
									t_weight = t_notv;
								}
								b_ret[k].mount = t_mount;
								b_ret[k].weight = t_weight;
							}
							var t_where = "where=^^ noa='" + b_ret[0].noa + "'";
							q_gt('view_orde', t_where, 0, 0, 0, "", r_accy);
							AddRet = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtRadius,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2,txtUno,txtMount,txtWeight,txtPrice,txtSize,txtStyle', b_ret.length, b_ret, 'productno,product,radius,dime,width,lengthb,unit,noa,no2,uno,mount,weight,price,size,style', 'txtProductno');
							/// 最後 aEmpField 不可以有【數字欄位】
							for (var i = 0; i < AddRet.length; i++) {
								$('#txtMount_' + i).change();
							}
							sum();
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}

			function distinct(arr1) {
				var uniArray = [];
				for (var i = 0; i < arr1.length; i++) {
					var val = arr1[i];
					if ($.inArray(val, uniArray) === -1) {
						uniArray.push(val);
					}
				}
				return uniArray;
			}

			var focus_addr = '';
			var StyleList = '';
			var vcces_as = new Array;
			var t_uccArray = new Array;
			var AddRet = new Array;
			function q_gtPost(t_name) {/// 資料下載後 ...
				switch (t_name) {
					case 'getVccatax':
						var as = _q_appendData("vcca", "", true);
						if (as[0] != undefined) {
							$('#txtVccatax').val(q_trv(as[0].tax, 0, 1));
							var t_noa = $('#txtNoa').val();
							for (var i = 0; i < abbm.length; i++) {
								if (abbm[i].noa == t_noa) {
									abbm[i].vccatax = as[0].tax;
									break;
								}
							}
						}
						break;
					case 'ucca_invo':
						var as = _q_appendData("ucca", "", true);
						if (as[0] != undefined) {
							isinvosystem = true;
							$('.istax').hide();
						} else {
							isinvosystem = false;
						}
						q_gt('style', '', 0, 0, 0, '');
						break;
					case 'check_memos':
						var as = _q_appendData("view_ordes", "", true);
						var err_log = '';
						for (var j = 0; j < q_bbsCount; j++) {
							var t_memo = trim($('#txtMemo_' + j).val());
							var OrdenoIndex = t_memo.search(/^[E]+[0-9]{10}\x2d[0-9]{3}/g);
							var bbsOrdeno = t_memo.substr(OrdenoIndex, 15);
							var t_productno = trim($('#txtProductno_' + j).val());
							for (var k = 0; k < as.length; k++) {
								var asOrdeno = as[k].noa + '-' + as[k].no2;
								if (bbsOrdeno == asOrdeno) {
									if (t_productno != as[k].productno) {
										err_log += '表身第 ' + (j + 1) + ' 筆訂單資料異常，訂單品號：' + as[k].productno + ' 表身品號：' + t_productno + '\n';
									}
									$('#txtMemo_' + j).val('');
									var t_ordeno = trim($('#txtOrdeno_' + j).val());
									var t_no2 = trim($('#txtNo2_' + j).val());
									if (t_ordeno.length == 0)
										$('#txtOrdeno_' + j).val(bbsOrdeno.split('-')[0]);
									if (t_no2.length == 0)
										$('#txtNo2_' + j).val(bbsOrdeno.split('-')[1]);
									break;
								}
							}
						}
						if (trim(err_log).length > 0) {
							alert('Warning：\n' + err_log);
						}
						checkOrde(q_bbsCount - 1);
						break;
					case 'view_orde':
						var as = _q_appendData("view_orde", "", true);
						if (as[0] != undefined) {(trim($('#txtTel').val()) == '' ? $('#txtTel').val(as[0].tel) : ''); (trim($('#txtFax').val()) == '' ? $('#txtFax').val(as[0].fax) : ''); (trim($('#txtPost').val()) == '' ? $('#txtPost').val(as[0].post) : ''); (trim($('#txtAddr').val()) == '' ? $('#txtAddr').val(as[0].addr) : ''); (trim($('#txtSalesno').val()) == '' ? $('#txtSalesno').val(as[0].salesno) : ''); (trim($('#txtSales').val()) == '' ? $('#txtSales').val(as[0].sales) : ''); (trim($('#txtPaytype').val()) == '' ? $('#txtPaytype').val(as[0].paytype) : '');
							$('#cmbTrantype').val(as[0].trantype); (trim($('#txtFloata').val()) == '' ? $('#txtFloata').val(as[0].floata) : '');
							$('#cmbCoin').val(as[0].coin);
						}
						break;
					case 'getAcomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							$('#txtCno').val(as[0].noa);
							$('#txtAcomp').val(as[0].nick);
						}
						Unlock(1);
						$('#txtNoa').val('AUTO');
						$('#txtDatea').val(q_date());
						$('#txtMon').val(q_date().substring(0, 6));
						$('#txtDatea').focus();
						size_change();
						break;
					case 'spec':
						t_spec = _q_appendData("spec", "", true);
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case 'view_vcces':
						vcces_as = _q_appendData("view_vcces", "", true);
						if (vcces_as[0] != undefined) {
							var distinctArray = new Array;
							var inStr = '';
							for (var i = 0; i < vcces_as.length; i++) {
								distinctArray.push(vcces_as[i].ordeno);
							}
							distinctArray = distinct(distinctArray);
							for (var i = 0; i < distinctArray.length; i++) {
								inStr += "'" + distinctArray[i] + "',";
							}
							inStr = inStr.substring(0, inStr.length - 1);
							if (trim(inStr).length > 0) {
								var t_where = "where=^^ ordeno in(" + inStr + ") and (isnull(ordeno,'') != '') ^^";
								q_gt('view_vccs', t_where, 0, 0, 0, "", r_accy);
							}
						}
						sum();
						break;
					case 'checkApv':
						var as = _q_appendData("view_orde", "", true);
						var ErrStr = '';
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if ($.trim(as[i].apv).length == 0) {
									ErrStr += '訂單編號：' + as[i].noa + '未經過核准!!\n';
								}
							}
						}
						if ($.trim(ErrStr).length == 0) {
							var unostkWhere = "where[1]=^^ 1=1 ^^where[2]=^^ 1=1 ^^where[4]=^^ 1=1 ^^";
							var UnoList = GetUnoList().split(',');
							var ReturnStr = '';
							for (var k = 0; k < UnoList.length; k++) {
								ReturnStr += "'" + UnoList[k] + "'";
								if (k < ((UnoList.length) - 1))
									ReturnStr += ',';
							}
							unostkWhere = unostkWhere + "where=^^ a.uno in (" + ReturnStr + ")^^";
							unostkWhere = unostkWhere + "where[3]=^^ noa != '" + $.trim($('#txtNoa').val()) + "'^^";
							q_gt('unostk', unostkWhere, 0, 0, 0, "", r_accy);
						} else {
							ErrStr += '禁止存檔!!';
							alert(ErrStr);
							Unlock(1);
							return;
						}
						break;
					case 'unostk':
						var unostkList = _q_appendData("unostktmp", "", true);
						var unostkList_Tmp=new Array();;
						var ErrStr='';
						if(unostkList.length > 0 && unostkList[0] != undefined){
							for(var j=0;j<unostkList.length;j++){
								unostkList_Tmp.push({
									uno:unostkList[j].uno,
									mount:unostkList[j].mount,
									weight:unostkList[j].weight
								});
							}
							for(var i=0;i<q_bbsCount;i++){
								bbsUno=$.trim($('#txtUno_'+i).val());
								bbsMount=dec($('#txtMount_'+i).val());
								for(var k=0;k<unostkList_Tmp.length;k++){
									if(bbsUno==$.trim(unostkList_Tmp[k].uno)){
										unostkList_Tmp[k].mount = dec(unostkList_Tmp[k].mount)-bbsMount;
									}
								}
							}
							for(var k=0;k<unostkList_Tmp.length;k++){
								if(dec(unostkList_Tmp[k].mount) < 0){
									ErrStr+='批號：'+unostkList_Tmp[k].uno+' 庫存量：'+dec(unostkList[k].mount)+' 本次出貨量：' + (dec(unostkList[k].mount)-dec(unostkList_Tmp[k].mount)) + '\n';
								}
							}
							if($.trim(ErrStr).length > 0){
								ErrStr = '警告：\n'+ErrStr;
								alert(ErrStr);
							}
						}
						var t_noa = trim($('#txtNoa').val());
						var t_date = trim($('#txtDatea').val());
						if (t_noa.length == 0 || t_noa == "AUTO")
							q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
						else
							wrServer(t_noa);
						break;
					case 'view_vccs':
						var vccs_as = _q_appendData("view_vccs", "", true);
						for (var i = 0; i < vccs_as.length; i++) {
							for (var j = 0; j < vcces_as.length; j++) {
								if ((vcces_as[j].ordeno == vccs_as[i].ordeno) && (vcces_as[j].no2 == vccs_as[i].no2)) {
									vcces_as[j].mount = dec(vcces_as[j].mount) - dec(vccs_as[i].mount);
									vcces_as[j].weight = dec(vcces_as[j].weight) - dec(vccs_as[i].weight);
								}
							}
						}
						for (var i = 0; i < vcces_as.length; i++) {
							if (vcces_as[i].mount <= 0 || vcces_as[i].weight <= 0 || vcces_as[i].ordeno == '') {
								vcces_as.splice(i, 1);
								i--;
							}
						}
						if (vcces_as[0] != undefined) {
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_' + i).click();
							};
							AddRet = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtSpec,txtRadius,txtDime,txtWidth,txtLengthb,txtMount,txtWeight,txtPrice,txtStyle,txtOrdeno,txtNo2,txtSize', vcces_as.length, vcces_as, 'uno,productno,product,spec,radius,dime,width,lengthb,mount,weight,price,style,ordeno,no2,size', 'txtUno');
							size_change();
							sum();
							//get ordes.price <Start>
							var distinctArray = new Array;
							var inStr = '';
							for (var i = 0; i < vcces_as.length; i++) {
								distinctArray.push(vcces_as[i].ordeno);
							}
							distinctArray = distinct(distinctArray);
							for (var i = 0; i < distinctArray.length; i++) {
								inStr += "'" + distinctArray[i] + "',";
							}
							inStr = inStr.substring(0, inStr.length - 1);
							if (trim(inStr).length > 0) {
								var t_where = "where=^^ noa in(" + inStr + ") and (isnull(noa,'') != '') ^^";
								q_gt('view_ordes', t_where, 0, 0, 0, "", r_accy);
							}
							//get ordes.price <End>
						}
						vcces_as = new Array;
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
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
					default:
						if (t_name.substring(0, 11) == 'checkOrde1_') {
							var t_sel = parseInt(t_name.split('_')[1]);
							var t_ordeno = t_name.split('_')[2];
							var t_no2 = t_name.split('_')[3];
							var as = _q_appendData("view_ordes", "", true);
							if (as[0] != undefined) {
								var t_mount = parseFloat(as[0].mount.length == 0 ? "0" : as[0].mount);
								var t_weight = parseFloat(as[0].weight.length == 0 ? "0" : as[0].weight);
								var t_where = "where=^^ ordeno='" + t_ordeno + "' and no2='" + t_no2 + "' and noa!='" + $.trim($('#txtNoa').val()) + "'^^";
								q_gt('view_vccs', t_where, 0, 0, 0, 'checkOrde2_' + t_sel + '_' + t_ordeno + '_' + t_no2 + '_' + t_mount + '_' + t_weight, r_accy);
							} else {
								alert('查無訂單資料【' + t_ordeno + '-' + t_no2 + '】');
								Unlock(1);
							}
						} else if (t_name.substring(0, 11) == 'checkOrde2_') {
							var t_sel = parseInt(t_name.split('_')[1]);
							var t_ordeno = t_name.split('_')[2];
							var t_no2 = t_name.split('_')[3];
							var t_mount = parseFloat(t_name.split('_')[4]);
							var t_weight = parseFloat(t_name.split('_')[5]);
							var as = _q_appendData("view_vccs", "", true);
							var tot_mount = 0, tot_weight = 0;
							var tot_mount2 = 0, tot_weight2 = 0;
							if (as[0] != undefined) {
								for (var i = 0; i < as.length; i++) {
									tot_mount = q_add(tot_mount, parseFloat(as[i].mount.length == 0 ? "0" : as[i].mount));
									tot_weight = q_add(tot_weight, parseFloat(as[i].weight.length == 0 ? "0" : as[i].weight));
								}
							}
							for (var i = 0; i < q_bbsCount; i++) {
								if ($.trim($('#txtOrdeno_' + i).val()) == t_ordeno && $.trim($('#txtNo2_' + i).val()) == t_no2) {
									tot_mount2 = q_add(tot_mount2, q_float('txtMount_' + i));
									tot_weight2 = q_add(tot_weight2, q_float('txtWeight_' + i));
								}
							}
							if ($('#cmbKind').val() == 'B2') {
								if (q_mul(t_mount, 1.2) >= q_add(tot_mount, tot_mount2)) {
									checkOrde(t_sel - 1);
								} else {
									alert("訂單【" + t_ordeno + "-" + t_no2 + "】數量異常，超過１２％!\n訂數：" + q_trv(t_mount, 2) + "\n已派：" + q_trv(tot_mount, 2) + "\n本次：" + q_trv(tot_mount2, 2));
									Unlock(1);
								}
							} else {
								if (q_mul(t_weight, 1.2) >= q_add(tot_weight, tot_weight2)) {
									checkOrde(t_sel - 1);
								} else {
									alert("訂單【" + t_ordeno + "-" + t_no2 + "】重量異常，超過１２％!\n訂重：" + q_trv(t_weight, 2) + "\n已派：" + q_trv(tot_weight, 2) + "\n本次：" + q_trv(tot_weight2, 2));
									Unlock(1);
								}
							}
						} else if (t_name.substring(0, 13) == 'afterPopUno1_') {
							var t_sel = parseInt(t_name.split('_')[1]);
							var as = _q_appendData("view_ordes", "", true);
							if (as[0] != undefined) {
								$('#txtDime_' + t_sel).val(as[0].dime);
								$('#txtWidth_' + t_sel).val(as[0].width);
								$('#txtLengthb_' + t_sel).val(as[0].lengthb);
								$('#txtRadius_' + t_sel).val(as[0].radius);
								$('#txtSize_' + t_sel).val(as[0].size);
								size_change();
								sum();
							} else {//找不到訂單 回view_uccb找尺寸
								alert('警告：查無訂單【' + $('#txtOrdeno_' + t_sel).val() + '-' + $('#txtNo2_' + t_sel).val() + '】');
								q_gt('view_uccb', "where=^^ uno='" + $.trim($('#txtUno_' + t_sel).val()) + "'^^", 0, 0, 0, 'afterPopUno2_' + t_sel, r_accy);
							}
						} else if (t_name.substring(0, 13) == 'afterPopUno2_') {
							var t_sel = parseInt(t_name.split('_')[1]);
							var as = _q_appendData("view_uccb", "", true);
							if (as[0] != undefined) {
								$('#txtDime_' + t_sel).val(as[0].dime);
								$('#txtWidth_' + t_sel).val(as[0].width);
								$('#txtLengthb_' + t_sel).val(as[0].lengthb);
								$('#txtRadius_' + t_sel).val(as[0].radius);
								$('#txtSize_' + t_sel).val(as[0].size);
							} else {
								$('#txtDime_' + t_sel).val('');
								$('#txtWidth_' + t_sel).val('');
								$('#txtLengthb_' + t_sel).val('');
								$('#txtRadius_' + t_sel).val('');
								$('#txtSize_' + t_sel).val('');
							}
							size_change();
							sum();
						}
				}  /// end switch
			}

			function btnOrdes() {
				var t_custno = trim($('#txtCustno').val());
				var t_kind = $('#cmbKind').val();
				var t_where = " 1=1 and kind='" + t_kind + "'";
				if (t_custno.length > 0) {
					t_where += (t_custno.length > 0 ? q_sqlPara2("custno", t_custno) : "");
					////  sql AND 語法，請用 &&
					t_where = t_where;
				} else {
					alert(q_getMsg('msgCustEmp'));
					return;
				}
				var distinctArray = new Array;
				var inStr = '';
				for (var i = 0; i < abbsNow.length; i++) {
					distinctArray.push(abbsNow[i].ordeno + abbsNow[i].no2);
				}
				distinctArray = distinct(distinctArray);
				for (var i = 0; i < distinctArray.length; i++) {
					if (trim(distinctArray[i]) != '')
						inStr += "'" + distinctArray[i] + "',";
				}
				inStr = inStr.substring(0, inStr.length - 1);
				t_where += " and (select enda from view_orde where view_orde.noa=view_ordes" + r_accy + ".noa)='0' ";
				t_where += " and (((enda!=1) and (notv > 0))" + (trim(inStr).length > 0 ? " or noa+no2 in(" + inStr + ") " : '') + ")";
				q_box("ordests_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
			}/// q_box()  開 視窗

			function GetOrdenoList() {
				var ReturnStr = new Array;
				for (var i = 0; i < q_bbsCount; i++) {
					var thisVal = trim($('#txtOrdeno_' + i).val());
					if (thisVal.length > 0)
						ReturnStr.push(thisVal);
				}
				ReturnStr = distinct(ReturnStr).sort();
				return ReturnStr.toString();
			}

			function GetUnoList() {
				var ReturnStr = new Array;
				for (var i = 0; i < q_bbsCount; i++) {
					var thisVal = trim($('#txtUno_' + i).val());
					if (thisVal.length > 0)
						ReturnStr.push(thisVal);
				}
				ReturnStr = distinct(ReturnStr).sort();
				return ReturnStr.toString();
			}

			function btnOk() {
				Lock(1, {
					opacity : 0
				});
				$('#txtOrdeno').val(GetOrdenoList());
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtMon').val().length == 0)
					$('#txtMon').val($('#txtDatea').val().substring(0, 6));
				if (!q_cd($('#txtMon').val() + '/01')) {
					alert(q_getMsg('lblMon') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtDatea').val().substring(0, 3) != r_accy) {
					alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
					Unlock(1);
					return;
				}
				if ($.trim($('#txtNick').val()).length == 0 && $.trim($('#txtComp').val()).length > 0)
					$('#txtNick').val($.trim($('#txtComp').val()).substring(0, 4));
				sum();

				var distinctArray = new Array;
				for (var k = 0; k < q_bbsCount; k++) {
					var t_memo = trim($('#txtMemo_' + k).val());
					var OrdenoIndex = t_memo.search(/^[E]+[0-9]{10}\x2d[0-9]{3}/g);
					if (OrdenoIndex > -1) {
						var x_ordeno = t_memo.substr(OrdenoIndex, 15);
						distinctArray.push(x_ordeno);
					}
				}
				var inStr = '';
				distinctArray = distinct(distinctArray);
				for (var i = 0; i < distinctArray.length; i++) {
					if (trim(distinctArray[i]) != '')
						inStr += "'" + distinctArray[i] + "',";
				}
				inStr = inStr.substring(0, inStr.length - 1);
				if (trim(inStr).length == 0) {
					checkOrde(q_bbsCount - 1);
				} else {
					var t_where = "where=^^ noa+'-'+no2 in(" + inStr + ")^^";
					q_gt('view_ordes', t_where, 0, 0, 0, "check_memos", r_accy);
				}
			}

			function chkOrdenoEmp() {
				var err_log = '';
				if (q_getPara('sys.comp').substring(0, 3) == '裕承隆') {
					for (var i = 0; i < q_bbsCount; i++) {
						var t_uno = $.trim($('#txtUno_' + i).val());
						var t_ordeno = $.trim($('#txtOrdeno_' + i).val());
						var t_no2 = $.trim($('#txtNo2_' + i).val());
						if (t_uno.length > 0 && ((t_ordeno.length == 0) || (t_no2.length == 0))) {
							err_log += '表身第 ' + (i + 1) + ' 筆訂單編號或訂序為空\n';
						}
					}
					if (trim(err_log).length > 0) {
						alert('Warning：\n' + err_log);
					}
				}
			}

			function checkOrde(n) {
				if (n < 0) {
					if (q_cur == 1)
						$('#txtWorker').val(r_name);
					else
						$('#txtWorker2').val(r_name);
					chkOrdenoEmp();
					var OrdenoList = GetOrdenoList().split(',');
					var ReturnStr = '';
					for (var k = 0; k < OrdenoList.length; k++) {
						ReturnStr += "'" + OrdenoList[k] + "'";
						if (k < ((OrdenoList.length) - 1))
							ReturnStr += ',';
					}
					var t_where = "where=^^ noa in (" + ReturnStr + ")^^";
					q_gt('view_orde', t_where, 0, 0, 0, "checkApv", r_accy);
				} else {
					//
					var t_noa = $.trim($('#txtNoa').val());
					var t_ordeno = $.trim($('#txtOrdeno_' + n).val());
					var t_no2 = $.trim($('#txtNo2_' + n).val());
					if (t_ordeno.length > 0 && (($('#cmbKind').val() == 'B2' && q_float('txtMount_' + n) != 0) || ($('#cmbKind').val() != 'B2' && q_float('txtWeight_' + n) != 0))) {
						var t_where = "where=^^ noa='" + t_ordeno + "' and no2='" + t_no2 + "'^^";
						q_gt('view_ordes', t_where, 0, 0, 0, 'checkOrde1_' + n + '_' + t_ordeno + '_' + t_no2, r_accy);
					} else {
						checkOrde(n - 1);
					}
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				$('#txtVccatax').val(0);
				var t_noa = $('#txtNoa').val();
				for (var i = 0; i < abbm.length; i++) {
					if (abbm[i].noa == t_noa) {
						abbm[i].vccatax = 0;
						break;
					}
				}
				var strSplit = xmlString.split(';');
				if (strSplit.length >= 2) {
					abbm[q_recno]['accno'] = strSplit[0];
					$('#txtAccno').val(strSplit[0]);
					abbm[q_recno]['invono'] = strSplit[1];
					$('#txtInvono').val(strSplit[1]);
					if (strSplit[1].length > 0)
						q_gt('vcca', "where=^^noa='" + strSplit[1] + "'^^", 0, 0, 0, 'getVccatax', r_accy);
				}
				Unlock(1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('vccst_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
			}

			function getTheory(b_seq) {
				t_Radius = dec($('#txtRadius_' + b_seq).val());
				t_Width = dec($('#txtWidth_' + b_seq).val());
				t_Dime = dec($('#txtDime_' + b_seq).val());
				t_Lengthb = dec($('#txtLengthb_' + b_seq).val());
				t_Mount = dec($('#txtMount_' + b_seq).val());
				t_Style = $('#txtStyle_' + b_seq).val();
				t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting = {
					calc : StyleList,
					ucc : t_uccArray,
					radius : t_Radius,
					width : t_Width,
					dime : t_Dime,
					lengthb : t_Lengthb,
					mount : t_Mount,
					style : t_Style,
					productno : t_Productno,
					round : 3
				};
				if ($('#cmbKind').val().substr(1, 1) == '4') {//鋼胚
					q_tr('txtTheory_' + b_seq, round(t_Mount * theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), t_Dime, t_Width, t_Lengthb), 0));
				} else {
					q_tr('txtTheory_' + b_seq, theory_st(theory_setting));
				}
				var t_Product = $('#txtProduct_' + b_seq).val();
				if (t_Product.indexOf('管') > -1 && dec($('#txtWeight_' + b_seq).val()) == 0) {
					$('#txtWeight_' + b_seq).val($('#txtTheory_' + b_seq).val());
				}
			}

			function bbsAssign() {/// 表身運算式
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtStyle_' + j).blur(function() {
							$('input[id*="txtProduct_"]').each(function() {
								thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
								$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
							});
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							ProductAddStyle(n);
							sum();
							$('#txtWeight_'+n).val($('#txtTheory_'+n).val());
						});
						//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
						$('#textSize1_' + j).focusout(function() {
                            if(q_cur==1 || q_cur==2){
                                var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                                sum();
                                $('#txtWeight_'+n).val($('#txtTheory_'+n).val());
                            }
                        });
						$('#textSize2_' + j).focusout(function() {
                            if(q_cur==1 || q_cur==2){
                                var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                                sum();
                                $('#txtWeight_'+n).val($('#txtTheory_'+n).val());
                            }
                        });
						$('#textSize3_' + j).focusout(function() {
                            if(q_cur==1 || q_cur==2){
                                var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                                sum();
                                $('#txtWeight_'+n).val($('#txtTheory_'+n).val());
                            }
                        });
						$('#textSize4_' + j).focusout(function() {
                            if(q_cur==1 || q_cur==2){
                                var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                                sum();
                                $('#txtWeight_'+n).val($('#txtTheory_'+n).val());
                            }
                        });
						$('#txtSize_' + j).change(function(e) {
							if ($.trim($(this).val()).length == 0)
								return;
							var n = $(this).attr('id').replace('txtSize_', '');
							var data = tranSize($.trim($(this).val()));
							$(this).val(tranSize($.trim($(this).val()), 'getsize'));
							$('#textSize1_' + n).val('');
							$('#textSize2_' + n).val('');
							$('#textSize3_' + n).val('');
							$('#textSize4_' + n).val('');
							if ($('#cmbKind').val() == 'A1') {//鋼捲鋼板
								if (!(data.length == 2 || data.length == 3)) {
									alert(q_getPara('transize.error01'));
									return;
								}
								$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
								$('#textSize2_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
								$('#textSize3_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
								sum();
							} else if ($('#cmbKind').val() == 'A4') {//鋼胚
								if (!(data.length == 2 || data.length == 3)) {
									alert(q_getPara('transize.error04'));
									return;
								}
								$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
								$('#textSize2_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
								$('#textSize3_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
							} else if ($('#cmbKind').val() == 'B2') {//鋼管
								if (!(data.length == 3 || data.length == 4)) {
									alert(q_getPara('transize.error02'));
									return;
								}
								if (data.length == 3) {
									$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
									$('#textSize3_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
									$('#textSize4_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
								} else {
									$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
									$('#textSize2_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
									$('#textSize3_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
									$('#textSize4_' + n).val((data[3] != undefined ? (data[3].toString().length > 0 ? (isNaN(parseFloat(data[3])) ? 0 : parseFloat(data[3])) : 0) : 0));
								}
							} else if ($('#cmbKind').val() == 'C3') {//鋼筋
								if (data.length != 1) {
									alert(q_getPara('transize.error03'));
									return;
								}
								$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
							} else {
								//nothing
							}
							sum();
							$('#txtWeight_'+n).val($('#txtTheory_'+n).val());
						});
						//-------------------------------------------------
						$('#txtSpec_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if ($('#cmbKind').val().substr(1, 1) == '4') {//鋼胚
								q_tr('txtTheory_' + n, theory_bi(t_spec, $('#txtSpec_' + n).val(), dec($('#txtDime_' + n).val()), dec($('#txtWidth_' + n).val()), dec($('#txtLengthb_' + n).val())));
							}
						});
						$('#txtUnit_' + j).focusout(function() {
						    if(q_cur==1 || q_cur==2)
							    sum();
						});
						$('#txtWeight_' + j).focusout(function() {
							if(q_cur==1 || q_cur==2)
                                sum();
						});
						$('#txtPrice_' + j).focusout(function() {
							if(q_cur==1 || q_cur==2){
							    sum();
							}
						});
						$('#txtMount_' + j).focusout(function() {
							if(q_cur==1 || q_cur==2){
							    var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                                sum();
                                $('#txtWeight_'+n).val($('#txtTheory_'+n).val());
							}
						});
					}
				}//j
				_bbsAssign();
				size_change();
			}

			function btnIns() {
				_btnIns();
				$('#cmbTaxtype').val(1);
				Lock(1, {
					opacity : 0
				});
				q_gt('acomp', '', 0, 0, 0, 'getAcomp', r_accy);
				var t_where = "where=^^ 1=1  group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				/* var s1 = '';
				 for (var j = 0; j < aPop.length; j++) {
				 if (aPop[j][0].length > 6 && aPop[j][0].substr(0, 7) == 'txtUno_') {
				 aPop[j][8] = '';
				 for (var i = 0; i < q_bbsCount; i++) {
				 s1 = $('#txtUno_' + i).val();
				 if (s1 && s1.length > 0)
				 aPop[j][8] += s1 + ',';
				 }

				 if (aPop[j][8].length > 0) {
				 s1 = aPop[j][8];
				 s1 = s1.substr(0, s1.length - 1);
				 aPop[j][8] = 'uno={' + s1 + '}';
				 }

				 break;
				 }
				 }*/

				$('#txtDatea').focus();
				size_change();
				sum();
			}

			function btnPrint() {
				//q_box('z_vccstp.aspx', '', "95%", "95%", q_getMsg("popPrint"));
				q_box("z_vccstp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'z_vccstp', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
				// key_value
			}

			function bbsSave(as) {
				if (!as['product'] && !as['uno'] && parseFloat(as['mount'].length == 0 ? "0" : as['mount']) == 0 && parseFloat(as['weight'].length == 0 ? "0" : as['weight']) == 0) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['type'] = abbm2['type'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['datea'] = abbm2['datea'];
				as['tggno'] = abbm2['tggno'];
				as['kind'] = abbm2['kind'];
				if (abbm2['storeno'])
					as['storeno'] = abbm2['storeno'];

				t_err = '';
				if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
					t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';

				if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
					t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

				if (t_err) {
					alert(t_err);
					return false;
				}

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				if (r_rank < 9) {
					$('#btnImportVcce').css('display', 'none');
				}
				size_change();
			//	q_popPost('txtProductno_');
				if (isinvosystem)
					$('.istax').hide();
			}
			var ret; //勿刪
			var x_bseq = 0;
			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function() {
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
						});
						if (trim($('#txtStyle_' + b_seq).val()).length != 0)
							ProductAddStyle(b_seq);
						$('#txtStyle_' + b_seq).focus();
						break;
					case 'txtUno_':
						var t_ordeno = $.trim($('#txtOrdeno_' + b_seq).val());
						var t_no2 = $.trim($('#txtNo2_' + b_seq).val());
						var t_uno = $.trim($('#txtUno_' + b_seq).val());
						if(ret != undefined && ret.length > 0){
							if (t_ordeno.length > 0 && t_no2 > 0) {
								q_gt('view_ordes', "where=^^ noa='" + t_ordeno + "' and no2='" + t_no2 + "'^^", 0, 0, 0, 'afterPopUno1_' + b_seq, r_accy);
							} else if (t_uno.length > 0) {
								q_gt('view_uccb', "where=^^ uno='" + t_uno + "'^^", 0, 0, 0, 'afterPopUno2_' + b_seq, r_accy);
							}
						}
						break;
				}

			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				var WantDisabledArray = ['btnImportVcce', 'btnVcceImport'];
				for (var k = 0; k < WantDisabledArray.length; k++) {
					if (q_cur == 1 || q_cur == 2) {
						$("#" + WantDisabledArray[k]).removeAttr('disabled', 'disabled');
					} else {
						$("#" + WantDisabledArray[k]).attr('disabled', 'disabled');
					}
				}
				size_change();
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				size_change();
				if (q_tables == 's')
					bbsAssign();
			}

			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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

			function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
				$('#cmbKind').val((($('#cmbKind').val()) ? $('#cmbKind').val() : q_getPara('vcc.kind')));
				var t_kind = (($('#cmbKind').val()) ? $('#cmbKind').val() : '');
				t_kind = t_kind.substr(0, 1);
				if (t_kind == 'A') {
					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).hide();
						$('#Size').css('width', '220px');
						$('#txtSpec_' + j).css('width', '220px');
						$('#textSize1_' + j).val($('#txtDime_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				} else if (t_kind == 'B') {
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).show();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).show();
						$('#Size').css('width', '300px');
						$('#txtSpec_' + j).css('width', '300px');
						$('#textSize1_' + j).val($('#txtRadius_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtDime_' + j).val());
						$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
					}
				} else {//鋼筋和鋼胚
					$('#lblSize_help').text(q_getPara('sys.lblSizec'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).hide();
						$('#textSize2_' + j).hide();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).hide();
						$('#x2_' + j).hide();
						$('#x3_' + j).hide();
						$('#Size').css('width', '55px');
						$('#txtSpec_' + j).css('width', '55px');
						$('#textSize1_' + j).val(0);
						$('#txtDime_' + j).val(0);
						$('#textSize2_' + j).val(0);
						$('#txtWidth_' + j).val(0);
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
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

			function tipShow() {
				Lock(1);
				tipInit();
				var t_set = $('body');
				t_set.find('.tip').eq(0).show();
				//tipClose
				for (var i = 1; i < t_set.data('tip').length; i++) {
					index = t_set.data('tip')[i].index;
					obj = t_set.data('tip')[i].ref;
					msg = t_set.data('tip')[i].msg;
					shiftX = t_set.data('tip')[i].shiftX;
					shiftY = t_set.data('tip')[i].shiftY;
					if (obj.is(":visible")) {
						t_set.find('.tip').eq(index).show().offset({
							top : round(obj.offset().top + shiftY, 0),
							left : round(obj.offset().left + obj.width() + shiftX, 0)
						}).html(msg);
					} else {
						t_set.find('.tip').eq(index).hide();
					}
				}
			}

			function tipInit() {
				tip($('#lblOrdeno'), '<a style="color:darkblue;font-size:16px;font-weight:bold;width:300px;display:block;">點擊【' + q_getMsg('lblOrdeno') + '】匯入訂單</a>', 0, -15);
				tip($('#btnImportVcce'), '<a style="color:darkblue;font-size:16px;font-weight:bold;width:300px;display:block;">↓匯入派車單資料。</a>', -20, -15);
				tip($('#btnVcceImport'), '<a style="color:darkblue;font-size:16px;font-weight:bold;width:350px;display:block;">↑匯入裁剪、製管資料，需有訂單(未結案)。</a>', -20, 20);
			}

			function tip(obj, msg, x, y) {
				x = x == undefined ? 0 : x;
				y = y == undefined ? 0 : y;
				var t_set = $('body');
				if ($('#tipClose').length == 0) {
					//顯示位置在btnTip上
					t_set.data('tip', new Array());
					t_set.append('<input type="button" id="tipClose" class="tip" value="關閉"/>');
					$('#tipClose').css('position', 'absolute').css('z-index', '1001').css('color', 'red').css('font-size', '18px').css('display', 'none').click(function(e) {
						$('body').find('.tip').css('display', 'none');
						Unlock(1);
					});
					$('#tipClose').offset({
						top : round($('#btnTip').offset().top - 2, 0),
						left : round($('#btnTip').offset().left - 15, 0)
					});
					t_set.data('tip').push({
						index : 0,
						ref : $('#tipClose')
					});
				}
				if (obj.data('tip') == undefined) {
					t_index = t_set.find('.tip').length;
					obj.data('tip', t_index);
					t_set.append('<div class="tip" style="position: absolute;z-index:1000;display:none;"> </div>');
					t_set.data('tip').push({
						index : t_index,
						ref : obj,
						msg : msg,
						shiftX : x,
						shiftY : y
					});
				}
			}

			function combAddr_chg() {/// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
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
				width: 900px;
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
				width: 10%;
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
				color: black;
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
			.dbbs {
				width: 1740px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
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
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
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
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt" style="width:40%;"></select><select id="cmbStype" class="txt" style="width:60%;"></select></td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"></select></td>
						<td></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"   type="text" class="txt c1"/>
						</td>
						<td class="tdZ">
						<input type="button" id="btnTip" value="?" style="float:right;" onclick="tipShow()"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td>
						<input id="txtMon" type="text" class="txt c1"/>
						</td>
						<td></td>
						<td></td>
						<td colspan="2">
						<input type="checkbox" id="chkIsgenvcca" style="float:left;"/>
						<a id='lblIsgenvcca' class="lbl" style="float:left;"> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtCno" type="text" style="float:left;width:25%;"/>
						<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<td><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtInvono" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td ><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtCustno" type="text" style="float:left;width:25%;"/>
						<input id="txtComp"  type="text" style="float:left;width:75%;"/>
						<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblOrdeno' class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtOrdeno" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtTel"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
						<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="4" >
						<input id="txtPost"  type="text" style="float:left; width:70px;"/>
						<input id="txtAddr"  type="text" style="float:left; width:369px;"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="4" >
						<input id="txtPost2"  type="text" style="float:left; width:70px;"/>
						<input id="txtAddr2"  type="text" style="float:left; width:347px;"/>
						<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'></select></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtPaytype" type="text" style="float:left; width:87%;"/>
						<select id="combPaytype" style="float:left; width:26px;"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtCardealno" type="text" style="float:left;width:25%;"/>
						<input id="txtCardeal" type="text" style="float:left;width:75%;" />
						</td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtCarno" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td>
						<input id="txtTotalus" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td>
						<input id="txtFloata" type="text" class="txt num c1" />
						</td>
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbCoin" style="float:left;width:80px;" ></select></td>
						<td></td>
						<td colspan="2">
						<input id="btnImportVcce" type="button"/>
						<input id="btnVcceImport" type="button" title="cut cubu"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td>
						<input id="txtMoney" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
						<input id="txtTax" type="text" class="txt num c1 istax" />
						<input id="txtVccatax" type="text" class="txt num c1 " style="display:none;" />
						</td>
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbTaxtype" style="float:left;width:80px;" ></select></td>
						<td><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
						<td>
						<input id="txtTotal" type="text" class="txt num c1 istax" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td>
						<input id="txtWeight" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblPrices' class="lbl"> </a></td>
						<td>
						<input id="txtPrice" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td>
						<input id="txtTranmoney" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7">
						<input id="txtMemo" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td>
						<input id="txtWorker2"  type="text" class="txt c1"/>
						</td>
						<td></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno" type="text"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:230px;"><a id="lblUno_st" > </a></td>
					<td align="center" style="width:120px;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProduct_st'> </a></td>
					<td align="center" id="Size"><a id='lblSize_help'> </a>
					<BR>
					<a id='lblSize_st'> </a></td>
					<td align="center" style="width:180px;"><a id='lblSizea_st'></a></td>
					<td align="center" style="width:30px;"><a id='lblUnit'></a></td>
					<td align="center" style="width:80px;"><a id='lblMount_st'></a></td>
					<td align="center" style="width:100px;"><a id='lblWeight_st'></a></td>
					<td align="center" style="width:80px;"><a id='lblPrices_st'></a></td>
					<td align="center" style="width:80px;">合計
					<br>
					理論重</td>
					<td align="center" style="width:100px;"><a id='lblGweight_st'></a></td>
					<td align="center" style="width:60px;">寄Y
					<BR>
					代Z</td>
					<td align="center" style="width:80px;"><a id='lblStore2_st'> </a></td>
					<td align="center" style="width:180px;"><a id='lblMemos_st'></a></td>

				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input class="btn" id="btnUno.*" type="button" value='.' style="width:10%;"/>
					<input id="txtUno.*" type="text" style="width:80%;"/>
					</td>
					<td>
					<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:15px;float:left;" />
					<input  id="txtProductno.*" type="text" style="width:85px;" />
					<span style="display:block;width:15px;"> </span>
					<input id="txtClass.*" type="text" style='width: 85px;'/>
					</td>
					<td>
					<input type="text" id="txtStyle.*" style="width:85%;text-align:center;" />
					</td>
					<td>
					<input type="text" id="txtProduct.*" style="width:95%;" />
					</td>
					<!--<td><input class="txt c1" id="txtSpec.*" type="text"/></td>-->
					<td>
					<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
					<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >
						x
					</div>
					<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
					<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">
						x
					</div>
					<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
					<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">
						x
					</div>
					<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
					<!--上為虛擬下為實際-->
					<input id="txtRadius.*" type="text" style="display:none;"/>
					<input id="txtWidth.*" type="text" style="display:none;"/>
					<input id="txtDime.*" type="text" style="display:none;"/>
					<input id="txtLengthb.*" type="text" style="display:none;"/>
					<input id="txtSpec.*" type="text" style="float:left;"/>
					</td>
					<td>
					<input id="txtSize.*" type="text" style="width:95%;" />
					</td>
					<td>
					<input id="txtUnit.*" type="text" class="txt num" style="width:95%;text-align: center;"/>
					</td>
					<td>
					<input id="txtMount.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtPrice.*" type="text"  class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtTotal.*" type="text" class="txt num" style="width:95%;"/>
					<input id="txtTheory.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtGweight.*" type="text"  class="txt num" style="width:95%;"/>
					</td>
					<td >
					<input class="txt" id="txtUsecoil.*" type="text" style="text-align:center;width:95%;"/>
					</td>
					<td >
					<input class="btn"  id="btnStoreno2.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;display:none;" />
					<input  id="txtStoreno2.*" type="text" style="width:95%;" />
					<input id="txtStore2.*" type="text" style='width: 95%;'/>
					</td>
					<td>
					<input id="txtMemo.*" type="text" class="txt" style="width:95%;"/>
					<input id="txtOrdeno.*" type="text" style="width:65%;" />
					<input id="txtNo2.*" type="text" style="width:20%;" />
					<input id="recno.*" type="hidden" />
					</td>

				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
