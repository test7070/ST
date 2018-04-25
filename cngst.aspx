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
			//RK  store: bbm move to bbs
		
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_desc = 1;
			q_tables = 's';
			var q_name = "cng";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtWeight', 'txtMount'];
			var q_readonlys = [];
			var bbmNum = [['txtPrice', 15, 3, 1], ['txtWeight', 15, 3, 1], ['txtTranmoney', 10, 0, 1]];
			var bbsNum = [['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1], ['txtMount', 10, 0, 1], ['txtWeight', 15, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			aPop = new Array(['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']
			, ['txtStoreinno', 'lblStorein', 'store', 'noa,store', 'txtStoreinno,txtStorein', 'store_b.aspx']
			,['txtStoreno_', '', 'store', 'noa,store', 'txtStoreno_', 'store_b.aspx']
			,['txtStoreinno_', '', 'store', 'noa,store', 'txtStoreinno_', 'store_b.aspx']
			, ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
			, ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']
			, ['txtUno_', 'btnUno_', 'view_uccc', 'uno,uno,productno,class,product,unit,radius,width,dime,lengthb,spec,spec,emount,eweight', '0txtUno_,txtUno_,txtProductno_,txtClass_,txtProduct_,txtUnit_,txtRadius_,txtWidth_,txtDime_,txtLengthb_,txtSpec_,combSpec_,txtMount_,txtWeight_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%']
			, ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
			, ['txtStyle_', 'btnStyle_', 'style', 'noa,product', 'txtStyle_', 'style_b.aspx']);
			
			t_spec='',t_store=new Array();
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('spec', '', 0, 0, 0, '');
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				var t_weight = 0, t_mount = 0,t_price = 0;
				for (var i = 0; i < q_bbsCount; i++) {
					t_weight = q_add(t_weight, q_float('txtWeight_' + i));
					t_mount = q_add(t_mount, q_float('txtMount_' + i));
				}
                t_price = q_float('txtPrice');
                if (t_price != 0) {
                    $('#txtTranmoney').val(FormatNumber(round(q_mul(t_weight, t_price), 0)));
                }
				$('#txtWeight').val(FormatNumber(t_weight));
				$('#txtMount').val(FormatNumber(t_mount));
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('cng.typea'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				q_cmbParse("combSpec", t_spec,'s');
				
				$('#cmbKind').change(function() {
					size_change();
				});
				$('#txtPrice').change(function(e) {
					sum();
				});

			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				var
				ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}/// end Switch
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'getStoreno':
						var as = _q_appendData("store", "", true);
						if(as[0]!=undefined){
							$('#txtStoreno').val(as[0].noa);
							$('#txtStore').val(as[0].store);
						}
						t_where = "noa='"+t_storeinno+"'";
						q_gt('store', 'where=^^'+t_where+'^^', 0, 0, 0, 'getStoreinno');
						break;
					case 'getStoreinno':
						var as = _q_appendData("store", "", true);
						if(as[0]!=undefined){
							$('#txtStoreinno').val(as[0].noa);
							$('#txtStorein').val(as[0].store);
						}
						Save();
						break;
					case 'spec':
						var as = _q_appendData("spec", "", true);
						t_spec='';
						for ( i = 0; i < as.length; i++) {
							t_spec+=','+as[i].noa+'@'+as[i].product;
						}
						if(t_spec.length==0) t_spec=' ';
						q_gt('store', '', 0, 0, 0, '');
						break;
					case 'store':
						var as = _q_appendData("store", "", true);
						t_store=new Array();
						for ( i = 0; i < as.length; i++) {
							t_store.push({noa:as[i].noa,store:as[i].store});
						}
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
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

			function q_popPost(s1) {
				switch (s1) {
					case 'txtUno_':
						size_change();
						break;
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

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}

			function btnOk() {
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					//var t_storeno = '';
					//var t_storeinno = '';
					for(var i=0;i<q_bbsCount;i++){
						if($('#txtStoreno_'+i).val().length>0 && $('#txtStoreinno_'+i).val().length>0){
							for(var j=0;j<t_store.length;j++){
								if($('#txtStoreno_'+i).val()==t_store[j].noa){
									$('#txtStoreno').val(t_store[j].noa);
									$('#txtStore').val(t_store[j].store);
									break;	
								}
							}
							for(var j=0;j<t_store.length;j++){
								if($('#txtStoreinno_'+i).val()==t_store[j].noa){
									$('#txtStoreinno').val(t_store[j].noa);
									$('#txtStorein').val(t_store[j].store);
									break;	
								}
							}
							break;
						}
					}
					Save();
					//回寫倉庫到表頭
					/*if(t_storeno.length>0 && t_storeinno.length>0){
						t_where = "noa='"+t_storeno+"'";
						q_gt('store', 'where=^^'+t_where+'^^', 0, 0, 0, 'getStoreno');
					}else{
						Save();
					}*/
				}else{
					Save();
				}
			}
			function Save(){
				Lock(1, {
					opacity : 0
				});
				//日期檢查
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}
				var t_storeno = $.trim($('#txtStoreno').val());
				var t_storeinno = $.trim($('#txtStoreinno').val());
				for(var i=0;i<q_bbsCount;i++){
					if($('#txtStoreno_'+i).val().length==0)
						$('#txtStoreno_'+i).val(t_storeno);
					if($('#txtStoreinno_'+i).val().length==0)
						$('#txtStoreinno_'+i).val(t_storeinno);
				}
				/*if ($('#txtDatea').val().substring(0, 3) != r_accy) {
					alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
					Unlock(1);
					return;
				}*/
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cng') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cng_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtUno_'+j).bind('contextmenu', function(e) {
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							$('#btnUno_'+n).click();
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
						$('#txtWeight_' + j).change(function(e) {
							sum();
						});
						$('#txtMount_' + j).change(function(e) {
							sum();
						});
						//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
						$('#textSize1_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if ($('#cmbKind').val().substr(0, 1) == 'A') {
								q_tr('txtDime_' + n, q_float('textSize1_' + n));
							} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
								q_tr('txtRadius_' + n, q_float('textSize1_' + n));
							}
						});
						$('#textSize2_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if ($('#cmbKind').val().substr(0, 1) == 'A') {
								q_tr('txtWidth_' + n, q_float('textSize2_' + n));
							} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
								q_tr('txtWidth_' + n, q_float('textSize2_' + n));
							}
						});
						$('#textSize3_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if ($('#cmbKind').val().substr(0, 1) == 'A') {
								q_tr('txtLengthb_' + n, q_float('textSize3_' + n));
							} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
								q_tr('txtDime_' + n, q_float('textSize3_' + n));
							} else {//鋼筋、胚
								q_tr('txtLengthb_' + n, q_float('textSize3_' + n));
							}
						});
						$('#textSize4_' + j).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							if ($('#cmbKind').val().substr(0, 1) == 'A') {
								q_tr('txtRadius_' + n, q_float('textSize4_' + n));
							} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
								q_tr('txtLengthb_' + n, q_float('textSize4_' + n));
							}
						});
						//-------------------------------------------------------------------------------------
					}
				}
				_bbsAssign();
				size_change();
				if(q_getPara('sys.project').toUpperCase()=='PE'){
					$('.pe_hide').hide();
				}
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					$('.rk_hide').hide();
				}
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				$('#cmbKind').val(q_getPara('vcc.kind'));
				
				if(q_getPara('sys.project').toUpperCase()=='PE')
					$('#cmbKind').val('A1');
				size_change();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				sum();
			}

			function btnPrint() {
				switch(q_getPara('sys.project').toUpperCase()){
					case 'BD':
						q_box("z_cngbdp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'cng_rk', "95%", "95%", m_print);
						break;
					case 'RK':
						q_box("z_cng_rkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'cng_rk', "95%", "95%", m_print);
						break;
					default:
						q_box('z_cngstp.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
						break;
				}
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['productno'] && !as['product'] && !as['spec']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['date'] = abbm2['date'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				size_change();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				size_change();
				refreshBbs();
			}
			function refreshBbs(){
				//金額小計自訂
				for(var i=0;i<q_bbsCount;i++){
					$('#combSpec_'+i).val($('#txtSpec_'+i).val());
					if(q_cur==1 || q_cur==2)
						$('#combSpec_'+i).removeAttr('disabled');
					else
						$('#combSpec_'+i).attr('disabled','disabled');
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
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
						$('#Size').css('width', '222px');
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
						$('#Size').css('width', '310px');
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
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					for(var i=0;i<q_bbsCount;i++){
						$('#combSpec_'+i).show();
						$('#txtSpec_'+i).hide();	
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
                width: 800px;
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
                width: 1400px;
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
                width: 1400px;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1600px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview"  >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewStore'> </a></td>
						<td align="center" style="width:20%"><a id='vewStorein'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='store'>~store</td>
						<td align="center" id='storein'>~storein</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblType" class="lbl" > </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td><input id="txtNoa"   type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="pe_hide"><span> </span><a id="lblKind" class="lbl" > </a></td>
						<td class="pe_hide"><select id="cmbKind" class="txt c1"> </select></td>
						<td><span> </span><a id="lblStore" class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreno" type="text"  class="txt" style="width:50%;"/>
							<input id="txtStore" type="text" class="txt" style="width:50%;"/>
						</td>
						<td><span> </span><a id="lblStorein" class="lbl btn"> </a></td>
						<td>
							<input id="txtStoreinno" type="text" class="txt" style="width:50%;"/>
							<input id="txtStorein" type="text" class="txt" style="width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text"  class="txt" style="width:30%;"/>
							<input id="txtTgg" type="text"  class="txt" style="width:70%;"/>
						</td>
						<td><span> </span><a id="lblTrantype" class="lbl" > </a></td>
						<td><select id="cmbTrantype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCardealno" type="text"  class="txt c4"/>
							<input id="txtCardeal" type="text"  class="txt c5"/>
						</td>
						<td><span> </span><a id="lblCarno" class="lbl" > </a></td>
						<td><input id="txtCarno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWeight" class="lbl" > </a></td>
						<td><input id="txtWeight"   type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
					</tr>
					<tr class="pe_hide">
						<td><span> </span><a id="lblPrice" class="lbl" > </a></td>
						<td><input id="txtPrice"   type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTranmoney" class="lbl" > </a></td>
						<td><input id="txtTranmoney"   type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='5'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:white; background:#003366;' >
					<td style="width:1%;" align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td style="width:2%;"> </td>
					<td align="center" style="width:190px;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:120px;"><a>品號<BR>品名</a></td>
					<td class="pe_hide rk_hide" align="center" style="width:30px;"><a id='lblStyle_st'>型</a></td>
					<td class="pe_hide rk_hide" align="center" style="width:80px;"><a>等級</a></td>
					<td align="center" id='Size'>
						<a id='lblSize_st'> </a><BR>
						<a id='lblSize_help'> </a>
					</td>
					<td align="center" style="width: 45px;"><a id='lblUnit_st'> </a></td>
					<td align="center" style="width: 100px;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width: 100px;"><a id='lblWeight_st'> </a></td>
					<td align="center" style="width: 80px;"><a>調出倉</a></td>
					<td align="center" style="width: 80px;"><a>調入倉</a></td>
					<td align="center" style="width: 80px;"><a>儲位</a></td>
					<td align="center" ><a id='lblMemo_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtUno.*" type="text" style="width:95%;"/>
						<input id="btnUno.*" type="button" style="display:none;"/>
					</td>
					<td>
						<input id="txtProductno.*" type="text" style="width:95%;" />
						<input type="text" id="txtProduct.*" style="width:95%;" />
						<input class="btn" id="btnProduct.*" type="button" style="display:none;"/>
					</td>
					<td class="pe_hide rk_hide">
						<input type="text" id="txtStyle.*" style="width:95%;text-align:center;" />
						<input id="btnStyle.*" type="button" style="display:none;"/>
					</td>
					<td class="pe_hide rk_hide"><input id="txtClass.*" type="text" style='width: 95%;'/></td>
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
						<select id='combSpec.*' style="width:95%;display:none;"> </select>
					</td>
					<td><input class="txt c1" id="txtUnit.*" type="text" /></td>
					<td><input class="txt num c1" id="txtMount.*" type="text"/></td>
					<td><input class="txt num c1" id="txtWeight.*" type="text" /></td>
					<td><input class="txt c1" id="txtStoreno.*" type="text" /></td>
					<td><input class="txt c1" id="txtStoreinno.*" type="text" /></td>
					<td><input class="txt c1" id="txtPlace.*" type="text" /></td>
					<td>
						<input class="txt c1" id="txtMemo.*" type="text"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>