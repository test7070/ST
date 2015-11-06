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
			
			q_bbsLen=20;
            q_tables = 's';
            var q_name = "deli";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtCoinretiremoney','txtCointotal','txtCointariff','txtRetiremoney'
            							,'txtTotal','txtTariff','txtTrade','txtCommoditytax','txtVatbase','txtVat','txtRc2no','txtPaybno','txtLctotal'];
            var q_readonlys = ['txtOrdcno','txtNo2','txtLcmoney','txtCost'];
            var bbmNum = [['txtFloata', 15, 3, 1],['txtVatrate', 15, 2, 1],['txtVatbase', 15, 0, 1],['txtVat', 15, 0, 1],['txtTranmoney', 15, 0, 1]
            						,['txtInsurance', 15, 0, 1],['txtModification', 15, 0, 1],['txtCoinretiremoney', 15, 2, 1],['txtCointotal', 15, 2, 1]
            						,['txtCointariff', 15, 2, 1],['txtRetiremoney', 15, 0, 1],['txtTotal', 15, 0, 1],['txtTariff', 15, 0, 1]
            						,['txtTrade', 15, 0, 1],['txtCommoditytax', 15, 0, 1],['txtLctotal', 15, 0, 1]
            						];
            var bbsNum = [['txtMount', 15, 0, 1],['txtInmount', 15, 0, 1],['txtPrice', 10, 2, 1],['txtPrice2', 10, 2, 1],['txtMoney', 15, 2, 1],['txtCointotal', 15, 2, 1],['txtTotal', 15, 0, 1]
									,['txtTariffrate', 5, 4, 1],['txtCointariff', 15, 2, 1],['txtTariff', 15, 0, 1],['txtTraderate', 10, 4, 1],['txtTrade', 15, 0, 1]
									,['txtCommodityrate', 5, 4, 1],['txtCommoditytax', 15, 0, 1],['txtVatbase', 15, 0, 1],['txtVat', 15, 0, 1],['txtCasemount', 15, 0, 1]
									,['txtMweight', 15, 2, 1],['txtCuft', 15, 2, 1],['txtWeight', 15, 2, 1],['txtInweight', 15, 2, 1]
									,['txtDime', 15, 3, 1],['txtWidth', 15, 2, 1],['txtLengthb', 15, 2, 1],['txtDime2', 15, 3, 1],['txtLengthc', 15, 2, 1],['txtLengthd', 15, 2, 1]
									,['txtLcmoney', 15, 0, 1],['txtCost', 15, 0, 1]];
            
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array( ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx']
            ,['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            ,['txtTranno', 'lblTranno', 'tgg', 'noa,comp', 'txtTranno,txtTrancomp', 'tgg_b.aspx']
            ,['txtBcompno', 'lblBcomp', 'tgg', 'noa,comp', 'txtBcompno,txtBcomp', 'tgg_b.aspx']
            //,['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_,txtClass_', 'ucaucc_b.aspx']
            ,['txtStoreno_', 'btnProductno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
            ,['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_', 'ucc_b.aspx']
            ,['txtStyle_', 'btnStyle_', 'style', 'noa,product', 'txtStyle_', 'style_b.aspx']
	        ,['txtSpec_', '', 'spec', 'noa,product', '0txtSpec_,txtSpec_', 'spec_b.aspx', '95%', '95%']
            );
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
                q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
            });

            var abbsModi = [];

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
            
            function sum() {
                var t_coinretiremoney=0,t_cointotal=0,t_total=0,t_cointariff=0,t_tariff=0,t_trade=0,t_commoditytax=0,t_lctotal=0,t_vatbase=0,t_vat=0;
                for (var j = 0; j < q_bbsCount; j++) {
                	t_coinretiremoney=q_add(t_coinretiremoney,q_float('txtMoney_'+j));
                	t_cointotal=q_add(t_cointotal,q_float('txtCointotal_'+j));
                	t_total=q_add(t_total,q_float('txtTotal_'+j));
                	t_cointariff=q_add(t_cointariff,q_float('txtCointariff_'+j));
                	t_tariff=q_add(t_tariff,q_float('txtTariff_'+j));
                	t_trade=q_add(t_trade,q_float('txtTrade_'+j));
                	t_commoditytax=q_add(t_commoditytax,q_float('txtCommoditytax_'+j));
                	t_lctotal=q_add(t_lctotal,q_float('txtLcmoney_'+j));
                	t_vatbase=q_add(t_vatbase,q_float('txtVatbase_'+j));
                	t_vat=q_add(t_vat,q_float('txtVat_'+j));
                } // j
                
                q_tr('txtCoinretiremoney',t_coinretiremoney);
                q_tr('txtRetiremoney',round(q_mul(t_coinretiremoney,q_float('txtFloata')),0));
                q_tr('txtCointotal',t_coinretiremoney);
                q_tr('txtTotal',t_total);
                q_tr('txtCointariff',t_cointariff);
                q_tr('txtTariff',t_tariff);
                q_tr('txtTrade',t_trade);
                q_tr('txtCommoditytax',t_commoditytax);
                q_tr('txtLctotal',t_lctotal);
                q_tr('txtVatbase',t_vatbase);
                q_tr('txtVat',t_vat);
            }
            
            function bbs_sum() {
            	for (var j = 0; j < q_bbsCount; j++) {
            			var t_cointotaldiv=0,t_mount=0;
            			t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
            			if($('#cmbFeetype').val()=='2'){
            				for (var k = 0; k < q_bbsCount; k++) {
            					t_mount=q_add(t_mount,q_float('txtInmount_'+k));
            				}
            				t_cointotaldiv=(t_mount==0?0:q_div(q_float('txtInmount_'+j),t_mount));
            			}else if($('#cmbFeetype').val()=='5'){
            				for (var k = 0; k < q_bbsCount; k++) {
            					t_mount=q_add(t_mount,q_float('txtInweight_'+k));
            				}
            				t_cointotaldiv=(t_mount==0?0:q_div(q_float('txtInweight_'+j),t_mount));
            			}else if($('#cmbFeetype').val()=='3'){
            				for (var k = 0; k < q_bbsCount; k++) {
            					t_mount=q_add(t_mount,q_float('txtMweight_'+k));
            				}
            				t_cointotaldiv=(t_mount==0?0:q_div(q_float('txtMweight_'+j),t_mount));
            			}else if($('#cmbFeetype').val()=='4'){
            				for (var k = 0; k < q_bbsCount; k++) {
            					t_mount=q_add(t_mount,q_float('txtCuft_'+k));
            				}
            				t_cointotaldiv=(t_mount==0?0:q_div(q_float('txtCuft_'+j),t_mount));
            			}else{
            				for (var k = 0; k < q_bbsCount; k++) {
            					t_mount=q_add(t_mount,q_float('txtMoney_'+k));
            				}
            				t_cointotaldiv=(t_mount==0?0:q_div(q_float('txtMoney_'+j),t_mount));
            			}
            			
						//原幣完稅價格(原幣進貨額 + ( (原幣運費+原幣保險費+原幣加減費用) * (該筆原幣進貨額/原幣進貨額合計) ))
                		q_tr('txtCointotal_'+j,q_add(q_float('txtMoney_'+j),round(q_mul(q_add(q_add(q_float('txtTranmoney'),q_float('txtInsurance')),q_float('txtModification'))
                		,t_cointotaldiv),2)));
                		//本幣完稅價格(原幣完稅價格*匯率)
                		q_tr('txtTotal_'+j,round(q_mul(q_float('txtCointotal_'+j),q_float('txtFloata')),0));
                		//本幣單價
						var t_unit = $.trim($('#txtUnit_' + b_seq).val()).toUpperCase();
						if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'MT' ||  t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
							q_tr('txtPrice2_'+j,round(q_div(q_float('txtTotal_'+j),q_float('txtInweight_'+j)),3));
                        }else{
                        	q_tr('txtPrice2_'+j,round(q_div(q_float('txtTotal_'+j),q_float('txtInmount_'+j)),3));
                        }
                		//原幣關稅(原幣完稅價格*關稅率)
                		q_tr('txtCointariff_'+j,round(q_mul(q_float('txtCointotal_'+j),q_div(q_float('txtTariffrate_'+j),100)),2));
                		//本幣關稅(本幣完稅價格*關稅率)
                		q_tr('txtTariff_'+j,round(q_mul(q_float('txtTotal_'+j),q_div(q_float('txtTariffrate_'+j),100)),0));
                		//推廣貿易費(本幣完稅價格*推廣貿易費率)
                		q_tr('txtTrade_'+j,round(q_mul(q_float('txtTotal_'+j),q_div(q_float('txtTraderate_'+j),100)),0));
                		//貨物稅額((本幣完稅價格+本幣關稅) * 貨物稅率)
                		q_tr('txtCommoditytax_'+j,round(q_mul(q_add(q_float('txtTotal_'+j),q_float('txtTariff_'+j)),q_div(q_float('txtCommodityrate_'+j),100)),0));
                		//本幣營業稅基(本幣完稅價格+本幣關稅+貨物稅)
                		q_tr('txtVatbase_'+j,q_add(q_add(q_float('txtTotal_'+j),q_float('txtTariff_'+j)),q_float('txtCommoditytax_'+j)));
                		//本幣營業稅額(本幣營業稅基 * 營業稅率)
                		q_tr('txtVat_'+j,q_mul(q_float('txtVatbase_'+j),q_div(q_float('txtVatrate'),100)));
                		//進貨總成本
                		q_tr('txtCost_'+j,q_add(q_add(q_add(q_float('txtTotal_'+j),q_float('txtTariff_'+j)),q_float('txtTrade_'+j)),q_float('txtCommoditytax_'+j)));
                	} // j
                	sum();
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtDeliverydate', r_picd],['txtArrivedate', r_picd],['txtEtd', r_picd],['txtEta', r_picd]
                					,['txtWarehousedate', r_picd],['txtNegotiatingdate', r_picd],['txtPaydate', r_picd],['txtDeclaredate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbCredittype", ",1@可扣抵進貨及費用,2@可扣抵固定資產,3@不可扣抵進貨及費用,4@不可扣抵固定資產");
                q_cmbParse("cmbFeetype", ",1@依進貨金額,2@依進貨數量,5@依進貨重量,3@依毛重,4@依材積");
                
                if(q_getPara('sys.project').toUpperCase()=='PK'){
                	bbsNum=[];
                }
                
                if(q_getPara('sys.project').toUpperCase()=='RK'){
                	$('#btnRc2').hide();
                }
                
                $('#btnOrdc').click(function() {
                	if(q_cur==1||q_cur==2){
	                	var t_tggno = trim($('#txtTggno').val());
	                	var t_where='';
	                	if (t_tggno.length > 0) {
							//t_where = " isnull(view_ordcs.enda,0)=0 && isnull(view_ordcs.cancel,0)=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "");  ////  sql AND 語法，請用 &&
							//t_where = t_where;
							//q_box("ordcs_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+r_accy, 'ordcs', "95%", "95%", q_getMsg('popOrdcs'));
							t_where = " view_ordcs.enda='0'  and b.enda='0' " + (t_tggno.length > 0 ? q_sqlPara2("tggno", t_tggno) : "");
							q_box("ordcsst_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'ordcs', "95%", "95%", q_getMsg('popOrdcs'));
						}else {
							alert('請填入【'+q_getMsg('lblTgg')+'】!!!');
							return;
						}
					}
				});
				 $('#lblSino').click(function() {
				 	var t_sino = trim($('#txtSino').val());
                	if(t_sino.length>0){
	                	var t_where="noa='"+t_sino+"'";
						q_box("shipinstruct.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+r_accy, 'shipinstruct', "95%", "95%", q_getMsg('popShipinstruct'));
					}
				});
				$('#cmbFeetype').change(function() {bbs_sum();});
				$('#txtTranmoney').change(function() {bbs_sum();});
				$('#txtInsurance').change(function() {bbs_sum();});
				$('#txtModification').change(function() {bbs_sum();});
				$('#txtFloata').change(function() {bbs_sum();});
				$('#txtVatrate').change(function() {bbs_sum();});
				
				$('#btnHelp').click(function() {
					$('#div_help').show();
				});
				$('#btnHelpClose').click(function() {
					$('#div_help').hide();
				});
				
				$('#btnRc2').click(function() {
					if(emp($('#txtRc2no').val())){
						q_func('qtxt.query.post1', 'deli.txt,post,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';1;'+r_userno);
					}else{
						q_func('rc2_post.post.a1', r_accy + ',' + $('#txtRc2no').val() + ',0');
					}
				});
            }
			
			var ordcsArray = new Array;
            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                	case 'ordcs':
						if (q_cur > 0 && q_cur < 4) {
							ordcsArray = getb_ret();
							if (ordcsArray && ordcsArray[0] != undefined) {
								var distinctArray = new Array;
								var inStr = '';
								for (var i = 0; i < ordcsArray.length; i++) {
									distinctArray.push(ordcsArray[i].noa);
								}
								distinctArray = distinct(distinctArray);
								for (var i = 0; i < distinctArray.length; i++) {
									inStr += "'" + distinctArray[i] + "',";
								}
								inStr = inStr.substring(0, inStr.length - 1);
								var t_where = "where=^^ ordeno in(" + inStr + ") ^^";
								q_gt('rc2s', t_where, 0, 0, 0, "", r_accy);
							}
						}
						break;
                	/*case 'ordcs':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							for (var i = 0; i < q_bbsCount; i++) {
                                $('#btnMinus_' + i).click();
                            }
                            
                            var t_ordcno='';
                            for (var j=0;j<b_ret.length;j++){
                            	if(t_ordcno.length==0 || t_ordcno.indexOf(b_ret[j].noa)==-1){
                            		t_ordcno=t_ordcno+(t_ordcno.length>0?',':'')+b_ret[j].noa;
                            	}
                            }
                            
							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtInmount,txtOrdcno,txtNo2,txtPrice,txtMoney,txtMemo', b_ret.length, b_ret
															   , 'productno,product,unit,mount,mount,noa,no2,price,total,memo'
															   , 'txtProductno,txtProduct');   /// 最後 aEmpField 不可以有【數字欄位】
							//依據ordc 取得lcs 的開狀費
							q_gt('ordcs_lccost', "where=^^charindex(a.lcno,'"+t_ordcno+"')>0 ^^", 0, 0, 0, "ordcs_lccost");
							
							sum();
							bbs_sum();
							bbsAssign();
						}
						break;*/
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
			
			var z_cno=r_cno,z_acomp=r_comp,z_nick=r_comp.substr(0,2);
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'btnOk_checkuno':
						var as = _q_appendData("view_uccb", "", true);
						if (as[0] != undefined) {
							var msg = '';
							for (var i = 0; i < as.length; i++) {
								if($('#txtRc2no').val()!=as[i].noa)
									msg += (msg.length > 0 ? '\n' : '') + as[i].uno + ' 此批號已存在!!\n【' + as[i].action + '】單號：' + as[i].noa;
							}
							if(msg.length>0){
								alert('ERROR:'+msg);
								Unlock(1);
								return;
							}else{
								getUno(0);
							}
						} else {
							getUno(0);
						}
						break;
                	case 'rc2s':
						var as = _q_appendData("rc2s", "", true);
						for (var i = 0; i < ordcsArray.length; i++) {
							if(q_getPara('sys.project').toUpperCase()=='RK'){
								if ((ordcsArray[i].mount <= 0 && ordcsArray[i].weight <= 0) || ordcsArray[i].noa == '' || dec(ordcsArray[i].cnt) == 0) {
									ordcsArray.splice(i, 1);
									i--;
								}
							}else{
								if (ordcsArray[i].mount <= 0 || ordcsArray[i].weight <= 0 || ordcsArray[i].noa == '' || dec(ordcsArray[i].cnt) == 0) {
									ordcsArray.splice(i, 1);
									i--;
								}
							}
						}
						if (ordcsArray[0] != undefined) {
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_' + i).click();
							}
							var newB_ret = new Array;
							for (var j = 0; j < ordcsArray.length; j++) {
								if (dec(ordcsArray[j].cnt) > 1) {
									var n_mount = round(q_div(dec(ordcsArray[j].mount), dec(ordcsArray[j].cnt)), 0);
									var n_weight = round(q_div(ordcsArray[j].weight, dec(ordcsArray[j].cnt)), 0);
									if ((ordcsArray[j].product).indexOf('捲') == -1) {
										ordcsArray[j].mount = n_mount;
										ordcsArray[j].weight = n_weight;
									} else {
										ordcsArray[j].weight = round(q_div(ordcsArray[j].weight, dec(ordcsArray[j].mount)), 0);
										ordcsArray[j].mount = 1;
									}
									ordcsArray[j].uno = '';
									for (var i = 0; i < dec(ordcsArray[j].cnt); i++) {
										newB_ret.push(ordcsArray[j]);
									}
									ordcsArray.splice(j, 1);
									j--;
								} else {
									newB_ret.push(ordcsArray[j]);
								}
							}
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtOrdcno,txtNo2,txtPrice,txtMount,txtWeight,txtInmount,txtInweight,txtTotal,txtMemo,txtClass,txtStyle,txtUnit', newB_ret.length, newB_ret
							, 'uno,productno,product,spec,size,dime,width,lengthb,noa,no2,price,mount,weight,mount,weight,total,memo,class,style,unit', 'txtProductno,txtProduct,txtSpec');
							/// 最後 aEmpField 不可以有【數字欄位】
							
							//依據ordc 取得lcs 的開狀費
							q_gt('ordcs_lccost', "where=^^a.noa='" + newB_ret[0].noa + "' ^^", 0, 0, 0, "ordcs_lccost");
							
							bbsAssign();
							sum();
						}
						ordcsArray = new Array;
						break;
                	case 'cno_acomp':
                		var as = _q_appendData("acomp", "", true);
                		if (as[0] != undefined) {
	                		z_cno=as[0].noa;
	                		z_acomp=as[0].acomp;
	                		z_nick=as[0].nick;
	                	}
                		break;
                	case 'ordcs_lccost':
                		var as = _q_appendData("view_ordc", "", true);
                		for (var i = 0; i < q_bbsCount; i++) {
                			for (var j=0;j<as.length;j++){
                				if(emp($('#txtOrdcno_'+i).val()))
                					break;
                				if($('#txtOrdcno_'+i).val()==as[j].noa && $('#txtNo2_'+i).val()==as[j].no2){
                					$('#txtLcmoney_'+i).val(as[j].lccost);
                				}
                			}
                		}
                		sum();
						bbs_sum();
                		break;
                    case q_name:
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
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_where = '';
				for (var i = 0; i < q_bbsCount; i++) {
					if ($.trim($('#txtUno_' + i).val()).length > 0)
						t_where += (t_where.length > 0 ? ' or ' : '') + "(uno='" + $.trim($('#txtUno_' + i).val()) + "' and not(accy='" + r_accy + "' and tablea='rc2s' and noa='" + $.trim($('#txtNoa').val()) + "'))";
				}
				if (t_where.length > 0)
					q_gt('view_uccb', "where=^^" + t_where + "^^", 0, 0, 0, 'btnOk_checkuno');
				else
					getUno(0)
            }
            function getUno(n) {
				if(n<q_bbsCount){
					t_buno = ' 　';
					t_datea = $('#txtDatea').val();
					t_style = $('#txtStyle_' + n).val();
					if($('#txtUno_' + n).val().length == 0 && $('#txtProductno_'+n).val().toUpperCase()!='OEM' && $('#txtStyle_' + n).val().toUpperCase()>='A' && $('#txtStyle_' + n).val().toUpperCase()<='M'){
						q_func('qtxt.query.getuno_'+n, 'uno.txt,getuno_bydate,' + t_buno + ';' + t_datea + ';' + t_style + ';');	
					}else{
						getUno(n+1);
					}
				}else{
					if (q_cur == 1)
						$('#txtWorker').val(r_name);
					else
						$('#txtWorker2').val(r_name);
					sum();
					var t_noa = trim($('#txtNoa').val());
					var t_date = trim($('#txtDatea').val());
					if (t_noa.length == 0 || t_noa == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_rc2') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(t_noa);
				}
			}
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'rc2_post.post.a1':
                		q_func('qtxt.query.post0', 'deli.txt,post,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';0;'+r_userno);
                		break;
                	case 'rc2_post.post.a2':
                		q_func('qtxt.query.post2', 'deli.txt,post,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';0;'+r_userno);
                		break;
                    case 'qtxt.query.post0':
                        q_func('qtxt.query.post1', 'deli.txt,post,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';1;'+r_userno);
                        break;
					case 'qtxt.query.post1':
						var as = _q_appendData("tmp0", "", true, true);
						var t_invono='';
							if (as[0] != undefined) {
								abbm[q_recno]['rc2no'] = as[0].rc2no;
								$('#txtRc2no').val(as[0].rc2no);
								
								//rc2.post內容
								if(!emp($('#txtRc2no').val())){
									q_func('rc2_post.post', r_accy + ',' + $('#txtRc2no').val() + ',1');
								}
							}
							if(q_cur==2)
                        		alert('已更新進貨單!!');
                        	else
                        		alert('成功轉出進貨單!!');
                        break;
					case 'qtxt.query.post2':
						_btnOk($('#txtNoa').val(), bbmKey[0],'', '', 3);
                        break;
					default:
						if(t_func.substring(0,18)=='qtxt.query.getuno_'){
							var n = t_func.replace('qtxt.query.getuno_','');
							var as = _q_appendData("tmp0", "", true, true);
							if (as[0] != undefined) {
								$('#txtUno_' + n).val(as[0].uno);
							}
							getUno(parseInt(n)+1);
						}
						break;
						
				}
			}
            
            function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				
				if(q_cur==2 && !emp($('#txtRc2no').val())){//修改後重新產生 避免資料不對應
					//rc2.post內容
					q_func('rc2_post.post.a1', r_accy + ',' + $('#txtRc2no').val() + ',0');
				}
			}

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('deli_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    	$('.lengthd.num,.dime2.num,.lengthc.num').change(function() {
                    		$(this).val(dec($(this).val()));
						});
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
                        $('#txtSize_'+j).change(function(e){
							if ($.trim($(this).val()).length == 0)
								return;
							var n = $(this).attr('id').replace('txtSize_','');			
							var data = tranSize($.trim($(this).val()));
							$(this).val(tranSize($.trim($(this).val()),'getsize'));
							$('#txtDime_'+n).val('');
							$('#txtWidth_'+n).val('');
							$('#txtLengthb_'+n).val('');
							$('#txtDime_'+n).val((data[0]!=undefined?(data[0].toString().length>0?(isNaN(parseFloat(data[0]))?0:parseFloat(data[0])):0):0));
							$('#txtWidth_'+n).val((data[1]!=undefined?(data[1].toString().length>0?(isNaN(parseFloat(data[1]))?0:parseFloat(data[1])):0):0));
							$('#txtLengthb_'+n).val((data[2]!=undefined?(data[2].toString().length>0?(isNaN(parseFloat(data[2]))?0:parseFloat(data[2])):0):0));
							sum();
						});
                        $('#txtInmount_' + j).change(function () {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//進貨金額
							var t_unit = $.trim($('#txtUnit_' + b_seq).val()).toUpperCase();
							if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'MT' ||  t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
                        		q_tr('txtMoney_'+b_seq,q_mul(q_float('txtInweight_'+b_seq),q_float('txtPrice_'+b_seq)));
                        	}else{
                        		q_tr('txtMoney_'+b_seq,q_mul(q_float('txtInmount_'+b_seq),q_float('txtPrice_'+b_seq)));
                        	}
                        	bbs_sum();
                        });
                        $('#txtInweight_' + j).change(function () {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//進貨金額
							var t_unit = $.trim($('#txtUnit_' + b_seq).val()).toUpperCase();
							if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'MT' ||  t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
                        		q_tr('txtMoney_'+b_seq,q_mul(q_float('txtInweight_'+b_seq),q_float('txtPrice_'+b_seq)));
                        	}else{
                        		q_tr('txtMoney_'+b_seq,q_mul(q_float('txtInmount_'+b_seq),q_float('txtPrice_'+b_seq)));
                        	}
                        	bbs_sum();
                        });
                        $('#txtPrice_' + j).change(function () {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//進貨金額
							var t_unit = $.trim($('#txtUnit_' + b_seq).val()).toUpperCase();
                        	if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'MT' ||  t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
                        		q_tr('txtMoney_'+b_seq,q_mul(q_float('txtInweight_'+b_seq),q_float('txtPrice_'+b_seq)));
                        	}else{
                        		q_tr('txtMoney_'+b_seq,q_mul(q_float('txtInmount_'+b_seq),q_float('txtPrice_'+b_seq)));
                        	}
                        	bbs_sum();
                        });
                        $('#txtMoney_' + j).change(function () {
                        	bbs_sum();
                        });
                        $('#txtCointotal_' + j).change(function () {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	//原幣關稅(原幣完稅價格*關稅率)
                			q_tr('txtCointariff_'+b_seq,round(q_mul(q_float('txtCointotal_'+b_seq),q_div(q_float('txtTariffrate_'+b_seq),100)),2));
                			sum();
                        });
                        $('#txtTotal_' + j).change(function () {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	//本幣關稅(本幣完稅價格*關稅率)
                			q_tr('txtTariff_'+b_seq,round(q_mul(q_float('txtTotal_'+b_seq),q_div(q_float('txtTariffrate_'+b_seq),100)),0));
                			//推廣貿易費(本幣完稅價格*推廣貿易費率)
                			q_tr('txtTrade_'+b_seq,round(q_mul(q_float('txtTotal_'+b_seq),q_div(q_float('txtTraderate_'+b_seq),100)),0));
                			//貨物稅額((本幣完稅價格+本幣關稅) * 貨物稅率)
                			q_tr('txtCommoditytax_'+b_seq,round(q_mul(q_add(q_float('txtTotal_'+b_seq),q_float('txtTariff_'+b_seq)),q_div(q_float('txtCommodityrate_'+b_seq),100)),0));
                			//本幣營業稅基(本幣完稅價格+本幣關稅+貨物稅)
                			q_tr('txtVatbase_'+b_seq,q_add(q_add(q_float('txtTotal_'+b_seq),q_float('txtTariff_'+b_seq)),q_float('txtCommoditytax_'+b_seq)));
                			sum();
                        });
                        $('#txtTariffrate_' + j).change(function () {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	//原幣關稅(原幣完稅價格*關稅率)
                			q_tr('txtCointariff_'+b_seq,round(q_mul(q_float('txtCointotal_'+b_seq),q_div(q_float('txtTariffrate_'+b_seq),100)),2));
                			//本幣關稅(本幣完稅價格*關稅率)
                			q_tr('txtTariff_'+b_seq,round(q_mul(q_float('txtTotal_'+b_seq),q_div(q_float('txtTariffrate_'+b_seq),100)),0));
                			//貨物稅額((本幣完稅價格+本幣關稅) * 貨物稅率)
                			q_tr('txtCommoditytax_'+b_seq,round(q_mul(q_add(q_float('txtTotal_'+b_seq),q_float('txtTariff_'+b_seq)),q_div(q_float('txtCommodityrate_'+b_seq),100)),0));
                			//本幣營業稅基(本幣完稅價格+本幣關稅+貨物稅)
                			q_tr('txtVatbase_'+b_seq,q_add(q_add(q_float('txtTotal_'+b_seq),q_float('txtTariff_'+b_seq)),q_float('txtCommoditytax_'+b_seq)));
                			sum();
                        });
                        $('#txtTraderate_' + j).change(function () {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	//推廣貿易費(本幣完稅價格*推廣貿易費率)
                			q_tr('txtTrade_'+b_seq,round(q_mul(q_float('txtTotal_'+b_seq),q_div(q_float('txtTraderate_'+b_seq),100)),0));
                			sum();
                        });
                        $('#txtCommodityrate_' + j).change(function () {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                        	//貨物稅額((本幣完稅價格+本幣關稅) * 貨物稅率)
                			q_tr('txtCommoditytax_'+b_seq,round(q_mul(q_add(q_float('txtTotal_'+b_seq),q_float('txtTariff_'+b_seq)),q_div(q_float('txtCommodityrate_'+b_seq),100)),0));
                			//本幣營業稅基(本幣完稅價格+本幣關稅+貨物稅)
                			q_tr('txtVatbase_'+b_seq,q_add(q_add(q_float('txtTotal_'+b_seq),q_float('txtTariff_'+b_seq)),q_float('txtCommoditytax_'+b_seq)));
                			sum();
                        });
                        $('#txtVatbase_' + j).change(function () {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                			//本幣營業稅額(本幣營業稅基 * 營業稅率)
                			q_tr('txtVat_'+b_seq,q_mul(q_float('txtVatbase_'+b_seq),q_div(q_float('txtVatrate'),100)));
                			sum();
                        });
                        //回推計算///////////////////////////////////////////
                        //原幣關稅(原幣完稅價格*關稅率)
                        $('#txtCointariff_'+j).change(function() {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtTariffrate_'+b_seq,round(q_mul(q_div(q_float('txtCointariff_'+b_seq),q_float('txtCointotal_'+b_seq)),100),4));
							sum();
						});
                		//本幣關稅(本幣完稅價格*關稅率)
                		$('#txtTariff_'+j).change(function() {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtTariffrate_'+b_seq,round(q_mul(q_div(q_float('txtTariff_'+b_seq),q_float('txtTotal_'+b_seq)),100),4));
							sum();
						});
                		//推廣貿易費(本幣完稅價格*推廣貿易費率)
                		$('#txtTrade_'+j).change(function() {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtTraderate_'+b_seq,round(q_mul(q_div(q_float('txtTrade_'+b_seq),q_float('txtTotal_'+b_seq)),100),4));
							sum();
						});
                		//貨物稅額((本幣完稅價格+本幣關稅) * 貨物稅率)
                		$('#txtCommoditytax_'+j).change(function() {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtCommodityrate_'+b_seq,round(q_mul(q_div(q_float('txtCommoditytax_'+b_seq),q_add(q_float('txtTotal_'+b_seq),q_float('txtTariff_'+b_seq))),100),4));
							sum();
						});
                    }
                }
                _bbsAssign();
                if(q_getPara('sys.project').toUpperCase()!='PK'){
                	$('.dime2').hide();
                	$('.lengthc').hide();
                	$('.lengthd').hide();
                	$('.dbbs').css('width','3550px');
                }
                
            }

            function btnIns() {
                _btnIns();
                $('#txtCno').val(z_cno);
            	$('#txtAcomp').val(z_acomp);
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();

            }

            function btnPrint() {
                //q_box('z_deli.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['mount']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['date'] = abbm2['date'];

                return true;
            }

            function refresh(recno) {
                _refresh(recno);
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
                   		var t_productno = $.trim($('#txtProductno_'+b_seq).val());
	                	var t_style = $.trim($('#txtStyle_'+b_seq).val());
	                	var t_comp = q_getPara('sys.comp');          	
	                	q_gt('getproduct',"where=^^[N'"+t_productno+"',N'"+t_style+"',N'"+t_comp+"')^^", 0, 0, 0, "getproduct_"+b_seq); 
                        $('#txtStyle_'+b_seq).blur();
                        break;
                }
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
            	if (!emp($('#txtNoa').val())){
					if (!confirm(mess_dele))
						return;
					q_cur = 3;
					
					if(emp($('#txtRc2no').val()))
						q_func('qtxt.query.post2', 'deli.txt,post,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';0;'+r_userno);
					else
						q_func('rc2_post.post.a2', r_accy + ',' + $('#txtRc2no').val() + ',0');
				}
                //_btnDele();
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
                width: 98%;
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
                width: 98%;
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
                width: 39%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 20%;
                float: left;
            }
            .txt.c5 {
                width: 75%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
                float: left;
            }
            .txt.c7 {
                float: left;
                width: 22%;
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
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1px;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .delivery {
				background: #FF88C2;
			}
			.retire {
				background: #66FF66;
			}
			.tax {
				background: #FFAA33;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_help" style="position:absolute; top:300px; left:550px; display:none; width:500px; background-color: #CDFFCE; border: 5px solid gray;">
			<table style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr style="background-color: #f8d463;">
					<td>
						<a style="font-size: medium;font-weight: bold;">表身欄位計算說明：</a>
						<input id="btnHelpClose" type="button" value="關閉" style="float: right;">
					</td>
				</tr>
				<tr><td>進貨金額=進貨數量(重量)*採購單價。</td></tr>
				<tr><td>原幣完稅價格 = 原幣進貨額 + ( (原幣運費+原幣保險費+原幣加減費用) 　　　　　　　 * (該筆原幣進貨額/原幣進貨額合計) )。</td></tr>
				<tr><td>本幣完稅價格 = 原幣完稅價格*匯率。</td></tr>
				<tr><td>原幣關稅 =原幣完稅價格*關稅率。</td></tr>
				<tr><td>本幣關稅 = 本幣完稅價格*關稅率。</td></tr>
				<tr><td>本推廣貿易費 = 本幣完稅價格*推廣貿易費率，小數以下捨棄。</td></tr>
				<tr><td>貨物稅額= (本幣完稅價格+本幣關稅) * 貨物稅率，小數以下捨棄。</td></tr>
				<tr><td>本幣營業稅基 = 本幣完稅價格+本幣關稅+貨物稅。</td></tr>
				<tr><td>本幣營業稅額 = 本幣營業稅基 * 營業稅率，小數以下捨棄。</td></tr>
			</table>
		</div>
		<div id='dmain' style="width: 1260px;">
			<div class="dview" id="dview" style="float: left;  width:20%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:60%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:35%"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 80%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr class="tr1">
						<td class='td1'><span> </span><a id="lblEntryno" class="lbl" > </a></td>
						<td class="td2" colspan="3"><input id="txtEntryno" type="text" class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td6"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class='td7'><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td class="td8"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblCno" class="lbl btn" > </a></td>
						<td class="td2" colspan="3">
							<input id="txtCno"  type="text"  class="txt c2"/>
							<input id="txtAcomp"  type="text" class="txt c3"/>
						</td>
						<td class='td1'><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtTggno" type="text"  class="txt c2"/>
							<input id="txtComp" type="text"  class="txt c3"/>
						</td>
					</tr>
					
					<tr class="tr3 delivery">
						<td class="td1"><span> </span><a id="lblDeliveryno" class="lbl" > </a></td>
						<td class="td2" colspan="3"><input id="txtDeliveryno"  type="text"  class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblDeliverydate" class="lbl"> </a></td>
						<td class="td6"><input id="txtDeliverydate" type="text"  class="txt c1"/></td>
						<td class='td7'><span> </span><a id="lblArrivedate" class="lbl"> </a></td>
						<td class="td8"><input id="txtArrivedate" type="text"  class="txt c1"/></td>
					</tr>
					<tr class="tr4 delivery">
						<td class="td1"><span> </span><a id="lblTranno" class="lbl btn" > </a></td>
						<td class="td2" colspan="3">
							<input id="txtTranno"  type="text"  class="txt c2"/>
							<input id="txtTrancomp"  type="text" class="txt c3"/>
						</td>
						<td class='td5'><span> </span><a id="lblEtd" class="lbl"> </a></td>
						<td class="td6"><input id="txtEtd" type="text"  class="txt c1"/></td>
						<td class='td7'><span> </span><a id="lblEta" class="lbl"> </a></td>
						<td class="td8"><input id="txtEta" type="text"  class="txt c1"/></td>
					</tr>
					<tr class="tr5 delivery">
						<td class="td1"><span> </span><a id="lblCaseyard" class="lbl" > </a></td>
						<td class="td2" colspan="3"><input id="txtCaseyard"  type="text"  class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblWarehousedate" class="lbl"> </a></td>
						<td class="td6"><input id="txtWarehousedate" type="text"  class="txt c1"/></td>
						<td class='td7'> </td>
						<td class="td8"> </td>
					</tr>
					
					<tr class="tr6 retire">
						<td class="td1"><span> </span><a id="lblBcompno" class="lbl btn" > </a></td>
						<td class="td2" colspan="3">
							<input id="txtBcompno"  type="text"  class="txt c2"/>
							<input id="txtBcomp"  type="text" class="txt c3"/>
						</td>
						<td class="td5"><span> </span><a id="lblPaytype" class="lbl" > </a></td>
						<td class="td6" colspan="3"><input id="txtPaytype"  type="text"  class="txt c1"/></td>
					</tr>
					<tr class="tr7 retire">
						<td class="td1"><span> </span><a id="lblBoatname" class="lbl" > </a></td>
						<td class="td2"><input id="txtBoatname"  type="text"  class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblShip" class="lbl" > </a></td>
						<td class="td4"><input id="txtShip"  type="text"  class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblSino" class="lbl btn" > </a></td>
						<td class="td6"><input id="txtSino"  type="text"  class="txt c1"/></td>
						<td class='td7'> </td>
						<td class="td8"> </td>
					</tr>
					<tr class="tr8 retire">
						<td class="td1"><span> </span><a id="lblNegotiatingdate" class="lbl" > </a></td>
						<td class="td2"><input id="txtNegotiatingdate"  type="text"  class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblCoin" class="lbl"> </a></td>
						<td class="td4"><input id="txtCoin" type="text"  class="txt num c1"/></td>
						<td class="td5"><span> </span><a id="lblFloata" class="lbl"> </a></td>
						<td class="td6"><input id="txtFloata" type="text"  class="txt num c1"/></td>
						<td class="td7"> </td>
						<td class="td8"> </td>
					</tr>
					<!--<tr class="tr9 retire">
						<td class="td7"><span> </span><a id="lblForwarddate" class="lbl"> </a></td>
						<td class="td8"><input id="txtForwarddate" type="text"  class="txt num c1"/></td>
						<td class="td1"><span> </span><a id="lblYearrate" class="lbl" > </a></td>
						<td class="td2"><input id="txtYearrate"  type="text"  class="txt num c1"/></td>
						<td class="td3"><span> </span><a id="lblInterest" class="lbl" > </a></td>
						<td class="td4"><input id="txtInterest"  type="text"  class="txt num c1"/></td>
						<td class="td5"><span> </span><a id="lblPaydate" class="lbl" > </a></td>
						<td class="td6"><input id="txtPaydate"  type="text"  class="txt c1"/></td>
						<td class='td7'> </td>
						<td class="td8"> </td>
					</tr>-->
					
					<tr class="tr10 tax">
						<td class="td1"><span> </span><a id="lblIcno" class="lbl" > </a></td>
						<td class="td2" colspan="3"><input id="txtIcno"  type="text"  class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblDeclaredate" class="lbl" > </a></td>
						<td class="td6"><input id="txtDeclaredate"  type="text"  class="txt num c1"/></td>
						<td class="td7"><span> </span><a id="lblCredittype" class="lbl" > </a></td>
						<td class="td8"><select id="cmbCredittype" class="txt c1"> </select></td>
					</tr>
					<tr class="tr11 tax">
						<td class="td1"><span> </span><a id="lblVatrate" class="lbl" > </a></td>
						<td class="td2"><input id="txtVatrate"  type="text"  class="txt num c3"/>&nbsp; %</td>
						<td class="td3"><span> </span><a id="lblVatbase" class="lbl" > </a></td>
						<td class="td4"><input id="txtVatbase"  type="text"  class="txt num c1"/></td>
						<td class="td5"><span> </span><a id="lblVat" class="lbl" > </a></td>
						<td class="td6"><input id="txtVat"  type="text"  class="txt num c1"/></td>
						<td class='td7'> </td>
						<td class="td8"> </td>
					</tr>
					<tr class="tr12 tax">
						<td class="td1"><span> </span><a id="lblTranmoney" class="lbl" > </a></td>
						<td class="td2"><input id="txtTranmoney"  type="text"  class="txt num c1"/></td>
						<td class="td3"><span> </span><a id="lblInsurance" class="lbl" > </a></td>
						<td class="td4"><input id="txtInsurance"  type="text"  class="txt num c1"/></td>
						<td class="td5"><span> </span><a id="lblModification" class="lbl" > </a></td>
						<td class="td6"><input id="txtModification"  type="text"  class="txt num c1"/></td>
						<td class="td7"><span> </span><a id="lblFeetype" class="lbl" > </a></td>
						<td class="td8"><select id="cmbFeetype" class="txt c1"> </select></td>
					</tr>
					
					<tr class="tr13">
						<td class="td1"><span> </span><a id="lblCoinretiremoney" class="lbl" > </a></td>
						<td class="td2"><input id="txtCoinretiremoney"  type="text"  class="txt num c1"/></td>
						<td class="td3"><span> </span><a id="lblCointotal" class="lbl" > </a></td>
						<td class="td4"><input id="txtCointotal"  type="text"  class="txt num c1"/></td>
						<td class="td5"><span> </span><a id="lblCointariff" class="lbl" > </a></td>
						<td class="td6"><input id="txtCointariff"  type="text"  class="txt num c1"/></td>
						<td class="td7"> </td>
						<td class="td8"><input id="btnOrdc" type="button"/></td>
					</tr>
					<tr class="tr14">
						<td class="td1"><span> </span><a id="lblRetiremoney" class="lbl" > </a></td>
						<td class="td2"><input id="txtRetiremoney"  type="text"  class="txt num c1"/></td>
						<td class="td3"><span> </span><a id="lblTotal" class="lbl" > </a></td>
						<td class="td4"><input id="txtTotal"  type="text"  class="txt num c1"/></td>
						<td class="td5"><span> </span><a id="lblTariff" class="lbl" > </a></td>
						<td class="td6"><input id="txtTariff"  type="text"  class="txt num c1"/></td>
						<td class="td7"> </td>
						<td class="td8"><input id="btnRc2" type="button"/></td>
					</tr>
					<tr class="tr15">
						<td class="td1"><span> </span><a id="lblTrade" class="lbl" > </a></td>
						<td class="td2"><input id="txtTrade"  type="text"  class="txt num c1"/></td>
						<td class="td3"><span> </span><a id="lblCommoditytax" class="lbl" > </a></td>
						<td class="td4"><input id="txtCommoditytax"  type="text"  class="txt num c1"/></td>
						<td class="td5"><span> </span><a id="lblLctotal" class="lbl" > </a></td>
						<td class="td6"><input id="txtLctotal"  type="text"  class="txt num c1"/></td>
						<td class="td7"> <input id="btnHelp" type="button" value="?" style="float: right;"/></td>
						<td class="td8"><!--<input id="btnPayb" type="button"/>--></td>
					</tr>
					<!--<td class="td1"><span> </span><a id="lblLctotal" class="lbl" > </a></td>
						<td class="td2"><input id="txtLctotal"  type="text"  class="txt num c1"/></td>
						<td class="td3"><span> </span><a id="lblBltotal" class="lbl" > </a></td>
						<td class="td4"><input id="txtBltotal"  type="text"  class="txt num c1"/></td>
						<td class="td5"><span> </span><a id="lblBlcost" class="lbl" > </a></td>
						<td class="td6"><input id="txtBlcost"  type="text"  class="txt num c1"/></td>-->
					<tr class="tr16">
						<td class="td1"><span> </span><a id="lblRc2no" class="lbl" > </a></td>
						<td class="td2"><input id="txtRc2no"  type="text"  class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblPaybno" class="lbl" > </a></td>
						<td class="td4"><input id="txtPaybno"  type="text"  class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td6"><input id="txtWorker" type="text"  class="txt c1"/> </td>
						<td class='td7'><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td class="td8"><input id="txtWorker2" type="text"  class="txt c1"/> </td>
					</tr>
					<tr class="tr17">
						<td class='td1'><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="7"><input id="txtMemo" type="text"  class="txt c1"/> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 3800px;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td align="center" style="width:200px;"><a id='lblUno_s'> </a></td>
					<td align="center" style="width:100px;"><a>品號<BR>品名</a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_st'>型</a></td>
					<td align="center" style="width:60px;"><a>等級</a></td>
					<td align="center" style="width:140px;">規範<BR>國別</td>
					<td align="center" style="width:220px;"><a id='lblSizea_s'> </a><BR><a id='lblSpec_s'> </a></td>
					<td align="center" style="width:130px;"><a id='lblSize_s'> </a></td>
					<td align="center" style="width:60px;" class="dime2"><a>實際<BR>厚度</a></td>
					<td align="center" style="width:60px;" class="lengthc"><a>實際<BR>寬度</a></td>
					<td align="center" style="width:60px;" class="lengthd"><a>實際<BR>長度</a></td>	
					<td align="center" style="width:40px;"><a id='lblSource_s'> </a></td>
					
					<td align="center" style="width:115px;"><a id='lblInmount_s'> </a><BR><a id='lblMount_s'> </a></td>
						<td align="center" style="width:50px;"><a>數量<BR>單位</a></td>
					<td align="center" style="width:115px;"><a id='lblInweight_s'> </a><BR><a id='lblWeight_s'> </a></td>
						<td align="center" style="width:50px;"><a>計價<BR>單位</a></td>
					<td align="center" style="width:115px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblStore_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblCointotal_s'> </a><BR><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblTariffrate_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblCointariff_s'> </a><BR><a id='lblTariff_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblTraderate_s'> </a><BR><a id='lblTrade_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblCommodityrate_s'> </a><BR><a id='lblCommoditytax_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblVatbase_s'> </a><BR><a id='lblVat_s'> </a></td>
					<td align="center" style="width:115px;"><!--<a id='lblBlmoney_s'> </a><BR>--><a id='lblLcmoney_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblCost_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblCaseno_s'> </a><BR><a id='lblCasetype_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblCasemount_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblMweight_s'> </a><BR><a id='lblCuft_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblInvoiceno_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:130px;"><a id='lblUno2_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><input class="txt c1" id="txtUno.*" type="text"  /></td>
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
                        <input id="txtUcolor.*" type="text" style="width:95%;"/>
                        <input id="txtScolor.*" type="text" style="width:95%;"/>
                    </td>
					<td>
						<input class="txt num" id="txtDime.*" type="text" style="float: left;width:55px;"/>
						<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >x</div>
						<input class="txt num" id="txtWidth.*" type="text" style="float: left;width:55px;"/>
						<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="txtLengthb.*" type="text" style="float: left;width:55px;"/>
						<BR>
						<input class="txt c1" id="txtSpec.*" type="text"/>
					</td>
					<td><input class="txt c1" id="txtSize.*" type="text"/>	</td>.
					<td class='dime2'><input class="txt num c1 dime2" id="txtDime2.*" type="text"  /></td>
					<td class='lengthc'><input class="txt num c1 lengthc" id="txtLengthc.*" type="text"  /></td>
					<td class='lengthd'><input class="txt num c1 lengthd" id="txtLengthd.*" type="text"  /></td>
					<td><input class="txt c1" id="txtSource.*" type="text"  /></td>
					
					<td>
						<input class="txt num c1" id="txtInmount.*" type="text"  />
						<input class="txt num c1" id="txtMount.*" type="text"  />
					</td>
					<td><input class="txt c1" id="txtUnit2.*" type="text"/>	</td>
					<td>
						<input class="txt num c1" id="txtInweight.*" type="text"  />
						<input class="txt num c1" id="txtWeight.*" type="text"  />
					</td>
					<td><input class="txt c1" id="txtUnit.*" type="text"/>	</td>
					<td>
						<input class="txt num c1" id="txtPrice.*" type="text"  />
						<input class="txt num c1" id="txtPrice2.*" type="text"  />
					</td>
					<td><input class="txt num c1" id="txtMoney.*" type="text"  /></td>
					<td style="text-align: left;">
						<input  id="txtStoreno.*" type="text" style="width:80%;" />
						<input class="btn"  id="btnStoreno.*" type="button" value='.' style="width:1%;"  />
						<input  id="txtStore.*" type="text" style="width:80%;" />
					</td>
					<td>
						<input class="txt num c1" id="txtCointotal.*" type="text"  />
						<input class="txt num c1" id="txtTotal.*" type="text"  />
					</td>
					<td><input class="txt num c1" id="txtTariffrate.*" type="text"  /></td>
					<td>
						<input class="txt num c1" id="txtCointariff.*" type="text"  />
						<input class="txt num c1" id="txtTariff.*" type="text"  />
					</td>
					<td>
						<input class="txt num c1" id="txtTraderate.*" type="text"  />
						<input class="txt num c1" id="txtTrade.*" type="text"  />
					</td>
					<td>
						<input class="txt num c1" id="txtCommodityrate.*" type="text"  />
						<input class="txt num c1" id="txtCommoditytax.*" type="text"  />
					</td>
					<td>
						<input class="txt num c1" id="txtVatbase.*" type="text"  />
						<input class="txt num c1" id="txtVat.*" type="text"  />
					</td>
					<td>
						<!--<input class="txt num c1" id="txtBlmoney.*" type="text"  />-->
						<input class="txt num c1" id="txtLcmoney.*" type="text"  />
					</td>
					<td><input class="txt num c1" id="txtCost.*" type="text"  /></td>
					<td>
						<input class="txt c1" id="txtCaseno.*" type="text"  />
						<input class="txt c1" id="txtCasetype.*" type="text"  />
					</td>
					<td><input class="txt num c1" id="txtCasemount.*" type="text"  />	</td>
					<td>
						<input class="txt num c1" id="txtMweight.*" type="text"  />
						<input class="txt num c1" id="txtCuft.*" type="text"  />
					</td>
					<td><input class="txt c1" id="txtInvoiceno.*" type="text"  />	</td>
					<td>
						<input class="txt c1" id="txtMemo.*" type="text" />
						<input class="txt c5" id="txtOrdcno.*" type="text" />
						<input class="txt c4" id="txtNo2.*" type="text" />
						<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
					</td>
					<td><input class="txt c1" id="txtUno2.*" type="text"  /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
