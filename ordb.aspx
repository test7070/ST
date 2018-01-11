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
			q_tables = 's';
			var q_name = "ordb";
			var q_readonly = ['txtOrdcno','txtWorkgno', 'txtTgg', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney', 'txtTotal', 'txtTotalus','txtApv'];
			var q_readonlys = ['txtNo3','txtStdmount', 'txtNo2', 'txtTotal', 'txtC1', 'txtNotv', 'txtOmount','chkEnda','txtOrdeno','txtNo2'];
			var bbmNum = [
				['txtFloata', 10, 5, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1],
				['txtTotal', 10, 0, 1], ['txtTotalus', 10, 0, 1]
			];
			//chkIsnotdeal 功能未知 先隱藏
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			//q_xchg = 1;
			brwCount2 = 10;
			aPop = new Array(
				['txtProductno1_', 'btnProduct1_', 'ucaucc2', 'noa,product,unit,spec,stdmount', 'txtProductno1_,txtProduct_,txtUnit_,txtSpec_,txtStdmount_,txtProduct_', 'ucaucc2_b.aspx'],
				['txtProductno2_', 'btnProduct2_', 'bcc', 'noa,product,unit', 'txtProductno2_,txtProduct_,txtUnit_,txtProduct_', 'bcc_b.aspx'],
				['txtProductno3_', 'btnProduct3_', 'fixucc', 'noa,namea,unit', 'txtProductno3_,txtProduct_,txtUnit_,txtProduct_', 'fixucc_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype', 'txtTggno,txtTgg,txtNick,txtPaytype', 'tgg_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx']
			);

			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				var t_db=q_db.toLocaleUpperCase();
				q_gt('acomp', "where=^^(dbname='"+t_db+"' or not exists (select * from acomp where dbname='"+t_db+"')) ^^ stop=1", 0, 0, 0, "cno_acomp");
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				$('#txtMoney').attr('readonly', true);
				$('#txtTax').attr('readonly', true);
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

				var t_mount = 0, t_price = 0, t_money = 0, t_weight = 0, t_total = 0, t_tax = 0;
				var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
				var t_float = q_float('txtFloata');

				for (var j = 0; j < q_bbsCount; j++) {
					t_weights = q_float('txtWeight_' + j);
					t_prices = q_float('txtPrice_' + j);
					t_mounts = q_float('txtMount_' + j);
					t_moneys = round(q_mul(t_prices, t_mounts), 0);

					t_weight = q_add(t_weight, t_weights);
					t_mount = q_add(t_mount, t_mounts);
					t_money = q_add(t_money, t_moneys);

					$('#txtTotal_' + j).val(q_trv(t_moneys, 0, 1));
				}
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
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
						t_tax = round(q_mul(q_div(t_money, q_add(1, t_taxrate)), t_taxrate), 0);
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
				t_price = q_float('txtPrice');
				if (t_price != 0) {
					$('#txtTranmoney').val(q_trv(round(q_mul(t_weight, t_price), 0), 0, 1));
				}
				$('#txtWeight').val(q_trv(t_weight, 0, 1));

				$('#txtMoney').val(q_trv(t_money, 0, 1));
				$('#txtTax').val(q_trv(t_tax, 0, 1));
				$('#txtTotal').val(q_trv(t_total, 0, 1));
				$('#txtTotalus').val(q_trv(round(q_mul(q_float('txtTotal'), q_float('txtFloata')), 2), 0, 1));
			}

			function mainPost() {
				if (q_getPara('sys.project').toUpperCase()=='RB'){
					aPop = new Array(
						['txtProductno1_', 'btnProduct1_', 'ucc', 'noa,product,unit,spec,stdmount', 'txtProductno1_,txtProduct_,txtUnit_,txtSpec_,txtStdmount_,txtProduct_', 'ucc_b2.aspx'],
						['txtProductno2_', 'btnProduct2_', 'bcc', 'noa,product,unit', 'txtProductno2_,txtProduct_,txtUnit_,txtProduct_', 'bcc_b.aspx'],
						['txtProductno3_', 'btnProduct3_', 'ucc', 'noa,product,unit,spec,stdmount', 'txtProductno3_,txtProduct_,txtUnit_,txtSpec_,txtStdmount_,txtProduct_', 'ucc_b2.aspx'],
						['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
						['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
						['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype', 'txtTggno,txtTgg,txtNick,txtPaytype', 'tgg_b.aspx']
					);
				}
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					aPop = new Array(
						['txtProductno1_', '', 'ucc_xy', 'noa,product,style,unit,spec,stdmount', 'txtProductno1_,txtProduct_,txt_,txtUnit_,txtSpec_,txtStdmount_,txtProduct_', ''],
						['txtProductno2_', 'btnProduct2_', 'bcc', 'noa,product,unit', 'txtProductno2_,txtProduct_,txtUnit_,txtProduct_', 'bcc_b.aspx'],
						['txtProductno3_', '', 'ucc_xy', 'noa,product,style,unit,spec,stdmount', 'txtProductno3_,txtProduct_,txt_,txtUnit_,txtSpec_,txtStdmount_,txtProduct_', ''],
						['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
						['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
						['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype', 'txtTggno,txtTgg,txtNick,txtPaytype', 'tgg_b.aspx'],
						['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx']
					);
					q_readonlys.push('txtUnit');
				}
				
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				bbsNum = [['txtMount', 10, q_getPara('rc2.mountPrecision'), 1], ['txtOmount', 10, q_getPara('rc2.mountPrecision'), 1], ['txtPrice', 10, q_getPara('rc2.pricePrecision'), 1],
										['txtTotal', 10, 0, 1], ['txtC1', 10, q_getPara('rc2.mountPrecision'), 1], ['txtNotv', 10, q_getPara('rc2.mountPrecision'), 1], ['txtStdmount', 10, q_getPara('rc2.mountPrecision'), 1]];
				
				bbsMask = [['txtLdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbKind", q_getPara('ordb.kind'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

				$("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2)
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
				});
				$("#combAddr").change(function(e) {
					if (q_cur == 1 || q_cur == 2) {
						$('#txtAddr').val($('#combAddr').find("option:selected").text());
						$('#txtPost').val($('#combAddr').find("option:selected").val());
					}
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
				
				$('#btnOrde').hide();
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('#btnOrde').show();
				}
				$('#btnOrde').click(function() {
					//var t_where =" isnull(enda,'0')='0' and ISNULL(cancel,'0')='0' and noa+'_'+no2 not in (select isnull(ordeno,'')+'_'+isnull(no2,'') from view_ordbs" + r_accy + " where noa!='" + $('#txtNoa').val() + "') and productno in ( select noa from ucc)";
					//q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+t_where+";"+r_accy, 'ordes', "95%", "95%", q_getMsg('popOrde'));
					
					if (q_getPara('sys.project').toUpperCase()=='XY'){
						var t_where =" isnull(enda,'0')='0' and ISNULL(cancel,'0')='0' and mount!=0 ";//105/03/02 便品也可以匯入 and charindex('-',productno)>0
						//105/03/02 請購過的不能再出現 一次請完
						t_where +=" and not exists(select * from view_ordbs where ordeno=a.noa and no2=a.no2 and noa!='"+$('#txtNoa').val()+"')";
						//排除已出過貨
						t_where +=" and not exists(select * from view_vcc where ordeno=a.noa and no2=a.no2)";
						q_box("ordes_b3_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+t_where+";"+r_accy, 'ordes', "95%", "95%", q_getMsg('popOrde'));
					}
				});

				//變動按鈕
				$('#cmbKind').change(function() {
					for (var j = 0; j < q_bbsCount; j++) {
						btnMinus('btnMinus_' + j);
					}
					product_change();
				});
				$('#txtAddr').change(function() {
					var t_where = "where=^^ noa='" + trim($(this).val()) + "' ^^";
					q_gt('cust', t_where, 0, 0, 0, "", r_accy);
				});

				$('#txtFloata').change(function() {
					sum();
				});
				$("#cmbTaxtype").change(function(e) {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				$('#txtTggno').change(function() {
					loadCustAddr($.trim($(this).val()));
					if(q_getPara('sys.project').toUpperCase()=='XY'){
						var t_where =" noa='"+$('#txtTggno').val()+"'";
						q_gt('tgg', "where=^^ "+t_where+" ^^", 0, 0, 0, "xytggdata");
					}
				});
				$('#btnOrdc').click(function(e) {
					$('#exportordc').toggle();
					$('#textBno_a').val($('#txtNoa').val());
					$('#textEno_a').val($('#txtNoa').val());
				});
				$('#btnExport_a').click(function(e) {
					var t_tggno = $('#textTggno_a').val();
					var t_datea = $('#textDatea_a').val();
					var t_bedate = $('#textBedate_a').val();
					var t_eedate = $('#textEedate_a').val();
					var t_bfdate = $('#textBfdate_a').val();
					var t_efdate = $('#textEfdate_a').val();
					var t_bodate = $('#textBodate_a').val();
                    var t_eodate = $('#textEodate_a').val();
                    var t_bldate = $('#textBldate_a').val();
                    var t_eldate = $('#textEldate_a').val();
					var t_bproductno = $('#textBproductno_a').val();
                    var t_eproductno = $('#textEproductno_a').val();
					var t_workgno = $('#textWorkgno_a').val();
					var t_bno = $('#textBno_a').val();
					var t_eno = $('#textEno_a').val();
					if (t_datea.length > 0) {
						Lock(1, {
							opacity : 0
						});
						q_func('qtxt.query.ordb', 'ordb.txt,ordc,' + encodeURI(r_userno) + ';' + encodeURI(r_name) + ';' + encodeURI(q_getPara('key_ordc')) + ';' + encodeURI(t_datea) + ';' + encodeURI(t_tggno)
						+ ';' + encodeURI(t_bedate) + ';' + encodeURI(t_eedate) + ';' + encodeURI(t_bfdate) + ';' + encodeURI(t_efdate) + ';' + encodeURI(t_workgno) + ';' + encodeURI(t_bno) + ';' + encodeURI(t_eno)
						+ ';' + encodeURI(t_bodate) + ';' + encodeURI(t_eodate)
                        + ';' + encodeURI(t_bldate) + ';' + encodeURI(t_eldate)
                        + ';' + encodeURI(t_bproductno) + ';' + encodeURI(t_eproductno));
					} else
						alert('請輸入採購日期。');
				});
				$('#btnClose_a').click(function(e) {
					$('#exportordc').toggle();
				});
				//--------------------------------------------------------
				/*var t_para = ( typeof (q_getId()[5]) == 'undefined' ? '' : q_getId()[5]).split('&');
				for (var i = 0; i < t_para.length; i++) {
					if (t_para[i] == 'report=z_ordbp06') {
						q_box("z_ordbp.aspx?" + r_userno + ";" + r_name + ";" + q_id + ";action=z_ordbp06;" + r_accy, 'z_vccstp', "95%", "95%", q_getMsg('popPrint'));
					}
				}*/
				$('#lblOrdcno').click(function(e){
                    var t_where = "1!=1";
                    var t_ordcno = $('#txtOrdcno').val().split(',');
                    for(var i in t_ordcno){
                        if(t_ordcno[i].length>0)
                            t_where += " or noa='"+t_ordcno[i]+"'";
                    }
                    q_box("ordc.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'ordc', "95%", "95%", q_getMsg("popOrdc"));
                });
                
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
				//判斷核准(手動)是否顯示
				$('.apv').hide();
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.ordb':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							var t_msg = '';
							for (var i = 0; i < as.length; i++) {
								t_msg += (t_msg.length > 0 ? '\r\n' : '') + as[i].memo;
							}
							alert(t_msg);
							if (as.length > 1)
							    window.open("z_ordbp.aspx?" + r_userno + ";" + r_name + ";" + q_id + ";action=z_ordbp06;" + r_accy);
							location.replace("ordb.aspx?" + r_userno + ";" + r_name + ";" + q_id + ";;" + r_accy);
						} else {
							alert('無資料!');
						}
						Unlock(1);
						break;
					default:
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'xytggdata':
						var as = _q_appendData("tgg", "", true);
						if (as[0] != undefined) {
							$('#cmbTaxtype').val(as[0].conn);
						}
						break;
					case 'ucctgg':
						var as = _q_appendData("ucctgg", "", true);
						var ass = _q_appendData("ucctggs", "", true);
						var mount=dec($('#txtMount_'+b_seq).val())==0?1:dec($('#txtMount_'+b_seq).val());
						if (as[0] != undefined) {
							for ( var i = 0; i < ass.length; i++) {
								ass[i].dmoumt=q_sub(mount,dec(ass[i].mount));
								if(ass[i].dmoumt<0){
									ass.splice(i, 1);
	                                i--;
								}
							}
							ass.sort(function(a,b){return a.dmoumt-b.dmoumt;})
							if (ass[0] != undefined) {
								q_tr('txtPrice_'+b_seq,ass[0].price);
							}
						}
						break;
					case 'check_accu':
						var bbs_total=0,accu_total=0,ordb_total=0;
						var as = _q_appendData("accu", "", true);
						if (as[0] != undefined) {
							accu_total=dec(as[0].accu_total);
							ordb_total=dec(as[0].ordb_total);
						}
						if(!$('#chkCancel').prop('checked')){
							for(var i=0;i<q_bbsCount;i++){
								if(!$('#chkCancel_'+i).prop('checked')){
									bbs_total=q_add(bbs_total,dec($('#txtTotal_'+i).val()));
								}
							}
						}
						
						if(accu_total>=q_add(bbs_total,ordb_total)){
							chack_accu=true;
							btnOk();
						}else{
							alert(' 請購預算額度='+q_trv(accu_total)+' \r 已請購金額='+q_trv(ordb_total)+' \r 本次請購金額='+q_trv(bbs_total)+' \r ----------------------------------------- \r可用額度='+q_trv(Math.abs(q_sub(accu_total,q_add(bbs_total,ordb_total)))));
						}
						
						break;
					case 'GetTggt':
						var as = _q_appendData("ordb", "", true);
						if (as[0] != undefined) {
							$('#vttggt2_'+q_recno).text((as[0].tggt).substr(0,2));
							$('#vtfinish_'+q_recno).text((as[0].finish));
						}
						break;
					case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
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
					case 'combAddr':
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
					case 'cust' :
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							var CustAddr = trim(as[0].addr_fact);
							if (CustAddr.length > 0) {
								$('#txtAddr').val(CustAddr);
								$('#txtPost').val(as[0].zip_fact);
							}
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if(t_name.substring(0,11)=='ordesucctgg'){
					var n = parseInt(t_name.split('_')[1]);
                    var as = _q_appendData("ucctgg", "", true);
					var ass = _q_appendData("ucctggs", "", true);
					var mount=dec($('#txtMount_'+n).val())==0?1:dec($('#txtMount_'+n).val());
					if (as[0] != undefined) {
						for ( var i = 0; i < ass.length; i++) {
							ass[i].dmoumt=q_sub(mount,dec(ass[i].mount));
							if(ass[i].dmoumt<0){
								ass.splice(i, 1);
	                               i--;
							}
						}
						ass.sort(function(a,b){return a.dmoumt-b.dmoumt;})
						if (ass[0] != undefined) {
							q_tr('txtPrice_'+n,ass[0].price);
						}
					}
				}
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ucaucc_b_xy':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							if ($('#cmbKind').val() == '1') {
								$('#txtProductno1_'+b_seq).val(b_ret[0].noa);
							}else{
								$('#txtProductno3_'+b_seq).val(b_ret[0].noa);
							}
							$('#txtProduct_'+b_seq).val(b_ret[0].product);
							
							/*if (!emp(b_ret[0].noa)){
								var t_where =" noa='"+b_ret[0].noa+"' ";
								q_gt('ucc_xy', "where=^^ "+t_where+" ^^", 0, 0, 0, "getuccspec",r_accy,1);
								var as = _q_appendData("ucc", "", true, true);
								if (as[0] != undefined) {
									$('#txtUnit_'+b_seq).val(as[0].uunit);
								}else{
									$('#txtUnit_'+b_seq).val(b_ret[0].unit);
								}
							}*/
							$('#txtUnit_'+b_seq).val(b_ret[0].unit);
							$('#txtSpec_'+b_seq).val(b_ret[0].style+' '+b_ret[0].spec+' '+b_ret[0].engpro);
							$('#txtStdmount_'+b_seq).val(b_ret[0].stdmount);
							$('#txtProduct_'+b_seq).focus().select();
						}
						break;
					case 'ordbt':
						setTimeout(function(){
							var t_noa = $.trim($('#txtNoa').val());
							q_gt('ordb', "where=^^ noa='" + t_noa + "' ^^", 0, 0, 0, "GetTggt",r_accy);
						},800)
						break;
					case 'ordes': //XY 用
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							//if (q_getPara('sys.project').toUpperCase()!='XY')
							//	return;
								
							for (var j = 0; j < q_bbsCount; j++) {
								$('#btnMinus_' + j).click();
							}
							
							var t_post='',t_addr='',t_memo='',t_err='';
							for (var i = 0; i < b_ret.length; i++) {
								var t_where =" noa='"+b_ret[i].noa+"' ";
								q_gt('view_orde', "where=^^ "+t_where+" ^^", 0, 0, 0, "getordeaddr",r_accy,1);
								var as = _q_appendData("view_orde", "", true);
								if (as[0] != undefined) {
									if(i==0){ //只取第一筆訂單
										$('#cmbTrantype').val(as[0].trantype);
									}
									if(t_memo.indexOf(as[0].noa)==-1)
										t_memo=t_memo+as[0].noa+":"+as[0].memo+" ";
									
									if(as[0].trantype=='直寄'){
										if(as[0].addr2.length>0){
											if(t_addr.indexOf(as[0].addr2)==-1){
												t_addr=t_addr+(t_addr.length>0?',':'')+as[0].addr2;
												t_post=t_post+(t_post.length>0?',':'')+as[0].post2;
											}
										}else{
											if(t_addr.indexOf(as[0].addr)==-1){
												t_addr=t_addr+(t_addr.length>0?',':'')+as[0].addr;
												t_post=t_post+(t_post.length>0?',':'')+as[0].post;
											}
										}
									}
								}
								
								//合併
								b_ret[i].spec=b_ret[i].classa+' '+b_ret[i].spec;
								//產品主檔
								if (!emp(b_ret[i].productno)){
									var t_where =" noa='"+b_ret[i].productno+"' ";
									q_gt('ucc_xy', "where=^^ "+t_where+" ^^", 0, 0, 0, "getuccspec",r_accy,1);
									var as = _q_appendData("ucc", "", true, true);
									if (as[0] != undefined) {
										b_ret[i].spec=b_ret[i].spec+' '+as[0].engpro;
										b_ret[i].unit=as[0].unit;
										if(as[0].cdate!='採購'){
											t_err=t_err+b_ret[i].product+' 採購製令方式 非【採購】\n';
										}
									}else{
										t_err=t_err+b_ret[i].product+' 不在產品主檔內!!\n';
									}
								}
							}
							
							if(t_err.length>0){
								alert(t_err);
							}
							
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProductno1,txtProduct,txtUnit,txtSpec,txtMount,txtOrdeno,txtNo2,txtCustno,txtComp,txtMemo'
							, b_ret.length, b_ret, 'productno,productno,product,unit,spec,mount,noa,no2,custno,comp,memo', 'txtOrdeno,txtNo2');
							sum();
							if(t_addr.length>0){
								$('#txtPost').val(t_post);
								$('#txtAddr').val(t_addr);
							}
							if(t_memo.length>0){
								$('#txtMemo').val(t_memo);
							}
							if(q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtTggno').val())){
								for (var j = 0; j < q_bbsCount; j++) {
									if (!emp($('#txtProductno1_'+j).val())){
										var t_where =" tggno='"+$('#txtTggno').val()+"' and productno='" + $('#txtProductno1_'+j).val() + "'";
										q_gt('ucctgg', "where=^^ "+t_where+" ^^", 0, 0, 0, "ordesucctgg_"+j);
									}
								}
							}
							
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				if(s2[0]!=undefined){
					if(s2[0]=='ucc' && q_getPara('sys.project').toUpperCase()=='RB'){
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							for (var j = 0; j < q_bbsCount; j++) {
								if(!emp($('#txtProductno1_'+j).val()))
									$('#txtProductno_'+j).val($('#txtProductno1_'+j).val());
							}
							if (b_ret.length>0)
								b_ret.splice(0, 1);
							if (b_ret.length>0)
								ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProductno1,txtProduct,txtSpec,txtUnit,txtStdmount', b_ret.length, b_ret, 'noa,noa,product,spec,unit,stdmount', 'txtProductno,txtProductno1,txtProduct,txtSpec');
						}
					}
				}
				b_pop = '';
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				if(q_getPara('sys.project').toUpperCase()=='XY')
					q_box('ordb_s.aspx', q_name + '_s', "490px", "480px", q_getMsg("popSeek"));
				else
					q_box('ordb_s.aspx', q_name + '_s', "490px", "420px", q_getMsg("popSeek"));
			}

			function btnIns() {
				//106/12/26 重新抓取
				var t_db=q_db.toLocaleUpperCase();
				q_gt('acomp', "where=^^(dbname='"+t_db+"' or not exists (select * from acomp where dbname='"+t_db+"')) ^^ stop=1", 0, 0, 0, "cno_acomp",r_accy,1);
				var as = _q_appendData("acomp", "", true);
				if (as[0] != undefined) {
					z_cno = as[0].noa;
					z_acomp = as[0].acomp;
					z_nick = as[0].nick;
				}
				_btnIns();
				$('#chkIsproj').attr('checked', true);
				$('#txtNoa').val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtOdate').focus();
				$('#txtDatea').val(q_cdn(q_date(),10));
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				product_change();
				if (abbm[q_recno] != undefined)
					loadCustAddr(abbm[q_recno].tggno);
					
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('#txtSalesno').val(r_userno);
					$('#txtSales').val(r_name);
					//1050223 預設送貨地址
					$('#txtPost').val('333');
					$('#txtAddr').val('桃園市龜山區綠野街88號 廖秀雲小姐');
				}
				
				if (q_getPara('sys.project').toUpperCase()=='XY' || q_getPara('sys.project').toUpperCase()=='RB'){
					$('#cmbKind').val('1');
				}
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				/*var c1CheckStr = '';
				for(var k=0;k<q_bbsCount;k++){
					var s_c1 = dec($('#txtC1_'+k).val());
					if(s_c1 > 0){
						c1CheckStr = '表身第 ' + (k+1) + ' 筆 已採購\n';
					}
				}
				if($.trim(c1CheckStr).length > 0){
					alert(c1CheckStr + '禁止修改!!');
					return;
				}*/
				var t_where = "where=^^ordbno='"+$('#txtNoa').val()+"' and isnull(mount,0)>0 ^^";
				q_gt('view_ordcs', t_where, 0, 0, 0, "",r_accy,1);
				var as = _q_appendData("view_ordcs", "", true);
				if (as[0] != undefined) {
					alert('【'+$('#txtNoa').val() + '】請購單已採購，禁止修改!!');
					return;
				}
				
				_btnModi();
				$('#txtOdate').focus();
				product_change();
				if (abbm[q_recno] != undefined)
					loadCustAddr(abbm[q_recno].tggno);
				sum();
			}

			function btnPrint() {
				q_box("z_ordbp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'z_ordbp', "95%", "95%", q_getMsg('popPrint'));
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}
			
			//103/08/29根據ordb.accu判斷預估作業
			var chack_accu=false;
			function btnOk() {
				
				if ($('#txtOdate').val().length == 0 || !q_cd($('#txtOdate').val())) {
					alert(q_getMsg('lblOdate') + '錯誤。');
					return;
				}
				
				if(q_getPara('ordb.accu')=='1' && !chack_accu &&q_getPara('sys.project').toUpperCase()=='RB'){
					var t_year = $.trim($('#txtOdate').val()).substr(0,r_len);
					var t_where='',t_where1='';
					t_where="where=^^left(a.datea,"+r_len+")='"+t_year+"' and isnull(a.cancel,0)=0 and isnull(b.cancel,0)=0 and a.noa!='"+$('#txtNoa').val()+"'^^"
					t_where1="where[1]=^^left(c.mon,"+r_len+")='"+t_year+"' ^^"
					q_gt('accu_ordb', t_where+t_where1, 0, 0, 0, "check_accu",r_accy);
					return;
				}
				
				//105/04/20
				if(q_cur==2){
					var t_where = "where=^^ordbno='"+$('#txtNoa').val()+"' and isnull(mount,0)>0 ^^";
					q_gt('view_ordcs', t_where, 0, 0, 0, "",r_accy,1);
					var as = _q_appendData("view_ordcs", "", true);
					if (as[0] != undefined) {
						alert('【'+$('#txtNoa').val() + '】請購單已採購，禁止修改!!');
						return;
					}
				}
				
				Lock(1, {
					opacity : 0
				});

				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}

				//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
						if($('#chkCancel').prop('checked'))
							$('#chkCancel_'+j).prop('checked','true')
					}
				}

				for (var i = 0; i < q_bbsCount; i++) {
					if (q_cur == 1 || (q_cur != 1 && q_float('txtOmount_' + i) == 0))
						$('#txtOmount_' + i).val($('#txtMount_' + i).val());
				}
				
				sum();
				
				if ($('#cmbKind').val() == '1') {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtProductno_' + j).val($('#txtProductno1_' + j).val());
					}
				} else if ($('#cmbKind').val() == '2') {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtProductno_' + j).val($('#txtProductno2_' + j).val());
					}
				} else {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtProductno_' + j).val($('#txtProductno3_' + j).val());
					}
				}
				
				//106/10/25 品號有KEY數量!=0
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_' + i).val()) && dec($('#txtMount_'+i).val())==0){
						alert($('#txtProduct_' + i).val()+' '+q_getMsg('lblMount_st') + '不可為零。');
						Unlock(1);
						return;
					}
				}
				
				if (q_cur == 1) {
					$('#txtWorker').val(r_name);
				} else if (q_cur == 2) {
					$('#txtWorker2').val(r_name);
				} else {
					alert("error: btnok!");
				}
							
				//清除是否判斷預估
				chack_accu=false;
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtOdate').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr').val($('#combAddr').find("option:selected").text());
					$('#txtPost').val($('#combAddr').find("option:selected").val());
				}
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtOdate').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function bbsSave(as) {
				if (!as['productno1'] && !as['productno2'] && !as['productno3'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				as['odate'] = abbm2['odate'];
				as['noa'] = abbm2['noa'];
				as['apv'] = abbm2['apv'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				product_change();
				HiddenTreat();
			}

			function loadCustAddr(t_tggno) {
				$('#combAddr').children().remove();
				if ((q_cur == 1 || q_cur == 2)) {
					if (t_tggno.length > 0) {
						q_gt('custaddr', "where=^^ noa='" + t_tggno + "' ^^ stop=100", 0, 0, 0, "combAddr");
					}
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
					$('#tmp').find("input[type='text']").attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
					$('#tmp').find("input[type='text']").removeAttr('disabled');
				}
				if (q_getPara('sys.project').toUpperCase()=='XY' || q_getPara('sys.project').toUpperCase()=='RB'){
					$('#cmbKind').attr('disabled', 'disabled');
				}
				
				HiddenTreat();
			}
			
			function HiddenTreat() {
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
				if (q_getPara('sys.project').toUpperCase()!='XY'){
					$('.isCust').hide();
				}else{
					$('.bbsorde').show();
					$('.dbbs').css('width','1850px');
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnProduct1_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_getPara('sys.project').toUpperCase()=='XY'){
								q_box("ucaucc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex('-',noa)=0;" + r_accy, 'ucaucc_b_xy', "95%", "95%", '');
							}
						});
						
						$('#txtProductno1_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtProductno1_'+b_seq).val())){
								var t_where =" noa='"+$('#txtProductno1_'+b_seq).val()+"' ";
								q_gt('ucc_xy', "where=^^ "+t_where+" ^^", 0, 0, 0, "getuccspec",r_accy,1);
								var as = _q_appendData("ucc", "", true, true);
								if (as[0] != undefined) {
									$('#txtUnit_'+b_seq).val(as[0].unit);
									$('#txtSpec_'+b_seq).val(as[0].style+' '+as[0].spec+' '+as[0].engpro);
								}
							}
						});
						$('#txtMount_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtProductno1_'+b_seq).val()) &&!emp($('#txtTggno').val())){
								var t_where =" tggno='"+$('#txtTggno').val()+"' and productno='" + $('#txtProductno1_'+b_seq).val() + "'";
								q_gt('ucctgg', "where=^^ "+t_where+" ^^", 0, 0, 0, "ucctgg");
							}
							sum();
							if(q_getPara('sys.project').toUpperCase()=='XY'){
								var t_max_unit='';
								var t_max_inmout=0;
								var t_unit=$('#txtUnit_'+b_seq).val();
								var t_inmount=0;
								var t_mount=dec($('#txtMount_'+b_seq).val());
	                            var t_where = "where=^^noa='"+$('#txtProductno1_'+b_seq).val()+"'^^";
								q_gt('pack2s', t_where, 0, 0, 0, "getpack2s", r_accy, 1);
								var as = _q_appendData("pack2s", "", true);
	                            for(var i=0 ; i<as.length;i++){
									if(t_max_inmout<dec(as[i].inmount)){
										t_max_unit=as[i].pack;
										t_max_inmout=dec(as[i].inmount);
									}
									if(t_unit==as[i].pack){
										t_inmount=dec(as[i].inmount);
									}
								}
								if(t_max_inmout==0){
									t_max_inmout=1;
									t_max_unit=t_unit;
								}
								
								if(t_max_unit!=t_unit && Math.floor(t_mount/t_max_inmout)>0){
									var t_m1=Math.floor(q_div(t_mount,t_max_inmout));
									var t_m2=q_sub(t_mount,(q_mul(Math.floor(q_div(t_mount,t_max_inmout)),t_max_inmout)));
									$('#txtMemo_'+b_seq).val(t_m1+t_max_unit+(t_m2>0?('+'+t_m2+t_unit):''));
								}else{
									$('#txtMemo_'+b_seq).val('');
								}
							}
						});
						$('#txtPrice_' + j).change(function() {
							sum();
						});
						$('#btnRc2record_' + j).click(function() {
							var n = replaceAll($(this).attr('id'), 'btnRc2record_', '');
							q_box("z_rc2record.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";ordbno=" + $('#txtNoa').val() + "&no3=" + $('#txtNo3_' + n).val() + ";" + r_accy, 'z_rc2record', "95%", "95%", q_getMsg('popPrint'));
						});
						$('#btnOrdc_' + j).click(function(e) {
							var n = replaceAll($(this).attr('id'), 'btnOrdc_', '');
							t_where = "productno='" + $('#txtProductno_' + n).val() + "'";
							if ($('#txtProductno_' + n).val().length > 0)
								q_box("ucctgg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucctgg', "95%", "95%", '採購建議量');
						});
						$('#btnOrdc2_' + j).click(function(e) {
							var n = replaceAll($(this).attr('id'), 'btnOrdc2_', '');
							t_where = "productno='" + $('#txtProductno_' + n).val() + "' and product='" + $('#txtProduct_' + n).val() + "'";
							if ($('#txtProductno_' + n).val().length > 0)
								q_box("z_ordbordc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordbordc', "95%", "95%", '採購統計');
						});
						$('#btnRecord_' + j).click(function(e) {
							var n = replaceAll($(this).attr('id'), 'btnRecord_', '');
							t_where = "b.noa is not null" + " and c.noa is not null" + " and isnull(a.rprice,0)!=0" + " and c.productno='" + $('#txtProductno_' + n).val() + "'";
							if ($('#txtProductno_' + n).val().length > 0)
								q_box("ordbt_view_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordbt_view', "95%", "95%", '歷史詢價記錄');
						});
						$('#btnTmprecord_' + j).click(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var t_pno = $.trim($('#txtProductno_'+n).val());
							var t_no3 = $.trim($('#txtNo3_'+n).val());
							var t_noa = $.trim($('#txtNoa').val());
							if((t_pno.length>0) && (t_no3.length>0) && (t_noa.length>0) && (t_noa != 'AUTO')){
								var t_where = "noa='" + t_noa + "' and no3='" + t_no3 + "' ";
								q_box("ordbt_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordbt', "95%", "95%", '詢價紀錄');
							}
						});
						
						$('#txtOrdeno_'+j).bind('contextmenu',function(e) {
	                    	/*滑鼠右鍵*/
	                    	e.preventDefault();
	                    	t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (q_getPara('sys.project').toUpperCase()=='XY'){
	                    		q_box("orde_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + r_accy, 'orde', "95%", "95%", '訂單作業');
	                    	}else{
	                    		q_box("orde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + r_accy, 'orde', "95%", "95%", '訂單作業');
	                    	}
	                   });
	                   
						$('#txtProductno2_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#txtProductno3_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
					}
				}
				_bbsAssign();
				product_change();
				HiddenTreat();
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('#tdpno').css('width','130px');
					$('#tdspec').css('width','270px');
				}
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
					}
				}
				_bbtAssign();
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
				var t_where = "where=^^ordbno='"+$('#txtNoa').val()+"' ^^";
				q_gt('view_ordcs', t_where, 0, 0, 0, "",r_accy,1);
				var as = _q_appendData("view_ordcs", "", true);
				if (as[0] != undefined) {
					alert('【'+$('#txtNoa').val() + '】請購單已採購，禁止修改!!');
					return;
				}
				
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
					case 'txtProductno1_':
						$('#txtProductno_'+b_seq).val($('#txtProductno1_'+b_seq).val());
						
						if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtProductno1_'+b_seq).val()) &&!emp($('#txtTggno').val())){
							var t_where =" tggno='"+$('#txtTggno').val()+"' and productno='" + $('#txtProductno1_'+b_seq).val() + "'";
							q_gt('ucctgg', "where=^^ "+t_where+" ^^", 0, 0, 0, "ucctgg");
						}
						if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtProductno1_'+b_seq).val()) && $('#txtProductno1_'+b_seq).val().indexOf('-') > -1 ){
							var t_where =" noa='"+$('#txtProductno1_'+b_seq).val().substr(0,5)+"' ";
							q_gt('cust', "where=^^ "+t_where+" ^^", 0, 0, 0, "getcust",r_accy,1);
							var as = _q_appendData("cust", "", true, true);
							if (as[0] != undefined) {
								$('#txtCustno_'+b_seq).val(as[0].noa);
								$('#txtComp_'+b_seq).val(as[0].nick.length!=0?as[0].nick:as[0].comp);
							}
						}
						if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtProductno1_'+b_seq).val())){
							var t_where =" noa='"+$('#txtProductno1_'+b_seq).val()+"' ";
							q_gt('ucc_xy', "where=^^ "+t_where+" ^^", 0, 0, 0, "getuccspec",r_accy,1);
							var as = _q_appendData("ucc", "", true, true);
							if (as[0] != undefined) {
								$('#txtUnit_'+b_seq).val(as[0].unit);
								$('#txtSpec_'+b_seq).val(as[0].style+' '+as[0].spec+' '+as[0].engpro);
							}
						}
						break;
					case 'txtProductno2_':
						$('#txtProductno_'+b_seq).val($('#txtProductno2_'+b_seq).val());
						break;
					case 'txtProductno3_':
						$('#txtProductno_'+b_seq).val($('#txtProductno3_'+b_seq).val());
						break;
					case 'txtTggno':
						loadCustAddr($.trim($('#txtTggno').val()));
						if(q_getPara('sys.project').toUpperCase()=='XY'){
							var t_where =" noa='"+$('#txtTggno').val()+"'";
							q_gt('tgg', "where=^^ "+t_where+" ^^", 0, 0, 0, "xytggdata");
						}
						break;
					default:
						break;
				}
				id='';
			}

			function product_change() {
				if ($('#cmbKind').val() == '1') {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#btnProduct1_' + j).show();
						$('#btnProduct2_' + j).hide();
						$('#btnProduct3_' + j).hide();
						$('#txtProductno1_' + j).show();
						$('#txtProductno2_' + j).hide();
						$('#txtProductno3_' + j).hide();
						$('#txtProductno1_' + j).val($('#txtProductno_' + j).val());
					}
				} else if ($('#cmbKind').val() == '2') {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#btnProduct1_' + j).hide();
						$('#btnProduct2_' + j).show();
						$('#btnProduct3_' + j).hide();
						$('#txtProductno1_' + j).hide();
						$('#txtProductno2_' + j).show();
						$('#txtProductno3_' + j).hide();
						$('#txtProductno2_' + j).val($('#txtProductno_' + j).val());
					}
				} else {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#btnProduct1_' + j).hide();
						$('#btnProduct2_' + j).hide();
						$('#btnProduct3_' + j).show();
						$('#txtProductno1_' + j).hide();
						$('#txtProductno2_' + j).hide();
						$('#txtProductno3_' + j).show();
						$('#txtProductno3_' + j).val($('#txtProductno_' + j).val());
					}
				}
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
				width: 850px;
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
			.c1 {
				width: 100%;
				float: left;
			}
			.c2 {
				width: 95%;
				float: left;
			}
			.num {
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
			input[type="text"], input[type="button"],select {
				font-size: medium;
			}
			.dbbs {
				width: 2000px;
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
				width: 800px;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="exportordc" style="background:pink;display:none; position: absolute;top:200px;left:400px;width:600px;height:400px;">
			<table style="width:100%;height:100%;border: 2px white double;">
				<tr style="height:1px;">
					<td style="width:40%;"> </td>
					<td style="width:60%;"> </td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center; color:darkblue;"><a>已匯出至採購單的,須先刪除採購單才可重新匯出</a></td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>採購日期</a></td>
					<td><input id="textDatea_a" type="text" style="width:40%;"/></td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>廠商</a></td>
					<td>
						<input id="textTggno_a" type="text" style="width:45%;float:left;"/>
						<input id="textTgg_a" type="text" style="width:45%;float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>請購單號</a></td>
					<td>
						<input id="textBno_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEno_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
                    <td style="text-align: center;"><a>請購日期</a></td>
                    <td>
                        <input id="textBodate_a" type="text" style="width:40%; float:left;"/>
                        <a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
                        <input id="textEodate_a" type="text" style="width:40%; float:left;"/>
                    </td>
                </tr>
				<tr>
                    <td style="text-align: center;"><a>最慢需求日</a></td>
                    <td>
                        <input id="textBldate_a" type="text" style="width:40%; float:left;"/>
                        <a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
                        <input id="textEldate_a" type="text" style="width:40%; float:left;"/>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;"><a>物品編號</a></td>
                    <td>
                        <input id="textBproductno_a" type="text" style="width:40%; float:left;"/>
                        <a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
                        <input id="textEproductno_a" type="text" style="width:40%; float:left;"/>
                    </td>
                </tr>
				<tr>
					<td style="text-align: center;"><a>合約有效日期</a></td>
					<td>
						<input id="textBedate_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEedate_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>成交日期</a></td>
					<td>
						<input id="textBfdate_a" type="text" style="width:40%; float:left;"/>
						<a style="float:left;">&nbsp;&nbsp;~&nbsp;&nbsp;</a>
						<input id="textEfdate_a" type="text" style="width:40%; float:left;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><a>轉來</a></td>
					<td><input id="textWorkgno_a" type="text" style="width:80%;"/></td>
				</tr>
				<tr>
					<td align="center">
						<input id="btnExport_a" type="button" style="width:100px;" value="匯出採購"/>
					</td>
					<td align="center">
						<input id="btnClose_a" type="button" style="width:100px;" value="關閉"/>
					</td>
				</tr>
			</table>
		</div>

		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:25px"><a id='vewChk'> </a></td>
						<td align="center" style="width:70px"><a id='vewOdate'> </a></td>
						<td align="center" style="width:150px"><a id='vewTgg'> </a></td>
						<td align="center" style="width:150px"><a id='vewTggt'> </a></td>
						<td align="center" style="width:100px"><a id='vewFinish'>成交日期</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='nick'>~nick</td>
						<td align="center" id='tggt,2'>~tggt,2</td>
						<td align="center" id='finish'>~finish</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td><input type="text" style="display:none;" id="txtFinish"></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td class="td2"><select id="cmbKind" class="txt c1"> </select></td>
						<td class="td3"><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td class="td4"><input id="txtOdate" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td8" align="right">
							<input id="chkIsproj" type="checkbox"/>
							<a id='lblIsproj' style="width: 50%;"> </a><span> </span>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtCno" type="text" style="float:left;width:30%;"/>
							<input id="txtAcomp" type="text" style="float:left;width:70%;"/>
						</td>
						<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td8" align="right">
							<input id="chkEnda" type="checkbox"/>
							<a id='lblEnd' style="width: 50%;"> </a><span> </span>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtTggno" type="text" style="float:left;width:30%;"/>
							<input id="txtTgg" type="text" style="float:left;width:70%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
							<input id="txtTggtno" type="text" style="display:none;"/>
							<input id="txtTggt" type="text" style="display:none;"/>
						</td>
						<td class="td5"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td class="td6" colspan="2">
							<input id="txtPaytype" type="text" style="float:left; width:90%;"/>
							<select id="combPaytype" style="float:left; width:10%;"> </select>
						</td>
						<td class="td8" align="right">
                            <input id="chkCancel" type="checkbox"/>
                            <a id='lblCancel' style="width: 50%;"> </a><span> </span>
                        </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtTel" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtFax" type="text" class="txt c1"/></td>
						<td class="td8" align="center"><input id="btnOrde" type="button" style="text-align: center;"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td class="td2" colspan="7">
						<input id="txtPost" type="text" style="float:left; width:95px;"/>
						<input id="txtAddr" type="text" style="float:left; width:520px;"/>
						<select id="combAddr" style="float:left;width: 20px;"> </select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td class="td2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
						<td class="td3"><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td class="td4" colspan="2">
							<input id="txtContract" type="text" class="txt c1"/>
						</td>
						<td class="td6"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td class="td7" colspan="2">
							<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
							<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1" /></td>
						<td><select id="cmbTaxtype" class="txt c1" style="float:left;" > </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTotal" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblOrde" class="lbl"> </a></td>
						<td class="td2"><input id="txtOrdeno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTotalus" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblOrdcno" class="lbl btn"> </a></td>
						<td class="td2" colspan="4"><input id="txtOrdcno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblApv' class="lbl apv"> </a></td>
						<td><input id="txtApv" type="text" class="txt c1 apv" /></td>
						<td><input id="btnOrdc" type="button" value="批次轉採購單" style="display:none;" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>

						<td><span> </span><a id='lblWorkgno' class="lbl"> </a></td>
                        <td colspan="3"><input id="txtWorkgno" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width:1770px">
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
                        <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"> </td>
					<td id="tdpno" align="center" style="width:200px;"><a id='lblProductno'> </a></td>
					<td id="tdspec" align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:95px;" class="isStyle"><a id='lblStyles'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:110px;"><a id='lblOmount_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotals'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:120px;" class="isCust"><a id='lblCustnos'> </a></td>
					<td align="center" style="width:100px;"><a id='lblLdates'> </a></td>
					<td align="center" style="width:50px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblPrice_st'> </a></td>
					<td align="center" style="width:50px;"><a id='lblPrice_ot'> </a></td>
					<td align="center" style="width:50px;"><a id='lblReport'> </a></td>
					<td align="center" style="width:50px;"><a id='lblReport2'> </a></td>
					<!--<td align="center" style="width:50px;">未成交</td>-->
					<td align="center" style="width:50px;"><a id='lblCancel_s'> </a</td>
					<td align="center" style="width:50px;"><a id='lblEnda'> </a</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td align="center">
						<input id="txtProductno1.*" type="text" class="txt c1" style="width:97%;float:left;"/>
						<input id="txtProductno2.*" type="text" class="txt c1" style="width:97%;float:left;"/>
						<input id="txtProductno3.*" type="text" class="txt c1" style="width:97%;float:left;"/>
						<input id="txtProductno.*" style="display:none;" />
						<input id="txtNo3.*" type="text" style="width:80px;float:left;"/>
						<input id="btnProduct1.*" type="button" value='.' style="font-weight: bold;float:left;" />
						<input id="btnProduct2.*" type="button" value='.' style="font-weight: bold;float:left;" />
						<input id="btnProduct3.*" type="button" value='.' style="font-weight: bold;float:left;" />
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c2"/>
						<input id="txtSpec.*" type="text" class="txt c2 isSpec"/>
					</td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c2"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c2"/></td>
					<td><input id="txtMount.*" type="text" class="txt c2 num"/></td>
					<td>
						<input id="txtOmount.*" type="text" class="txt c2 num"/>
						<input id="txtStdmount.*" type="text" class="txt c2 num"/>
					</td>
					<td><input id="txtPrice.*" type="text" class="txt c2 num"/></td>
					<td><input id="txtTotal.*" type="text" class="txt c2 num"/></td>
					<td>
						<input id="txtC1.*" type="text" class="txt c2 num"/>
						<input id="txtNotv.*" type="text" class="txt c2 num"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c2" style="float:left;"/>
						<input id="txtOrdeno.*" type="text" class="bbsorde" style="float:left;width:145px;display: none;" />
						<input id="txtNo2.*" type="text" class="bbsorde" style="float:left;width:40px;display: none;" />
					</td>
					<td class="isCust">
						<input id="txtCustno.*" type="text" class="txt c1" style="width:70%;"/>
						<input id="btnCustno.*" type="button" value="." style=" font-weight: bold" />
						<input id="txtComp.*"type="text" class="txt c1" />
					</td>
					<td><input id="txtLdate.*" type="text" class="txt c2"/></td>
					<td align="center"><input class="btn" id="btnTmprecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnRecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnOrdc.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnOrdc2.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnRc2record.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<!--<td align="center"><input id="chkIsnotdeal.*" type="checkbox"/></td>-->
                    <td align="center"><input id="chkCancel.*" type="checkbox"/></td>
                    <td align="center"><input id="chkEnda.*" type="checkbox"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>