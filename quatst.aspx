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

			q_desc = 1;
			q_tables = 's';
			var q_name = "quat";
			var q_readonly = ['txtComp', 'txtAcomp', 'txtSales', 'txtWorker', 'txtNoa','txtTotal','txtTax','txtMoney','txtOrdgweight','txtOrdeweight'];
			var q_readonlys = ['txtNo3', 'txtNo2','txtTheory','txtC1','txtNotv'];
			var bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 15, 0, 1], ['txtTotalus', 15, 2, 1], ['txtFloata', 15, 3, 1], ['txtWeight', 15, 3, 1], ['txtOrdgweight', 15, 3, 1], ['txtOrdeweight', 15, 3, 1]];
			var bbsNum = [['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1], ['txtMount', 10, 0, 1], ['txtWeight', 15, 3, 1], ['txtPrice', 15, 3, 1], ['txtTotal', 15, 0, 1], ['txtTheory', 15, 3, 1], ['txtOrdgweight', 15, 3, 1], ['txtOrdeweight', 15, 3, 1]];
			var bbmMask = [];
			var bbsMask = [['txtStyle', 'A']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_', 'ucc_b.aspx']
			, ['txtStyle_', 'btnStyle_', 'style', 'noa,product', 'txtStyle_', 'style_b.aspx']
			, ['txtCustno', 'lblCust', 'cust', 'noa,comp,paytype,trantype,tel,fax,zip_comp,addr_comp', 'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx']
			, ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
			, ['txtAddr', '', 'view_road', 'memo,zipcode', '0txtAddr,txtPost', 'road_b.aspx']
			, ['txtSpec_', '', 'spec', 'noa,product', '0txtSpec_,txtSpec_', 'spec_b.aspx', '95%', '95%']
			, ['txtAddr2', '', 'view_road', 'memo,zipcode', '0txtAddr2,txtPost2', 'road_b.aspx']
			, ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				q_brwCount();
				q_gt('style', '', 0, 0, 0, '');
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});

			//////////////////   end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}

				mainForm(1);
			}

			function currentData() {}
			currentData.prototype = {
				data : [],
				exclude : ['txtNoa','chkEnda'],  //bbm
				excludes : ['chkEnda'], //bbs
				copy : function() {
					this.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in this.exclude) {
							if (fbbm[i] == this.exclude[j] ) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude ) {
							this.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
					//bbs
					for (var i in fbbs) {
						for(var j = 0; j < q_bbsCount; j++) {
							var isExcludes = false;
							for (var k in this.excludes) {
								if (fbbs[i] == this.excludes[k] ) {
									isExcludes = true;
									break;
								}
							}
							if (!isExcludes ) {
								this.data.push({
									field : fbbs[i]+'_'+j,
									value : $('#' + fbbs[i]+'_'+j).val()
								});
							}
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in this.data) {
					   	$('#' + this.data[i].field).val(this.data[i].value);
				   	}
				}
			};
			var curData = new currentData();


			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				$('#cmbTaxtype').val((($('#cmbTaxtype').val())?$('#cmbTaxtype').val():'1'));
				$('#txtMoney').attr('readonly', true);
				$('#txtTax').attr('readonly', true);
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

				var t_mount = 0, t_price = 0, t_money = 0, t_moneyus=0, t_weight = 0, t_total = 0, t_tax = 0;
				var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
				var t_unit = '';
				var t_float = q_float('txtFloata');
				var t_kind = (($('#cmbKind').val())?$('#cmbKind').val():'');
				t_kind = t_kind.substr(0, 1);
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
					t_product = $.trim($('#txtProduct_' + j).val());
					if(t_unit.length==0 && t_product.length>0){
						if(t_product.indexOf('管')>0)
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
					if(t_unit.length==0 ||t_unit=='KG' || t_unit=='M2' || t_unit=='M' || t_unit=='批' || t_unit=='公斤' || t_unit=='噸' || t_unit=='頓'){
						t_moneys = q_mul(t_prices,t_weights);
					}else{
						t_moneys = q_mul(t_prices,t_mounts);
					}
					if(t_float==0){
						t_moneys = round(t_moneys,0);
					}else{
						t_moneyus = round(q_add(t_moneyus,t_moneys),2);
						t_moneys = round(q_mul(t_moneys,t_float),0);
					}
					t_weight = q_add(t_weight,t_weights);
					t_mount = q_add(t_mount,t_mounts);
					t_money = q_add(t_money,t_moneys);
					$('#txtTotal_' + j).val(FormatNumber(t_moneys));
				}
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				switch ($('#cmbTaxtype').val()) {
					case '1':
						// 應稅
						t_tax = round(q_mul(t_money,t_taxrate), 0);
						t_total = q_add(t_money,t_tax);
						break;
					case '2':
						//零稅率
						t_tax = 0;
						t_total = q_add(t_money,t_tax);
						break;
					case '3':
						// 內含
						t_tax = q_sub(t_money,round(q_div(t_money, q_add(1, t_taxrate)), 0));
						t_total = t_money;
						t_money = q_sub(t_total,t_tax);
						break;
					case '4':
						// 免稅
						t_tax = 0;
						t_total = q_add(t_money,t_tax);
						break;
					case '5':
						// 自定
						$('#txtTax').attr('readonly', false);
						$('#txtTax').css('background-color', 'white').css('color', 'black');
						t_tax = round(q_float('txtTax'), 0);
						t_total = q_add(t_money,t_tax);
						break;
					case '6':
						// 作廢-清空資料
						t_money = 0, t_tax = 0, t_total = 0;
						break;
					default:
				}
				t_price = q_float('txtPrice');
				if (t_price != 0) {
					$('#txtTranmoney').val(FormatNumber(round(q_mul(t_weight,t_price),0)));
				}
				$('#txtWeight').val(FormatNumber(t_weight));

				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
				if(t_float==0)
					$('#txtTotalus').val(0);
				else
					$('#txtTotalus').val(FormatNumber(t_moneyus));
			}

			var t_spec;
			//儲存spec陣列
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbStype", q_getPara('vcc.stype'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				q_gt('spec', '', 0, 0, 0, "", r_accy);
				$('#cmbKind').change(function() {
					size_change();
				});
				$('#txtFloata').change(function() {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				$('#lblContract').click(function() {
					if(!(q_cur==1 || q_cur ==2))
						return;
					var t_contract = $.trim($('#txtContract').val());
					q_box("contst.aspx?;;;contract='" + t_contract + "';" + r_accy, 'cont', "95%", "95%", q_getMsg("popContst"));
				});
				$('#btnQuatst2Contst').click(function() {
					if(r_rank <=8)
						return;
					//動作執行順序 : 確認系統參數 > 確認欄位是否留空 > 產生對話框詢問是否執行 > 如選市則執行func否則跳出
					if ((q_cur == 0 || q_cur == 4) && !emp($.trim($('#txtNoa').val()))) {
						var t_quatstnoa = encodeURI($.trim($('#txtNoa').val()));
						var t_datea = encodeURI($.trim($('#txtDatea').val()));
						var t_contno = encodeURI($.trim($('#txtContract').val()));
						var t_contPreFix = encodeURI(q_getPara('sys.key_contst'));
						if (emp(r_accy) || emp(r_name) || emp(t_contPreFix)) {
							alert('系統參數錯誤!!');
							return;
						} else if (emp(t_quatstnoa) || t_quatstnoa == 'AUTO') {
							alert('請先產生' + q_getMsg('lblNoa'));
							return;
						} else if (emp(t_datea)) {
							alert(q_getMsg('lblDatea') + '禁止為空!!');
							return;
						} else if (emp(t_contno)) {
							alert('請先輸入' + q_getMsg('lblContract'));
							return;
						}
						var todo = confirm('你確定要執行嗎?');
						if (todo == true) {
							q_func('qtxt.query.quatst2contst', 'quatst2contst.txt,quatst2contst,' + encodeURI(r_accy) + ';' + t_quatstnoa + ';' + t_datea + ';' + t_contno + ';' + t_contPreFix + ';' + encodeURI(r_name));
						}
					} else {
						alert('請點選確定後存檔才能執行!!');
					}
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
				$("#cmbTaxtype").change(function(e) {
					sum();
				});
				
				$('#txtTax').change(function() {
					sum();
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
			}
			function showSizeInfo(){
				$('#sizeInfo').toggle();
				$('#sizeInfo').offset({top:100,left:150});
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.quatst2contst':
						alert('執行成功!!');
						break;
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

			var focus_addr = '';
			var StyleList = '';
			var t_uccArray = new Array;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'getAcomp':
						var as = _q_appendData("acomp", "", true);
						if(as[0]!=undefined){
							$('#txtCno').val(as[0].noa);
							$('#txtAcomp').val(as[0].nick);
						}
						Unlock(1);
						$('#chkIsproj').attr('checked',true);
						$('#cmbKind').val(q_getPara('vcc.kind'));
						size_change();
						$('#txtNoa').val('AUTO');
						$('#txtOdate').val(q_date());
						$('#txtDatea').val(q_date());
						sum();
						$('#txtCno').focus();
						break;
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno])
							$('#cmbCoin').val(abbm[q_recno].coin);
						
						break;
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
						}
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case 'spec':
						t_spec = _q_appendData("spec", "", true);
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						if(t_name.substring(0, 11) == 'getproduct_'){
     						var t_seq = parseInt(t_name.split('_')[1]);
	                		as = _q_appendData('dbo.getproduct', "", true);
	                		if(as[0]!=undefined){
	                			$('#txtProduct_'+t_seq).val(as[0].product);
	                		}else{
	                			$('#txtProduct_'+t_seq).val('');
	                		}
	                		break;
                        }
				}
			}

			function btnOk() {
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
					}
				}
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				$('#txtWorker').val(r_name);
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_quat') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('quatst_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtOdate').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function getTheory(b_seq) {
				t_Radius = dec($('#txtRadius_' + b_seq).val());
				t_Width = dec($('#txtWidth_' + b_seq).val());
				t_Dime = dec($('#txtDime_' + b_seq).val());
				t_Lengthb = dec($('#txtLengthb_' + b_seq).val());
				t_Mount = dec($('#txtMount_' + b_seq).val());
				t_Style = $('#txtStyle_' + b_seq).val();
				t_Stype = ($('#cmbStype').find("option:selected").text() == '外銷' ? 1 : 0);
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
					stype : t_Stype,
					productno : t_Productno,
					round:3
				};
				if ($('#cmbKind').val().substr(1, 1) == '4') {
					q_tr('txtTheory_' + b_seq, round(t_Mount * theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), t_Dime, t_Width, t_Lengthb), 0));
				} else {
					q_tr('txtTheory_' + b_seq, theory_st(theory_setting));
				}
				var t_Product = $('#txtProduct_' + b_seq).val();
				if(t_Product.indexOf('管') > -1 && dec($('#txtWeight_' + b_seq).val()) == 0){
					$('#txtWeight_' + b_seq).val($('#txtTheory_' + b_seq).val());
				}
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtStyle_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtStyle_', '');
                            $('#btnStyle_'+n).click();
                        });
                        $('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
						$('#textSize1_' + j).change(function() {sum();});
						$('#textSize2_' + j).change(function() {sum();});
						$('#textSize3_' + j).change(function() {sum();});
						$('#textSize4_' + j).change(function() {sum();});
						$('#txtSize_'+j).change(function(e){
							if ($.trim($(this).val()).length == 0)
								return;
							var n = $(this).attr('id').replace('txtSize_','');
							var data = tranSize($.trim($(this).val()));
							$(this).val(tranSize($.trim($(this).val()),'getsize'));
							$('#textSize1_'+n).val('');
							$('#textSize2_'+n).val('');
							$('#textSize3_'+n).val('');
							$('#textSize4_'+n).val('');
							if($('#cmbKind').val()=='A1'){//鋼捲鋼板
								if(!(data.length==2 || data.length==3)){
									alert(q_getPara('transize.error01'));
									return;
								}
								$('#textSize1_'+n).val((data[0]!=undefined?(data[0].toString().length>0?(isNaN(parseFloat(data[0]))?0:parseFloat(data[0])):0):0));
								$('#textSize2_'+n).val((data[1]!=undefined?(data[1].toString().length>0?(isNaN(parseFloat(data[1]))?0:parseFloat(data[1])):0):0));
								$('#textSize3_'+n).val((data[2]!=undefined?(data[2].toString().length>0?(isNaN(parseFloat(data[2]))?0:parseFloat(data[2])):0):0));
								sum();
							}else if($('#cmbKind').val()=='A4'){//鋼胚
								if(!(data.length==2 || data.length==3)){
									alert(q_getPara('transize.error04'));
									return;
								}
								$('#textSize1_'+n).val((data[0]!=undefined?(data[0].toString().length>0?(isNaN(parseFloat(data[0]))?0:parseFloat(data[0])):0):0));
								$('#textSize2_'+n).val((data[1]!=undefined?(data[1].toString().length>0?(isNaN(parseFloat(data[1]))?0:parseFloat(data[1])):0):0));
								$('#textSize3_'+n).val((data[2]!=undefined?(data[2].toString().length>0?(isNaN(parseFloat(data[2]))?0:parseFloat(data[2])):0):0));
							}else if($('#cmbKind').val()=='B2'){//鋼管
								if(!(data.length==3 || data.length==4)){
									alert(q_getPara('transize.error02'));
									return;
								}
								if(data.length==3){
									$('#textSize1_'+n).val((data[0]!=undefined?(data[0].toString().length>0?(isNaN(parseFloat(data[0]))?0:parseFloat(data[0])):0):0));
									$('#textSize3_'+n).val((data[1]!=undefined?(data[1].toString().length>0?(isNaN(parseFloat(data[1]))?0:parseFloat(data[1])):0):0));
									$('#textSize4_'+n).val((data[2]!=undefined?(data[2].toString().length>0?(isNaN(parseFloat(data[2]))?0:parseFloat(data[2])):0):0));
								}else{
									$('#textSize1_'+n).val((data[0]!=undefined?(data[0].toString().length>0?(isNaN(parseFloat(data[0]))?0:parseFloat(data[0])):0):0));
									$('#textSize2_'+n).val((data[1]!=undefined?(data[1].toString().length>0?(isNaN(parseFloat(data[1]))?0:parseFloat(data[1])):0):0));
									$('#textSize3_'+n).val((data[2]!=undefined?(data[2].toString().length>0?(isNaN(parseFloat(data[2]))?0:parseFloat(data[2])):0):0));
									$('#textSize4_'+n).val((data[3]!=undefined?(data[3].toString().length>0?(isNaN(parseFloat(data[3]))?0:parseFloat(data[3])):0):0));
								}
							}else if($('#cmbKind').val()=='C3'){//鋼筋
								if(data.length!=1){
									alert(q_getPara('transize.error03'));
									return;
								}
								$('#textSize1_'+n).val((data[0]!=undefined?(data[0].toString().length>0?(isNaN(parseFloat(data[0]))?0:parseFloat(data[0])):0):0));
							}else{
								//nothing
							}
							sum();
						});
						$('#txtMount_' + j).change(function() {
							sum();
						});
						//-------------------------------------------------------------------------------------

						$('#txtSpec_' + j).change(function() {
							sum();
						});
						$('#txtWeight_' + j).change(function() {
							sum();
						});
						$('#txtPrice_' + j).change(function() {
							sum();
						});
						$('#txtTotal_' + j).change(function() {
							sum();
						});
					}
				}
				_bbsAssign();
				size_change();
			}

			function btnIns() {
				if($('#checkCopy').is(':checked'))
					curData.copy();
				_btnIns();
				if($('#checkCopy').is(':checked'))
					curData.paste();
				$('#cmbTaxtype').val(1);
				Lock(1, {
					opacity : 0
				});
				q_gt('acomp', '', 0, 0, 0, 'getAcomp', r_accy);
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
				size_change();
			}

			function btnPrint() {
				q_box('z_quatstp.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['size']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				size_change();
				//q_popPost('txtProductno_');
				$('input[id*="txtProduct_"]').each(function() {
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
		           	$(this).attr('OldValue',$('#txtProductno_'+thisId).val());
				});
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						var t_productno = $.trim($('#txtProductno_'+b_seq).val());
	                	var t_style = $.trim($('#txtStyle_'+b_seq).val());
	                	var t_comp = q_getPara('sys.comp');          	
	                	q_gt('getproduct',"where=^^[N'"+t_productno+"',N'"+t_style+"',N'"+t_comp+"')^^", 0, 0, 0, "getproduct_"+b_seq); 
                        $('#txtStyle_' + b_seq).focus();
						break;
					case 'txtStyle_':
						console.log(b_seq);
                   		var t_productno = $.trim($('#txtProductno_'+b_seq).val());
	                	var t_style = $.trim($('#txtStyle_'+b_seq).val());
	                	var t_comp = q_getPara('sys.comp');          	
	                	q_gt('getproduct',"where=^^[N'"+t_productno+"',N'"+t_style+"',N'"+t_comp+"')^^", 0, 0, 0, "getproduct_"+b_seq); 
                        $('#txtStyle_'+b_seq).blur();
                        break;
					case 'txtCustno':
						$('#txtPost2').val($('#txtPost').val());
						$('#txtAddr2').val($('#txtAddr').val());
						$('#txtPaytype').focus();
						break;
					case 'txtSalesno':
						$('#txtTel').focus();
						break;
					case 'txtAddr':
						$('#txtPost2').focus();
						break;
					case 'txtAddr2':
						$('#txtContract').focus();
						break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(r_rank >8)
					$('#btnQuatst2Contst').css('display','');
				else
					$('#btnQuatst2Contst').css('display','none');
				size_change();
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				size_change();
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

			function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
				$('#cmbKind').val((($('#cmbKind').val())?$('#cmbKind').val():q_getPara('vcc.kind')));
				var t_kind = (($('#cmbKind').val())?$('#cmbKind').val():'');
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
						$('#Size').css('width', '230px');
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
						$('#Size').css('width', '308px');
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
						$('#Size').css('width', '70px');
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
		</script>
		<style type="text/css">
			#dmain {
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
				color: black;
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
			.txt.c4 {
				width: 30%;
				float: left;
			}
			.txt.c5 {
				width: 70%;
				float: left;
			}
			.txt.c6 {
				width: 85%;
				text-align: center;
			}
			.txt.c7 {
				width: 95%;
				float: left;
			}
			.txt.c8 {
				float: left;
				width: 65px;
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
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.dbbs {
				float: left;
				width: 1800px;
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
			.trX {
				background: pink;
			}
			.trTitle {
				padding-left: 18px;
				font-size: 18px;
				font-weight: bolder;
				color: brown;
				letter-spacing: 5px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="sizeInfo" style="position: absolute;display:none;width:200px;height:300px;">
			<table style="background:#8ADF39;border: 2px white double;"> 
				<tr>
					<td align="center" style="width:100px;"><a>編號</a></td>
					<td align="center" style="width:100px;"><a>尺寸</a></td>
				</tr>
				<tr>
					<td align="center"><a>A</a></td>
					<td align="center"><a>1/2"</a></td>
				</tr>
				<tr>
					<td align="center"><a>B</a></td>
					<td align="center"><a>3/4"</a></td>
				</tr>
				<tr>
					<td align="center"><a>C</a></td>
					<td align="center"><a>1"</a></td>
				</tr>
				<tr>
					<td align="center"><a>D</a></td>
					<td align="center"><a>1-1/4"</a></td>
				</tr>
				<tr>
					<td align="center"><a>E</a></td>
					<td align="center"><a>1-1/2"</a></td>
				</tr>
				<tr>
					<td align="center"><a>F</a></td>
					<td align="center"><a>2"</a></td>
				</tr>
				<tr>
					<td align="center"><a>G</a></td>
					<td align="center"><a>2-1/2"</a></td>
				</tr>
				<tr>
					<td align="center"><a>H</a></td>
					<td align="center"><a>3"</a></td>
				</tr>
				<tr>
					<td align="center"><a>I</a></td>
					<td align="center"><a>3-1/2"</a></td>
				</tr>
				<tr>
					<td align="center"><a>J</a></td>
					<td align="center"><a>4"</a></td>
				</tr>
				<tr>
					<td align="center"><a>K</a></td>
					<td align="center"><a>5"</a></td>
				</tr>
				<tr>
					<td align="center"><a>L</a></td>
					<td align="center"><a>6"</a></td>
				</tr>
				<tr>
					<td align="center"><a>W</a></td>
					<td align="center"><a>125*75</a></td>
				</tr>
				<tr>
					<td align="center"><a>X</a></td>
					<td align="center"><a>100*100</a></td>
				</tr>
				<tr>
					<td align="center"><a>Y</a></td>
					<td align="center"><a>150*100</a></td>
				</tr>
				<tr>
					<td align="center"><a>Z</a></td>
					<td align="center"><a>125*125</a></td>
				</tr>
			</table>
		</div>
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
			<div class="dview" id="dview">
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewDatea'></a></td>
						<td align="center" style="width:25%"><a id='vewNoa'></a></td>
						<td align="center" style="width:40%"><a id='vewComp'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='custno comp,4'>~custno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr class="tr1">
						<td class="td1">
							<input id="checkCopy" type="checkbox" style="float:left;"/>
							<span> </span><a id='lblCopy' class="lbl" style="float:left;"></a>
							<span> </span><a id='lblStype' class="lbl"></a>
						</td>
						<td class="td2"><select id="cmbStype" class="txt c1"></select></td>
						<td class="td5">
							<select id="cmbKind" class="txt c1"></select>
						</td>
						<td class="td7"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td8">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td>
						<input id="chkIsproj" type="checkbox"/>
						<span> </span><a id='lblIsproj'> </a>
						</td>
						<td class="td1"><span> </span><a id='lblOdate' class="lbl"></a></td>
						<td class="td2">
							<input id="txtOdate" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn" ></a></td>
						<td class="td2" colspan="2">
						<input id="txtCno"  type="text"  class="txt c4"/>
						<input id="txtAcomp"  type="text" class="txt c5"/>
						</td>
						<td class="td4"><span> </span><a id='lblFloata' class="lbl"></a></td>
						<td class="td5"><select id="cmbCoin" class="txt c1" onchange='coin_chg()'></select></td>
						<td class="td6">
						<input id="txtFloata"  type="text"  class="txt num c1" />
						</td>
						<td class="td4"><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td5">
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblCust" class="lbl btn"></a></td>
						<td class="td2" colspan="2">
						<input id="txtCustno" type="text" class="txt c4"/>
						<input id="txtComp"  type="text" class="txt c5"/>
						</td>
						<td class="td4"><span> </span><a id='lblPaytype' class="lbl"></a></td>
						<td class="td5">
						<input id="txtPaytype" type="text" class="txt c1" />
						</td>
						<td class="td6"><select id="combPaytype" class="txt c1"  onchange='combPaytype_chg()'> </select></td>
						<td class="td7"></td>
						<td class="td8">
						<input id="btnQuatst2Contst" type="button"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblSales" class="lbl btn"></a></td>
						<td class="td2" colspan="2">
						<input id="txtSalesno" type="text" class="txt c4"/>
						<input id="txtSales" type="text" class="txt c5"/>
						</td>
						<td class="td4"><span> </span><a id='lblTel' class="lbl"></a></td>
						<td class="td5" colspan='2'>
						<input id="txtTel"  type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblFax' class="lbl"></a></td>
						<td class="td8">
						<input id="txtFax"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
						<td class="td2">
						<input id="txtPost" type="text"  class="txt c1">
						</td>
						<td class="td3" colspan='4' >
						<input id="txtAddr" type="text"  class="txt c1" />
						</td>
						<td class="td7"><span> </span><a id='lblTrantype' class="lbl"></a></td>
						<td class="td8"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id='lblAddr2' class="lbl"></a></td>
						<td class="td2">
						<input id="txtPost2"  type="text"  class="txt c1"/>
						</td>
						<td class="td3" colspan='4'>
						<input id="txtAddr2"  type="text"  class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblContract' class="lbl btn"></a></td>
						<td class="td8">
						<input id="txtContract"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
						<td class="td2" colspan='2'>
						<input id="txtMoney" type="text" class="txt num c1" />
						</td>
						<td class="td4"><span> </span><a id='lblTax' class="lbl"></a></td>
						<td class="td5">
						<input id="txtTax" type="text"  class="txt num c1" />
						</td>
						<td class="td6"><select id="cmbTaxtype" class="txt c1"></select></td>
						<td class="td7"><span> </span><a id='lblTotal' class="lbl"></a></td>
						<td class="td8">
						<input id="txtTotal" type="text"  class="txt num c1" />
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblTotalus' class="lbl"></a></td>
						<td class="td2" colspan='2'>
						<input id="txtTotalus" type="text"  class="txt num c1" />
						</td>
						<td class="td4"><span> </span><a id='lblWeight' class="lbl"></a></td>
						<td class="td5" colspan='2' >
						<input id="txtWeight"  type="text"  class="txt num c1" />
						</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id='lblOrdgweight' class="lbl"> </a></td>
						<td class="trX">
						<input id="txtOrdgweight" type="text" class="txt c1 num" />
						</td>
						<td class="trX"><span> </span><a id='lblOrdeweight' class="lbl"> </a></td>
						<td class="trX">
						<input id="txtOrdeweight" type="text" class="txt c1 num" />
						</td>
						<td class="trX" colspan="2" align="center"><span> </span><a id='lblCtrlweight'> </a>
						<input id="chkIsctrlweight" type="checkbox"/>
						<span> </span><a id='lblEnda'> </a>
						<input id="chkEnda" type="checkbox"/>
						</td>
						<td class="trX"><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td class="trX">
						<input id="txtWorker"  type="text" class="txt c1" />
						</td>
						<td class="tdZ trX"></td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan='7' >						<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"></textarea></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;' >
						<td align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
						</td>
						<td align="center" style="width:20px;"></td>
						<td align="center" style="width:120px;"><a>品號<BR>品名</a></td>
						<td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
						<td align="center" style="width:80px;"><a>等級</a></td>
						<td align="center" id='Size'><a id='lblSize_help'> </a></br><a id='lblSize_st'> </a></td>
						<td align="center" style="width:10%;"><a id='lblSizea_st'></a><input id="btnShowInfo" type="button" value="代碼列表" onclick="showSizeInfo()"></td>
						<td align="center" style="width:3%;"><a id='lblUnit_st'></a></td>
						<td align="center" style="width:5%;"><a id='lblMount_st'></a></td>
						<td align="center" style="width:7%;"><a id='lblWeight_st'></a></td>
						<td align="center" style="width:5%;"><a id='lblPrice_st'></a></td>
						<td align="center" style="width:8%;"><a id='lblTotal_st'></a></td>
						<td align="center"><a id='lblMemo_st'></a></td>
						<td align="center" style="width:5%;"><a id='lblGweight_st'></a></td>
						<td align="center" style="width:5%;"><a id='lblEweight_st'></a></td>
						<!--
						<td align="center" style="width:5%;"><a id='lblOrdgweight_st'></a></td>
						<td align="center" style="width:5%;"><a id='lblOrdeweight_st'></a></td>
						-->
						<td align="center" style="width:2%;"><a id='lblEnda_st'></a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td >
							<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
							<input type="text" id="txtNo3.*"  style="display:none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input id="txtProductno.*" type="text" style="width:95%;" />
							<input type="text" id="txtProduct.*" style="width:95%;" />
							<input class="btn" id="btnProduct.*" type="button" style="display:none;"/>
						</td>
						<td><input type="text" id="txtStyle.*" style="width:95%;text-align:center;" />
							<input id="btnStyle.*" type="button" style="display:none;" value="."/>
						</td>
						<td><input id="txtClass.*" type="text" style='width: 95%;'/></td>
						
						<td>
						<input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/>
						<div id="x1.*" style="float: left">
							x
						</div>
						<input class="txt num c8" id="textSize2.*" type="text" disabled="disabled"/>
						<div id="x2.*" style="float: left">
							x
						</div>
						<input class="txt num c8" id="textSize3.*" type="text" disabled="disabled"/>
						<div id="x3.*" style="float: left">
							x
						</div>
						<input class="txt num c8" id="textSize4.*" type="text" disabled="disabled"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="hidden"/>
						<input  id="txtWidth.*" type="hidden"/>
						<input  id="txtDime.*" type="hidden"/>
						<input id="txtLengthb.*" type="hidden"/>
						<input class="txt c1" id="txtSpec.*" type="text"/>
						</td>
						<td >
						<input id="txtSize.*" type="text" class="txt c7"/>
						</td>
						<td >
						<input id="txtUnit.*" type="text" class="txt c7"/>
						</td>
						<td >
						<input id="txtMount.*" type="text"  class="txt num c7"/>
						</td>
						<td >
						<input id="txtWeight.*" type="text"  class="txt num c7" />
						</td>
						<td >
						<input id="txtPrice.*" type="text" class="txt num c7" />
						</td>
						<td >
						<input id="txtTotal.*" type="text" class="txt num c7" />
						<input id="txtTheory.*" type="text" class="txt num c7" />
						</td>
						<td>
						<input id="txtMemo.*" type="text" class="txt c7"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
						</td>
						<td >
						<input id="txtC1.*" type="text" class="txt num c7" />
						</td>
						<td >
						<input id="txtNotv.*" type="text" class="txt num c7" />
						</td>
						<!--
						<td ><input id="txtOrdgweight.*" type="text" class="txt num c7" /></td>
						<td ><input id="txtOrdeweight.*" type="text" class="txt num c7" /></td>
						-->
						<td align="center">
						<input id="chkEnda.*" type="checkbox"/>
						</td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
