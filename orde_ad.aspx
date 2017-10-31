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
			var q_name = "orde";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtSales', 'txtOrdbno', 'txtOrdcno','txtApv'];
			var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3', 'txtC1', 'txtNotv'
							,'txtPackway','txtSprice','txtBenifit','txtPayterms','txtSize','txtProfit','txtDime'
							,'txtProduct'];
			var bbmNum = [['txtTotal', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1],['txtFloata', 10, 5, 1], ['txtTotalus', 15, 2, 1]];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'odate';
			brwCount2 = 12;
			
			aPop = new Array(
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,nick,paytype,trantype,tel,fax,zip_comp,addr_fact,custno2,cust2', 'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr,txtCustno2,txtCust2', 'cust_b.aspx'],
				['txtCustno2', 'lblCust2', 'cust', 'noa,nick', 'txtCustno2,txtCust2', 'cust_b.aspx'],
				['ordb_txtTggno_', '', 'tgg', 'noa,comp', 'ordb_txtTggno_,ordb_txtTgg_', ''],
				
				['txtProductno_', 'btnProduct_', 'ucaucc2', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'uca_ad_b.aspx'],
				['txtUcolor_','','adspec','noa,mon,memo,memo1,memo2','0txtUcolor_','adspec_b.aspx'],
				['txtScolor_','','adly','noa,mon,memo,memo1,memo2','0txtScolor_','adly_b.aspx'],
				['txtClass_','','adly','noa,mon,memo,memo1,memo2','0txtClass_','adly_b.aspx'],
				['txtClassa_','','adly','noa,mon,memo,memo1,memo2','0txtClassa_','adly_b.aspx'],
				['txtZinc_','','adly','noa,mon,memo,memo1,memo2','0txtZinc_','adly_b.aspx'],
				['txtSizea_','','adoth','noa,mon,memo,memo1,memo2','0txtSizea_','adoth_b.aspx'],
				['txtSource_','','adpro','noa,mon,memo,memo1,memo2','0txtSource_','adpro_b.aspx'],
				['txtHard_','','addime','noa,mon,memo,memo1,memo2','0txtHard_','addime_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no2'];
				q_brwCount();
				if(q_content.length>0){
					q_content="where=^^ not(stype='3' or stype='4') and "+replaceAll(q_content,"where=^^",'');
				}else{
					q_content="where=^^ not(stype='3' or stype='4') ^^ "
				}
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
				$('#txtOdate').focus();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = $('#txtUnit_' + j).val();
					//t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() == 'kg' ? $('#txtWeight_' + j).val() : $('#txtMount_' + j).val()); // 計價量
					t_mount = $('#txtMount_' + j).val();
					// 計價量
					//t_weight = t_weight + dec( $('#txtWeight_' + j).val()) ; // 重量合計
					$('#txtTotal_' + j).val(round(q_mul(dec($('#txtPrice_' + j).val()), dec(t_mount)), q_getPara('vcc.pricePrecision')));
					
					q_tr('txtNotv_' + j, q_sub(q_float('txtMount_' + j), q_float('txtC1' + j)));
					t1 = q_add(t1, dec($('#txtTotal_' + j).val()));
				}
				$('#txtMoney').val(round(t1, q_getPara('vcc.pricePrecision')));
				if (!emp($('#txtPrice').val()))
					$('#txtTranmoney').val(round(q_mul(t_weight, dec($('#txtPrice').val())), q_getPara('vcc.pricePrecision')));
				// $('#txtWeight').val(round(t_weight, 0));
				q_tr('txtTotal', q_add(t1, dec($('#txtTax').val())));
				q_tr('txtTotalus', q_mul(q_float('txtMoney'), q_float('txtFloata')));
				calTax();
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtOdate', r_picd]];
				q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd],['txtIndate', r_picd]];
				bbsNum = [['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 9, q_getPara('vcc.mountPrecision'), 1], ['txtTotal', 10, 0, 1],['txtC1', 10, q_getPara('vcc.mountPrecision'), 1], ['txtNotv', 10, q_getPara('vcc.mountPrecision'), 1]];
				//q_cmbParse("cmbStype", q_getPara('orde.stype'));
				q_cmbParse("cmbStype", '1@內銷,2@代工,5@計畫生產');
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("cmbPayterms", q_getPara('sys.payterms'));
				q_cmbParse("combPayterms", q_getPara('sys.payterms'));
				q_cmbParse("cmbCasetype", "20',40'" );
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }

				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");

				$('#btnOrdei').click(function() {
					if (q_cur != 1 && $('#cmbStype').find("option:selected").text() == '外銷')
						q_box("ordei.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';" + r_accy + ";" + q_cur, 'ordei', "95%", "95%", q_getMsg('popOrdei'));
				});
				$('#btnQuat').click(function() {
					btnQuat();
				});
				$('#txtFloata').change(function() {
					sum();
				});
				$('#txtTotal').change(function() {
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
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});

				$('#btnCredit').click(function() {
					if (!emp($('#txtCustno').val())) {
						q_box("z_credit.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";custno='" + $('#txtCustno').val() + "';" + r_accy + ";" + q_cur, 'ordei', "95%", "95%", q_getMsg('btnCredit'));
					}
				});
				
				$('#cmbPayterms').change(function() {
					if($(this).val().slice(-2)=='＆C'){
						for (var j = 0; j < q_bbsCount; j++) {
							if(!emp($('#txtProductno_'+j).val())){
								$('#txtPayterms_'+j).val($(this).val());
								bbspaytermschange(j);
								$('#txtSize_'+j).val($(this).val().substr(0,$(this).val().length-2));
								uncommission(j);
							}else{
								$('#txtPayterms_'+j).val('');
								$('#txtSize_'+j).val('');
								$('#txtRadius_'+j).val('');
								$('#txtProfit2_'+j).val('');
								$('#txtDime_'+j).val('');
								$('#txtLengthb_'+j).val('');
							}
						}
					}else{
						for (var j = 0; j < q_bbsCount; j++) {
							if(!emp($('#txtProductno_'+j).val())){
								$('#txtPayterms_'+j).val($(this).val());
							}else{
								$('#txtPayterms_'+j).val('');
							}
							$('#txtSize_'+j).val('');
							$('#txtRadius_'+j).val('');
							$('#txtProfit2_'+j).val('');
							$('#txtDime_'+j).val('');
							$('#txtLengthb_'+j).val('');
						}
					}
				});
				////-----------------以下為addr2控制事件---------------
				$('#btnAddr2').mousedown(function(e) {
					var t_post2 = $('#txtPost2').val().split(';');
					var t_addr2 = $('#txtAddr2').val().split(';');
					var maxline=0;//判斷最多有幾組地址
					t_post2.length>t_addr2.length?maxline=t_post2.length:maxline=t_addr2.length;
					maxline==0?maxline=1:maxline=maxline;
					var rowslength=document.getElementById("table_addr2").rows.length-1;
					for (var j = 1; j < rowslength; j++) {
						document.getElementById("table_addr2").deleteRow(1);
					}
					
					for (var i = 0; i < maxline; i++) {
						var tr = document.createElement("tr");
						tr.id = "bbs_"+i;
						tr.innerHTML = "<td id='addr2_tdBtn2_"+i+"'><input class='btn addr2' id='btnAddr_minus_"+i+"' type='button' value='-' style='width: 30px' onClick=minus_addr2("+i+") /></td>";
						tr.innerHTML+= "<td id='addr2_tdPost2_"+i+"'><input id='addr2_txtPost2_"+i+"' type='text' class='txt addr2' value='"+t_post2[i]+"' style='width: 70px'/></td>";
						tr.innerHTML+="<td id='addr2_tdAddr2_"+i+"'><input id='addr2_txtAddr2_"+i+"' type='text' class='txt c1 addr2' value='"+t_addr2[i]+"' /></td>";
						var tmp = document.getElementById("addr2_close");
						tmp.parentNode.insertBefore(tr,tmp);
					}
					readonly_addr2();
					$('#div_addr2').show();
				});
				$('#btnAddr_plus').click(function() {
					var rowslength=document.getElementById("table_addr2").rows.length-2;
					var tr = document.createElement("tr");
						tr.id = "bbs_"+rowslength;
						tr.innerHTML = "<td id='addr2_tdBtn2_"+rowslength+"'><input class='btn addr2' id='btnAddr_minus_"+rowslength+"' type='button' value='-' style='width: 30px' onClick=minus_addr2("+rowslength+") /></td>";
						tr.innerHTML+= "<td id='addr2_tdPost2_"+rowslength+"'><input id='addr2_txtPost2_"+rowslength+"' type='text' class='txt addr2' value='' style='width: 70px' /></td>";
						tr.innerHTML+="<td id='addr2_tdAddr2_"+rowslength+"'><input id='addr2_txtAddr2_"+rowslength+"' type='text' class='txt c1 addr2' value='' /></td>";
						var tmp = document.getElementById("addr2_close");
						tmp.parentNode.insertBefore(tr,tmp);
				});
				$('#btnClose_div_addr2').click(function() {
					if(q_cur==1||q_cur==2){
						var rows=document.getElementById("table_addr2").rows.length-3;
						var t_post2 = '';
						var t_addr2 = '';
						for (var i = 0; i <= rows; i++) {
							if(!emp($('#addr2_txtPost2_'+i).val())||!emp($('#addr2_txtAddr2_'+i).val())){
								t_post2 += $('#addr2_txtPost2_'+i).val()+';';
								t_addr2 += $('#addr2_txtAddr2_'+i).val()+';';
							}
						}
						$('#txtPost2').val(t_post2.substr(0,t_post2.length-1));
						$('#txtAddr2').val(t_addr2.substr(0,t_addr2.length-1));
					}
					$('#div_addr2').hide();
				});
				
				$('#btnOrdem').click(function() {
					q_box("ordem_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';" + r_accy + ";" + q_cur, 'ordem', "95%", "95%", q_getMsg('popOrdem'));
				});
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
				//div 事件
				$('#btnClose_div_getprice').click(function() {
					$('#div_getprice').hide();
				});
				
				$('#btnOk_div_getprice').click(function() {
					//回寫單價
					if(q_cur==1 || q_cur==2){
						$('#txtPrice_'+$('#textNoq').val()).val($('#textCost3').val());
						$('#txtSprice_'+$('#textNoq').val()).val($('#textCost').val());
						$('#txtWeight_'+$('#textNoq').val()).val($('#textWeight').val());
						$('#txtPackwayno_'+$('#textNoq').val()).val($('#textPackwayno').val());
						$('#txtPackway_'+$('#textNoq').val()).val($('#textPackway').val());
						$('#txtTotal_'+$('#textNoq').val()).val(round(q_mul(dec($('#txtMount_'+$('#textNoq').val()).val()),dec($('#txtPrice_'+$('#textNoq').val()).val())),q_getPara('vcc.pricePrecision')));
						$('#txtPayterms_'+$('#textNoq').val()).val($('#combPayterms').val());
						
						$('#txtProfit_'+$('#textNoq').val()).val($('#textProfit').val());
						$('#txtInsurance_'+$('#textNoq').val()).val($('#textInsurance').val());
						$('#txtCommission_'+$('#textNoq').val()).val($('#textCommission').val());
						
						sum();
						
						if(!emp($('#txtProductno_'+$('#textNoq').val()).val()) && !emp($('#txtPackwayno_'+$('#textNoq').val()).val())){
							var t_where="where=^^ noa='"+$('#txtProductno_'+$('#textNoq').val()).val()+"' and packway='"+$('#txtPackwayno_'+$('#textNoq').val()).val()+"' ^^";
		                	q_gt('pack2s', t_where, 0, 0, 0, "", r_accy,1);
		                	var as = _q_appendData("pack2s", "", true);
							if (as[0] != undefined) {
								var t_mount=dec($('#txtMount_'+$('#textNoq').val()).val());
								var t_uweight=dec(as[0].uweight);
								var t_inmount=dec(as[0].inmount)==0?1:dec(as[0].inmount);
								var t_outmount=dec(as[0].outmount)==0?1:dec(as[0].outmount);
								var t_inweight=dec(as[0].inweight);
								var t_outweight=dec(as[0].outweight);
								var t_cuft=dec(as[0].cuft);
								t_nweight=q_mul(t_mount,t_uweight);
								var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
								var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
								var t_emount=q_sub(t_mount,q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
								$('#txtCuft_'+b_seq).val(q_mul(t_cuft,t_pcmount));
		                	}
	                	}
					}
					$('#div_getprice').hide();
				});
				
				$('#div_pack2').click(function() {
					t_where = "noa='" + $('#textProductno').val() + "'";
					q_box("pack2_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'divpack2', "95%", "95%", '包裝方式');
				});
				
				$('#textCost').change(function() {
					divtrantypechange();
					var cost2=dec($('#textCost2').val());
					var tranprice=dec($('#textTranprice').val());
					var profit=$('#textProfit').val();
					var insurance=$('#textInsurance').val();
					var commission=$('#textCommission').val();
					$('#textProfitmoney').val(round(q_mul(cost2,q_div(profit,100)),q_getPara('vcc.pricePrecision')));
					$('#textInsurmoney').val(round(q_mul(cost2,q_div(insurance,100)),q_getPara('vcc.pricePrecision')));
					$('#textCommimoney').val(round(q_mul(cost2,q_div(commission,100)),q_getPara('vcc.pricePrecision')));
					divpaytermschange();
				});
				
				$('[name="trantype"]').change(function() {
					divtrantypechange();
				});
				
				$('#textCyprice').change(function() {
					divtrantypechange();
				});
				
				$('#textCycbm').change(function() {
					divtrantypechange();
				});
				
				$('#textKgprice').change(function() {
					divtrantypechange();
				});
				
				$('#textCuftprice').change(function() {
					divtrantypechange();
				});
				
				$('#textTranprice').change(function() {
					var t_cost=dec($('#textCost').val());
					$('#textCost2').val(q_add(t_cost,q_add(dec($('#textFee').val()),dec($('#textTranprice').val()))));
					divpaytermschange();
				});
				
				$('#textFee').change(function() {
					var t_cost=dec($('#textCost').val());
					$('#textCost2').val(q_add(t_cost,q_add(dec($('#textFee').val()),dec($('#textTranprice').val()))));
					divpaytermschange();
				});
				
				$('#textProfit').change(function() {
					var profit=$('#textProfit').val();
					var cost2=dec($('#textCost2').val());
					$('#textProfitmoney').val(round(q_mul(cost2,q_div(profit,100)),q_getPara('vcc.pricePrecision')));
					divpaytermschange();
				});
				
				$('#textInsurance').change(function() {
					var insurance=$('#textInsurance').val();
					var cost2=dec($('#textCost2').val());
					$('#textInsurmoney').val(round(q_mul(cost2,q_div(insurance,100)),q_getPara('vcc.pricePrecision')));
					divpaytermschange();
				});
				
				$('#textCommission').change(function() {
					var commission=$('#textCommission').val();
					var cost2=dec($('#textCost2').val());
					$('#textCommimoney').val(round(q_mul(cost2,q_div(commission,100)),q_getPara('vcc.pricePrecision')));
					divpaytermschange();
				});
				
				$('#combPayterms').change(function() {
					if(!emp($('#txtCustno').val()) && !emp($('#txtProductno_'+$('#textNoq').val()).val()) && !emp($('#combPayterms').val())){
						var t_where = "where=^^ a.custno='"+$('#txtCustno').val()+"' and a.productno='"+$('#txtProductno_'+$('#textNoq').val()).val()+"' and a.payterms='"+$('#combPayterms').val()+"' and '"+$('#txtOdate').val()+"'>=a.bdate order by bdate desc,noa desc --^^";
						q_gt('custprices_uca', t_where, 0, 0, 0, "getcustprices", r_accy, 1);
						var as = _q_appendData("custprices", "", true);
						if (as[0] != undefined) {
							$('#textCommission').val(as[0].commission);
							$('#textInsurance').val(as[0].insurance);
							$('#textProfit').val(as[0].profit);
							$('#textCost').val(as[0].cost);
							$('#textTranprice').val(as[0].tranprice);
						}
					}
					divpaytermschange();
				});
				
				$('#textMount').change(function() {
					var t_weight=0;
					var t_mount=dec($('#textMount').val());
					var t_uweight=dec($('#textUweight').val());
					var t_inmount=dec($('#textInmount').val())==0?1:dec($('#textInmount').val());
					var t_outmount=dec($('#textOutmount').val())==0?1:dec($('#textOutmount').val());
					var t_inweight=dec($('#textInweight').val());
					var t_outweight=dec($('#textOutweight').val());
					var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
					var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
					var t_emount=q_sub(dec($('#textMount').val()),q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
					t_weight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
					t_weight=q_mul(t_pfmount,t_weight); //整箱毛重
					if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
						var tt_weight=q_mul(t_emount,t_uweight);
						tt_weight=q_add(tt_weight,t_outweight);
						tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
						t_weight=q_add(t_weight,tt_weight);
					}
					$('#textWeight').val(t_weight);
				});
				
				$('#textUweight').change(function() {
					var t_weight=0;
					var t_mount=dec($('#textMount').val());
					var t_uweight=dec($('#textUweight').val());
					var t_inmount=dec($('#textInmount').val())==0?1:dec($('#textInmount').val());
					var t_outmount=dec($('#textOutmount').val())==0?1:dec($('#textOutmount').val());
					var t_inweight=dec($('#textInweight').val());
					var t_outweight=dec($('#textOutweight').val());
					var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
					var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
					var t_emount=q_sub(dec($('#textMount').val()),q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
					t_weight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
					t_weight=q_mul(t_pfmount,t_weight); //整箱毛重
					if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
						var tt_weight=q_mul(t_emount,t_uweight);
						tt_weight=q_add(tt_weight,t_outweight);
						tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
						t_weight=q_add(t_weight,tt_weight);
					}
					$('#textWeight').val(t_weight);
				});
				
				//下一格
				SeekF=[];
				$("#table_getprice [type='text'] ").each(function() {
					SeekF.push($(this).attr('id'));
				});
						
				SeekF.push('btnOk_div_getprice');
				$("#table_getprice [type='text'] ").each(function() {
					$(this).bind('keydown', function(event) {
						keypress_bbm(event, $(this), SeekF, 'btnOk_div_getprice');
					});
				});
				
				$("#table_getprice .num").each(function() {
					$(this).keyup(function(e) {
						if(e.keyCode>=37 && e.keyCode<=40)
							return;
						var tmp=$(this).val();
						tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
						$(this).val(tmp);
					});
					
					$(this).focusin(function() {
						$(this).select();
					});
				});
				
				$('#btnClose_div_ucagroup').click(function() {
					ucagroupdivmove = false;
					$('#div_ucagroup').hide();
				});
				
				//106/10/25 增加
				$('#btnUpload').change(function() {
					if(!(q_cur==1 || q_cur==2)){
						return;
					}
					var file = $(this)[0].files[0];
					if(file){
						Lock(1);
						var ext = '';
						var extindex = file.name.lastIndexOf('.');
						if(extindex>=0){
							ext = file.name.substring(extindex,file.name.length);
						}
						$('#txtUpfile').val(file.name);
						
						fr = new FileReader();
						fr.fileName = $('#txtUpfile').val();
					    fr.readAsDataURL(file);
					    fr.onprogress = function(e){
							if ( e.lengthComputable ) { 
								var per = Math.round( (e.loaded * 100) / e.total) ; 
								$('#FileList').children().last().find('progress').eq(0).attr('value',per);
							}; 
						}
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						}
						fr.onloadend = function(e){
							$('#FileList').children().last().find('progress').eq(0).attr('value',100);
							console.log(fr.fileName+':'+fr.result.length);
							var oReq = new XMLHttpRequest();
							oReq.upload.addEventListener("progress",function(e) {
								if (e.lengthComputable) {
									percentComplete = Math.round((e.loaded / e.total) * 100,0);
									$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
								}
							}, false);
							oReq.upload.addEventListener("load",function(e) {
								Unlock(1);
							}, false);
							oReq.upload.addEventListener("error",function(e) {
								alert("資料上傳發生錯誤!");
							}, false);
								
							oReq.timeout = 360000;
							oReq.ontimeout = function () { alert("Timed out!!!"); }
							oReq.open("POST", 'orde_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);//oReq.send(e.target.result);
						};
					}
				});
				
				$('#btnDownload').click(function(){
					if($('#txtUpfile').val().length>0){
						$('#xdownload').attr('src','orde_download.aspx?FileName='+$('#txtUpfile').val()+'&TempName='+$('#txtUpfile').val());
                    }else{    
						alert('No Data!!');
					}
				});
			}
			
			function divtrantypechange(){
				var t_cost=dec($('#textCost').val());
				if($('[name="trantype"]:checked').val()=='cy'){
					var cyprice=dec($('#textCyprice').val());
					var cycbm=dec($('#textCycbm').val());
					var cbm=dec($('#textCbm').val());
					var t_ctnmount=q_mul(dec($('#textInmount').val()),dec($('#textOutmount').val()));//一箱多少產品
					var t_cbmmount=cbm==0?0:q_mul(Math.ceil(q_div(cycbm,cbm)),t_ctnmount); //一櫃可裝多少產品
					var unitprice=t_cbmmount==0?0:round(q_div(cyprice,t_cbmmount),q_getPara('vcc.pricePrecision')); //平均一產品成本
					$('#textTranprice').val(unitprice);
				}else if ($('[name="trantype"]:checked').val()=='kg') {
					var kgprice=dec($('#textKgprice').val());
					$('#textMount').change();
					$('#textTranprice').val(q_mul(dec($('#textWeight').val()),kgprice));
				}else if ($('[name="trantype"]:checked').val()=='cuft') {
					var cuftprice=dec($('#textCuftprice').val());
					var cuft=$('#textCuft').val();
					var t_ctnmount=q_mul(dec($('#textInmount').val()),dec($('#textOutmount').val()));//一箱多少產品
					if(t_ctnmount==0)
						$('#textTranprice').val(0);
					else
						$('#textTranprice').val(round(q_div(q_mul(cuftprice,cuft),t_ctnmount),q_getPara('vcc.pricePrecision')));
				}
				$('#textCost2').val(q_add(t_cost,q_add(dec($('#textFee').val()),dec($('#textTranprice').val()))));
				divpaytermschange();
			}
			
			function divpaytermschange(){
				var cost=dec($('#textCost').val());				
				var tranprice=dec($('#textTranprice').val());
				var fee=dec($('#textFee').val());
				var profit=$('#textProfit').val();
				var insurance=$('#textInsurance').val();
				var commission=$('#textCommission').val();
				var payterms= $('#combPayterms').val();
				var cost3=0
				var precision=dec(q_getPara('vcc.pricePrecision'));
				switch (payterms) {//P利潤 I保險 C佣金 F運費
					case 'C＆F'://(成本/(1-P)+F) //=CFR   
						cost3=round(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),precision);
						break;
					case 'C＆F＆C'://(成本/(1-P)+F)/(1-C)
						cost3=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'C＆I': //成本/(1-P)/(1-I)
						cost3=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),precision);
						break;
					case 'C＆I＆C'://成本/(1-P)/(1-I)/(1-C)
						cost3=round(q_div(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'CIF'://(成本/(1-P)+F)/(1-I)   
						cost3=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),precision);
						break;
					case 'CIF＆C'://(成本/(1-P)+F)/(1-I)/(1-C)
						cost3=round(q_div(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'EXW'://成本/(1-P)
						cost3=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
					case 'FOB'://成本/(1-P)
						cost3=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
					case 'FOB＆C': //成本/(1-P)/(1-C)
						cost3=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(commission,100))),precision);
						break;
				}
				$('#textCost3').val(cost3);
			}
			
			//addr2控制事件vvvvvv-------------------
			function minus_addr2(seq) {	
				$('#addr2_txtPost2_'+seq).val('');
				$('#addr2_txtAddr2_'+seq).val('');
			}
			
			function readonly_addr2() {
				if(q_cur==1||q_cur==2){
					$('.addr2').removeAttr('disabled');
				}else{
					$('.addr2').attr('disabled', 'disabled');
				}
			}
			
			//addr2控制事件^^^^^^--------------------
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'quats':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							$('#txtQuatno').val(b_ret[0].noa);
							//取得報價的第一筆匯率等資料
							var t_where = "where=^^ noa='" + b_ret[0].noa + "' ^^";
							q_gt('quat', t_where, 0, 0, 0, "", r_accy);

							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtPrice,txtMount,txtQuatno,txtNo3', b_ret.length, b_ret, 'productno,product,spec,unit,price,mount,noa,no3', 'txtProductno,txtProduct,txtSpec');
							/// 最後 aEmpField 不可以有【數字欄位】
							sum();
							bbsAssign();
						}
						break;
					case 'pack2':
						ret = getb_ret();
						if (ret != undefined) {
							$('#txtPackwayno_'+b_seq).val(ret[0].packway);
							$('#txtPackway_'+b_seq).val(ret[0].pack);
						}
						if(!emp($('#txtProductno_'+b_seq).val()) && !emp($('#txtPackwayno_'+b_seq).val())){
							var t_where="where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' and packway='"+$('#txtPackwayno_'+b_seq).val()+"' ^^";
		                	q_gt('pack2s', t_where, 0, 0, 0, "", r_accy,1);
		                	var as = _q_appendData("pack2s", "", true);
							if (as[0] != undefined) {
								var t_gweight=0; //毛重
								var t_nweight=0; //淨重
								var t_mount=dec($('#txtMount_'+b_seq).val());
								var t_uweight=dec(as[0].uweight);
								var t_inmount=dec(as[0].inmount)==0?1:dec(as[0].inmount);
								var t_outmount=dec(as[0].outmount)==0?1:dec(as[0].outmount);
								var t_inweight=dec(as[0].inweight);
								var t_outweight=dec(as[0].outweight);
								var t_cuft=dec(as[0].cuft);
								t_nweight=q_mul(t_mount,t_uweight);
								var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
								var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
								var t_emount=q_sub(t_mount,q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
								t_gweight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
								t_gweight=q_mul(t_pfmount,t_gweight); //整箱毛重
								if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
									var tt_weight=q_mul(t_emount,t_uweight);
									tt_weight=q_add(tt_weight,t_outweight);
									tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
									t_gweight=q_add(t_gweight,tt_weight);
								}
								//$('#txtWeight_'+b_seq).val(t_nweight);
								//$('#txtGweight_'+b_seq).val(t_gweight);
								$('#txtCuft_'+b_seq).val(q_mul(t_cuft,t_pcmount));
		                	}
	                	}
						break;
					case 'divpack2':
						ret = getb_ret();
						if (ret != undefined) {
							$('#textPackwayno').val(ret[0].packway);
							$('#textPackway').val(ret[0].pack);
							$('#textInmount').val(ret[0].inmount);
							$('#textOutmount').val(ret[0].outmount);
							$('#textInweight').val(ret[0].inweight);
							$('#textOutweight').val(ret[0].outweight);
							$('#textCbm').val(ret[0].cbm);
							$('#textCuft').val(ret[0].cuft);
							$('#textMount').change();
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function browTicketForm(obj) {
				//資料欄位名稱不可有'_'否則會有問題
				if (($(obj).attr('readonly') == 'readonly') || ($(obj).attr('id').substring(0, 3) == 'lbl')) {
					if ($(obj).attr('id').substring(0, 3) == 'lbl')
						obj = $('#txt' + $(obj).attr('id').substring(3));
					var noa = $.trim($(obj).val());
					var openName = $(obj).attr('id').split('_')[0].substring(3).toLowerCase();
					if (noa.length > 0) {
						switch (openName) {
							case 'ordbno':
								q_box("ordb.aspx?;;;charindex(noa,'" + noa + "')>0;" + r_accy, 'ordb', "95%", "95%", q_getMsg("popOrdb"));
								break;
							case 'ordcno':
								q_box("ordc.aspx?;;;noa='" + noa + "';" + r_accy, 'ordc', "95%", "95%", q_getMsg("popOrdc"));
								break;
							case 'quatno':
								q_box("quat.aspx?;;;noa='" + noa + "';" + r_accy, 'quat', "95%", "95%", q_getMsg("popQuat"));
								break;
						}
					}
				}
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
					case 'orde_ordb':
						var as = _q_appendData("view_orde", "", true);
						var rowslength=document.getElementById("table_ordb").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("table_ordb").deleteRow(1);
						}
							
						for (var i = 0; i < as.length; i++) {
							var tr = document.createElement("tr");
							tr.id = "bbs_"+i;
							tr.innerHTML= "<td id='ordb_tdNo2_"+i+"'><input id='ordb_txtNo2_"+i+"' type='text' value='"+as[i].no2+"' style='width: 45px' disabled='disabled' /><input id='ordb_txtNoa_"+i+"' type='text' value='"+as[i].noa+"' style='width: 45px;display:none' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdProdcut_"+i+"'><input id='ordb_txtProdcut_"+i+"' type='text' value='"+as[i].product+"' style='width: 200px' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdMount_"+i+"'><input id='ordb_txtMount_"+i+"' type='text' value='"+as[i].mount+"' style='width: 80px;text-align: right;' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdSafemount_"+i+"'><input id='ordb_txtSafemount_"+i+"' type='text' value='"+dec(as[i].safemount)+"' style='width: 80px;text-align: right;' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdStmount_"+i+"'><input id='ordb_txtStmount_"+i+"' type='text' value='"+as[i].stmount+"' style='width: 80px;text-align: right;' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdOcmount_"+i+"'><input id='ordb_txtOcmount_"+i+"' type='text' value='"+dec(as[i].ocmount)+"' style='width: 80px;text-align: right;' disabled='disabled' /></td>";
							//庫存-訂單數量>安全量?不需請購:abs(安全量-(庫存-訂單數量))
							tr.innerHTML+="<td id='ordb_tdObmount_"+i+"'><input id='ordb_txtObmount_"+i+"' type='text' value='"+(q_sub(dec(as[i].stmount),dec(as[i].mount))>as[i].safemount?0:Math.abs(q_sub(dec(as[i].safemount),q_sub(dec(as[i].stmount),dec(as[i].mount)))))+"' class='num' style='width: 80px;text-align: right;' /></td>";
							tr.innerHTML+="<td id='ordb_tdTggno_"+i+"'><input id='ordb_txtTggno_"+i+"' type='text' value='"+as[i].tggno+"' style='width: 150px'  /><input id='ordb_txtTgg_"+i+"' type='text' value='"+as[i].tgg+"' style='width: 200px' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdInprice_"+i+"'><input id='ordb_txtInprice_"+i+"' type='text' value='"+(dec(as[i].tggprice)>0?as[i].tggprice:as[i].inprice)+"' class='num' style='width: 80px;text-align: right;' /></td>";
								
							var tmp = document.getElementById("ordb_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						$('#lblOrde2ordb').text(q_getMsg('lblOrde2ordb'));
						$('#div_ordb').show();
						
						var SeekF= new Array();
						$('#table_ordb td').children("input:text").each(function() {
							if($(this).attr('disabled')!='disabled')
								SeekF.push($(this).attr('id'));
						});
						
						SeekF.push('btn_div_ordb');
						$('#table_ordb td').children("input:text").each(function() {
							$(this).keydown(function(event) {
								if( event.which == 13) {
									$('#'+SeekF[SeekF.indexOf($(this).attr('id'))+1]).focus();
									$('#'+SeekF[SeekF.indexOf($(this).attr('id'))+1]).select();
								}
							});
						});
						
						$('#table_ordb td .num').each(function() {
							$(this).keyup(function() {
								var tmp=$(this).val();
								tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
								$(this).val(tmp);
							});
						});
						
						refresh(q_recno);
						q_cur=2;
						break;
					case 'msg_ucc':
						var as = _q_appendData("ucc", "", true);
						t_msg = '';
						if (as[0] != undefined) {
							t_msg = "銷售單價：" + dec(as[0].saleprice) + "<BR>";
						}
						//客戶售價
						var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and datea<'" + q_date() + "' ^^ stop=1";
						q_gt('quat', t_where, 0, 0, 0, "msg_quat", r_accy);	
						
						break;
					case 'msg_quat':
						var as = _q_appendData("quats", "", true);
						var quat_price = 0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtProductno_' + b_seq).val())
									quat_price = dec(as[i].price);
							}
						}
						t_msg = t_msg + "最近報價單價：" + quat_price + "<BR>";
						//最新出貨單價
						var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and noa in (select noa from vccs" + r_accy + " where productno='" + $('#txtProductno_' + b_seq).val() + "' and price>0 ) ^^ stop=1";
						q_gt('vcc', t_where, 0, 0, 0, "msg_vcc", r_accy);
						break;
					case 'msg_vcc':
						var as = _q_appendData("vccs", "", true);
						var vcc_price = 0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtProductno_' + b_seq).val())
									vcc_price = dec(as[i].price);
							}
						}
						t_msg = t_msg + "最近出貨單價：" + vcc_price;
						q_msg($('#txtPrice_' + b_seq), t_msg);
						break;
					case 'msg_stk':
						var as = _q_appendData("stkucc", "", true);
						var stkmount = 0;
						t_msg = '';
						for (var i = 0; i < as.length; i++) {
							stkmount = q_add(stkmount, dec(as[i].mount));
						}
						t_msg = "庫存量：" + stkmount;
						//平均成本
						var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by datea desc ^^ stop=1";
						q_gt('wcost', t_where, 0, 0, 0, "msg_wcost", r_accy);
						break;
					case 'msg_wcost':
						var as = _q_appendData("wcost", "", true);
						var wcost_price;
						if (as[0] != undefined) {
							if (dec(as[0].mount) == 0) {
								wcost_price = 0;
							} else {
								wcost_price = round(q_div(q_add(q_add(q_add(dec(as[0].costa), dec(as[0].costb)), dec(as[0].costc)), dec(as[0].costd)), dec(as[0].mount)), q_getPara('vcc.pricePrecision'))
								//wcost_price=round((dec(as[0].costa)+dec(as[0].costb)+dec(as[0].costc)+dec(as[0].costd))/dec(as[0].mount),0);
							}
						}
						if (wcost_price != undefined) {
							t_msg = t_msg + "<BR>平均成本：" + wcost_price;
							q_msg($('#txtMount_' + b_seq), t_msg);
						} else {
							//原料成本
							var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by mon desc ^^ stop=1";
							q_gt('costs', t_where, 0, 0, 0, "msg_costs", r_accy);
						}
						break;
					case 'msg_costs':
						var as = _q_appendData("costs", "", true);
						var costs_price;
						if (as[0] != undefined) {
							costs_price = as[0].price;
						}
						if (costs_price != undefined) {
							t_msg = t_msg + "<BR>平均成本：" + costs_price;
						}
						q_msg($('#txtMount_' + b_seq), t_msg);
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
					case 'quat':
						var as = _q_appendData("quat", "", true);
						if (as[0] != undefined) {
							$('#txtFloata').val(as[0].floata);
							$('#cmbCoin').val(as[0].coin);
							$('#txtPaytype').val(as[0].paytype);
							$('#txtSalesno').val(as[0].salesno);
							$('#txtSales').val(as[0].sales);
							$('#txtContract').val(as[0].contract);
							$('#cmbTrantype').val(as[0].trantype);
							$('#txtTel').val(as[0].tel);
							$('#txtFax').val(as[0].fax);
							$('#txtPost').val(as[0].post);
							$('#txtAddr').val(as[0].addr);
							$('#txtPost2').val(as[0].post2);
							$('#txtAddr2').val(as[0].addr2);
							$('#cmbTaxtype').val(as[0].taxtype);
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
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnQuat() {
				var t_custno = trim($('#txtCustno').val());
				var t_where = '';
				if (t_custno.length > 0) {					
					t_where = "noa+'_'+no3 not in (select isnull(quatno,'')+'_'+isnull(no3,'') from view_ordes" + r_accy + " where noa!='" + $('#txtNoa').val() + "' ) and isnull(enda,0)=0 and isnull(cancel,0)=0"
					t_where = t_where + ' and ' + q_sqlPara("custno", t_custno)+" and datea>='"+$('#txtOdate').val()+"'";
					q_box("quat_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'quats', "95%", "95%", $('#btnQuat').val());	
					
				}else {
					alert(q_getMsg('msgCustEmp'));
					return;
				}
				
			}
			
			var t_dodate='',t_dodatename='';
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				var t_ucawhere='1=0'; //產品
				var t_adspecwhere='1=0';//車縫線顏色
				var t_adlywhere='1=0';//皮料
				var t_adothwhere='1=0';//網烙印
				var t_adprowhere='1=0'; //轉印
				var t_addimewhere='1=0'; //電鍍
				
				for(var k=0;k<q_bbsCount;k++){
					if(emp($('#txtDatea_'+k).val())){
						//106/07/24 暫時不使用
						//getpdate(k);
						//$('#txtDatea_'+k).val(q_cdn($.trim($('#txtOdate').val()),15))
					}
					if(!emp($('#txtProductno_'+k).val())){
						t_ucawhere=t_ucawhere+" or noa='"+$('#txtProductno_'+k).val()+"'";
					}
					if(!emp($('#txtUcolor_'+k).val())){
						t_adspecwhere=t_adspecwhere+" or noa='"+$('#txtUcolor_'+k).val()+"'";
					}
					if(!emp($('#txtScolor_'+k).val())){
						t_adlywhere=t_adlywhere+" or noa='"+$('#txtScolor_'+k).val()+"'";
					}
					if(!emp($('#txtClass_'+k).val())){
						t_adlywhere=t_adlywhere+" or noa='"+$('#txtClass_'+k).val()+"'";
					}
					if(!emp($('#txtClassa_'+k).val())){
						t_adlywhere=t_adlywhere+" or noa='"+$('#txtClassa_'+k).val()+"'";
					}
					if(!emp($('#txtZinc_'+k).val())){
						t_adlywhere=t_adlywhere+" or noa='"+$('#txtZinc_'+k).val()+"'";
					}
					if(!emp($('#txtSizea_'+k).val())){
						t_adothwhere=t_adothwhere+" or noa='"+$('#txtSizea_'+k).val()+"'";
					}
					if(!emp($('#txtSource_'+k).val())){
						t_adprowhere=t_adprowhere+" or noa='"+$('#txtSource_'+k).val()+"'";
					}
					if(!emp($('#txtHard_'+k).val())){
						t_addimewhere=t_addimewhere+" or noa='"+$('#txtHard_'+k).val()+"'";
					}
				}
				if(t_ucawhere!='1=0'){
					t_ucawhere='where=^^'+t_ucawhere+'^^';
					t_adspecwhere='where=^^'+t_adspecwhere+'^^';
					t_adlywhere='where=^^'+t_adlywhere+'^^';
					t_adothwhere='where=^^'+t_adothwhere+'^^';
					t_adprowhere='where=^^'+t_adprowhere+'^^';
					t_addimewhere='where=^^'+t_addimewhere+'^^';
					
					q_gt('view_ucaucc',t_ucawhere, 0, 0, 0, "getucaucc", r_accy,1);
					var ucaas = _q_appendData("view_ucaucc", "", true);
					q_gt('adspec',t_adspecwhere, 0, 0, 0, "getadspec", r_accy,1);
					var adspecas = _q_appendData("adspec", "", true);
					q_gt('adly',t_adlywhere, 0, 0, 0, "getadly", r_accy,1);
					var adlyas = _q_appendData("adly", "", true);
					q_gt('adoth',t_adothwhere, 0, 0, 0, "getadoth", r_accy,1);
					var adothas = _q_appendData("adoth", "", true);
					q_gt('adpro',t_adprowhere, 0, 0, 0, "getadpro", r_accy,1);
					var adproas = _q_appendData("adpro", "", true);
					q_gt('addime',t_addimewhere, 0, 0, 0, "getaddime", r_accy,1);
					var addimeas = _q_appendData("addime", "", true);
					
					for(var i=0;i<q_bbsCount;i++){
						//產品
						if(!emp($('#txtProductno_'+i).val())){
							var t_product='';
							for(var j=0;j<ucaas.length;j++){
								if($('#txtProductno_'+i).val()==ucaas[j].noa){
									t_product=ucaas[j].product;
									break;
								}
							}
							//車縫線顏色
							if(!emp($('#txtUcolor_'+i).val())){
								for(var j=0;j<adspecas.length;j++){
									if($('#txtUcolor_'+i).val()==adspecas[j].noa){
										t_product=t_product+(t_product.length>0?',':'')+'車縫線顏色:'+adspecas[j].mon;
										break;
									}
								}
							}
							//皮料1
							if(!emp($('#txtScolor_'+i).val())){
								for(var j=0;j<adlyas.length;j++){
									if($('#txtScolor_'+i).val()==adlyas[j].noa){
										t_product=t_product+(t_product.length>0?',':'')+'皮料1:'+adlyas[j].mon;
										break;
									}
								}
							}
							//皮料2
							if(!emp($('#txtClass_'+i).val())){
								for(var j=0;j<adlyas.length;j++){
									if($('#txtClass_'+i).val()==adlyas[j].noa){
										t_product=t_product+(t_product.length>0?',':'')+'皮料2:'+adlyas[j].mon;
										break;
									}
								}
							}
							//皮料3
							if(!emp($('#txtClassa_'+i).val())){
								for(var j=0;j<adlyas.length;j++){
									if($('#txtClassa_'+i).val()==adlyas[j].noa){
										t_product=t_product+(t_product.length>0?',':'')+'皮料3:'+adlyas[j].mon;
										break;
									}
								}
							}
							//皮料4
							if(!emp($('#txtZinc_'+i).val())){
								for(var j=0;j<adlyas.length;j++){
									if($('#txtZinc_'+i).val()==adlyas[j].noa){
										t_product=t_product+(t_product.length>0?',':'')+'皮料4:'+adlyas[j].mon;
										break;
									}
								}
							}
							//網烙印
							if(!emp($('#txtSizea_'+i).val())){
								for(var j=0;j<adothas.length;j++){
									if($('#txtSizea_'+i).val()==adothas[j].noa){
										t_product=t_product+(t_product.length>0?',':'')+'網烙印:'+adothas[j].mon;
										break;
									}
								}
							}
							//轉印
							if(!emp($('#txtSource_'+i).val())){
								for(var j=0;j<adproas.length;j++){
									if($('#txtSource_'+i).val()==adproas[j].noa){
										t_product=t_product+(t_product.length>0?',':'')+'轉印:'+adproas[j].mon;
										break;
									}
								}
							}
							//電鍍
							if(!emp($('#txtHard_'+i).val())){
								for(var j=0;j<addimeas.length;j++){
									if($('#txtHard_'+i).val()==addimeas[j].noa){
										t_product=t_product+(t_product.length>0?',':'')+'電鍍:'+addimeas[j].mon;
										break;
									}
								}
							}
							
							$('#txtProduct_'+i).val(t_product);
						}
					}
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
				
				//106/03/16 限制 訂單交期 106/03/17後面等確定再改抓orde.dodate
				//var t_where="where=^^noa='qsys.orde.dodate'^^"
				//106/09/14 不判斷
				/*var t_where="where=^^noa='orde.dodate'^^"
				q_gt('qsys', t_where, 0, 0, 0, "getdodate", r_accy, 1);
				var as = _q_appendData("qsys", "", true);
				if (as[0] != undefined) {
					t_dodatename=as[0].name;
					t_dodate=as[0].value;
				}
				
				var modi_mount2=0;
				for(var i=0;i<q_bbsCount;i++){
					modi_mount2=q_add(modi_mount2,dec($('#txtMount_'+i).val()));
				}
				
				var t_err='';
				if(t_dodate.length>0 && (q_cur==1 || (q_cur==2 && modi_mount!=modi_mount2)) ){
					for(var k=0;k<q_bbsCount;k++){
						if($('#txtDatea_'+k).val()<=t_dodate && !emp($('#txtDatea_'+k).val())){
							t_err=q_getMsg('lblDateas')+"【"+$('#txtDatea_'+k).val()+"】不可低於"+t_dodatename+"【"+t_dodate+"】";
							break;
						}	
					}
				}
				if(t_err.length>0){
					alert(t_err);
					return;
				}*/
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orde') + $('#txtOdate').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('orde_ad_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
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

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}

			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnMinus_' + j).click(function() {
							btnMinus($(this).attr('id'));
						});
						$('#btnProductno_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						$('#txtProductno_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//q_change($(this), 'ucc', 'noa', 'noa,product,unit');
						});

						$('#txtUnit_' + j).focusout(function() {
							sum();
						});
						// $('#txtWeight_' + j).focusout(function () { sum(); });
						$('#txtPrice_' + j).focusout(function() {
							sum();
						});
						$('#txtMount_' + j).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							sum();
							//106/07/24 暫時不使用
							//getpdate(b_seq);
						});
						$('#txtTotal_' + j).focusout(function() {
							sum();
						});

						$('#txtMount_' + j).focusin(function() {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								if (!emp($('#txtProductno_' + b_seq).val())) {
									//庫存
									var t_where = "where=^^ ['" + q_date() + "','','"+$('#txtProductno_' + b_seq).val()+"')  ^^";
									q_gt('calstk', t_where, 0, 0, 0, "msg_stk", r_accy);
								}
							}
						});
						$('#txtPrice_' + j).focusin(function() {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								if (!emp($('#txtProductno_' + b_seq).val())) {
									//金額
									var t_where = "where=^^ noa='" + $('#txtProductno_' + b_seq).val() + "' ^^ stop=1";
									q_gt('ucc', t_where, 0, 0, 0, "msg_ucc", r_accy);
								}
							}
						});

						$('#btnBorn_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "noa='" + $('#txtNoa').val() + "' and no2='" + $('#txtNo2_' + b_seq).val() + "'";
							q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn'));
						});
						$('#btnNeed_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "productno='" + $('#txtProductno_'+ b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "'";
							q_box("z_vccneed.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'Need', "95%", "95%", q_getMsg('lblNeed'));
						});

						$('#btnVccrecord_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "custno='" + $('#txtCustno').val() + "' and comp='" + $('#txtComp').val() + "' and productno='" + $('#txtProductno_' + b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "' and ordeno='"+$('#txtNoa').val()+"' and no2='"+$('#txtNo2_'+b_seq).val()+"' ";
							q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
						});
						
						$('#btnScheduled_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val())) {
								t_where = "noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
								q_box("z_scheduled.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
							}
						});
						
						$('#btnOrdemount_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "title='本期訂單' and bdate='"+q_cdn(q_date(),-61)+"' and edate='"+q_cdn(q_date(),+61)+"' and noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
							q_box("z_workgorde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
						});
						
						$('#btnGetprice_'+j).click(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtProductno_'+b_seq).val())){
								$('#textNoq').val(b_seq);
								$('#textProductno').val($('#txtProductno_'+b_seq).val());
								$('#textProduct').val($('#txtProduct_'+b_seq).val());
								$('#textUnit').val($('#txtUnit_'+b_seq).val());
								$('#textMount').val($('#txtMount_'+b_seq).val());
								var t_where = "where=^^ noa='"+$('#textProductno').val()+"' ^^";
								q_gt('view_ucaucc', t_where, 0, 0, 0, "getucaucc", r_accy, 1);
								var as = _q_appendData("view_ucaucc", "", true);
								if (as[0] != undefined) {
									$('#textUweight').val(as[0].uweight);
								}else{
									$('#textUweight').val('');
								}
								$('#textCost').val($('#txtSprice_'+b_seq).val());
								$('#textPackwayno').val($('#txtPackwayno_'+b_seq).val());
								$('#textPackway').val($('#txtPackway_'+b_seq).val());
								var t_where = "where=^^ noa='"+$('#textProductno').val()+"' and packway='"+$('#textPackwayno').val()+"' ^^";
								q_gt('pack2s', t_where, 0, 0, 0, "getpack2s", r_accy, 1);
								var as = _q_appendData("pack2s", "", true);
								if (as[0] != undefined) {
									if(dec($('#textUweight').val())==0)
										$('#textUweight').val(as[0].uweight)
									$('#textInmount').val(as[0].inmount);
									$('#textOutmount').val(as[0].outmount);
									$('#textInweight').val(as[0].inweight);
									$('#textOutweight').val(as[0].outweight);
									$('#textCbm').val(as[0].cbm);
									$('#textCuft').val(as[0].cuft);	
								}else{
									$('#textInmount').val('');
									$('#textOutmount').val('');
									$('#textInweight').val('');
									$('#textOutweight').val('');
									$('#textCbm').val('');
									$('#textCuft').val('');	
								}
								if($('#cmbCasetype').val()=="20'")
									$('#textCycbm').val(33.2);
								if($('#cmbCasetype').val()=="40'")
									$('#textCycbm').val(67.7);
								
								$('#textProfit').val($('#txtProfit_'+b_seq).val());
								$('#textInsurance').val($('#txtInsurance_'+b_seq).val());
								$('#textCommission').val($('#txtCommission_'+b_seq).val());
								
								$('#combPayterms').val($('#cmbPayterms').val());
								
								$('#textMount').change();
								$('#textCost').change();
								$('#div_getprice').css('top', e.pageY- $('#div_getprice').height());
								$('#div_getprice').css('left', e.pageX - $('#div_getprice').width());
								
								$('#div_getprice').show();
							}
						});
						
						$('#btnPackway_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							t_where = "noa='" + $('#txtProductno_'+b_seq).val() + "'";
							q_box("pack2_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack2', "95%", "95%", '包裝方式');
						});
						
						$('#btnUcagroup_' + j).click(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#table_ucagroup .no').text('');
							$('#table_ucagroup .mon').text('');
							$('#table_ucagroup .memo1').text('');
							$('#table_ucagroup .memo2').text('');
							if(!emp($('#txtProductno_'+b_seq).val())){
								$('.ucano').text($('#txtProductno_'+b_seq).val());
								var t_where = "where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' ^^";
								q_gt('uca', t_where, 0, 0, 0, "",r_accy,1);
								var as = _q_appendData("uca", "", true);
								if (as[0] != undefined) {
									$('.ucaname').text(as[0].product);
									$('.ucaspec').text(as[0].spec);
									//車縫
									$('.groupe.no').text(as[0].groupeno);
									if(!emp($('.groupe.no').text())){
										var t_where = "where=^^ noa='"+$('.groupe.no').text()+"' ^^";
										q_gt('adsize', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adsize", "", true);
										if (ass[0] != undefined) {
											$('.groupe.mon').text(ass[0].mon);
											$('.groupe.memo1').text(ass[0].memo1);
											$('.groupe.memo2').text(ass[0].memo2);
										}
									}
									//車縫線顏色
									$('.ucolor.no').text($('#txtUcolor_'+b_seq).val());
									if(!emp($('.ucolor.no').text())){
										var t_where = "where=^^ noa='"+$('.ucolor.no').text()+"' ^^";
										q_gt('adspec', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adspec", "", true);
										if (ass[0] != undefined) {
											$('.ucolor.mon').text(ass[0].mon);
											$('.ucolor.memo1').text(ass[0].memo1);
											$('.ucolor.memo2').text(ass[0].memo2);
										}
									}
									//護片
									$('.groupf.no').text(as[0].groupfno);
									if(!emp($('.groupf.no').text())){
										var t_where = "where=^^ noa='"+$('.groupf.no').text()+"' ^^";
										q_gt('adsss', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adsss", "", true);
										if (ass[0] != undefined) {
											$('.groupf.mon').text(ass[0].mon);
											$('.groupf.memo1').text(ass[0].memo1);
											$('.groupf.memo2').text(ass[0].memo2);
										}
									}
									//皮料1
									$('.scolor.no').text($('#txtScolor_'+b_seq).val());
									if(!emp($('.scolor.no').text())){
										var t_where = "where=^^ noa='"+$('.scolor.no').text()+"' ^^";
										q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adly", "", true);
										if (ass[0] != undefined) {
											$('.scolor.mon').text(ass[0].mon);
											$('.scolor.memo1').text(ass[0].memo1);
											$('.scolor.memo2').text(ass[0].memo2);
										}
									}
									//皮料2
									$('.class.no').text($('#txtClass_'+b_seq).val());
									if(!emp($('.class.no').text())){
										var t_where = "where=^^ noa='"+$('.class.no').text()+"' ^^";
										q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adly", "", true);
										if (ass[0] != undefined) {
											$('.class.mon').text(ass[0].mon);
											$('.class.memo1').text(ass[0].memo1);
											$('.class.memo2').text(ass[0].memo2);
										}
									}
									//皮料3
									$('.classa.no').text($('#txtClassa_'+b_seq).val());
									if(!emp($('.classa.no').text())){
										var t_where = "where=^^ noa='"+$('.classa.no').text()+"' ^^";
										q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adly", "", true);
										if (ass[0] != undefined) {
											$('.classa.mon').text(ass[0].mon);
											$('.classa.memo1').text(ass[0].memo1);
											$('.classa.memo2').text(ass[0].memo2);
										}
									}
									//皮料4
									$('.zinc.no').text($('#txtZinc_'+b_seq).val());
									if(!emp($('.zinc.no').text())){
										var t_where = "where=^^ noa='"+$('.zinc.no').text()+"' ^^";
										q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adly", "", true);
										if (ass[0] != undefined) {
											$('.zinc.mon').text(ass[0].mon);
											$('.zinc.memo1').text(ass[0].memo1);
											$('.zinc.memo2').text(ass[0].memo2);
										}
									}
									//網烙印
									$('.sizea.no').text($('#txtSizea_'+b_seq).val());
									if(!emp($('.sizea.no').text())){
										var t_where = "where=^^ noa='"+$('.sizea.no').text()+"' ^^";
										q_gt('adoth', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adoth", "", true);
										if (ass[0] != undefined) {
											$('.sizea.mon').text(ass[0].mon);
											$('.sizea.memo1').text(ass[0].memo1);
											$('.sizea.memo2').text(ass[0].memo2);
										}
									}
									//轉印
									$('.source.no').text($('#txtSource_'+b_seq).val());
									if(!emp($('.source.no').text())){
										var t_where = "where=^^ noa='"+$('.source.no').text()+"' ^^";
										q_gt('adpro', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adpro", "", true);
										if (ass[0] != undefined) {
											$('.source.mon').text(ass[0].mon);
											$('.source.memo1').text(ass[0].memo1);
											$('.source.memo2').text(ass[0].memo2);
										}
									}
									//大弓
									$('.groupg.no').text(as[0].groupgno);
									if(!emp($('.groupg.no').text())){
										var t_where = "where=^^ noa='"+$('.groupg.no').text()+"' ^^";
										q_gt('adknife', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adknife", "", true);
										if (ass[0] != undefined) {
											$('.groupg.mon').text(ass[0].mon);
											$('.groupg.memo1').text(ass[0].memo1);
											$('.groupg.memo2').text(ass[0].memo2);
										}
									}
									//中束
									$('.grouph.no').text(as[0].grouphno);
									if(!emp($('.grouph.no').text())){
										var t_where = "where=^^ noa='"+$('.grouph.no').text()+"' ^^";
										q_gt('adpipe', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adpipe", "", true);
										if (ass[0] != undefined) {
											$('.grouph.mon').text(ass[0].mon);
											$('.grouph.memo1').text(ass[0].memo1);
											$('.grouph.memo2').text(ass[0].memo2);
										}
									}
									//座管
									$('.groupi.no').text(as[0].groupino);
									if(!emp($('.groupi.no').text())){
										var t_where = "where=^^ noa='"+$('.groupi.no').text()+"' ^^";
										q_gt('adtran', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adtran", "", true);
										if (ass[0] != undefined) {
											$('.groupi.mon').text(ass[0].mon);
											$('.groupi.memo1').text(ass[0].memo1);
											$('.groupi.memo2').text(ass[0].memo2);
										}
									}
									//電鍍
									$('.hard.no').text($('#txtHard_'+b_seq).val());
									if(!emp($('.hard.no').text())){
										var t_where = "where=^^ noa='"+$('.hard.no').text()+"' ^^";
										q_gt('addime', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("addime", "", true);
										if (ass[0] != undefined) {
											$('.hard.mon').text(ass[0].mon);
											$('.hard.memo1').text(ass[0].memo1);
											$('.hard.memo2').text(ass[0].memo2);
										}
									}
									var t_top=e.pageY- $('#div_ucagroup').height()-80;
									if(t_top<0){
										t_top=0
									}
									$('#div_ucagroup').css('top', t_top);
									$('#div_ucagroup').css('left', e.pageX +10);
									ucagroupdivmove = false;
									$('#div_ucagroup').show();
								}
							}
						});
					}
				}
				_bbsAssign();
				HiddenTreat();
				if (q_cur<1 && q_cur>2) {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtDatea_'+j).datepicker( 'destroy' );
					}
				} else {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtDatea_'+j).removeClass('hasDatepicker')
						$('#txtDatea_'+j).datepicker();
					}
				}
				if(q_cur==1 || q_cur==2){
					$('#btnGetpdate').removeAttr('disabled');
				}else{
					$('#btnGetpdate').attr('disabled', 'disabled');
				}
				
				$('#btnGetpdate').unbind('click');
				$('#btnGetpdate').click(function() {
					for(var k=0;k<q_bbsCount;k++){
						if(emp($('#txtDatea_'+k).val())){
							getpdate(k);
						}
					}
				});
			}

			function btnIns() {
				_btnIns();
				$('#chkIsproj').attr('checked', true);
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				$('#txtOdate').val(q_date());
				$('#txtOdate').focus();
				if(q_getPara('sys.project').toUpperCase()=="PK")
					$('#cmbStype').val('3');

				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				
			}
			
			//106/03/16 限制 訂單交期 修改判斷總量是否有變動
			var modi_mount=0;
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
					
				modi_mount=0;
				for(var i=0;i<q_bbsCount;i++){
					modi_mount=q_add(modi_mount,dec($('#txtMount_'+i).val()));
				}
				_btnModi();
				
				$('#txtOdate').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "'  ^^ stop=100";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
                var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
                 if (q_getPara('sys.project') =='ra')
                	q_box("z_ordep_ra.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
                else
               	    q_box("z_ordep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !dec(as['total'])) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['type'] = abbm2['type'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['odate'] = abbm2['odate'];

				/*if (!emp(abbm2['datea']))
					as['datea'] = abbm2['datea'];*/

				as['custno'] = abbm2['custno'];
				as['comp'] = abbm2['comp'];

				if (!as['enda'])
					as['enda'] = 'N';
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
				$('input[id*="txt"]').click(function() {
					browTicketForm($(this).get(0));
				});
				$('#div_addr2').hide();
				$('#div_ucagroup').hide();
				HiddenTreat();
				$('#btnUpload').val('');
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#btnOrdei').removeAttr('disabled');
					$('#combAddr').attr('disabled', 'disabled');
					$('#txtOdate').datepicker( 'destroy' );
					$('#btnOrdem').removeAttr('disabled');
					$('#btnUpload').attr('disabled', 'disabled');
				} else {
					$('#btnOrdei').attr('disabled', 'disabled');
					$('#combAddr').removeAttr('disabled');
					$('#txtOdate').datepicker();
					$('#btnOrdem').attr('disabled', 'disabled');
					$('#btnUpload').removeAttr('disabled', 'disabled');
				}	
				
				$('#div_addr2').hide();
				readonly_addr2();
				HiddenTreat();
				
				if(q_getPara('sys.project').toUpperCase()=="PK"){
					$('#cmbStype').attr('disabled', 'disabled');
				}
				$('#btnUpload').val('');
			}
			
			function HiddenTreat() {
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
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
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "'^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
					case 'txtProductno_':
						if(!emp($('#txtCustno').val()) && !emp($('#txtProductno_'+b_seq).val())){
							$('#txtPayterms_'+b_seq).val($('#cmbPayterms').val());
							if($('#cmbPayterms').val().slice(-2)=='＆C'){
								$('#txtPayterms2_'+b_seq).val($('#cmbPayterms').val().substr(0,$('#cmbPayterms').val().length-2));
							}
							
							var t_where = "where=^^ a.custno='"+$('#txtCustno').val()+"' and a.productno='"+$('#txtProductno_'+b_seq).val()+"' and a.payterms='"+$('#cmbPayterms').val()+"' and '"+$('#txtOdate').val()+"'>=a.bdate order by bdate desc,noa desc-- ^^";
							q_gt('custprices_uca', t_where, 0, 0, 0, "getcustprices", r_accy, 1);
							var as = _q_appendData("custprices", "", true);
							if (as[0] != undefined) {
								$('#txtCommission_'+b_seq).val(as[0].commission);
								$('#txtInsurance_'+b_seq).val(as[0].insurance);
								$('#txtProfit_'+b_seq).val(as[0].profit);
								$('#txtSprice_'+b_seq).val(as[0].cost);
								$('#txtPrice_'+b_seq).val(as[0].price2);
								
								if($('#cmbPayterms').val().slice(-2)=='＆C'){
									if(!emp($('#txtProductno_'+b_seq).val())){
										$('#txtPayterms_'+b_seq).val($('#cmbPayterms').val());
										$('#txtSize_'+b_seq).val($('#cmbPayterms').val().substr(0,$('#cmbPayterms').val().length-2));
										uncommission(b_seq);
									}
								}
							}
							/*if (as[1] != undefined) {
								$('#txtCommission2_'+b_seq).val(as[1].commission);
								$('#txtInsurance2_'+b_seq).val(as[1].insurance);
								$('#txtProfit2_'+b_seq).val(as[1].profit);
								$('#txtPayterms2_'+b_seq).val(as[1].payterms);
								$('#txtCost2_'+b_seq).val(as[1].cost);
								$('#txtPrice2_'+b_seq).val(as[1].price2);
							}*/
							$('#txtMount_'+b_seq).val(1);
							//105/04/15 取第一種包裝
							//105/06/17 依據客戶料號抓取包裝資料
							var t_where = "where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' and custno='"+$('#txtCustno').val()+"' ^^";
							q_gt('ucccust', t_where, 0, 0, 0, "getucccust", r_accy, 1);
							var isucccust=false;
							var as = _q_appendData("ucccust", "", true);
							if (as[0] != undefined) {
								$('#txtPackwayno_'+b_seq).val(as[0].packwayno);
								$('#txtPackway_'+b_seq).val(as[0].packway);
								isucccust=true;
							}
							//106/10/30 不取第一種包裝 但客戶有設定仍去撈取
							//106/10/31 直接取第一種包裝方式
							/*if(isucccust){
								var t_where = "where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' and packway='"+$('#txtPackwayno_'+b_seq).val()+"' ^^";
							else*/
								var t_where = "where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"'  ^^";
								q_gt('pack2s', t_where, 0, 0, 0, "gettop1pack2s", r_accy, 1);
								var as = _q_appendData("pack2s", "", true);
								if (as[0] != undefined) {
									$('#txtPackwayno_'+b_seq).val(as[0].packway);
									$('#txtPackway_'+b_seq).val(as[0].pack);
									//計算重量
									var t_weight=0;
									var t_mount=dec($('#txtMount_'+b_seq).val());
									var t_uweight=dec(as[0].uweight);
									var t_inmount=dec(as[0].inmount)==0?1:dec(as[0].inmount);
									var t_outmount=dec(as[0].outmount)==0?1:dec(as[0].outmount);
									var t_inweight=dec(as[0].inweight);
									var t_outweight=dec(as[0].outweight);
									var t_cuft=dec(as[0].cuft);
									var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
									var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
									var t_emount=q_sub(t_mount,q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
									
									$('#txtCuft_'+b_seq).val(q_mul(t_cuft,t_pcmount));
								}
							//}
							sum();
						}
						break;
				}
			}
			
			function bbspaytermschange(n){
				if(!emp($('#txtCustno').val()) && !emp($('#txtProductno_'+n).val()) && !emp($('#txtPayterms_'+n).val())){
					var t_where = "where=^^ a.custno='"+$('#txtCustno').val()+"' and (a.productno='"+$('#txtProductno_'+n).val()+"') and a.payterms='"+$('#txtPayterms_'+n).val()+"' and '"+$('#txtOdate').val()+"'>=a.bdate order by bdate desc,noa desc --^^";
					q_gt('custprices_uca', t_where, 0, 0, 0, "getcustprices", r_accy, 1);
					var as = _q_appendData("custprices", "", true);
					if (as[0] != undefined) {
						$('#txtCommission_'+n).val(as[0].commission);
						$('#txtInsurance_'+n).val(as[0].insurance);
						$('#txtProfit_'+n).val(as[0].profit);
						$('#txtSprice_'+n).val(as[0].cost);
						$('#textTranprice').val(as[0].tranprice);
						$('#txtPrice_'+n).val(as[0].price2);
					}else{
						var cost=dec($('#txtSprice_'+n).val());				
						var tranprice=dec($('#textTranprice').val()); //抓暫存的資料
						var fee=dec($('#textFee').val()); //抓暫存的資料
						var profit=$('#txtProfit_'+n).val();
						var insurance=$('#txtInsurance_'+n).val();
						var commission=$('#txtCommission_'+n).val();
						var payterms= $('#txtPayterms_'+n).val();
						var cost3=0
						var precision=dec(q_getPara('vcc.pricePrecision'));
						switch (payterms) {//P利潤 I保險 C佣金 F運費
							case 'C＆F'://(成本/(1-P)+F) //=CFR   
								cost3=round(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),precision);
								break;
							case 'C＆F＆C'://(成本/(1-P)+F)/(1-C)
								cost3=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(commission,100))),precision);
								break;
							case 'C＆I': //成本/(1-P)/(1-I)
								cost3=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),precision);
								break;
							case 'C＆I＆C'://成本/(1-P)/(1-I)/(1-C)
								cost3=round(q_div(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
								break;
							case 'CIF'://(成本/(1-P)+F)/(1-I)   
								cost3=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),precision);
								break;
							case 'CIF＆C'://(成本/(1-P)+F)/(1-I)/(1-C)
								cost3=round(q_div(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
								break;
							case 'EXW'://成本/(1-P)
								cost3=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
								break;
							case 'FOB'://成本/(1-P)
								cost3=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
								break;
							case 'FOB＆C': //成本/(1-P)/(1-C)
								cost3=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(commission,100))),precision);
								break;
						}
						$('#txtPrice_'+n).val(cost3);
					}
				}
			}
			
			function uncommission(n) {
				var t_commission=q_sub(1,q_div(dec($('#txtCommission_'+n).val()),100));
				$('#txtRadius_'+n).val(round(q_mul(dec($('#txtPrice_'+n).val()),t_commission),q_getPara('vcc.pricePrecision')));
				$('#txtDime_'+n).val($('#txtProfit_'+n).val());
				$('#txtWidth_'+n).val($('#txtCommission_'+n).val());
				$('#txtLengthb_'+n).val($('#txtInsurance_'+n).val());
			}
			
			var ucagroupdivmove = false;
			function move(event){
 				if(ucagroupdivmove){
					var x = event.clientX-sx;
					var y = event.clientY-sy;
					sx = event.clientX;
					sy = event.clientY;
					$('#div_ucagroup').css('top', $('#div_ucagroup').offset().top+y);
					$('#div_ucagroup').css('left', $('#div_ucagroup').offset().left+x);
				}
			}
			
			function ucadivmove(event){
				if(!ucagroupdivmove){
					ucagroupdivmove = true; 
					sx = event.clientX;
					sy = event.clientY;
				}
				else if(ucagroupdivmove)
					ucagroupdivmove = false;
			}
			
			function getpdate(x) {
				if((q_cur==1 || q_cur==2)){
					//106/03/27 根據sys orde.dodate +3 若 單一產品數量超出3000 多1天
					//106/03/28 依據型號 超出模具數多1天
					var t_dodate=$('#txtOdate').val()>q_date()?$('#txtOdate').val():q_date();
					var t_where = "where=^^ noa='orde.dodate' ^^";
					q_gt('qsys', t_where, 0, 0, 0, "",r_accy,1);
					var as = _q_appendData("qsys", "", true);
					if (as[0] != undefined) {
						t_dodate=as[0].value;
					}
					q_gt('holiday', "where=^^ noa>='"+q_date()+"' ^^ stop=100" , 0, 0, 0, "getholiday", r_accy,1);
					var holiday = _q_appendData("holiday", "", true);
					//先加3天
					var t_addday=3;
					var t_productno=$('#txtProductno_'+x).val();
					//該訂單品項總數量超出3000 多1天
					/*var t_mount=0;
					for (var j = 0; j < (dec(x)+1); j++) {
						if($('#txtProductno_'+ j).val()==t_productno){
							t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
						}
					}
					if(t_mount>3000){
						t_addday=q_add(t_addday,Math.floor(t_mount/3000))
					}*/
					
					//106/03/28 依據型號 超出模具數多1天 //找不到模具超過兩萬多一天
					q_gt('model', "where=^^ exists (select * from uca where noa='"+t_productno+"' and (spec=model.noa or spec=REPLACE(REPLACE(model.noa,'WU-',''),'WU',''))) ^^ stop=100" , 0, 0, 0, "getmodel", r_accy,1);
					var as = _q_appendData("model", "", true);
					var modelno='';
					var modelmount=0;//模具數
					var modelgen=0; //模具產能
					if (as[0] != undefined) {
						modelno=as[0].noa;
						modelmount=dec(as[0].mount);
						if(modelmount==0){
							modelmount=1;
						}
						modelgen=q_mul(modelmount,120);
					}
					//讀取表身相同型號的品號
					var modelucc=new Array(); 
					if(modelno.length>0){
						var t_where="";
						for (var j = 0; j < dec(x); j++) {
							if(!emp($('#txtProductno_'+j).val()))
								t_where+=" or noa='"+$('#txtProductno_'+j).val()+"'";
						}
						if(t_where.length>0){
							t_where="(1=0 "+t_where+") and exists (select * from model where noa='"+modelno+"' and (noa=uca.spec or REPLACE(REPLACE(noa,'WU-',''),'WU','')=uca.spec)) "
							q_gt('uca', "where=^^ "+t_where+" ^^ stop=999" , 0, 0, 0, "getuca", r_accy,1);
							modelucc = _q_appendData("uca", "", true);
						}
						var t_mount=dec($('#txtMount_'+x).val());
						for (var j = 0; j < dec(x); j++) {
							if($('#txtProductno_'+ j).val()==t_productno){
								t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
							}else{
								var t_existsmodel=false;
								for(var k=0;k<modelucc.length;k++){
									if($('#txtProductno_'+ j).val()==modelucc[k].noa){
										t_existsmodel=true;
										break;
									}
								}
								if(t_existsmodel){
									t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
								}
							}
						}
						if(t_mount>modelgen){
							t_addday=q_add(t_addday,Math.floor(t_mount/modelgen))
						}
					}else{
						var t_mount=0;
						//找不到模具
						for (var j = 0; j < (dec(x)+1); j++) {
							if($('#txtProductno_'+ j).val()==t_productno){
								t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
							}
						}
						if(t_mount>20000){
							t_addday=q_add(t_addday,Math.floor(t_mount/20000))
						}
					}
					while(t_addday>0){
						t_dodate=q_cdn(t_dodate,1);
						var t_iswork=true;
						var t_holidaywork=false; //假日主檔是否要上班
							
						for(var k=0;k<holiday.length;k++){
							if(holiday[k].noa==t_dodate){
								if(holiday[k].iswork=="true"){
									t_holidaywork=true;
								}else{
									t_iswork=false;
								}
							}
						}
							
						if(!t_holidaywork && t_iswork){
							var week='';
							if(t_dodate.length==10){
								week=new Date(dec(t_dodate.substr(0,4)),dec(t_dodate.substr(5,2))-1,dec(t_dodate.substr(8,2))).getDay()
							}else{
								week=new Date(dec(t_dodate.substr(0,3))+1911,dec(t_dodate.substr(4,2))-1,dec(t_dodate.substr(7,2))).getDay();
							}
									
							if(q_getPara('sys.saturday')!='1' && week==6)
								t_iswork=false;
							if(week==0)
								t_iswork=false;
						}
							
						if(t_iswork){
							t_addday--;
						}
					}
					$('#txtDatea_'+x).val(t_dodate);
				}
			}
			
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
				border-width: 0px;
			}
			.tview {
				width: 100%;
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
				width: 70%;
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
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
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
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
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
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
				float: left;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body onmousemove="move(event);">
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_ordb" style="position:absolute; top:180px; left:20px; display:none; width:1020px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_ordb" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="width:45px;background-color: #f8d463;" align="center">訂序</td>
					<td style="width:200px;background-color: #f8d463;" align="center">品名</td>
					<td style="width:80px;background-color: #f8d463;" align="center">訂單數量</td>
					<td style="width:80px;background-color: #f8d463;" align="center">安全庫存</td>
					<td style="width:80px;background-color: #f8d463;" align="center">庫存數量</td>
					<td style="width:80px;background-color: #f8d463;" align="center">在途數量</td>
					<td style="width:80px;background-color: #f8d463;" align="center">採購數量</td>
					<td style="width:200px;background-color: #f8d463;" align="center">供應商</td>
					<td style="width:80px;background-color: #f8d463;" align="center">進貨單價</td>
				</tr>
				<tr id='ordb_close'>
					<td align="center" colspan='9'>
						<input id="btnClose_div_ordb" type="button" value="確定">
						<input id="btnClose_div_ordb2" type="button" value="取消">
					</td>
				</tr>
			</table>
		</div>
		
		<div id="div_addr2" style="position:absolute; top:244px; left:500px; display:none; width:530px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_addr2" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="width:30px;background-color: #f8d463;" align="center">
						<input class="btn addr2" id="btnAddr_plus" type="button" value='＋' style="width: 30px" />
					</td>
					<td style="width:70px;background-color: #f8d463;" align="center">郵遞區號</td>
					<td style="width:430px;background-color: #f8d463;" align="center">指送地址</td>
				</tr>
				<tr id='addr2_close'>
					<td align="center" colspan='3'>
						<input id="btnClose_div_addr2" type="button" value="確定">
					</td>
				</tr>
			</table>
		</div>
		<div id="div_getprice" style="position:absolute; top:300px; left:500px; display:none; width:600px; background-color: #FFE7CD; ">
			<table id="table_getprice" class="table_row" style="width:100%;" cellpadding='1' cellspacing='0' border='1' >
				<tr style="display: none;">
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">產品</a></td>
					<td align="center" colspan="2"><input id="textProductno" type="text" class="txt c1" disabled="disabled"/></td>
					<td align="center" colspan="3">
						<input id="textProduct" type="text" class="txt c1" disabled="disabled"/>
						<input id="textNoq" type="hidden" class="txt c1" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">單位</a></td>
					<td align="center"><input id="textUnit" type="text" class="txt c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">數量</a></td>
					<td align="center"><input id="textMount" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">產品成本</a></td>
					<td align="center"><input id="textCost" type="text" class="txt num c1"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">單位重</a></td>
					<td align="center"><input id="textUweight" type="text" class="txt num c1"/></td>
					<td align="center"><a id="div_pack2" class="lbl" style="cursor: pointer;color: #4297D7;font-weight: bolder;">包裝方式</a></td>
					<td align="center"><input id="textPackwayno" type="text" class="txt c1" disabled="disabled"/></td>
					<td align="center" colspan="2"><input id="textPackway" type="text" class="txt c1" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">內包裝</a></td>
					<td align="center"><input id="textInmount" type="text" class="txt num c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">外包裝</a></td>
					<td align="center"><input id="textOutmount" type="text" class="txt num c1" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">內包裝重</a></td>
					<td align="center"><input id="textInweight" type="text" class="txt num c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">外包裝重</a></td>
					<td align="center"><input id="textOutweight" type="text" class="txt num c1" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">CBM/CTN</a></td>
					<td align="center"><input id="textCbm" type="text" class="txt num c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">CUFT/CTN</a></td>
					<td align="center"><input id="textCuft" type="text" class="txt num c1" disabled="disabled"/></td>
				</tr>
				<tr style="background-color: #E7FFCD; " >
					<td align="center"><a class="lbl">運費選擇</a></td>
					<td align="center" colspan="5"> </td>
				</tr>
				<tr style="background-color: #E7FFCD; " >
					<td align="center">
						<input type="radio" name="trantype" value="cy" checked> 
						<a class="lbl">CY $</a>
					</td>
					<td align="center"><input id="textCyprice" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">CBM</a></td>
					<td align="center"><input id="textCycbm" type="text" class="txt num c1"/></td>
					<td align="center" colspan="2"> </td>
				</tr>
				<tr style="background-color: #E7FFCD; ">
					<td align="center">
						<input type="radio" name="trantype" value="kg">
						<a class="lbl">KG $</a>
					</td>
					<td align="center"><input id="textKgprice" type="text" class="txt num c1"/></td>
					<td align="center">
						<input type="radio" name="trantype" value="cuft">
						<a class="lbl">Cuft $</a>
					</td>
					<td align="center"><input id="textCuftprice" type="text" class="txt num c1"/></td>
					<td align="center" colspan="2"> </td>
				</tr>
				<tr style="background-color: #E7CDFF; ">
					<td align="center"><a class="lbl">運費成本</a></td>
					<td align="center"><input id="textTranprice" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">其他支出</a></td>
					<td align="center"><input id="textFee" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">成本合計</a></td>
					<td align="center"><input id="textCost2" type="text" class="txt num c1"/></td>
				</tr>
				<tr style="background-color: #EC7DD2; ">
					<td align="center"><a class="lbl">Profit</a></td>
					<td align="center"><input id="textProfit" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
					<td align="center"><a class="lbl">Insurance</a></td>
					<td align="center"><input id="textInsurance" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
					<td align="center"><a class="lbl">Commission</a></td>
					<td align="center"><input id="textCommission" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
				</tr>
				<tr style="background-color: #EC7DD2;display: none;">
					<td align="right"><a class="lbl">$</a></td>
					<td align="center"><input id="textInsurmoney" type="text" class="txt num c1"/></td>
					<td align="right"><a class="lbl">$</a></td>
					<td align="center"><input id="textCommimoney" type="text" class="txt num c1"/></td>
					<td align="right"><a class="lbl">$</a></td>
					<td align="center"><input id="textProfitmoney" type="text" class="txt num c1"/></td>
				</tr>
				<tr style="background-color: #52FDAC;">
					<td align="center"><a class="lbl">價格條件</a></td>
					<td align="center"><select id="combPayterms" class="txt c1" disabled="disabled"> </select></td>
					<td align="center"><a class="lbl">試算單價</a></td>
					<td align="center"><input id="textCost3" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">試算總重量</a></td>
					<td align="center"><input id="textWeight" type="text" class="txt num c1"/></td>
				</tr>
				<tr style="background-color: #F1A0A2;">
					<td align="center" colspan='6'>
						<input id="btnOk_div_getprice" type="button" value="取回單價/重量">
						<input id="btnClose_div_getprice" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="div_ucagroup" style="position:absolute; top:300px; left:500px; display:none; width:680px; background-color: #FFE7CD; " onmousedown="ucadivmove(event);">
			<table id="table_ucagroup" class="table_row" style="width:100%;" cellpadding='1' cellspacing='0' border='1' >
				<tr>
					<td align="center"><a class="lbl">Item No.</a></td>
					<td align="left" colspan="4" class="ucano"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">Description</a></td>
					<td align="left" colspan="4" class="ucaname"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">型號</a></td>
					<td align="left" colspan="4" class="ucaspec"> </td>
				</tr>
				<tr>
					<td align="center" width="110px"><a class="lbl">要件</a></td>
					<td align="center" width="120px"><a class="lbl">編號</a></td>
					<td align="center" width="150px"><a class="lbl">中文</a></td>
					<td align="center" width="150px"><a class="lbl">英文</a></td>
					<td align="center" width="150px"><a class="lbl">越文</a></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">車縫 Đường may</a></td>
					<td align="center" class="groupe no"> </td>
					<td align="center" class="groupe mon"> </td>
					<td align="center" class="groupe memo1"> </td>
					<td align="center" class="groupe memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">車縫線顏色 Màu chỉ may</a></td>
					<td align="center" class="ucolor no"> </td>
					<td align="center" class="ucolor mon"> </td>
					<td align="center" class="ucolor memo1"> </td>
					<td align="center" class="ucolor memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">護片 Phụ kiện</a></td>
					<td align="center" class="groupf no"> </td>
					<td align="center" class="groupf mon"> </td>
					<td align="center" class="groupf memo1"> </td>
					<td align="center" class="groupf memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料1 Da1</a></td>
					<td align="center" class="scolor no"> </td>
					<td align="center" class="scolor mon"> </td>
					<td align="center" class="scolor memo1"> </td>
					<td align="center" class="scolor memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料2 Da2</a></td>
					<td align="center" class="class no"> </td>
					<td align="center" class="class mon"> </td>
					<td align="center" class="class memo1"> </td>
					<td align="center" class="class memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料3 Da3</a></td>
					<td align="center" class="classa no"> </td>
					<td align="center" class="classa mon"> </td>
					<td align="center" class="classa memo1"> </td>
					<td align="center" class="classa memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料4 Da4</a></td>
					<td align="center" class="zinc no"> </td>
					<td align="center" class="zinc mon"> </td>
					<td align="center" class="zinc memo1"> </td>
					<td align="center" class="zinc memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">網烙印 In ép</a></td>
					<td align="center" class="sizea no"> </td>
					<td align="center" class="sizea mon"> </td>
					<td align="center" class="sizea memo1"> </td>
					<td align="center" class="sizea memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">轉印 In ủi</a></td>
					<td align="center" class="source no"> </td>
					<td align="center" class="source mon"> </td>
					<td align="center" class="source memo1"> </td>
					<td align="center" class="source memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">大弓 Gọng</a></td>
					<td align="center" class="groupg no"> </td>
					<td align="center" class="groupg mon"> </td>
					<td align="center" class="groupg memo1"> </td>
					<td align="center" class="groupg memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">中束 Bông</a></td>
					<td align="center" class="grouph no"> </td>
					<td align="center" class="grouph mon"> </td>
					<td align="center" class="grouph memo1"> </td>
					<td align="center" class="grouph memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">座管 Ống yên</a></td>
					<td align="center" class="groupi no"> </td>
					<td align="center" class="groupi mon"> </td>
					<td align="center" class="groupi memo1"> </td>
					<td align="center" class="groupi memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">電鍍 mạ</a></td>
					<td align="center" class="hard no"> </td>
					<td align="center" class="hard mon"> </td>
					<td align="center" class="hard memo1"> </td>
					<td align="center" class="hard memo2"> </td>
				</tr>
				<tr>
					<td align="center" colspan='6'>
						<input id="btnClose_div_ucagroup" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewOdate'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='custno comp,4'>~custno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr class="tr1" style="height: 0px">
						<td class="td1" style="width: 108px;"> </td>
						<td class="td2" style="width: 108px;"> </td>
						<td class="td3" style="width: 108px;"> </td>
						<td class="td4" style="width: 108px;"> </td>
						<td class="td5" style="width: 108px;"> </td>
						<td class="td6" style="width: 108px;"> </td>
						<td class="td7" style="width: 108px;"> </td>
						<td class="td7" style="width: 108px;"> </td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td class="td2"><input id="txtOdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td class="td4"><select id="cmbStype" class="txt c1"> </select></td>
						<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td8" align="center"><input id="btnOrdei" type="button" /></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td class="td5" ><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td class="td6"colspan="2"><input id="txtContract" type="text" class="txt c1"/></td>
						<td class="td8" align="center">
							<input id="btnOrdem" type="button" style="display: none;"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCustno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td class="td6"><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td class="td7">
							<select id="combPaytype" class="txt c1" onchange='combPaytype_chg()' > </select>
						</td>
						<td class="td8" align="center"><input id="btnCredit" type="button" value='' /></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td class="td2" colspan='3'><input id="txtTel" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtFax" type="text" class="txt c1" /></td>
						<td class="td8" align="center">
							<input id="btnQuat" type="button" value='' />
							<input id="txtQuatno" type="hidden" class="txt c1" />
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td class="td2"><input id="txtPost" type="text" class="txt c1"/></td>
						<td class="td3"colspan='4'><input id="txtAddr" type="text" class="txt c1"/></td>
						<td class="td7"><span> </span><a id='lblOrdbno' class="lbl"> </a></td>
						<td class="td8"><input id="txtOrdbno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td class="td2"><input id="txtPost2" type="text" class="txt c1"/></td>
						<td class="td3" colspan='4'>
							<input id="txtAddr2" type="text" class="txt c1" style="width: 412px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
						<td class="td7"><input id="btnAddr2" type="button" value='...' style="width: 30px;height: 21px" /> <span> </span><a id='lblOrdcno' class="lbl"> </a></td>
						<td class="td8"><input id="txtOrdcno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td class="td2" colspan="2">
							<select id="cmbTrantype" class="txt c1" name="D1" > </select>
						</td>
						<td class="td4"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td class="td5" colspan="2">
							<input id="txtSalesno" type="text" class="txt c2"/>
							<input id="txtSales" type="text" class="txt c3"/>
						</td>
						<td class="td7"><span> </span><a id='lblCustorde' class="lbl"> </a></td>
						<td class="td8"><input id="txtCustorde" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td2" colspan='2'>
							<input id="txtMoney" type="text" class="txt c1" style="text-align: center;"/>
						</td>
						<td class="td4"><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td class="td5"><input id="txtTax" type="text" class="txt num c1"/></td>
						<td class="td6"><select id="cmbTaxtype" class="txt c1" onchange='sum()' > </select></td>
						<td class="td7"><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td class="td8"><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td class="td2"><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td class="td3"><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td class="td4"><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td class="td5" colspan='2'><input id="txtTotalus" type="text" class="txt num c1"/></td>
						<td class="td7"><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td class="td8"><input id="txtApv" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblCust2" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCustno2" type="text" class="txt c1"/></td>
						<td class="td3"><input id="txtCust2" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPayterms_r' class="lbl">Price Term</a></td>
						<td colspan="2"><select id="cmbPayterms" class="txt c1"> </select></td>
						<td><span> </span><a id='lblCasetype_r' class="lbl">Cabinet Type</a></td>
						<td><select id="cmbCasetype" class="txt c1"> </select></td>
					</tr>
					<tr class="tr10">
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2" colspan='2'><input id="txtWorker" type="text" class="txt c1" /></td>
						<td class="td4"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td6" colspan='2'><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td colspan="2">
							<input id="chkIsproj" type="checkbox"/>
							<span> </span><a id='lblIsproj'> </a>
							<input id="chkEnda" type="checkbox"/>
							<span> </span><a id='lblEnda'> </a>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'> </a>
						</td>
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id='lblMemo' class='lbl'> </a></td>
						<td class="td2" colspan='7'>
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUpload' class='lbl'> </a></td>
						<td colspan="4">
							<input id="btnUpload" type="file"/>
							<input id="btnDownload" type="button"/>
							<input id="txtUpfile" type="hidden">
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 2100px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:45px;"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" /></td>
					<td align="center" style="width:160px;"><a id='lblProductno_r'>Item No.</a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s_r'>Description</a></td>
					<td align="center" style="width:95px;"><a id='lblMay_r'>車縫線顏色<br>Màu chỉ may</a></td>
					<td align="center" style="width:95px;"><a id='lblDa12_r'>皮料1 Da1<br>皮料2 Da2</a></td>
					<td align="center" style="width:95px;"><a id='lblDa34_r'>皮料3 Da3<br>皮料4 Da4</a></td>
					<td align="center" style="width:95px;"><a id='lblIn_r'>網烙印 In ép<br>轉印 In ủi</a></td>
					<td align="center" style="width:95px;"><a id='lblEle_r'>電鍍<br>mạ</a></td>
					<td align="center" style="width:55px;"><a id='lblUnit_r'>Unit</a></td>
					<td align="center" style="width:85px;"><a id='lblMount_r'>Quantity</a></td>
					<td align="center" style="width:85px;display: none;"><a id='lblCost_s_r'>Cost</a></td>
					<td align="center" style="width:40px;display: none;"><a id='lblGetprice_s'> </a></td>
					<td align="center" style="width:100px;display: none;"><a id='lblPayterms_s'>Price Term</a></td>
					<td align="center" style="width:85px;"><a id='lblPrices_r'>Unit Price</a></td>
					<td align="center" style="width:85px;display: none;"><a id='lblBenifit_s'> </a> %</td>
					<td align="center" style="width:100px;"><a id='lblPackway_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblTotal_s_r'>Amount</a></td>
					<td align="center" style="width:85px;"><a id='lblCuft_s'> </a></td>
					<td align="center" style="width:150px;display: none;" class="isimg"><a id='lblImg_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblGemounts'> </a></td>
					<td align="center" style="width:175px;"><a id='lblMemos_r'>Remark</a></td>
					<td align="center" style="width:110px;">
						<a id='lblDateas'> </a><input id='btnGetpdate' type="button" style="width: 50px;font-size: 12px;font-weight: bold;" value="計算">
						<BR><a id='lblPlanpdate_s'>生管預交日</a>
					</td>
					<td align="center" style="width:43px;"><a id='lblEndas_r'>Closed</a></td>
					<td align="center" style="width:43px;"><a id='lblCancels_r'>Cancel</a></td>
					<td align="center" style="width:43px;"><a id='lblBorn'> </a></td>
					<td align="center" style="width:43px;"><a id='lblNeed'> </a></td>
					<td align="center" style="width:43px;"><a id='lblVccrecord'> </a></td>
					<td align="center" style="width:43px;"><a id='lblOrdemount'> </a></td>
					<td align="center" style="width:43px;"><a id='lblScheduled'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td align="center">
						<input class="txt c6" id="txtProductno.*" maxlength='30'type="text" style="width:98%;" />
						<input class="btn" id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
						<input class="txt c6" id="txtNo2.*" type="text" />
						<input class="btn" id="btnUcagroup.*" type="button" value='要件明細' style="font-size: 10px;" />
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td style="display: none;">
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td><input id="txtUcolor.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtScolor.*" type="text" class="txt c1"/>
						<input id="txtClass.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtClassa.*" type="text" class="txt c1"/>
						<input id="txtZinc.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtSizea.*" type="text" class="txt c1"/>
						<input id="txtSource.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtHard.*" type="text" class="txt c1"/></td>
					<td align="center"><input class="txt c7" id="txtUnit.*" type="text"/></td>
					<td><input class="txt num c7" id="txtMount.*" type="text" /></td>
					<td style="display: none;"><input class="txt num c7" id="txtSprice.*" type="text" /></td>
					<td align="center" style="display: none;"><input class="btn" id="btnGetprice.*" type="button" value='.' style=" font-weight: bold;"/></td>
					<td style="display: none;">
						<input id="txtPayterms.*" type="text" class="txt c1"/>
						<input id="txtSize.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtPrice.*" type="text" class="txt num c1"/>
						<!--<input id="txtProfit.*" type="hidden" class="txt c1 num"/>-->
						<input id="txtCommission.*" type="hidden" class="txt c1 num"/>
						<input id="txtInsurance.*" type="hidden" class="txt c1 num"/>
						
						<input style="display: none;" id="txtRadius.*" type="text" class="txt num c1"/>
						<!--<input id="txtDime.*" type="hidden" class="txt c1 num"/>-->
						<input id="txtWidth.*" type="hidden" class="txt c1 num"/>
						<input id="txtLengthb.*" type="hidden" class="txt c1 num"/>
					</td>
					<td style="display: none;">
						<input id="txtProfit.*" type="text" class="txt c1 num"/>
						<input id="txtDime.*" type="text" class="txt c1 num"/>
					</td>
					<td>
						<input id="txtPackwayno.*" type="text" class="txt c1" style="width: 60%;"/>
						<input class="btn" id="btnPackway.*" type="button" value='.' style=" font-weight: bold;"/>
						<input id="txtPackway.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input class="txt num c7" id="txtTotal.*" type="text" />
						<input class="txt num c7" id="txtBenifit.*" type="text" style="display: none;" />
					</td>
					<td><input class="txt num c7" id="txtCuft.*" type="text" /></td>
					<td class="isimg" style="display: none;"><img id="images.*" style="width: 150px;"></td>
					<td>
						<input class="txt num c1" id="txtC1.*" type="text" />
						<input class="txt num c1" id="txtNotv.*" type="text" />
					</td>
					<td>
						<input class="txt c7" id="txtMemo.*" type="text" />
						<input class="txt" id="txtQuatno.*" type="text" style="width: 70%;" />
						<input class="txt" id="txtNo3.*" type="text" style="width: 20%;"/>
						<input id="recno.*" type="hidden" />
					</td>
					<td>
						<input class="txt c7" id="txtDatea.*" type="text" />
						<input class="txt c7" id="txtIndate.*" type="text" />
					</td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td align="center"><input id="chkCancel.*" type="checkbox"/></td>
					<td align="center"><input class="btn" id="btnBorn.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnNeed.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnVccrecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnOrdemount.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnScheduled.*" type="button" value='.' style=" font-weight: bold;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div style="width:100%;display: none;" id="FileList"> </div>
		<iframe id="xdownload" style="display:none;"> </iframe>
	</body>
</html>