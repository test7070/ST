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
			q_tables = 't';
			var q_name = "ordc";
			var q_readonly = ['txtTgg', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2','textXyodatea'];
			var q_readonlys = ['txtNo2', 'txtC1', 'txtNotv','txtOmount','chkEnda','txtStdmount','txtTotal','txtOrdbno','txtNo3'];
			var q_readonlyt = [];

			var bbmNum = [
				['txtFloata', 10, 5, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1],
				['txtTotal', 10, 0, 1], ['txtTotalus', 10, 0, 1], ['txtOverrate', 5, 2, 1],
			];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 14;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Odate';
			aPop = new Array(
				['txtProductno1_', 'btnProduct1_', 'ucaucc2', 'noa,product,unit,spec,stdmount', 'txtProductno1_,txtProduct_,txtUnit_,txtSpec_,txtStdmount_,txtMount_', 'ucaucc2_b.aspx'],
				['txtProductno2_', 'btnProduct2_', 'bcc', 'noa,product,unit', 'txtProductno2_,txtProduct_,txtUnit_,txtMount_', 'bcc_b.aspx'],
				['txtProductno3_', 'btnProduct3_', 'fixucc', 'noa,namea,unit', 'txtProductno3_,txtProduct_,txtUnit_,txtMount_', 'fixucc_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp,addr', 'txtCno,txtAcomp,txtAddr2', 'acomp_b.aspx'],
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp,trantype,paytype,salesno,sales,tel,fax,zip_comp,addr_comp'
				, 'txtTggno,txtTgg,cmbTrantype,txtPaytype,txtSalesno,txtSales,txtTel,txtFax,txtPost,txtAddr,txtPost2', 'tgg_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no2'];
				bbtKey = ['noa', 'noq'];
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
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				var t_money = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					if($('#chkAprice_'+j).prop('checked')){
						if(q_float('txtMount_' + j)==0)
							q_tr('txtPrice_' + j, 0);
						else
							q_tr('txtPrice_' + j, round(q_div(q_float('txtTotal_' + j), q_float('txtMount_' + j)), 2));
					}else{
						q_tr('txtTotal_' + j, q_mul(q_float('txtMount_' + j), q_float('txtPrice_' + j)));
					}
					q_tr('txtNotv_' + j, q_sub(q_float('txtMount_' + j), q_float('txtC1' + j)));
					t_money = q_add(t_money, q_float('txtTotal_' + j));
				}
				q_tr('txtMoney', t_money);
				q_tr('txtTotal', q_add(q_float('txtMoney'), q_float('txtTax')));
				q_tr('txtTotalus', q_mul(q_float('txtTotal'), q_float('txtFloata')));

				calTax();
			}

			function mainPost() {
				if (q_getPara('sys.project').toUpperCase()=='RB'){
					aPop = new Array(
						['txtProductno1_', 'btnProduct1_', 'ucc', 'noa,product,unit,spec,stdmount', 'txtProductno1_,txtProduct_,txtUnit_,txtSpec_,txtStdmount_,txtMount_', 'ucc_b2.aspx'],
						['txtProductno2_', 'btnProduct2_', 'bcc', 'noa,product,unit', 'txtProductno2_,txtProduct_,txtUnit_,txtMount_', 'bcc_b.aspx'],
						['txtProductno3_', 'btnProduct3_', 'fixucc', 'noa,namea,unit', 'txtProductno3_,txtProduct_,txtUnit_,txtMount_', 'fixucc_b.aspx'],
						['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
						['txtCno', 'lblAcomp', 'acomp', 'noa,acomp,addr', 'txtCno,txtAcomp,txtAddr2', 'acomp_b.aspx'],
						['txtTggno', 'lblTgg', 'tgg', 'noa,comp,trantype,paytype,salesno,sales,tel,fax,zip_comp,addr_comp'
						, 'txtTggno,txtTgg,cmbTrantype,txtPaytype,txtSalesno,txtSales,txtTel,txtFax,txtPost,txtAddr,txtPost2', 'tgg_b.aspx']
					);
					$('.rbhide').hide();
				}
				if (q_getPara('sys.project').toUpperCase()=='XY' ){
					aPop = new Array(
						['txtProductno1_', 'btnProduct1_', 'ucc_xy', 'noa,product,unit,spec,stdmount', 'txtProductno1_,txtProduct_,txtUnit_,txtSpec_,txtStdmount_,txtMount_', 'ucaucc_b.aspx'],
						['txtProductno2_', 'btnProduct2_', 'bcc', 'noa,product,unit', 'txtProductno2_,txtProduct_,txtUnit_,txtMount_', 'bcc_b.aspx'],
						['txtProductno3_', 'btnProduct3_', 'ucc_xy', 'noa,namea,unit,spec,stdmount', 'txtProductno3_,txtProduct_,txtUnit_,txtSpec_,txtStdmount_,txtMount_', 'ucaucc_b.aspx'],
						['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
						['txtCno', 'lblAcomp', 'acomp', 'noa,acomp,addr', 'txtCno,txtAcomp,txtAddr2', 'acomp_b.aspx'],
						['txtTggno', 'lblTgg', 'tgg', 'noa,comp,trantype,paytype,salesno,sales,tel,fax,zip_comp,addr_comp'
						, 'txtTggno,txtTgg,cmbTrantype,txtPaytype,txtSalesno,txtSales,txtTel,txtFax,txtPost,txtAddr,txtPost2', 'tgg_b.aspx'],
						['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx']
					);
					$('.isXY').show();
					q_readonlys.push('txtUnit');
				}
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd], ['txtTrandate', r_picd], ['txtEtd', r_picd], ['txtEta', r_picd], ['txtOnboarddate', r_picd]];
				bbsMask = [['txtTrandate', r_picd]];
				bbsNum = [['txtMount', 10, q_getPara('rc2.mountPrecision'), 1], ['txtPrice', 10, q_getPara('rc2.pricePrecision'), 1], ['txtTotal', 10, 0, 1], ['txtOmount', 10, q_getPara('rc2.mountPrecision'), 1]	,
								['txtStdmount', 10, q_getPara('rc2.mountPrecision'), 1],['txtC1', 10, q_getPara('rc2.mountPrecision'), 1],['txtNotv', 10, q_getPara('rc2.mountPrecision'), 1]];
				q_mask(bbmMask);
				q_cmbParse("cmbKind", q_getPara('ordc.kind'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				
				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				$('#cmbKind').change(function() {
					for (var j = 0; j < q_bbsCount; j++) {
						btnMinus('btnMinus_' + j);
					}
					product_change();
				});
				$('#lblOrdb').click(function() {
					var t_tggno = trim($('#txtTggno').val());
					var t_ordbno = trim($('#txtOrdbno').val());
					var t_where = '';
					
					if (q_getPara('sys.project').toUpperCase()=='XY' ) {
						t_where = "isnull(b.enda,0)!=1 and isnull(b.cancel,0)!=1 and b.datea>='"+q_date()+"' and b.mount!=0 ";
						t_where = t_where+ q_sqlPara2("a.tggno", t_tggno)  + q_sqlPara2("a.noa", t_ordbno) ;
						t_where = t_where+" and a.kind='" + $('#cmbKind').val() + "' ";
					}else {
						t_where = "isnull(b.enda,0)!=1 and isnull(b.cancel,0)!=1 " 
						+ q_sqlPara2("a.tggno", t_tggno)  + q_sqlPara2("a.noa", t_ordbno) + " and a.kind='" + $('#cmbKind').val() + "'";
						t_where = t_where;
					}
					
					q_box("ordbs_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordbs', "95%", "95%", $('#lblOrdb').text());
				});
				$('#txtFloata').change(function() {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				$('#txtTggno').change(function() {
					if (!emp($('#txtTggno').val())) {
						var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^ stop=100";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
					if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtTggno').val()) ) {
						for(var i=0;i<q_bbsCount;i++){
							if(!emp($('#txtProductno1_'+i).val())){
								var t_where = "where=^^ tggno='" + $('#txtTggno').val() + "' and productno='"+$('#txtProductno1_'+i).val()+"' ^^";
								q_gt('ucctgg', t_where, 0, 0, 0, "ucctgg_"+i);
							}
						}
					}
					if(q_getPara('sys.project').toUpperCase()=='XY'){
						var t_where =" noa='"+$('#txtTggno').val()+"'";
						q_gt('tgg', "where=^^ "+t_where+" ^^", 0, 0, 0, "xytggdata");
					}
				});
				$('#txtAddr').change(function() {
					var t_tggno = trim($(this).val());
					if (!emp(t_tggno)) {
						focus_addr = $(this).attr('id');
						zip_fact = $('#txtPost').attr('id');
						var t_where = "where=^^ noa='" + t_tggno + "' ^^";
						q_gt('tgg', t_where, 0, 0, 0, "");
					}
				});
				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						zip_fact = $('#txtPost2').attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				$('#btnImport').click(function() {
					if ($('#btnImport').val() == '進口欄位顯示') {
						$('.import').show();
						$('#btnImport').val('進口欄位隱藏');
					} else {
						$('.import').hide();
						$('#btnImport').val('進口欄位顯示');
					}
				});
				$('#txtOdate').focusout(function(){
					var thisVal = $.trim($(this).val());
					if(checkId(thisVal) != 0){
						$('#txtDatea').val(q_cdn(thisVal,20));
					}
				});
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
				//105/08/15 顯示第一個品項的訂單預交日
				if(q_getPara('sys.project').toUpperCase()=='XY'){
					$('#lblXyodatea').text('訂單預交日');
				}
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordbs':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							//取得請購的資料
							var t_where = "where=^^ noa='" + b_ret[0].noa + "' ^^";
							q_gt('ordb', t_where, 0, 0, 0, "", r_accy);
							$('#txtOrdbno').val(b_ret[0].noa);
							for (var i=0; i<b_ret.length;i++){
								b_ret[i].notv=q_sub(dec(b_ret[i].mount),dec(b_ret[i].c1));
							}
							
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtOrdbno,txtNo3,txtPrice,txtMount,txtTotal,txtMemo,txtUnit,txtSpec,txtCustno,txtComp', b_ret.length, b_ret, 'productno,product,noa,no3,price,notv,total,memo,unit,spec,custno,comp', 'txtProductno,txtProduct');
							
							//取第一個廠商資料
							if (q_getPara('sys.project').toUpperCase()=='XY' ){
								var xy_tggno='';
								var t_ordeno='',t_no2='';
								var t_moretgg=false;
								for (var i=0; i<b_ret.length;i++){
									if(b_ret[i].tggno_xy.length>0 && xy_tggno.length==0){
										xy_tggno=b_ret[i].tggno_xy;
									}
									if(xy_tggno.length>0 && b_ret[i].tggno_xy.length>0 && xy_tggno!=b_ret[i].tggno_xy){
										t_moretgg=true;
									}
									if(t_ordeno.length==0){
 										t_ordeno=b_ret[i].ordeno;
										t_no2=b_ret[i].no2;
									}
								}
								if(t_moretgg){
									alert('匯入請購單，含多個不同採購廠商!!');
								}
								if(xy_tggno.length>0){
									$('#txtTggno').val(xy_tggno);
									var t_where =" noa='"+$('#txtTggno').val()+"'";
									q_gt('tgg', "where=^^ "+t_where+" ^^", 0, 0, 0, "ordbxytgg",r_accy);
									$('#txtTggno').change();
								}
								//105/08/15 取得訂單預交日
								if(t_ordeno.length>0){
									var t_where =" noa='"+t_ordeno+"' and no2='"+t_no2+"'";
									q_gt('view_ordes', "where=^^ "+t_where+" ^^", 0, 0, 0, "xyordesdatea",r_accy);
								}
							}
							bbsAssign();
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

			var focus_addr = '', zip_fact = '';
			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ordbxytgg':
						var as = _q_appendData("tgg", "", true);
						if (as[0] != undefined) {
							$('#txtTgg').val(as[0].comp);
							$('#cmbTrantype').val(as[0].trantype);
							$('#txtPaytype').val(as[0].paytype);
							$('#txtSalesno').val(as[0].salesno);
							$('#txtSales').val(as[0].sales);
							$('#txtTel').val(as[0].tel);
							$('#txtFax').val(as[0].fax);
							$('#txtPost').val(as[0].zip_comp);
							$('#txtAddr').val(as[0].addr_comp);
							$('#cmbTaxtype').val(as[0].conn);
						}
						break;
					case 'xyordesdatea':
						var as = _q_appendData("view_ordes", "", true);
						if (as[0] != undefined) {
							$('#textXyodatea').val(as[0].datea);
						}else{
							$('#textXyodatea').val('');
						}
						break;
					case 'xytggdata':
						var as = _q_appendData("tgg", "", true);
						if (as[0] != undefined) {
							$('#cmbTaxtype').val(as[0].conn);
							
							if(as[0].typea.indexOf('合約')==-1){
								$('#txtOverrate').val(10);
							}
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
					case 'tgg':
						var as = _q_appendData("tgg", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + zip_fact).val(as[0].zip_fact);
							$('#' + focus_addr).val(as[0].addr_fact);
							zip_fact = '';
							focus_addr = '';
						}
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + zip_fact).val(as[0].zip_fact);
							$('#' + focus_addr).val(as[0].addr_fact);
							zip_fact = '';
							focus_addr = '';
						}
						break;
					case 'ordb':
						var ordb = _q_appendData("ordb", "", true);
						if (ordb[0] != undefined) {
							$('#combPaytype').val(ordb[0].paytype);
							$('#txtPaytype').val(ordb[0].pay);
							$('#cmbTrantype').val(ordb[0].trantype);
							$('#cmbCoin').val(ordb[0].coin);
							$('#txtPost2').val(ordb[0].post);
							$('#txtAddr2').val(ordb[0].addr);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if(t_name.substr(0,7)=='ucctgg_'){
					var t_seq=replaceAll(t_name,'ucctgg_','')
					var t_mount=dec($("#txtMount_"+t_seq).val());
					var t_price=[];
					var as = _q_appendData("ucctgg", "", true);
					if (as[0] != undefined) {
						var ass = _q_appendData("ucctggs", "", true);
						if (ass[0] != undefined) {
							for(var j=0;j<ass.length;j++){
								if(t_mount>=dec(ass[j].mount)){
									t_price.push({
										mount:dec(ass[j].mount),
										price:ass[j].price
									})
								}
							}
							if(t_price.length>0){
								t_price.sort(compare);
								$("#txtPrice_"+t_seq).val(t_price[t_price.length-1].price);
							}else{
								$("#txtPrice_"+t_seq).val(0);
							}
						}
					}
					sum();
				}
				
			}
			
			function compare(a,b) {
				if (a.mount < b.mount)
					return -1;
				if (a.mount > b.mount)
					return 1;
				return 0;
			}

			function btnOk() {
				$('#txtDatea').val($.trim($('#txtDatea').val()));
				if (checkId($('#txtDatea').val()) == 0) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				$('#txtOdate').val($.trim($('#txtOdate').val()));
				if (checkId($('#txtOdate').val()) == 0) {
					alert(q_getMsg('lblOdate') + '錯誤。');
					return;
				}
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
						if($('#chkCancel').prop('checked'))
							$('#chkCancel_'+j).prop('checked','true');
					}
				}
				//(BBS,BBT) 【取消】  同步
				for(var i=0;i<q_bbsCount;i++){
				    t_cancel = $('#chkCancel_'+i).prop('checked');
				    t_no2 = $.trim($('#txtNo2_'+i).val());
			        if(t_no2.length>0){
			            for(var j=0;j<q_bbtCount;j++){
			                if($.trim($('#txtNo2__'+j).val())== t_no2)
			                    $('#chkCancel__'+j).prop('checked',t_cancel);
			            }
			        }
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
				
				if(emp($('#txtTrandate').val()) && q_getPara('sys.project').toUpperCase()!='XY'){
					$('#txtTrandate').val(q_cdn(q_date(),10));
				}
				
				var t_xy_pricezero=false;
				for (var j = 0; j < q_bbsCount; j++) {
					if(!emp($('#txtProductno_' + j).val()) && emp($('#txtTrandate_'+j).val()))
						$('#txtTrandate_'+j).val($('#txtTrandate').val());
						
					if(q_cur==1)
						$('#txtOmount_'+j).val($('#txtMount_'+j).val());
						
					if(dec($('#txtMount_'+j).val())>0 && dec($('#txtPrice_'+j).val())==0){
						t_xy_pricezero=true;
					}
				}
				
				if (q_getPara('sys.project').toUpperCase()=='XY' && t_xy_pricezero) {
					alert('進貨品項單價等於0!!');
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
							
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordc') + $('#txtOdate').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ordc_s.aspx', q_name + '_s', "520px", "450px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype")
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
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtOdate').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
				    $('#lblNo_'+j).text(j+1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtUnit_' + j).change(function() {
							sum();
						});
						$('#txtUno_' + j).change(function(e) {
							if ($('#cmbTypea').val() != '2') {
								var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
								var t_uno = $.trim($(this).val());
								var t_noa = $.trim($('#txtNoa').val());
								q_gt('uccy', "where=^^uno='" + t_uno + "' and not(gform='ordcs' and gnoa='" + t_noa + "')^^", 0, 0, 0, 'checkUno_' + n);
							}
						});
						$('#txtMount_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtTggno').val()) &&!emp($('#txtProductno1_'+n).val())) {
								var t_where = "where=^^ tggno='" + $('#txtTggno').val() + "' and productno='"+$('#txtProductno1_'+n).val()+"' ^^";
								q_gt('ucctgg', t_where, 0, 0, 0, "ucctgg_"+n, r_accy,1);
								
								var t_mount=dec($("#txtMount_"+n).val());
								var t_price=[];
								var as = _q_appendData("ucctgg", "", true);
								if (as[0] != undefined) {
									var ass = _q_appendData("ucctggs", "", true);
									if (ass[0] != undefined) {
										for(var k=0;k<ass.length;k++){
											if(t_mount>=dec(ass[k].mount)){
												t_price.push({
													mount:dec(ass[k].mount),
													price:ass[k].price
												})
											}
										}
										if(t_price.length>0){
											t_price.sort(compare);
											$("#txtPrice_"+n).val(t_price[t_price.length-1].price);
										}else{
											$("#txtPrice_"+n).val(0);
										}
									}
								}
								
							}
							sum();
							if(q_getPara('sys.project').toUpperCase()=='XY'){
								var t_max_unit='';
								var t_max_inmout=0;
								var t_unit=$('#txtUnit_'+n).val();
								var t_inmount=0;
								var t_mount=dec($('#txtMount_'+n).val());
	                            var t_where = "where=^^noa='"+$('#txtProductno1_'+n).val()+"'^^";
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
									$('#txtMemo_'+n).val(t_m1+t_max_unit+(t_m2>0?('+'+t_m2+t_unit):''));
								}else{
									$('#txtMemo_'+n).val('');
								}
								
								if(dec($('#txtTotal_'+n).val())==0){
									alert($('#txtProduct_'+n).val()+' 產品小計金額等於0，請確認輸入數量是否正確!!');
								}else if(dec($('#txtTotal_'+n).val())>50000){
									alert($('#txtProduct_'+n).val()+' 產品小計金額大於50000，請確認輸入數量是否正確!!');
								}
							}
						});
						$('#txtPrice_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							sum();
							
							//106/07/24 判斷 金額=0 或超過50000
							if(q_getPara('sys.project').toUpperCase()=='XY'){
								if(dec($('#txtTotal_'+n).val())==0){
									alert($('#txtProduct_'+n).val()+' 產品小計金額等於0，請確認輸入單價是否正確!!');
								}else if(dec($('#txtTotal_'+n).val())>50000){
									alert($('#txtProduct_'+n).val()+' 產品小計金額大於50000，請確認輸入單價是否正確!!');
								}
							}
						});
						$('#txtTotal_' + j).change(function() {
							sum();
						});
						$('#btnRc2record_' + j).click(function() {
							var n = replaceAll($(this).attr('id'),'btnRc2record_','');
                            q_box("z_rc2record.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";ordcno="+$('#txtNoa').val()+"&no2="+$('#txtNo2_' + n).val()+";" + r_accy, 'z_rc2record', "95%", "95%", q_getMsg('popPrint'));    
						});
						
						$('#txtProductno1_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtTggno').val()) &&!emp($('#txtProductno1_'+n).val())) {
								var t_where = "where=^^ tggno='" + $('#txtTggno').val() + "' and productno='"+$('#txtProductno1_'+n).val()+"' ^^";
								q_gt('ucctgg', t_where, 0, 0, 0, "ucctgg_"+n);
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
						
						$('#chkAprice_'+j).click(function(e){refreshBbs();});
						
						$('#txtOrdbno_'+j).bind('contextmenu',function(e) {
	                    	/*滑鼠右鍵*/
	                    	e.preventDefault();
	                    	t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
	                    	q_box("ordb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + r_accy, 'ordb', "95%", "95%", '請購作業');
	                   });
					}
				}
				_bbsAssign();
				product_change();
				refreshBbs();
				$('#lblAprice_s').text('自訂金額');
			}
			
			function refreshBbs(){
				if(q_getPara('sys.project').toUpperCase()=='RB'){
					$('.aprice').show();
				}else{
					$('.aprice').hide();
				}
				if(q_getPara('sys.project').toUpperCase()!='XY'){
					$('.isCust').hide();
				}
				if (q_getPara('sys.project').toUpperCase().substr(0,2)!='AD'){
					$('.isAD').hide();
				}
				//金額小計自訂
				for(var i=0;i<q_bbsCount;i++){
					$('#txtTotal_'+i).attr('readonly','readonly');
					if($('#chkAprice_'+i).prop('checked')){
						$('#txtTotal_'+i).css('color','black').css('background-color','white');
						if(q_cur==1 || q_cur==2)
							$('#txtTotal_'+i).removeAttr('readonly');
					}else{
						$('#txtTotal_'+i).css('color','green').css('background-color','rgb(237,237,237)');
					}
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
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtDatea').val(q_cdn(q_date(),20));
				$('#txtOdate').focus();
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				product_change();
				if (!emp($('#txtTggno').val())) {
					var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^ stop=100";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					//1050223 預設送貨地址
					$('#txtPost2').val('333');
					$('#txtAddr2').val('桃園市龜山區綠野街88號 廖秀雲小姐');
					$('#txtTrandate').val(q_cdn(q_date(),1));
				}
				
				$('#cmbKind').val('1').change();
			}
			
			var xy_modimount=false;
			function btnModi() {
				var t_noa = $.trim($('#txtNoa').val());
				if (emp(t_noa))
					return;
					
				q_gt('view_rc2s', "where=^^ ordeno='" + t_noa + "' ^^", 0, 0, 0, "istorc2",r_accy,1);
				var as = _q_appendData("view_rc2s", "", true);
				if(as[0]!=undefined){
					if (q_getPara('sys.project').toUpperCase()=='XY' ){//105/05/03 開放只能修改數量
						xy_modimount=true;
					}else{
						alert('採購單【'+t_noa+'】已轉進貨單，禁止修改!!');
						return;
					}
				}
				
				_btnModi();
				$('#txtProduct').focus();
				product_change();
				if (!emp($('#txtTggno').val())) {
					var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^ stop=100";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
				
				if(xy_modimount){ //105/09/07 不限制單位和單價 要補資料
					$('#btnPlus').attr('disabled', 'disabled');
					for(var i=0;i<q_bbsCount;i++){
						$('#btnMinus_'+i).attr('disabled', 'disabled');
						if(r_rank<8){
							$('#txtProductno1_'+i).attr('disabled', 'disabled');
							$('#btnProduct1_'+i).attr('disabled', 'disabled');
							$('#txtProductno2_'+i).attr('disabled', 'disabled');
							$('#btnProduct2_'+i).attr('disabled', 'disabled');
							$('#txtProductno3_'+i).attr('disabled', 'disabled');
							$('#btnProduct3_'+i).attr('disabled', 'disabled');
						}
						$('#txtProduct_'+i).attr('disabled', 'disabled');
						$('#txtSpec_'+i).attr('disabled', 'disabled');
						//$('#txtUnit_'+i).attr('disabled', 'disabled');
						$('#txtStyle_'+i).attr('disabled', 'disabled');
						//$('#txtPrice_'+i).attr('disabled', 'disabled');
						$('#txtTrandate_'+i).attr('disabled', 'disabled');
						$('#txtMemo_'+i).attr('disabled', 'disabled');
						$('#txtOrdbno_'+i).attr('disabled', 'disabled');
						$('#txtNo3_'+i).attr('disabled', 'disabled');
					}
				}
				xy_modimount=false;
			}

			function btnPrint() {
				q_box("z_ordcp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'z_ordcp', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['productno1'] && !as['productno2'] && !as['productno3'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				as['kind'] = abbm2['kind'];
				as['tggno'] = abbm2['tggno'];
				as['odate'] = abbm2['odate'];
				as['trandate'] = abbm2['trandate'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				product_change();
				if (!emp($('#txtLcno').val())) {
					$('.import').show();
					$('#btnImport').val('進口欄位隱藏');
				} else {
					$('.import').hide();
					$('#btnImport').val('進口欄位顯示');
				}
				
				if (q_getPara('sys.project').toUpperCase()=='TN'){
					$('#lblOrdb').hide();
					$('#txtOrdbno').hide();
					$('.floata').hide();
				}
				

				
				if (q_getPara('sys.project').toUpperCase()=='XY' ){
					var t_ordbno='',t_no3='';
					for (var i = 0; i < q_bbsCount; i++) {
						t_ordbno=$('#txtOrdbno_'+i).val();
						t_no3=$('#txtNo3_'+i).val();
						if(t_ordbno.length>0)
							break;
					}
					if(t_ordbno.length>0){
						var t_where =" noa='"+t_ordbno+"' and no3='"+t_no3+"'";
						var t_where ="exists (select * from view_ordbs where noa='"+t_ordbno+"' and no3='"+t_no3+"' and a.noa=ordeno and a.no2=no2)"
						q_gt('view_ordes', "where=^^ "+t_where+" ^^", 0, 0, 0, "xyordesdatea",r_accy);
						/*var as = _q_appendData("view_ordes", "", true);
						if (as[0] != undefined) {
 							$('#textXyodatea').val(as[0].datea);
						}else{
							$('#textXyodatea').val('');
						}*/
					}
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#btnOrdb').attr('disabled', 'disabled');
					$('#combAddr').attr('disabled', 'disabled');
					$('#txtTrandate').datepicker( 'destroy' );
				} else {
					$('#btnOrdb').removeAttr('disabled');
					$('#combAddr').removeAttr('disabled');
					$('#txtTrandate').datepicker();
				}
				
				if (q_getPara('sys.project').toUpperCase()=='XY' ){
					$('#cmbKind').attr('disabled', 'disabled');
				}
				
				product_change();
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
			function btnPlut(org_htm, dest_tag, afield) {
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
				q_gt('view_rc2s', "where=^^ ordeno='" + $('#txtNoa').val() + "' ^^", 0, 0, 0, "istorc2",r_accy,1);
				var as = _q_appendData("view_rc2s", "", true);
				if(as[0]!=undefined){
					alert('採購單【'+t_noa+'】已轉進貨單，禁止修改!!');
					return;
				}
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function product_change() {
				if ($('#cmbKind').val() == '3') {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#btnProduct1_' + j).hide();
						$('#btnProduct2_' + j).hide();
						$('#btnProduct3_' + j).show();
						$('#txtProductno1_' + j).hide();
						$('#txtProductno2_' + j).hide();
						$('#txtProductno3_' + j).show();
						$('#txtProductno3_' + j).val($('#txtProductno_' + j).val());
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
						$('#btnProduct1_' + j).show();
						$('#btnProduct2_' + j).hide();
						$('#btnProduct3_' + j).hide();
						$('#txtProductno1_' + j).show();
						$('#txtProductno2_' + j).hide();
						$('#txtProductno3_' + j).hide();
						$('#txtProductno1_' + j).val($('#txtProductno_' + j).val());
					}
				}
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
			}

			function checkId(str) {
				if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
					var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
					var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
					var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
					if ((n % 10) == 0)
						return 1;
				} else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
					var key = '12121241';
					var n = 0;
					var m = 0;
					for (var i = 0; i < 8; i++) {
						n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
						m += Math.floor(n / 10) + n % 10;
					}
					if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
						return 2;
				} else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
					if (regex.test(str))
						return 3;
				} else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
					str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
					if (regex.test(str))
						return 4
				}
				return 0;
				//錯誤
			}

			function q_popPost(id) {
				switch (id) {
					case 'txtTggno':
						if (!emp($('#txtTggno').val())) {
							var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
							if(q_getPara('sys.project').toUpperCase()=='XY'){
								var t_where =" noa='"+$('#txtTggno').val()+"'";
								q_gt('tgg', "where=^^ "+t_where+" ^^", 0, 0, 0, "xytggdata");
							}
							
							if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#txtTggno').val()) ) {
								for(var i=0;i<q_bbsCount;i++){
									if(!emp($('#txtProductno1_'+i).val())){
										var t_where = "where=^^ tggno='" + $('#txtTggno').val() + "' and productno='"+$('#txtProductno1_'+i).val()+"' ^^";
										q_gt('ucctgg', t_where, 0, 0, 0, "ucctgg_"+i);
									}
								}
							}
						}
						break;
					case 'txtProductno1_':
						$('#txtProductno_'+b_seq).val($('#txtProductno1_'+b_seq).val());
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
					default:
						break;
				}
				id='';
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
					
				//有達自動產生便品//1041109 暫時不產生
				/*if(q_getPara('sys.project').toUpperCase()=='XY'){
					var isordc_ucc=false;
					for (var j = 0; j < q_bbsCount; j++) {
						if(!emp($('#txtProduct_'+j).val()) && emp($('#txtProductno_'+j).val())){
							isordc_ucc=true;
							break;
						}
					}
					if(isordc_ucc){
						var t_paras = $('#txtNoa').val()+ ';'+r_accy;
						q_func('qtxt.query.ordc_ucc', 'cust_ucc_xy.txt,ordc_ucc,' + t_paras);
					}
				}*/
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.ordc_ucc':
						//var as = _q_appendData("tmp0", "", true, true);
						var s2=[];
						s2[0]=q_name + '_s';
						s2[1]="where=^^ noa<='"+$('#txtNoa').val()+"' ^^"
						q_boxClose2(s2);
						break;
					default:
						break;
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
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
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
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 37%;
				float: left;
			}
			.txt.c3 {
				width: 57%;
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
				width: 25%;
			}
			.txt.c7 {
				width: 60%;
				float: left;
			}
			.txt.c8 {
				width: 48%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			.dbbs {
				width: 1600px;
			}
			.tbbs a {
				font-size: medium;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt.lef {
				float: left;
			}
			.import {
				background: #FFAA33;
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
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewOdate'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tggno tgg,4'>~tggno ~tgg,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr>
						<td style="width: 108px;"><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td style="width: 108px;"><select id="cmbKind" class="txt c1 lef"> </select></td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td style="width: 108px;"><input id="txtOdate" type="text" class="txt c1 lef"/></td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td style="width: 108px;"><input id="txtDatea" type="text" class="txt c1 lef"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn" > </a></td>
						<td colspan="5">
							<input id="txtCno" type="text" class="txt c4 lef"/>
							<input id="txtAcomp"type="text" class="txt c5 lef" />
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"	type="text" class="txt c1 lef"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="5">
							<input id="txtTggno" type="text" class="txt c4 lef"/>
							<input id="txtTgg" type="text" class="txt c5 lef"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1 lef" name="D1" > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" class="txt c2 lef"/>
							<input id="txtSales" type="text" class="txt c7 lef"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtPaytype" type="text" class="txt c8 lef"/>
							<select id="combPaytype" class="txt c8 lef" onchange='combPaytype_chg()'> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan='2'><input id="txtTel" type="text" class="txt c1 lef"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan='2'><input id="txtFax" type="text" class="txt c1 lef"/></td>
						<td style="display: none;" class="isXY"><span> </span><a id='lblXyodatea' class="lbl"> </a></td>
						<td style="display: none;" class="isXY"><input id="textXyodatea" type="text" class="txt c1 lef"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td><input id="txtPost" type="text"	class="txt c1 lef"/></td>
						<td colspan='4'>
							<input id="txtAddr" type="text" class="txt c1 lef" style="width: 98%;"/>
						</td>
						<td><span> </span><a id='lblOrdb' class="lbl btn"> </a></td>
						<td><input id="txtOrdbno" type="text" class="txt c1 lef" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td><input id="txtPost2" type="text" class="txt c1 lef"/></td>
						<td colspan='4' >
							<input id="txtAddr2" type="text" class="txt c1 lef" style="width: 412px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
						<td><span> </span><a id='lblTrandate' class="lbl"> </a></td>
						<td><input id="txtTrandate" type="text" class="txt c1 lef"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMoney" type="text" class="txt num c1 lef" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1 lef" /></td>
						<td><select id="cmbTaxtype" class="txt c1" onchange='sum()' > </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1 lef" /></td>
					</tr>
					<tr class="floata">
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1 lef" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt num c1 lef" /></td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTotalus" type="text" class="txt num c1 lef" /></td>
						<td> </td>
						<td class="rbhide"><input id="btnImport" type="button"/></td>
						<!--<td><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td><input id="txtApv" type="text" class="txt c1 lef" disabled="disabled" /></td>-->
					</tr>
					<tr class="import">
						<td><span> </span><a id='lblLcno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtLcno" type="text"	class="txt c1 lef"/></td>
						<td><span> </span><a id='lblImportno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtImportno" type="text"	class="txt c1 lef"/></td>
						<td> </td>
						<td><!--<input id="btnSi" type="button"/>--></td>
					</tr>
					<tr class="import">
						<td><span> </span><a id='lblEtd' class="lbl"> </a></td>
						<td colspan="2"><input id="txtEtd" type="text"	class="txt c1 lef"/></td>
						<td><span> </span><a id='lblEta' class="lbl"> </a></td>
						<td colspan="2"><input id="txtEta" type="text"	class="txt c1 lef"/></td>
						<td><span> </span><a id='lblOnboarddate' class="lbl"> </a></td>
						<td><input id="txtOnboarddate" type="text"	class="txt c1 lef"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td colspan="2"><input id="txtContract" type="text" class="txt c1 lef"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1 lef" /></td>
						<td><input id="txtWorker2" type="text" class="txt c1 lef" /></td>
						<td colspan="2" align="right">
							<input id="chkIsproj" type="checkbox"/>
							<a id='lblIsproj' style="width: 50%;"> </a><span> </span>
							<input id="chkEnda" type="checkbox"/>
							<a id='lblEnd' style="width: 40%;"> </a><span> </span>
							<input id="chkCancel" type="checkbox"/>
                            <a id='lblCancel' style="width: 50%;">取消</a><span> </span>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='5'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
						<td class="rbhide"><span> </span><a id='lblOverrate' class="lbl"> </a></td>
						<td class="rbhide"><input id="txtOverrate" type="text" class="txt num c1"  style="width: 80%;"/>%</td>
					</tr>
					<tr class="isXY" style="display: none;">
							<td> </td>
							<td colspan="5" style="color: red;">注意事項：廠商送貨時，請註明本購單單號或隨貨附本採購單，以利請款。</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width:1750px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td  align="center" style="width:30px;">
                        <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"> </td>
                    <td class="isAD" align="center" style="width:180px;"><a id='lblUno'> </a></td>
					<td align="center" style="width:180px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_st'> </a><a class="isSpec">/</a><a id='lblSpec' class="isSpec"> </a></td>
					<td align="center" style="width:95px;" class="isStyle"><a id='lblStyles'> </a></td>
					<td align="center" style="width:60px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:110px;"><a id='lblOmount_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotals'> </a></td>
					<td class="aprice" align="center" style="width:40px;"><a id='lblAprice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTrandates'> </a></td>
					<td align="center" style="width:120px;"><a id='lblGemounts'> </a></td>
					<td align="center" ><a id='lblMemos'> </a></td>
					<td align="center" style="width:130px;" class="isCust"><a id='lblCustnos'> </a></td>
					<td align="center" style="width:45px;"><a id='lblRc2record'> </a></td>
					<td align="center" style="width:45px;"><a id='lblCancels'> </a></td>
					<td align="center" style="width:45px;"><a id='lblEndas'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td class="isAD">
						<input class="txt c1" id="txtUno.*" type="text" />
					</td>
					<td>
						<input class="txt c1" id="txtProductno1.*" type="text" />
						<input class="txt c1" id="txtProductno2.*" type="text" />
						<input class="txt c1" id="txtProductno3.*" type="text" />
						<input class="txt c1" id="txtProductno.*" type="hidden" />
						<input id="txtNo2.*" type="text" class="txt" style="width:60px;"/>
						<input class="btn" id="btnProduct1.*" type="button" value='.' style=" font-weight: bold;" />
						<input class="btn" id="btnProduct2.*" type="button" value='.' style=" font-weight: bold;" />
						<input class="btn" id="btnProduct3.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1 isStyle"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtOmount.*" type="text" class="txt num c1" />
						<input id="txtStdmount.*" type="text" class="txt c1 num"/>
					</td>
					<td><input id="txtPrice.*" type="text" class="txt num c1" /></td>
					<td><input id="txtTotal.*" type="text" class="txt num c1" /></td>
					<td class="aprice"><input id="chkAprice.*" type="checkbox" class="txt c1" /></td>
					<td><input id="txtTrandate.*" type="text" class="txt c1"/></td>
					<td>
						<input class="txt num c1" id="txtC1.*" type="text" />
						<input class="txt num c1" id="txtNotv.*" type="text" />
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input class="txt" id="txtOrdbno.*" type="text" style="width:70%;" />
						<input class="txt" id="txtNo3.*" type="text" style="width:20%;" />
						<input id="recno.*" type="hidden" />
					</td>
					<td class="isCust">
						<input id="txtCustno.*" type="text" class="txt c1" style="width:80%;"/>
						<input id="btnCustno.*" type="button" value="." style=" font-weight: bold" />
						<input id="txtComp.*"type="text" class="txt c1" />
					</td>
					<td align="center"><input class="btn" id="btnRc2record.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="chkCancel.*" type="checkbox"/></td>
					<td align="center"><input class="btn" id="chkEnda.*" type="checkbox"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="display:none;">
            <table id="tbbt">
                <tbody>
                    <tr class="head" style="color:white; background:#003366;">
                        <td style="width:90px;">
                        <input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
                        </td>
                        <td style="width:20px;"> </td>
                        <td style="width:100px; text-align: center;">no2</td>
                        <td style="width:100px; text-align: center;">ordbaccy</td>
                        <td style="width:200px; text-align: center;">ordbno</td>
                        <td style="width:100px; text-align: center;">no3</td>
                        <td style="width:200px; text-align: center;">productno</td>
                        <td style="width:100px; text-align: center;">unit</td>
                        <td style="width:100px; text-align: center;">mount</td>
                        <td style="width:100px; text-align: center;">weight</td>
                        <td style="width:100px; text-align: center;">cancel</td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
                            <input id="txtNoq..*" type="text" style="display:none;"/>
                        </td>
                        <td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                        <td><input id="txtNo2..*" type="text" style="width:95%;"/></td>
                        <td><input id="txtOrdbaccy..*" type="text" style="width:95%;"/></td>
                        <td><input id="txtOrdbno..*" type="text" style="width:95%;"/></td>
                        <td><input id="txtNo3..*" type="text" style="width:95%;"/></td>
                        <td><input id="txtProductno..*" type="text" style="width:95%;"/></td>
                        <td><input id="txtUnit..*" type="text" style="width:95%;"/></td>
                        <td><input id="txtMount..*"  type="text" style="width:95%; text-align: right;"/></td>
                        <td><input id="txtWeight..*"  type="text" style="width:95%; text-align: right;"/></td>
                        <td align="center"><input class="btn" id="chkCancel..*" type="checkbox"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
	</body>
</html>