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
            var q_name = "rc2";
            var q_readonly = ['txtRc2atax', 'txtTgg', 'txtAccno', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney', 'txtWeight', 'txtTotal', 'txtTax'];
            var q_readonlys = ['txtMoney','txtDime','txtWidth','txtRadius','txtLengthb'];
            var bbmNum = [['txtPrice', 15, 3, 1], ['txtRc2atax', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtWeight', 10, 3, 1]];
            var bbsNum = [['txtPrice', 15, 3, 1], ['txtTotal', 12, 2, 1, 1], ['txtMount', 10, 2, 1], ['txtTheory', 10, 3, 1], ['txtDime', 10, 2, 1], ['txtWidth', 10, 2, 1], ['txtRadius', 10, 2, 1], ['txtLengthb', 10, 2, 1]];
            var bbmMask = [];
            var bbsMask = [['txtStyle', 'A']];
            q_desc = 1;
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';

            aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype,tel,trantype,zip_fact,addr_fact', 'txtTggno,txtTgg,txtNick,txtPaytype,txtTel,cmbTrantype,txtPost,txtAddr', 'tgg_b.aspx'], ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_', 'ucc_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtAddr', '', 'view_road', 'memo,zipcode', '0txtAddr,txtPost', 'road_b.aspx'], ['txtAddr2', '', 'view_road', 'memo,zipcode', '0txtAddr2,txtPost2', 'road_b.aspx'], ['txtSpec_', '', 'spec', 'noa,product', '0txtSpec_,txtSpec_', 'spec_b.aspx', '95%', '95%'], ['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'], ['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']);
            //, ['txtUno_', 'btnUno_', 'view_uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%']);
            brwCount2 = 12;
            var isinvosystem = false;
            //購買發票系統
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('rc2a', 'stop=1 ', 0, 0, 0, "isinvosystem");
                //判斷是否有買發票系統
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

                for (var j = 0; j < q_bbsCount; j++) {
                    t_weights = 0;
                    t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
                    t_product = $.trim($('#txtProduct_' + j).val());
                    
                    //---------------------------------------
                    var t_styles = $.trim($('#txtStyle_' + j).val());
                    var t_unos = $.trim($('#txtUno_' + j).val());
                    var t_dimes = $.trim($('#txtDime_' + j).val());
                    if (!(t_styles == '' && t_unos == '' && t_dimes == 0))
                        t_weights = q_float('txtWeight_' + j);
                    t_prices = q_float('txtPrice_' + j);
                    t_mounts = q_float('txtMount_' + j);

                    if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'MT' || t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
                        t_moneys = q_mul(t_prices, t_weights);
                    } else {
                        t_moneys = q_mul(t_prices, t_mounts);
                    }
                    console.log(t_styles == '' && t_unos == '' && t_dimes == 0);
                    console.log(t_unit);
                    console.log(t_prices);
                    console.log(t_weights);
                    console.log(t_moneys);

                    if (t_float == 0) {
                        t_moneys = round(t_moneys, 0);
                    } else {
                        t_moneyus = q_add(t_moneyus, round(t_moneys, 2));
                        t_moneys = round(q_mul(t_moneys, t_float), 0);
                    }
                    t_weight = q_add(t_weight, t_weights);
                    t_mount = q_add(t_mount, t_mounts);
                    t_money = q_add(t_money, t_moneys);
                    $('#txtTotal_' + j).val(FormatNumber(t_moneys));
                }
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
                q_cmbParse("cmbTypea", q_getPara('rc2.typea'));
                q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
                q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

                //限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
                $('#txtMemo').change(function() {
                    if ($('#txtMemo').val().substr(0, 1) == '*')
                        $('#txtMon').removeAttr('readonly');
                    else
                        $('#txtMon').attr('readonly', 'readonly');
                });
                $('#txtMon').click(function() {
                    if ($('#txtMon').attr("readonly") == "readonly" && (q_cur == 1 || q_cur == 2))
                        q_msg($('#txtMon'), "月份要另外設定，請在" + q_getMsg('lblMemo') + "的第一個字打'*'字");
                });

                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "95%", q_getMsg('btnAccc'), true);
                });
                
                $('#lblOrdc').click(function() {
                    if (!(q_cur == 1 || q_cur == 2))
                        return;
                    lblOrdc();
                });
                
                $('#txtAddr').change(function() {
                    var t_where = "where=^^ noa='" + trim($(this).val()) + "' ^^";
                    q_gt('cust', t_where, 0, 0, 0, "", r_accy);
                });
                
                $('#lblInvono').click(function() {
                    t_where = '';
                    t_invo = $('#txtInvono').val();
                    if (t_invo.length > 0) {
                        t_where = "noa='" + t_invo + "'";
                        q_box("invoice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('popInvo'));
                    }
                });
                $('#lblLcno').click(function() {
                    t_where = '';
                    t_lcno = $('#txtLcno').val();
                    if (t_lcno.length > 0) {
                        t_where = "lcno='" + t_lcno + "'";
                        q_box("lcs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'lcs', "95%", "95%", q_getMsg('popLcs'));
                    }
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
                $('#txtPrice').change(function() {
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

                if (isinvosystem) {
                    $('.istax').hide();
                    $('#txtRc2atax').show();
                }
            }

            function q_boxClose(s2) {///   q_boxClose 2/4 /// 查詢視窗、廠商視窗、訂單視窗  關閉時執行
                var
                ret;
                switch (b_pop) {/// 重要：不可以直接 return ，最後需執行 originalClose();
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

            function GetOrdcnoList() {
                var ReturnStr = new Array;
                for (var i = 0; i < q_bbsCount; i++) {
                    var thisVal = trim($('#txtOrdeno_' + i).val());
                    if (thisVal.length > 0)
                        ReturnStr.push(thisVal);
                }
                ReturnStr = distinct(ReturnStr).sort();
                return ReturnStr.toString();
            }

            var ordcsArray = new Array;
            var StyleList = '';
            var t_uccArray = new Array;
            function q_gtPost(t_name) {/// 資料下載後 ...
                switch (t_name) {
                    case 'getRc2atax':
                        var as = _q_appendData("rc2a", "", true);
                        if (as[0] != undefined) {
                            $('#txtRc2atax').val(q_trv(as[0].tax, 0, 1));
                            var t_noa = $('#txtNoa').val();
                            for (var i = 0; i < abbm.length; i++) {
                                if (abbm[i].noa == t_noa) {
                                    abbm[i].rc2atax = as[0].tax;
                                    break;
                                }
                            }
                        }
                        break;
                    case 'isinvosystem':
                        var as = _q_appendData("rc2a", "", true);
                        if (as[0] != undefined) {
                            isinvosystem = true;
                            $('.istax').hide();
                        } else {
                            isinvosystem = false;
                        }
                        q_gt('style', '', 0, 0, 0, '');
                        break;
                    case 'btnOk_checkuno':
                        var as = _q_appendData("view_uccb", "", true);
                        if (as[0] != undefined) {
                            var msg = '';
                            for (var i = 0; i < as.length; i++) {
                                msg += (msg.length > 0 ? '\n' : '') + as[i].uno + ' 此批號已存在!!\n【' + as[i].action + '】單號：' + as[i].noa;
                            }
                            alert(msg);
                            Unlock(1);
                            return;
                        } else {
                            getUno();
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
                        //$('#txtMon').val(q_date().substring(0, 6));
                        $('#txtDatea').focus();
                        break;
                    case 'flors':
                        var as = _q_appendData("flors", "", true);
                        if (as[0] != undefined) {
                            q_tr('txtFloata', as[0].floata);
                            sum();
                        }
                        break;
                    case 'rc2s':
                        var as = _q_appendData("rc2s", "", true);
                        for (var i = 0; i < ordcsArray.length; i++) {
                            if (ordcsArray[i].mount <= 0 || ordcsArray[i].weight <= 0 || ordcsArray[i].noa == '' || dec(ordcsArray[i].cnt) == 0) {
                                ordcsArray.splice(i, 1);
                                i--;
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
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtRadius,txtOrdeno,txtNo2,txtPrice,txtMount,txtWeight,txtTotal,txtMemo,txtClass,txtStyle,txtUnit', newB_ret.length, newB_ret, 'uno,productno,product,spec,size,dime,width,lengthb,radius,noa,no2,price,mount,weight,total,memo,class,style,unit', 'txtProductno,txtProduct,txtSpec');
                            /// 最後 aEmpField 不可以有【數字欄位】
                            t_where = "where=^^ noa='" + newB_ret[0].noa + "'";
                            q_gt('ordc', t_where, 0, 0, 0, "", r_accy);
                            bbsAssign();
                            sum();
                        }
                        ordcsArray = new Array;
                        break;
                    case 'ordc':
                        var as = _q_appendData("ordc", "", true);
                        if (as[0] != undefined) {
                            $('#txtTggno').val(as[0].tggno);
                            $('#txtTgg').val(as[0].tgg);
                            $('#txtSalesno').val(as[0].salesno);
                            $('#txtSales').val(as[0].sales);
                            $('#txtTel').val(as[0].tel);
                            $('#cmbTrantype').val(as[0].trantype);
                            $('#txtPost').val(as[0].post);
                            $('#txtAddr').val(as[0].addr);
                            $('#txtPaytype').val(as[0].paytype);
                            $('#txtPost2').val(as[0].post2);
                            $('#txtAddr2').val(as[0].addr2);
                        }
                        break;
                    case 'style' :
                        var as = _q_appendData("style", "", true);
                        StyleList = new Array();
                        StyleList = as;
                        q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
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
                        t_uccArray = _q_appendData("ucc", "", true);
                        if (q_cur == 4)// 查詢
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
                    case 'startdate':
                        var as = _q_appendData('tgg', '', true);
                        var t_startdate = '';
                        if (as[0] != undefined) {
                            t_startdate = as[0].startdate;
                        }
                        if (t_startdate.length == 0 || ('00' + t_startdate).slice(-2) == '00' || $('#txtDatea').val().substr(7, 2) < ('00' + t_startdate).slice(-2)) {
                            $('#txtMon').val($('#txtDatea').val().substr(0, 6));
                        } else {
                            var t_date = $('#txtDatea').val();
                            var nextdate = new Date(dec(t_date.substr(0, 3)) + 1911, dec(t_date.substr(4, 2)) - 1, dec(t_date.substr(7, 2)));
                            nextdate.setMonth(nextdate.getMonth() + 1)
                            t_date = '' + (nextdate.getFullYear() - 1911) + '/' + (nextdate.getMonth() < 9 ? '0' : '') + (nextdate.getMonth() + 1);
                            $('#txtMon').val(t_date);
                        }
                        check_startdate = true;
                        btnOk();
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
                }
            }

            function lblOrdc() {
                var t_tggno = trim($('#txtTggno').val());
                var t_where = '';
                t_where = " view_ordcs.enda='0'" + (t_tggno.length > 0 ? q_sqlPara2("tggno", t_tggno) : "");
                t_where += " and b.enda='0'";
                q_box("ordcsst_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'ordcs', "95%", "95%", q_getMsg('popOrdcs'));
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                $('#txtRc2atax').val(0);
                var t_noa = $('#txtNoa').val();
                for (var i = 0; i < abbm.length; i++) {
                    if (abbm[i].noa == t_noa) {
                        abbm[i].rc2atax = 0;
                        break;
                    }
                }
                var s1 = xmlString.split(';');
                abbm[q_recno]['accno'] = s1[0];
                $('#txtAccno').val(s1[0]);
                if ($.trim($('#txtInvono').val()).length > 0)
                    q_gt('rc2a', "where=^^noa='" + $.trim($('#txtInvono').val()) + "'^^", 0, 0, 0, 'getRc2atax', r_accy);
                Unlock(1);
            }

            var check_startdate = false;
            function btnOk() {
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')], ['txtTggno', q_getMsg('lblTgg')], ['txtCno', q_getMsg('lblAcomp')]]);
                // 檢查空白
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                Lock(1, {
                    opacity : 0
                });

                $('#txtOrdcno').val(GetOrdcnoList());
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

                //判斷起算日,寫入帳款月份
                //104/09/30 如果備註沒有*字就重算帳款月份
				//if(!check_startdate && emp($('#txtMon').val())){
				if(!check_startdate && $('#txtMemo').val().substr(0,1)!='*'){	
                    var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^";
                    q_gt('tgg', t_where, 0, 0, 0, "startdate", r_accy);
                    Unlock(1);
                    return;
                }
                check_startdate = false;

                /*if ($('#txtMon').val().length > 0 && !q_cd($('#txtMon').val() + '/01')) {
                 alert(q_getMsg('lblMon') + '錯誤。');
                 Unlock(1);
                 return;
                 }*/

                if ($.trim($('#txtStoreno').val()).length > 0) {
                    for (var i = 0; i < q_bbsCount; i++) {
                        $('#txtStoreno_' + i).val($.trim($('#txtStoreno').val()));
                        $('#txtStore_' + i).val($.trim($('#txtStore').val()));

                    }
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
                var t_where = '';
                for (var i = 0; i < q_bbsCount; i++) {
                    if ($.trim($('#txtUno_' + i).val()).length > 0)
                        t_where += (t_where.length > 0 ? ' or ' : '') + "(uno='" + $.trim($('#txtUno_' + i).val()) + "' and not(accy='" + r_accy + "' and tablea='rc2s' and noa='" + $.trim($('#txtNoa').val()) + "'))";
                }
                if (t_where.length > 0)
                    q_gt('view_uccb', "where=^^" + t_where + "^^", 0, 0, 0, 'btnOk_checkuno');
                else
                    getUno();
            }

            function getUno() {
                var t_buno = '　';
                var t_datea = '　';
                var t_style = '　';
                for (var i = 0; i < q_bbsCount; i++) {
                    if (i != 0) {
                        t_buno += '&';
                        t_datea += '&';
                        t_style += '&';
                    }
                    if ($('#txtUno_' + i).val().length == 0) {
                        t_buno += '';
                        t_datea += $('#txtDatea').val();
                        t_style += $('#txtStyle_' + i).val();
                    }
                }
                q_func('qtxt.query.getuno', 'uno.txt,getuno,' + t_buno + ';' + t_datea + ';' + t_style + ';');
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.getuno':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            if (as.length != q_bbsCount) {
                                alert('批號取得異常。');
                            } else {
                                for (var i = 0; i < q_bbsCount; i++) {
                                    if ($('#txtUno_' + i).val().length == 0) {
                                        $('#txtUno_' + i).val(as[i].uno);
                                    }
                                }
                            }
                        }
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
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('rc2st_s.aspx', q_name + '_s', "500px", "530px", q_getMsg("popSeek"));
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
                    productno : t_Productno,
                    round : 3
                };
                t_theory = theory_st(theory_setting);
                ;
                t_theory = (dec(t_theory) == 0 ? $('#txtWeight_' + b_seq).val() : t_theory);
                return t_theory;
            }

            var btnCert_Seq = -1;
            ///用來給q_box開啟cert時判斷位置
            function bbsAssign() {/// 表身運算式
                $('.btnCert').val($('#lblCert_st').text());
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    	$('#txtSize_' + j).blur(function() {
							if (q_cur>2 || q_cur<1)
								return;
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							var t_size;
							if ($('#txtSize_' + n).val().indexOf('*')>-1)
								t_size=$('#txtSize_' + n).val().split('*');
							else if($('#txtSize_' + n).val().indexOf('X')>-1)
								t_size=$('#txtSize_' + n).val().split('X');
							else if($('#txtSize_' + n).val().indexOf('x')>-1)
								t_size=$('#txtSize_' + n).val().split('x');
							else
								t_size=[];
								
							for(var i=0;i<t_size.length;i++){
								t_size[i]=t_size[i].replace(/[^0-9]/ig, "#")
							}
							var t_dime=0,t_width=0,t_radiuse=0,t_lengthb=0
							,tmp1,tmp2,tmp3,tmp4,t_foot=1;
							if(t_size.length>=3){
								tmp1=t_size[0].split('#');tmp2=t_size[1].split('#');tmp3=t_size[2].split('#');
								for(var i=0;i<tmp1.length;i++){	if(tmp1[i]==''){tmp1.splice(i, 1);i--;}}
								for(var i=0;i<tmp2.length;i++){	if(tmp2[i]==''){tmp2.splice(i, 1);i--;}}
								for(var i=0;i<tmp3.length;i++){	if(tmp3[i]==''){tmp3.splice(i, 1);i--;}}
								//捲板
								if(t_size.length==3){
									if($('#txtSize_' + n).val().indexOf('尺')>-1)
										t_foot=303;
									t_dime=tmp1[tmp1.length-1];
									t_width=tmp2[tmp2.length-1];
									t_lengthb=tmp3[0];
								}
								//製品
								if(t_size.length==4){
									t_foot=7.6;
									tmp4=t_size[3].split('#');
									for(var i=0;i<tmp4.length;i++){	if(tmp4[i]==''){tmp4.splice(i, 1);i--;}}
									t_dime=tmp1[tmp1.length-1];
									t_width=tmp2[tmp2.length-1];
									t_radiuse=tmp3[tmp3.length-1];
									t_lengthb=tmp4[0];
								}
							}
							$('#txtDime_'+n).val(t_dime);$('#txtWidth_'+n).val(t_width);$('#txtRadius_'+n).val(t_radiuse);$('#txtLengthb_'+n).val(t_lengthb);
							//理論重
							if(t_size.length==3)
								$("#txtTheory_"+n).val(q_mul(q_mul(q_mul(t_dime,t_width),t_lengthb),t_foot));
							if(t_size.length==4)
								$("#txtTheory_"+n).val(q_mul(q_mul(q_mul(q_mul(t_dime,t_width),t_lengthb),t_radiuse),t_foot));
						});
                    	
                        $('#btnCert_' + j).click(function() {
                            var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                            btnCert_Seq = n;
                            t_where = '';
                            t_uno = $('#txtUno_' + n).val();
                            if (t_uno.length > 0) {
                                t_where = "noa='" + t_uno + "'";
                                q_box("cert_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cert', "95%", "95%", q_getMsg('popCert'));
                            }
                        });
                        
                        $('#txtUno_' + j).change(function(e) {
                            if ($('#cmbTypea').val() != '2') {
                                var n = $(this).attr('id').replace('txtUno_', '');
                                var t_uno = $.trim($(this).val());
                                var t_noa = $.trim($('#txtNoa').val());
                                q_gt('view_uccb', "where=^^uno='" + t_uno + "' and not(accy='" + r_accy + "' and tablea='rc2s' and noa='" + t_noa + "')^^", 0, 0, 0, 'checkUno_' + n);
                            }
                        });
                        
                        $('#txtMount_' + j).change(function() {
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
                        
                        $('#txtStyle_' + j).blur(function() {
                            $('input[id*="txtProduct_"]').each(function() {
                                thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                                $(this).attr('OldValue', $('#txtProductno_' + thisId).val());
                            });
                            var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                            ProductAddStyle(n);
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
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
                $('#txtDatea').focus();
                sum();
            }

            function btnPrint() {
                t_where = "noa=" + $('#txtNoa').val();
                q_box("z_rc2stp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
                // key_value
            }

            function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
                if (!as['uno'] && !as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {//不存檔條件
                    as[bbsKey[1]] = '';
                    /// noq 為空，不存檔
                    return;
                }

                q_nowf();
                as['type'] = abbm2['type'];
                as['mon'] = abbm2['mon'];
                as['noa'] = abbm2['noa'];
                as['datea'] = abbm2['datea'];
                as['tggno'] = abbm2['tggno'];
                if (abbm2['storeno'])
                    as['storeno'] = abbm2['storeno'];

                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                $('input[id*="txtProduct_"]').each(function() {
                    thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                    $(this).attr('OldValue', $('#txtProductno_' + thisId).val());
                });
                if (isinvosystem)
                    $('.istax').hide();
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtProductno_':
                        $('input[id*="txtProduct_"]').each(function() {
                            thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                            $(this).attr('OldValue', $('#txtProductno_' + thisId).val());
                        });
                        if (trim($('#txtStyle_' + b_seq).val()).length != 0)
                            ProductAddStyle(b_seq);
                        $('#txtStyle_' + b_seq).focus();
                        break;
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                //限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
                if ($('#txtMemo').val().substr(0, 1) == '*')
                    $('#txtMon').removeAttr('readonly');
                else
                    $('#txtMon').attr('readonly', 'readonly');
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
                /// 表身運算式
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
                var t_where = 'where=^^ uno in(' + getBBSWhere('Uno') + ') ^^';
                q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
            }

            function btnCancel() {
                _btnCancel();
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
            .txt.c2 {
                width: 97%;
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
                width: 2450px;
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
                width: 1600px;
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
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
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
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"   type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td> </td>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td colspan="2"><input id="txtInvono" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCno" type="text" style="float:left;width:25%;"/>
							<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<td><span> </span><a id='lblOrdc' class="lbl btn"> </a></td>
						<td colspan="2"><input id="txtOrdcno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td ><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtTggno" type="text" style="float:left;width:25%;"/>
							<input id="txtTgg"  type="text" style="float:left;width:75%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
							<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="4"><input id="txtTel"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost"  type="text" style="float:left; width:25%;"/>
							<input id="txtAddr"  type="text" style="float:left; width:75%;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtPaytype" type="text" style="float:left; width:87%;"/>
							<select id="combPaytype" style="float:left; width:26px;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost2"  type="text" style="float:left; width:25%;"/>
							<input id="txtAddr2"  type="text" style="float:left; width:75%;"/>
						</td>
						<td><span> </span><a id='lblStoreno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtStoreno"  type="text" style="float:left; width:40%;"/>
							<input id="txtStore"  type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCardealno" type="text" style="float:left;width:25%;"/>
							<input id="txtCardeal" type="text" style="float:left;width:75%;" />
						</td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtCarno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
							<input id="txtTax" type="text" class="txt num c1 istax" />
							<input id="txtRc2atax" type="text" class="txt num c1 " style="display:none;" />
						</td>
						<td>
							<span style="float:left;display:block;width:10px;"> </span>
							<select id="cmbTaxtype" style="float:left;width:80px;" > </select>
						</td>
						<td><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1 istax" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1" /></td>
						<td> </td>
						<td><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td><input id="txtTranmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:200px;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:150px;"><a id='lblSize_st'> </a></td>
					<td align="center" style="width:150px;"><a id='lblSizea_st'> </a></td>
					<td align="center" style="width:50px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWeights_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrices_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotals_st'> </a></td>
					<td align="center">
						<a id='lblMemos_st'> </a><br>
						<a id='lblCert_st' style="display:none;"> </a>
					</td>
					<td align="center" style="width:200px;"><a id='lblUno2_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblStoreno_st'> </a></td>
					<td align="center" style="width:60px;"><a id='lblPlace_st'> </a></td>
					<td align="center" style="width:200px;"><a id='lblOrdcnos_st'> </a></td>
					<td align="center" style="width:280px;">厚 X 寬 X 高 X 長</td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnUno.*" type="button" value='.' style="float:left;width:20px;display:none;"/>
						<input id="txtUno.*" type="text" class="txt c2" />
					</td>
					<td>
						<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:20px;float:left;" />
						<input type="text" id="txtProductno.*"  style="width:75%; float:left;"/>
						<span style="display:block; width:20px;float:left;"> </span>
					</td>
					<td><input id="txtStyle.*" type="text" style="width:90%;text-align:center;" /></td>
					<td><input id="txtProduct.*" type="text" class="txt c2" /></td>
					<td><input id="txtSpec.*" type="text" class="txt c2"/></td>
					<td><input id="txtSize.*" type="text" class="txt c2"/></td>
					<td ><input id="txtUnit.*" type="text" style="width:90%;"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c2"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num c2"/></td>
					<td><input id="txtPrice.*" type="text"  class="txt num c2"/></td>
					<td>
						<input id="txtTotal.*" type="text" class="txt num c2" />
						<input id="txtGweight.*" type="text" class="txt num c2"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c2"/>
						<input id="btnCert.*" class="btnCert" type="button" style="width:95%;"/>
					</td>
					<td ><input id="txtUno2.*" type="text" style="width:90%;"/></td>
					<td>
						<input class="btn"  id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;width:20px;float:left;" />
						<input type="text" id="txtStoreno.*"  style="width:70px; float:left;"/>
						<span style="display:block; width:20px;float:left;"> </span>
						<input type="text" id="txtStore.*"  style="width:70px; float:left;"/>
					</td>
					<td><input id="txtPlace.*" type="text" style="width:90%;"/></td>
					<td>
						<input id="txtOrdeno.*" type="text"  style="width:140px;float:left;"/>
						<input id="txtNo2.*" type="text"  style="width:40px;float:left;"/>
					</td>
					<td>
						<input id="txtDime.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
						<a style="float: left;">X</a>
						<input id="txtWidth.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
						<a style="float: left;">X</a>
						<input id="txtRadius.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
						<a style="float: left;">X</a>
						<input id="txtLengthb.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
