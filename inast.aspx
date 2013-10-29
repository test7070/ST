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

            q_tables = 's';
            var q_name = "ina";
            var q_readonly = ['txtWorker', 'txtWorker2', 'txtNoa','txtWeight'];
            var q_readonlys = [];
            var bbmNum = [['txtWeight', 10, 2, 1]];
            var bbsNum = [['txtPrice', 15, 3, 1], ['txtTotal', 12, 2, 1, 1], ['txtWeight', 10, 2, 1], ['txtMount', 10, 2, 1],['txtTheory',10,0,1]];
            var bbmMask = [];
            var bbsMask = [['txtStyle', 'A']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            aPop = new Array(['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'], ['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'], ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
            brwCount2 = 7;
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('style', '', 0, 0, 0, '');
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            var abbsModi = [];

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
						t_moneyus = q_add(t_moneyus,round(t_moneys,2));
						t_moneys = round(q_mul(t_moneys,t_float),0);
					}
					t_weight = q_add(t_weight,t_weights);
					t_mount = q_add(t_mount,t_mounts);
					t_money = q_add(t_money,t_moneys);
					$('#txtTotal_' + j).val(FormatNumber(t_moneys));
				}
				for (var j = 0; j < q_bbtCount; j++) {
					if ($('#cmbKind').val().substr(0, 1) == 'A') {
						q_tr('txtDime__' + j, q_float('textSize1__' + j));
						q_tr('txtWidth__' + j, q_float('textSize2__' + j));
						q_tr('txtLengthb__' + j, q_float('textSize3__' + j));
						q_tr('txtRadius__' + j, q_float('textSize4__' + j));
					} else if ($('#cmbKind').val().substr(0, 1) == 'B') {
						q_tr('txtRadius__' + j, q_float('textSize1__' + j));
						q_tr('txtWidth__' + j, q_float('textSize2__' + j));
						q_tr('txtDime__' + j, q_float('textSize3__' + j));
						q_tr('txtLengthb__' + j, q_float('textSize4__' + j));
					} else {//鋼筋、胚
						q_tr('txtLengthb__' + j, q_float('textSize3__' + j));
					}
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
                        t_tax = round(q_div(t_money,q_mul(q_add(1,t_taxrate),t_taxrate)), 0);
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
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('ina.typea'));
                q_cmbParse("cmbItype", q_getPara('uccc.itype'));
                q_cmbParse("cmbKind", q_getPara('sys.stktype'));
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                /* 若非本會計年度則無法存檔 */
                $('#txtDatea').focusout(function() {
                    if ($(this).val().substr(0, 3) != r_accy) {
                        $('#btnOk').attr('disabled', 'disabled');
                        alert(q_getMsg('lblDatea') + '非本會計年度。');
                    } else {
                        $('#btnOk').removeAttr('disabled');
                    }
                });

                $('#btnRc2st').click(function() {
                    var t_where = "where=^^ kind='" + $('#cmbKind').val() + "' and tggno='" + $('#txtTggno').val() + "' and (storeno ='' OR storeno is null ) ^^";
                    q_gt('rc2', t_where, 0, 0, 0, "", r_accy);
                });

                //變動尺寸欄位
                $('#cmbKind').change(function() {
                    size_change();
                });
            }

            function q_boxClose(s2) {///  q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///  q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            var StyleList = '';
            var t_uccArray = new Array;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'rc2':
                        var rc2 = _q_appendData("rc2", "", true);
                        if (rc2[0] != undefined) {
                            var rc2s = _q_appendData("rc2s", "", true);
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtRadius,txtRc2no,txtMount,txtWeight,txtMemo', rc2s.length, rc2s, 'productno,product,spec,size,dime,width,lengthb,radius,noa,mount,weight,memo', 'txtProductno,txtProduct,');
                            size_change();
                        }
                        break;
                    case 'uccb':
                        var as = _q_appendData("uccb", "", true);
                        if (uccb_readonly) {
                            if (as[0] != undefined) {
                                //已領用的物品不能再變動與刪除
                                $('#btnMinus_' + bbs_id).attr('disabled', 'disabled');
                                $('#btnProductno_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtUno_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtUno_' + bbs_id).css('background', t_background2);
                                $('#txtProductno_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtProductno_' + bbs_id).css('background', t_background2);
                                $('#txtProduct_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtProduct_' + bbs_id).css('background', t_background2);
                                $('#txtSpec_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtSpec_' + bbs_id).css('background', t_background2);
                                $('#textSize1_' + bbs_id).attr('disabled', 'disabled');
                                $('#textSize1_' + bbs_id).css('background', t_background2);
                                $('#textSize2_' + bbs_id).attr('disabled', 'disabled');
                                $('#textSize2_' + bbs_id).css('background', t_background2);
                                $('#textSize3_' + bbs_id).attr('disabled', 'disabled');
                                $('#textSize3_' + bbs_id).css('background', t_background2);
                                $('#textSize4_' + bbs_id).attr('disabled', 'disabled');
                                $('#textSize4_' + bbs_id).css('background', t_background2);
                                $('#txtMount_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtMount_' + bbs_id).css('background', t_background2);
                                $('#txtWeight_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtWeight_' + bbs_id).css('background', t_background2);
                                $('#txtMemo_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtMemo_' + bbs_id).css('background', t_background2);
                            }
                            if ((dec(bbs_id) + 1) < q_bbsCount) {
                                bbs_id = dec(bbs_id) + 1;
                                bbs_readonly(bbs_id);
                            } else {
                                uccb_readonly = false;
                            }
                        } else {
                            if (as[0] != undefined) {
                                alert("批號已存在!!");
                                $('#txtUno_' + b_seq).val('');
                                $('#txtUno_' + b_seq).focus();
                            }
                        }
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
                    case 'deleUccy':
                        var as = _q_appendData("uccy", "", true);
                        var err_str = '';
                        if (as[0] != undefined) {
                            for (var i = 0; i < as.length; i++) {
                                if (dec(as[i].gweight) > 0) {
                                    err_str += as[i].uno + '已領料，不能刪除!!\n';
                                }
                            }
                            if (trim(err_str).length > 0) {
                                alert(err_str);
                                return;
                            } else {
                                _btnDele();
                            }
                        } else {
                            _btnDele();
                        }
                        break;
                    default:
                        if (t_name.substring(0, 9) == 'checkUno_') {
                            var n = t_name.split('_')[1];
                            var as = _q_appendData("view_uccb", "", true);
                            if (as[0] != undefined) {
                                var t_uno = $('#txtUno_' + n).val();
                                alert(t_uno + ' 此批號已存在!!\n【' + as[0].action + '】單號：' + as[0].noa);
                                $('#txtUno_' + n).focus();
                            }
                        } else if (t_name.substring(0, 14) == 'btnOkcheckUno_') {
                            var n = parseInt(t_name.split('_')[1]);
                            var as = _q_appendData("view_uccb", "", true);
                            if (as[0] != undefined) {
                                var t_uno = $('#txtUno_' + n).val();
                                alert(t_uno + ' 此批號已存在!!\n【' + as[0].action + '】單號：' + as[0].noa);
                                Unlock(1);
                                return;
                            } else {
                                btnOk_checkUno(n - 1);
                            }
                        }
                        break;
                } /// end switch
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                //日期檢查
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtDatea').val().substring(0, 3) != r_accy) {
                    alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
                    Unlock(1);
                    return;
                }
                //檢查批號
                for (var i = 0; i < q_bbsCount; i++) {
                    for (var j = i + 1; j < q_bbsCount; j++) {
                        if ($.trim($('#txtUno_' + i).val()).length > 0 && $.trim($('#txtUno_' + i).val()) == $.trim($('#txtUno_' + j).val())) {
                            alert('【' + $.trim($('#txtUno_' + i).val()) + '】' + q_getMsg('lblUno_st') + '重覆。\n' + (i + 1) + ', ' + (j + 1));
                            Unlock(1);
                            return;
                        }
                    }
                }
                btnOk_checkUno(q_bbsCount - 1);
            }

            function btnOk_checkUno(n) {
                if (n < 0) {
                    if (q_cur == 1)
                        $('#txtWorker').val(r_name);
                    else
                        $('#txtWorker2').val(r_name);
                    sum();
                    var t_noa = trim($('#txtNoa').val());
                    var t_date = trim($('#txtDatea').val());
                    if (t_noa.length == 0 || t_noa == "AUTO")
                        q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ina') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                    else
                        wrServer(t_noa);
                } else {
                    var t_uno = $.trim($('#txtUno_' + n).val());
                    var t_noa = $.trim($('#txtNoa').val());
                    q_gt('view_uccb', "where=^^uno='" + t_uno + "' and not(accy='" + r_accy + "' and tablea='inas' and noa='" + t_noa + "')^^", 0, 0, 0, 'btnOkcheckUno_' + n);
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('inast_s.aspx', q_name + '_s', "550px", "500px", q_getMsg("popSeek"));
            }

            function getTheory(b_seq) {
                t_Radius = $('#txtRadius_' + b_seq).val();
                t_Width = $('#txtWidth_' + b_seq).val();
                t_Dime = $('#txtDime_' + b_seq).val();
                t_Lengthb = $('#txtLengthb_' + b_seq).val();
                t_Mount = $('#txtMount_' + b_seq).val();
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
                    productno : t_Productno
                };
                return theory_st(theory_setting);
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtStyle_' + j).blur(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            ProductAddStyle(b_seq);
                        });
                        $('#txtUno_' + j).change(function() {
                            var n = $(this).attr('id').replace('txtUno_', '');
                            var t_uno = $.trim($(this).val());
                            var t_noa = $.trim($('#txtNoa').val());
                            q_gt('view_uccb', "where=^^uno='" + t_uno + "' and not(accy='" + r_accy + "' and tablea='inas' and noa='" + t_noa + "')^^", 0, 0, 0, 'checkUno_' + n);
                        });

                        //-------------------------------------------
                        //將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
                        $('#textSize1_' + j).change(function() {sum();});
						$('#textSize2_' + j).change(function() {sum();});
						$('#textSize3_' + j).change(function() {sum();});
						$('#textSize4_' + j).change(function() {sum();});
						$('#txtSize_'+j).change(function(e){
							if($.trim($(this).val).length==0)
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
                        $('#txtMount_' + j).change(function() {sum();});
                        $('#txtPrice_' + j).change(function() {sum();});

                        //-------------------------------------------------------------------------------------
                    }
                }
                _bbsAssign();
                size_change();
                if (q_cur == 2) {
                    uccb_readonly = true;
                    bbs_readonly(0);
                }
            }

            function btnIns() {
                _btnIns();
                $('#cmbKind').val(q_getPara('vcc.kind'));
                size_change();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
                size_change();
                uccb_readonly = true;
                bbs_readonly(0);
            	sum();
            }

            function btnPrint() {
                q_box('z_inast.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
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
                $('input[id*="txtProduct_"]').each(function() {
                    t_IdSeq = -1;
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    OldValue = $(this).val();
                    nowStyle = $('#txtStyle_' + b_seq).val();
                    if (!emp(nowStyle) && (StyleList[0] != undefined)) {
                        for (var i = 0; i < StyleList.length; i++) {
                            if (StyleList[i].noa.toUpperCase() == nowStyle) {
                                styleProduct = StyleList[i].product;
                                if (OldValue.substr(OldValue.length - styleProduct.length) == styleProduct) {
                                    OldValue = OldValue.substr(0, OldValue.length - styleProduct.length);
                                }
                            }
                        }
                    }
                    $(this).attr('OldValue', OldValue);
                });
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtProductno_':
                        $('input[id*="txtProduct_"]').each(function() {
                            $(this).attr('OldValue', $(this).val());
                        });
                        ProductAddStyle(b_seq);
                        $('#txtClass_' + b_seq).focus();
                        break;
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                size_change();
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
                var t_where = 'where=^^ uno in(' + getBBSWhere('Uno') + ') ^^';
                q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }

            var uccb_readonly = false;
            var bbs_id = '';
            function bbs_readonly(id) {
                bbs_id = id;
                var t_where = "where=^^ noa='" + $('#txtUno_' + bbs_id).val() + "' and gweight>0 ^^";
                q_gt('uccb', t_where, 0, 0, 0, "", r_accy);
            }

            function distinct(arr1) {
                for (var i = 0; i < arr1.length; i++) {
                    if ((arr1.indexOf(arr1[i]) != arr1.lastIndexOf(arr1[i])) || arr1[i] == '') {
                        arr1.splice(i, 1);
                        i--;
                    }
                }
                return arr1;
            }

            function getBBSWhere(objname) {
                var tempArray = new Array();
                for (var j = 0; j < q_bbsCount; j++) {
                    tempArray.push($('#txt' + objname + '_' + j).val());
                }
                var TmpStr = distinct(tempArray).sort();
                TmpStr = TmpStr.toString().replace(/,/g, "','").replace(/^/, "'").replace(/$/, "'");
                return TmpStr;
            }

            function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
                var t_kind = (($('#cmbKind').val())?$('#cmbKind').val():'');
                t_kind = t_kind.substr(0, 1);				
				if (t_kind == 'A') {
					$('*[id="lblSize_help"]').text(q_getPara('sys.lblSizea'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).hide();
						$('*[id="Size"]').css('width', '220px');
						$('#txtSpec_' + j).css('width', '220px');
						$('#textSize1_' + j).val($('#txtDime_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
					for (var j = 0; j < q_bbtCount; j++) {
						$('#textSize1__' + j).show();
						$('#textSize2__' + j).show();
						$('#textSize3__' + j).show();
						$('#textSize4__' + j).hide();
						$('#x1__' + j).show();
						$('#x2__' + j).show();
						$('#x3__' + j).hide();
						$('*[id="Sizet"]').css('width', '230px');
						$('#textSize1__' + j).val($('#txtDime__' + j).val());
						$('#textSize2__' + j).val($('#txtWidth__' + j).val());
						$('#textSize3__' + j).val($('#txtLengthb__' + j).val());
						$('#textSize4__' + j).val(0);
						$('#txtRadius__' + j).val(0);
					}
				} else if (t_kind == 'B') {
					$('*[id="lblSize_help"]').text(q_getPara('sys.lblSizeb'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).show();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).show();
						$('*[id="Size"]').css('width', '300px');
						$('#txtSpec_' + j).css('width', '300px');
						$('#textSize1_' + j).val($('#txtRadius_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtDime_' + j).val());
						$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
					}
					for (var j = 0; j < q_bbtCount; j++) {
						$('#textSize1__' + j).show();
						$('#textSize2__' + j).show();
						$('#textSize3__' + j).show();
						$('#textSize4__' + j).show();
						$('#x1__' + j).show();
						$('#x2__' + j).show();
						$('#x3__' + j).show();
						$('*[id="Sizet"]').css('width', '310px');
						$('#textSize1__' + j).val($('#txtRadius__' + j).val());
						$('#textSize2__' + j).val($('#txtWidth__' + j).val());
						$('#textSize3__' + j).val($('#txtDime__' + j).val());
						$('#textSize4__' + j).val($('#txtLengthb__' + j).val());
					}
				} else {//鋼筋和鋼胚
					$('*[id="lblSize_help"]').text(q_getPara('sys.lblSizec'));
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).hide();
						$('#textSize2_' + j).hide();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).hide();
						$('#x2_' + j).hide();
						$('#x3_' + j).hide();
						$('*[id="Size"]').css('width', '55px');
						$('#txtSpec_' + j).css('width', '55px');
						$('#textSize1_' + j).val(0);
						$('#txtDime_' + j).val(0);
						$('#textSize2_' + j).val(0);
						$('#txtWidth_' + j).val(0);
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
					for (var j = 0; j < q_bbtCount; j++) {
						$('#textSize1__' + j).hide();
						$('#textSize2__' + j).hide();
						$('#textSize3__' + j).show();
						$('#textSize4__' + j).hide();
						$('#x1__' + j).hide();
						$('#x2__' + j).hide();
						$('#x3__' + j).hide();
						$('*[id="Sizet"]').css('width', '55px');
						$('#textSize1__' + j).val(0);
						$('#txtDime__' + j).val(0);
						$('#textSize2__' + j).val(0);
						$('#txtWidth__' + j).val(0);
						$('#textSize3__' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4__' + j).val(0);
						$('#txtRadius__' + j).val(0);
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
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                width: 220px;
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
                width: 1600px;
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
            #dbbt {
                width: 1250px;
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
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewStation"> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="station" style="text-align: center;">~station</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr class>
						<td class><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class>
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblItype" class="lbl"> </a></td>
						<td><select id="cmbItype" class="txt c1"></select></td>
						<td><span> </span><a id="lblType" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblKind" class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"></select></td>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td>
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblOrdeno" class="lbl" > </a></td>
						<td>
						<input id="txtOrdeno" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text" style="float:left;width:30%;"/>
							<input id="txtComp" type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td>
						<input id="txtWeight" type="text" class="txt c1 num" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStore" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtStoreno" style="float:left;width:30%;"/>
							<input id="txtStore" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td>
						<input id="txtWorker" type="text" style="float:left;width:50%;"/>
						<input id="txtWorker2" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCardealno" type="text" style="float:left;width:50%;"/>
							<input id="txtCardeal" type="text" style="float:left;width:50%;"/>
						</td>
						<td><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td>
						<input id="txtCarno" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTrantype" class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1"></select></td>
						<td><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td>
						<input id="txtPrice" type="text" class="txt c1 num" />
						</td>
						<td><span> </span><a id="lblTranmoney" class="lbl"> </a></td>
						<td>
						<input id="txtTranmoney" type="text" class="txt c1 num" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1" /></td>
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
					<td align="center" style="width:150px;"><a id="lblUno_st" > </a></td>
					<td align="center" style="width:120px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:35px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:140px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblClasss'> </a></td>
					<td align="center" id='Size'><a id='lblSize_help'> </a><BR><a id='lblSize_st'> </a></td>
					<td align="center" style="width:180px;"><a id='lblSizea_st'> </a></td>
					<td align="center" style="width:50px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:120px;"><a id='lblWeights'> </a></td>
					<td align="center" style="width:120px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:120px;"><a id='lblTotals'> </a><br><a id='lblTheorys'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMemo_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input id="txtUno.*" type="text" style="width:95%;"/>
					</td>
					<td>
					<input class="btn"  id="btnProduct.*" type="button" value='' style=" font-weight: bold;width:15px;height:25px;float:left;" />
					<input type="text" id="txtProductno.*"  style="width:75px; float:left;"/>
					</td>
					<td>
					<input id="txtStyle.*" type="text" style="width:85%;text-align:center;"/>
					</td>
					<td>
						<span style="width:20px;height:1px;display:none;float:left;"> </span>
						<input id="txtProduct.*" type="text" style="float:left;width:93%;"/>
						<input class="btn" id="btnUno.*" type="button" value='' style="display:none;float:left;width:20px;height:25px;"/>
						<input id="txtUno.*" type="text" style="display:none;float:left;width:100px;" />
					</td><td >
					<input id="txtClass.*" type="text" style="width:90%;text-align:center;"/>
					</td>
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
					<td><input class="txt " id="txtSize.*" type="text" style="width:95%;"/></td>
					<td >
					<input  id="txtUnit.*" type="text" style="width:90%;"/>
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
					<input class="txt c1" id="txtMemo.*" type="text" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
