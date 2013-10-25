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
            var q_name = "vcce";
            var q_readonly = ['txtComp', 'txtAccno', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtWeight'];
            var q_readonlys = ['txtTotal', 'txtOrdeno', 'txtNo2'];
            var bbmNum = [['txtWeight', 10, 2, 1]];
            var bbsNum = [ ['txtWeight', 10, 2, 1], ['txtMount', 10, 2, 1], ['txtTheory', 10, 2, 1],['txtEweight', 10, 2, 1], ['txtEcount', 10, 2, 1],['txtAdjweight', 10, 2, 1], ['txtAdjcount', 10, 2, 1]];
            var bbmMask = [];
            var bbsMask = [['txtStyle', 'A']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick,tel,trantype,addr_fact', 'txtCustno,txtComp,txtNick,txtTel,cmbTrantype,txtAddr_post', 'cust_b.aspx'], ['txtStoreno2', 'lblStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx'], ['txtAddr_post', '', 'view_road', 'memo', '0txtAddr_post', 'road_b.aspx'], ['txtDeivery_addr', '', 'view_road', 'memo', '0txtDeivery_addr', 'road_b.aspx'], ['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,product,radius,dime,width,lengthb,spec,class', 'txtUno_,txtProductno_,txtProduct_,txtRadius_,txtDime_,txtWidth_,txtLengthb_,txtSpec_,txtClass_', 'uccc_seek_b.aspx', '95%', '60%'], ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];

                q_brwCount();
                q_gt('style', '', 0, 0, 0, '');
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
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
                var t_unit = '';
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
                    if ($('#cmbKind').val().substr(0, 1) == 'A') {
                        q_tr('txtDime_' + j, q_float('textSize1_' + j));
                        q_tr('txtWidth_' + j, q_float('textSize2_' + j));
                        q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
                        q_tr('txtRadius_' + j, q_float('textSize4_' + j));
                    } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                        q_tr('txtRadius_' + j, q_float('textSize1_' + j));
                        q_tr('txtWidth_' + j, q_float('textSize2_' + j));
                        q_tr('txtDime_' + j, q_float('textSize3_' + j));
                        q_tr('txtLengthb_' + j, q_float('textSize4_' + j));
                    } else {//鋼筋、胚
                        q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
                    }
                    getTheory(j);
                    //---------------------------------------
                    t_weight += q_float('txtWeight_' + j);
                }// j
                q_tr('txtWeight', t_weight);
            }

            function mainPost() {
                q_getFormat();
                q_cmbParse("cmbKind", q_getPara('sys.stktype'));
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                bbmMask = [['txtDatea', r_picd], ['txtCldate', r_picd]];
                q_mask(bbmMask);
                
                $('#cmbKind').change(function() {
                    size_change();
                    sum();
                });
                $("#cmbTrantype").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                /* 若非本會計年度則無法存檔 */
                $('#txtDatea').focusout(function() {
                    if ($(this).val().substr(0, 3) != r_accy) {
                        $('#btnOk').attr('disabled', 'disabled');
                        alert(q_getMsg('lblDatea') + '非本會計年度。');
                    } else {
                        $('#btnOk').removeAttr('disabled');
                    }
                });

                $('#btnOrdeimport').click(function() {
                    var t_ordeno = $('#txtOrdeno').val();
                    var t_where = ' 1=1 ';
                    var t_custno = trim($('#txtCustno').val());
                    if (t_ordeno.length > 0) {
                        t_where += q_sqlPara2('noa', t_ordeno);
                    }
                    t_where += q_sqlPara2('custno', t_custno);
                    q_box("ordet_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordet', "95%", "95%", q_getMsg('popOrde'));
                });
                $('#btnVcceImport').click(function() {
                    var t_ordeno = $('#txtOrdeno').val();
                    var t_custno = $('#txtCustno').val();
                    var t_where = '1=1 ';
                    t_where += q_sqlPara2('ordeno', t_ordeno) + q_sqlPara2('custno', t_custno) + " and ((len(gmemo)=0) or gmemo='cubu')";
                    q_box("vcce_import_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'view_vcce_import', "95%", "95%", q_getMsg('popVcceImport'));
                });
                $('#txtAddr_post').change(function() {
                    var t_custno = trim($(this).val());
                    if (!emp(t_custno)) {
                        focus_addr = $(this).attr('id');
                        var t_where = "where=^^ noa='" + t_custno + "' ^^";
                        q_gt('cust', t_where, 0, 0, 0, "");
                    }
                });
                $('#txtDeivery_addr').change(function() {
                    var t_custno = trim($(this).val());
                    if (!emp(t_custno)) {
                        focus_addr = $(this).attr('id');
                        var t_where = "where=^^ noa='" + t_custno + "' ^^";
                        q_gt('cust', t_where, 0, 0, 0, "");
                    }
                });
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
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtOrdeno,txtNo2,txtProductno,txtProduct,txtRadius,txtWidth,txtDime,txtLengthb,txtSpec,txtMount,txtWeight,txtPrice,txtStyle', b_ret.length, b_ret, 'uno,ordeno,no2,productno,product,radius,width,dime,lengthb,spec,mount,weight,price,style', '');
                            /// 最後 aEmpField 不可以有【數字欄位】
                            size_change();
                            for (var i = 0; i < ret.length; i++) {
                                $('#txtStyle_' + ret[i]).blur();
                            }
                            sum();
                        }
                        break;
                    case 'ordet':
                        if (q_cur > 0 && q_cur < 4) {
                            if (!b_ret || b_ret.length == 0) {
                                b_pop = '';
                                return;
                            }
                            for (var i = 0; i < q_bbsCount; i++) {
                                $('#btnMinus_' + i).click();
                            }
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtOrdeno,txtNo2,txtProductno,txtProduct,txtRadius,txtDime,txtWidth,txtLengthb,txtWeight,txtMount', b_ret.length, b_ret, 'uno,noa,no3,productno,product,radius,dime,width,lengthb,weight,mount', 'txtProductno');
                            /// 最後 aEmpField 不可以有【數字欄位】
                        }
                        sum();
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            var focus_addr = '';
            var StyleList = '';
            var t_uccArray = new Array;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'style' :
                        var as = _q_appendData("style", "", true);
                        StyleList = new Array();
                        StyleList = as;
                        break;
                    case 'cust':
                        var as = _q_appendData("cust", "", true);
                        if (as[0] != undefined && focus_addr != '') {
                            $('#' + focus_addr).val(as[0].addr_fact);
                            focus_addr = '';
                        }
                        break;
                    case q_name:
                        t_uccArray = _q_appendData("ucc", "", true);
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,11)=='checkOrde1_'){
                    		var t_sel = parseInt(t_name.split('_')[1]);
                    		var t_ordeno = t_name.split('_')[2];
                    		var t_no2 = t_name.split('_')[3];
                    		var as = _q_appendData("view_ordes", "", true);
                    		if(as[0]!=undefined){
                    			var t_mount = parseFloat(as[0].mount.length==0?"0":as[0].mount);
                    			var t_weight = parseFloat(as[0].weight.length==0?"0":as[0].weight);
                    			var t_where = "where=^^ ordeno='"+t_ordeno+"' and no2='"+t_no2+"' and noa!='"+$.trim($('#txtNoa').val())+"'^^";
            					q_gt('view_vcces',t_where,0,0,0,'checkOrde2_'+t_sel+'_'+t_ordeno+'_'+t_no2+'_'+t_mount+'_'+t_weight,r_accy);
                    		}else{
                    			alert('查無訂單資料【'+t_ordeno+'-'+t_no2+'】');
                    			Unlock();
                    		}
                    	}else if(t_name.substring(0,11)=='checkOrde2_'){
                    		var t_sel = parseInt(t_name.split('_')[1]);
                    		var t_ordeno = t_name.split('_')[2];
                    		var t_no2 = t_name.split('_')[3];
                    		var t_mount = parseFloat(t_name.split('_')[4]);
                    		var t_weight = parseFloat(t_name.split('_')[5]);
                    		var as = _q_appendData("view_vcces", "", true);
                    		var tot_mount=0,tot_weight=0;
                			var tot_mount2=0,tot_weight2=0;
                    		if(as[0]!=undefined){
                    			for(var i=0;i<as.length;i++){
                    				tot_mount = q_add(tot_mount,parseFloat(as[i].mount.length==0?"0":as[i].mount));
                    				tot_weight = q_add(tot_weight,parseFloat(as[i].weight.length==0?"0":as[i].weight));
                    			}
                    		}
                    		for(var i=0;i<q_bbsCount;i++){
                    				if($.trim($('#txtOrdeno_'+t_sel).val())==t_ordeno && $.trim($('#txtNo2_'+t_sel).val())==t_no2){
                    					tot_mount2 = q_add(tot_mount2,q_float('txtMount_'+t_sel));
                    					tot_weight2 = q_add(tot_weight2,q_float('txtWeight_'+t_sel));
                    				}
                    			}
                    			if($('#cmbKind').val()=='B2'){
                    				if(q_mul(t_mount,1.2)>=q_add(tot_mount,tot_mount2)){
	                    				checkOrde(t_sel-1);
	                    			}else{
	                    				alert("訂單【"+t_ordeno+"-"+t_no2+"】數量異常，超過１２％!\n訂數："+q_trv(t_mount,2)+"\n已派："+q_trv(tot_mount,2)+"\n本次："+q_trv(tot_mount2,2));
	                    				Unlock(1);
	                    			}
                    			}else{
                    				if(q_mul(t_weight,1.2)>=q_add(tot_weight,tot_weight2)){
	                    				checkOrde(t_sel-1);
	                    			}else{
	                    				alert("訂單【"+t_ordeno+"-"+t_no2+"】重量異常，超過１２％!\n訂重："+q_trv(t_weight,2)+"\n已派："+q_trv(tot_weight,2)+"\n本次："+q_trv(tot_weight2,2));
	                    				Unlock(1);
	                    			}
                    			}
                    	}
                }  /// end switch
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if (!q_cd($('#txtCldate').val())) {
                    alert(q_getMsg('lblCldate') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtDatea').val().substring(0, 3) != r_accy) {
                    alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
                    Unlock(1);
                    return;
                }
                if($.trim($('#txtNick').val()).length==0 && $.trim($('#txtComp').val()).length>0)
                	$('#txtNick').val($.trim($('#txtComp').val()).substring(0,4));
                sum();
				checkOrde(q_bbsCount-1);
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function checkOrde(n){
            	if(n<0){
            		if (q_cur == 1)
	                    $('#txtWorker').val(r_name);
	                else
	                    $('#txtWorker2').val(r_name);
            		var t_noa = trim($('#txtNoa').val());
	                var t_date = trim($('#txtDatea').val());
	                if (t_noa.length == 0 || t_noa == "AUTO")
	                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
	                else
	                    wrServer(t_noa);
            	}else{
            		//
            		var t_noa = $.trim($('#txtNoa').val());
            		var t_ordeno = $.trim($('#txtOrdeno_'+n).val());
            		var t_no2 = $.trim($('#txtNo2_'+n).val());
            		if(t_ordeno.length>0 && (($('#cmbKind').val()=='B2' && q_float('txtMount_'+n)!=0) || ($('#cmbKind').val()!='B2' && q_float('txtWeight_'+n)!=0))){
            			var t_where = "where=^^ noa='"+t_ordeno+"' and no2='"+t_no2+"'^^";
            			q_gt('view_ordes',t_where,0,0,0,'checkOrde1_'+n+'_'+t_ordeno+'_'+t_no2,r_accy);
            		}else{
            			checkOrde(n-1);
            		}
            	}
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('vccest_s.aspx', q_name + '_s', "520px", "450px", q_getMsg("popSeek"));
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
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtStyle_' + j).blur(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            ProductAddStyle(b_seq);
                        });
                        //將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
                        $('#textSize1_' + j).change(function() {
                            sum();
                        });
                        $('#textSize2_' + j).change(function() {
                            sum();
                        });
                        $('#textSize3_' + j).change(function() {
                            sum();
                        });
                        $('#textSize4_' + j).change(function() {
                            sum();
                        });
                        $('#txtSize_' + j).change(function(e) {
                            if ($.trim($(this).val).length == 0)
                                return;
                            var n = $(this).attr('id').replace('txtSize_', '');
                            var data = tranSize($.trim($(this).val()));
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
                        });
                        $('#txtMount_' + j).change(function() {
                            sum();
                        });
                        $('#txtWeight_' + j).change(function() {
                            sum();
                        });
                    }
                }
                _bbsAssign();
                size_change();
            }

            function btnIns() {
                _btnIns();
                $('#cmbKind').val(q_getPara('vcc.kind'));
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                size_change();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
                size_change();
            }

            function btnPrint() {
                q_box('z_vccestp.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['product'] && !as['uno'] && parseFloat(as['mount'].length == 0 ? "0" : as['mount']) == 0 && parseFloat(as['weight'].length == 0 ? "0" : as['weight']) == 0) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            ///////////////////////////////////////////////////
            function refresh(recno) {
                _refresh(recno);
                size_change();
                $('input[id*="txtProduct_"]').each(function() {
                    t_IdSeq = -1;
                    /// 要先給  才能使用 q_bodyId()
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
                        $('#txtStyle_' + b_seq).focus();
                        break;
                    case 'txtUno_':
                        size_change();
                        break;
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
                if ($('#cmbKind').val().substr(0, 1) == 'A') {
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
                        $('#txtSpec_' + j).css('width', '229px');
                        $('#textSize1_' + j).val($('#txtDime_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0);
                    }
                } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                    $('#lblSize_help').text(q_getPara('sys.lblSizeb'));
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).show();
                        $('#textSize2_' + j).show();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).show();
                        $('#x1_' + j).show();
                        $('#x2_' + j).show();
                        $('#x3_' + j).show();
                        $('#Size').css('width', '313px');
                        $('#txtSpec_' + j).css('width', '311px');
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
                        $('#Size').css('width', '65px');
                        $('#txtSpec_' + j).css('width', '60px');
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 210px;
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
						<td align="center" style="width:80px; color:black;"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
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
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><select id="cmbKind" class="txt" class="txt c1"> </select></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCldate" class="lbl"> </a></td>
						<td><input id="txtCldate"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="float:left;width:30%;"/>
							<input id="txtComp"  type="text" style="float:left;width:70%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblCaseno" class="lbl"> </a></td>
						<td><input id="txtCaseno"  type="text" class="txt c1"/></td>
						<td><input id="txtCaseno2"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTel" class="lbl"> </a></td>
						<td>
						<input id="txtTel"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
						<td><span> </span><a id="lblCardeal" class="lbl"> </a></td>
						<td><input id="txtCardeal"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td><input id="txtCarno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_post" class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtAddr_post"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblStype" class="lbl"> </a></td>
						<td><input id="txtStype"  type="text" class="txt c1"/></td>
						<td>
						<input id="btnSearchuno" type="button" />
						</td>
						<td>
						<input id="btnSearchstk" type="button" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDeivery_addr" class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtDeivery_addr"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td><input id="txtOrdeno"  type="text" class="txt c1"/></td>
						<td><input id="btnOrdeimport" type="button" title="only ordet"/></td>
						<td><input id="btnVcceImport" type="button" title="cut cubu"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo"  type="text" class="txt c1"/></td>
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
					<td align="center" style="width:200px;"><a id='lblUno_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:20px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProduct_st'> </a></td>
					<td align="center" id='Size'><a id='lblSize_help'> </a>
					<BR>
					<a id='lblSize_st'> </a></td>
					<td align="center" style="width:180px;"><a id='lblSizea_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:30px;"><a id='lblEnds_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblEweight_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblEcount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblAdjweight_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblAdjcount_s'> </a></td>
					<td align="center" style="width:170px;"><a id='lblMemo_s'> </a><br><a id='lblOrdeno_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input class="btn" id="btnUno.*" type="button" value='.' style="width:15px;"/>
					<input id="txtUno.*" type="text" style="width:170px;"/>
					</td>
					<td>
					<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:15px;float:left;" />
					<input  id="txtProductno.*" type="text" style="width:85px;" />
					<span style="display:block;width:15px;"> </span>
					<input id="txtClass.*" type="text" style='width: 85px;'/>
					</td>
					<td>
					<input type="text" id="txtStyle.*" style="width:90%;text-align:center;" />
					</td>
					<td>
					<input type="text" id="txtProduct.*" style="width:95%;" />
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
					<td>
					<input id="txtSize.*" type="text" style="width:95%;" />
					</td>
					<td >
					<input id="txtMount.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td >
					<input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td align="center" >
					<input id="chkEnda.*" type="checkbox"/>
					</td>
					<td >
					<input id="txtEweight.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
						<input id="txtEcount.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
						<input id="txtAdjweight.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
						<input id="txtAdjcount.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td >
					<input id="txtMemo.*" type="text" class="txt" style="width:95%;"/>
					<input id="txtOrdeno.*" type="text" style="width:65%;" />
					<input id="txtNo2.*" type="text" style="width:20%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
