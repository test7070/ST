﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;
            
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "payb";
            var q_readonly = ['txtVccno','txtAccno','txtNoa', 'txtMoney', 'txtTax', 'txtDiscount', 'txtTotal', 'txtWorker','txtWorker2','txtTotalus'];
            var q_readonlys = ['txtTotal','txtMoney'];
            var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtDiscount', 10, 0, 1], ['txtTotalus', 15, 2, 1], ['txtFloata', 15, 2, 1]];
            var bbsNum = [['txtPrice', 10, 0, 1], ['txtDiscount', 10, 0, 1], ['txtMount', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = -1;
            brwCount2 = 15;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //ajaxPath = "";
            aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtComp,txtNick', 'tgg_b.aspx']
            , ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx']
            , ['txtPayinvo_', '', 'invo', 'noa,comp', 'txtPayinvo_', '']
            , ['txtChgitemno_', 'btnChgitemno_', 'chgitem', 'noa,item,acc1,acc2', 'txtChgitemno_,txtChgitem_,txtAcc1_,txtAcc2_,txtMount_', 'chgitem_b.aspx']
            , ['txtProj_', '', 'proj', 'noa,proj', 'txtProj_', '']
            );
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
            }).mousedown(function (e) {
		        if (!$('#div_row').is(':hidden')) {
					$('#div_row').hide();
		        }
		    });
            
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);

            }
            
            function pop(form) {
                b_pop = form;
            }
            
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtIndate', r_picd],['txtDatea', r_picd], ['txtMon', r_picm], ['txtVbdate', r_picd], ['txtVedate', r_picd], ['txtPaydate', r_picd]];
                bbsMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_gt('acomp', '', 0, 0, 0, "");
                q_gt('part', '', 0, 0, 0, "");
                q_cmbParse("cmbTypea", q_getPara('payb.typea'));
                
                if (q_getPara('sys.project').toUpperCase() == 'RB') {
                	$('.dbbs').css('width','1400px');
                }
                
                if(q_db.substr( 0,2)!='dc')
                	$('#btnFix').hide();
                
                var kind=q_getPara('vcct.kind').split(',');
                 var t_kind='@';
                for(var i=0;i<kind.length;i++){
					if(kind[i].split('@')[0].substr(0,1)=='2')
						t_kind=t_kind+(t_kind.length>0?',':'')+kind[i];
	               
                }
                q_cmbParse("cmbVtype", t_kind,'s');
                
                $('#cmbTypea').change(function() {
                	typea_field();
                });
                
                $('#lblEntryno').click(function() {
                	if(!emp($('#txtEntryno').val())){
                		t_where = "entryno='" + $('#txtEntryno').val() + "'";
						q_box("delist.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'delist', "95%", "95%", '報關/贖單作業');
					}
				});
                
                $("#cmbCno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                
                $("#cmbPartno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                //........................下拉選單
                q_cmbParse("cmbKind", q_getPara('payb.kind'), 's');
                q_cmbParse("cmbXpayc", q_getMsg('payc').split('&').join());
                $("#cmbXpayc").change(function(e) {
                	if(q_cur==1 || q_cur==2){
                		$('#txtPayc').val($(this).find(":selected").text()); 
                		getIndate($('#txtDatea').val());
                	}
				});
                //.........................
                //........................單據匯入
                $('#btnFix').click(function() {
                	Lock(1,{opacity:0});
                    var t_noa = $.trim($('#txtNoa').val());
					var t_tggno = $.trim($('#txtTggno').val());
					var t_mon = $.trim($('#txtMon').val());				
					if(t_tggno.length>0 && t_mon.length>0){
						var t_where = "where=^^ (a.[money]!=0 or a.tax!=0 or a.discount!=0) and ((b.noa is null) or (b.noa is not null and b.noa='"+t_noa+"'))" 
                    	+ " and a.tggno='"+t_tggno+"' and a.mon='"+t_mon+"' ^^";
                    	var t_where1 = " where[1]=^^ (a.plusmoney!=0) and ((b.noa is null) or (b.noa is not null and b.noa='"+t_noa+"')) and a.tggno='"+t_tggno+"' ^^"
                    	q_gt('payb_fix', t_where+t_where1, 0, 0, 0, "", r_accy);
					}else{
						alert('請輸入'+q_getMsg('lblMon')+'、'+q_getMsg('lblTgg'));	
						Unlock(1);					
					}
                });
                //.........................
                $('#txtVedate').change(function() {
                    if (!emp($('#txtVedate').val()))
                        $('#txtMon').val($('#txtVedate').val().substr(0, r_lenm));
                });

                //........................會計傳票
                $('#lblAccno').click(function() {
                	var t_year=$('#txtDatea').val().substr(0,r_len);
                	if(r_len==4){
                		t_year=q_sub(t_year,1911);
                	}
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + t_year + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
                });
                //.........................
                $('#btnTgg').click(function() {
                    q_box('Tgg.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtTggno').val()), '', "95%", "600px", "廠商主檔");
                });
                $('#btnUcc').click(function() {
                    q_box('chgitem.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "600px", "費用主檔");

                });
                //--------------------------------------------
                $('#txtDatea').blur(function(e){
                	getPaydate($(this).val());
                	getIndate($(this).val());
                });
                //-----------------------
                $('#txtPayc').change(function(e){
                	getIndate($('#txtDatea').val());
                });
                
                $('#txtFloata').change(function() {
                	sum();
				});
				if (q_getPara('sys.project').toUpperCase() == 'RB') {
					$('.rbnoshow').hide();
				}
				
				//上方插入空白行
		        $('#lblTop_row').mousedown(function (e) {
		            if (e.button == 0) {
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
		            }
		        });
		        //下方插入空白行
		        $('#lblDown_row').mousedown(function (e) {
		            if (e.button == 0) {
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
		            }
		        });
            }
            
            function getNextMonth(date){
            	t_date = new Date(date.getFullYear(), date.getMonth(), 25);
            	t_date = new Date(t_date.getTime()+ 10*(1000 * 60 * 60 * 24));
            	t_date.setDate(1);
            	return t_date;     	
            }
            
            function getPaydate(date){
            	//付款日(立帳日次月第4個星期5)
            	if(q_cur==1 && date.length>0 && q_cd(date)){
		        	var t_year = parseInt(date.substring(0,r_len));
		        	if(r_len==3)
		        		t_year = parseInt(t_year)+1911;
		    		var t_mon = parseInt(date.substring(r_len+1,r_lenm)) - 1;
		    		var t_date = parseInt(date.substring(r_lenm+1,r_lend));
		    		
					var curdate = new Date(t_year,t_mon,t_date);           			
					var nextMon = nextMon = getNextMonth(curdate);	
		    		nextMon.setDate(27 - nextMon.getDay());
		    		
		    		if(r_len==3){
		    			t_year = nextMon.getFullYear()-1911;
		    		}
		    		t_year = '0000'+t_year;
		    		t_year = t_year.substring(t_year.length-r_len,t_year.length);
		    		
		    		t_mon = nextMon.getMonth()+1;
		    		t_mon = '00'+t_mon;
		    		t_mon = t_mon.substring(t_mon.length-2,t_mon.length);
		    		t_date = nextMon.getDate();
		    		t_date = '00'+t_date;
		    		t_date = t_date.substring(t_date.length-2,t_date.length);
		    		$('#txtPaydate').val(t_year+'/'+t_mon+'/'+t_date);
        		}
            }
            
            function getIndate(date){
            	//到期日(立帳日期(月) + 3個月又25天)
            	if(q_cur==1 && $('#txtPayc').val().indexOf('支票')>=0 && date.length>0 && q_cd(date)){
		        	var t_year = parseInt(date.substring(0,r_len));
		        	if(r_len==3)
		        		t_year = parseInt(t_year)+1911;
		    		var t_mon = parseInt(date.substring(r_len+1,r_lenm)) - 1;
		    		var t_date = parseInt(date.substring(r_lenm+1,r_lend));
		    		
					var curdate = new Date(t_year,t_mon,t_date); 
	            	var nextMon = getNextMonth(getNextMonth(getNextMonth(getNextMonth(curdate))));
	    			nextMon.setDate(25);
	    			
	    			if(r_len==3){
		    			t_year = nextMon.getFullYear()-1911;
		    		}
		    		t_year = '0000'+t_year;
		    		t_year = t_year.substring(t_year.length-r_len,t_year.length);
		    		
	        		t_mon = nextMon.getMonth()+1;
	        		t_mon = '00'+t_mon;
	        		t_mon = t_mon.substring(t_mon.length-2,t_mon.length);
	        		t_date = nextMon.getDate();
	        		t_date = '00'+t_date;
	        		t_date = t_date.substring(t_date.length-2,t_date.length);
	        		$('#txtIndate').val(t_year+'/'+t_mon+'/'+t_date);
        		}
            }
            
            function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
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

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'btnDele':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnDele();
                    	Unlock(1);
                		break;
                	case 'btnModi':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
	                	_btnModi();
	                	sum();
	                	Unlock(1);
                		$('#txtMemo').focus();
                		break;
                    case 'payb_fix':
                        var as = _q_appendData("payb_fix", "", true);
                        if (as[0] != undefined) {
                        	var n = 0;
                        	var t_partno = $('#cmbPartno').val();
                        	for(var i in as){
                        		if(as[i].partno == t_partno)
                        			n++;
                        	}
                        	q_gridAddRow(bbsHtm, 'tbbs', 'txtRc2no', as.length, as, 'noa', 'txtRc2no', '');
                        	//reset
	                        for (var j = 0; j < q_bbsCount; j++) {
	                            $('#txtRc2no_'+j).val('');
	                            $('#cmbKind_'+j).val('');
	                            $('#txtInvono_'+j).val('');
	                            $('#txtTax_'+j).val(0);
	                            $('#txtMount_'+j).val(0);
	                            $('#txtPrice_'+j).val(0);
	                            $('#txtDiscount_'+j).val(0);
	                            $('#txtMoney_'+j).val(0);
	                            $('#txtTotal_'+j).val(0);
	                            $('#txtMemo_'+j).val('');
	                            $('#txtAcc1_'+j).val('');
	                            $('#txtAcc2_'+j).val('');
	                            $('#txtBal_'+j).val('');
	                        }
	                        //insert
	                        var n = 0;
	                        for(var i in as){
	                        	if(as[i].partno == t_partno){
	                        		if(as[i].wmoney!=0 && as[i].cmoney!=0){
	                        			//維修&輪胎
	                        			$('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('維修');
			                            $('#txtInvono_'+n).val(as[i].invono);
			                            $('#txtTax_'+n).val(as[i].tax); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].wmoney);
			                            $('#txtDiscount_'+n).val(as[i].discount);
			                            $('#txtMoney_'+n).val(as[i].wmoney);
			                            $('#txtTotal_'+n).val(as[i].wmoney);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].wacc1);
			                            $('#txtAcc2_'+n).val(as[i].wacc2);
			                            $('#txtBal_'+n).val('');
			                            n++;
			                            //----------------------
			                            $('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('費用');
			                            $('#txtInvono_'+n).val('');
			                            $('#txtTax_'+n).val(0); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].cmoney);
			                            $('#txtDiscount_'+n).val(0);
			                            $('#txtMoney_'+n).val(as[i].cmoney);
			                            $('#txtTotal_'+n).val(as[i].cmoney);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].cacc1);
			                            $('#txtAcc2_'+n).val(as[i].cacc2);
			                            $('#txtBal_'+n).val('');
	                        		}else if(as[i].wmoney!=0){
	                        			//維修
	                        			$('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('維修');
			                            $('#txtInvono_'+n).val(as[i].invono);
			                            $('#txtTax_'+n).val(as[i].tax); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].wmoney);
			                            $('#txtDiscount_'+n).val(as[i].discount);
			                            $('#txtMoney_'+n).val(as[i].wmoney);
			                            $('#txtTotal_'+n).val(as[i].wmoney);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].wacc1);
			                            $('#txtAcc2_'+n).val(as[i].wacc2);
			                            $('#txtBal_'+n).val('');
	                        		}else if(as[i].cmoney!=0){
	                        			//輪胎
	                        			$('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('費用');
			                            $('#txtInvono_'+n).val(as[i].invono);
			                            $('#txtTax_'+n).val(as[i].tax); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].cmoney);
			                            $('#txtDiscount_'+n).val(as[i].discount);
			                            $('#txtMoney_'+n).val(as[i].cmoney);
			                            $('#txtTotal_'+n).val(as[i].cmoney);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].cacc1);
			                            $('#txtAcc2_'+n).val(as[i].cacc2);
			                            $('#txtBal_'+n).val('');
	                        		}else{
	                        			$('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('費用');
			                            $('#txtInvono_'+n).val(as[i].invono);
			                            $('#txtTax_'+n).val(as[i].tax); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].money);
			                            $('#txtDiscount_'+n).val(as[i].discount);
			                            $('#txtMoney_'+n).val(as[i].money);
			                            $('#txtTotal_'+n).val(as[i].money);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].acc1);
			                            $('#txtAcc2_'+n).val(as[i].acc2);
			                            $('#txtBal_'+n).val('');
	                        		}
	                        		n++;
	                        	}
	                        }
                        }
                        sum();
                        Unlock(1);
                        break;
                    case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                            q_cmbParse("cmbPartno", t_item);
                            if (abbm[q_recno] != undefined) {
                                $("#cmbPartno").val(abbm[q_recno].partno);
                            }
                        }
                        break;
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
                            var t_item = " @ ";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                            }
                            q_cmbParse("cmbCno", t_item);
                            if (abbm[q_recno] != undefined) {
                                $("#cmbCno").val(abbm[q_recno].cno);
                            }
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        if (q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }  /// end switch
            }
            
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString.split(";")[0];
                //abbm[q_recno]['payed'] = xmlString.split(";")[1];
                //abbm[q_recno]['unpay'] = xmlString.split(";")[2];
                //$('#txtAccno').val(xmlString.split(";")[0]);
                //$('#txtPayed').val(xmlString.split(";")[1]);
                //$('#txtUnpay').val(xmlString.split(";")[2]);
                Unlock(1);
            }
            
            function btnOk() {
            	Lock(1,{opacity:0});
                if ($.trim($('#txtNick').val()).length == 0)
                    $('#txtNick').val($('#txtComp').val());
                $('#txtAcomp').val($('#cmbCno').find(":selected").text());
                $('#txtPart').val($('#cmbPartno').find(":selected").text());

                if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
					
                if (!q_cd($('#txtPaydate').val())){
                	alert(q_getMsg('lblPaydate')+'錯誤。'); 
                	Unlock(1);
                	return;
                }
                if (!q_cd($('#txtIndate').val())){
                	alert(q_getMsg('lblIndate')+'錯誤。'); 
                	Unlock(1);
                	return;
                }
                if (!q_cd($('#txtVbdate').val()) || !q_cd($('#txtVedate').val())){
                	alert(q_getMsg('lblVdate')+'錯誤。');
                	Unlock(1); 
                	return; 
                }
               	if ($('#txtMon').val().length > 0 && r_lenm==6 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
                    return;
                }
                
                if ($('#txtMon').val().length > 0 && r_lenm==7 && !(/^[0-9]{4}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
                    return;
                }
                
                if(emp($('#txtMon').val()))
					$('#txtMon').val($('#txtDatea').val().substr(0,r_lenm));
                
                sum();
                
                var yufu=false;
                for (var j = 0; j < q_bbsCount; j++) {
                	if($('#cmbKind_'+j).val()!=null){
	                	if($('#cmbKind_'+j).val().indexOf('預付')>-1){
	                		yufu=true;
	                		break;
	                	}
                	}
                }
                if(yufu &&$('#txtPayc').val().indexOf('預付')==-1)
                	$('#txtPayc').val($('#txtPayc').val()+' 預付');
                	
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }
                
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_payb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('payb_s.aspx', q_name + '_s', "550px", "550px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_'+j).text(j+1);	
                	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                		$('#btnMinus_' + j).click(function() {
							btnMinus($(this).attr('id'));
						}).bind('contextmenu',function(e){ 
							e.preventDefault();
							////////////控制顯示位置
							$('#div_row').css('top', e.pageY);
							$('#div_row').css('left', e.pageX);
							////////////
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#div_row').show();
							row_b_seq = b_seq;
							row_bbsbbt = 'bbs';
						});
                		
                		$('#txtAcc1_' + j).change(function(e) {
		                    var patt = /^(\d{4})([^\.,.]*)$/g;
                    		$(this).val($(this).val().replace(patt,"$1.$2"));
                    		
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if(!emp($('#txtAcc1_'+b_seq).val())&&$('#txtAcc1_'+b_seq).val().substr(0,4)>='1400' && $('#txtAcc1_'+b_seq).val().substr(0,4)<='1491'){
								q_box("accz.aspx", 'ticket', "95%", "95%", q_getMsg("popAccz"));
							}
							
                		});
                		$('#txtMount_' + j).change(function(e) {
	                        sum();
	                    });
	                    $('#txtPrice_' + j).change(function(e) {
	                        sum();
	                    });
                		$('#txtMoney_' + j).change(function(e) {
	                        sum();
	                    });
	                    $('#txtTax_' + j).change(function(e) {
	                        sum();
	                    });
	                    $('#txtDiscount_' + j).change(function(e) {
	                        sum();
	                    });
                	}
                }
                _bbsAssign();
                typea_field();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                getPaydate(q_date());
                $('#txtMon').val(q_date().substr(0, r_lenm));
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                if (q_chkClose())
             		return;
                Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnModi',r_accy);
            }

            function btnPrint() {
			q_box('z_payb.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (as['payno'] =='' && as['chgitem'] =='' && as['memo'] =='' && as['acc1'] =='') {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            	var t_money=0,t_total=0,t_tax=0,t_discount=0;
            	var tot_money=0,tot_tax=0,tot_discount=0,tot_total=0;
            	var t_float = q_float('txtFloata');
            	var t_moneys = 0;
            	for (var j = 0; j < q_bbsCount; j++) {
            		if (t_float == 0) {
            			t_money = q_float('txtMount_'+j).mul(q_float('txtPrice_'+j)).round(0);
            			t_total = t_money.add(q_float('txtTax_'+j)).sub(q_float('txtDiscount_'+j));
	            		$('#txtMoney_'+j).val(FormatNumber(t_money));
	            		$('#txtTotal_'+j).val(FormatNumber(t_total));
	            		tot_money = tot_money.add(t_money);
	            		tot_tax = tot_tax.add(q_float('txtTax_'+j));
	            		tot_discount = tot_discount.add(q_float('txtDiscount_'+j));
	            		tot_total = tot_total.add(t_total);
	            		t_money=0;
            		}else{
            			//外幣合計
            			t_money = q_add(t_money,q_float('txtMount_'+j).mul(q_float('txtPrice_'+j)).round(0));
            			t_moneys = round(q_mul(q_float('txtMount_'+j).mul(q_float('txtPrice_'+j)).round(0), t_float), 0);
            			$('#txtMoney_'+j).val(FormatNumber(t_moneys));
            			t_total = t_moneys.add(q_float('txtTax_'+j)).sub(q_float('txtDiscount_'+j));
            			$('#txtTotal_'+j).val(FormatNumber(t_total));
            			tot_money = tot_money.add(t_moneys);
	            		tot_tax = tot_tax.add(q_float('txtTax_'+j));
	            		tot_discount = tot_discount.add(q_float('txtDiscount_'+j));
	            		tot_total = tot_total.add(t_total);
            		}
            	}
                $('#txtMoney').val(FormatNumber(tot_money));
            	$('#txtTax').val(FormatNumber(tot_tax));
            	$('#txtDiscount').val(FormatNumber(tot_discount));
            	$('#txtTotal').val(FormatNumber(tot_total));
            	$('#txtTotalus').val(FormatNumber(t_money));
            }

            function refresh(recno) {
                _refresh(recno);
                typea_field();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#btnFix').attr('disabled', 'disabled');
                } else {
                    $('#btnFix').removeAttr('disabled');
                }
                typea_field();
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
            	if (q_chkClose())
             		return;
            	Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnDele',r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
			Number.prototype.round = function(arg) {
			    return Math.round(this * Math.pow(10,arg))/ Math.pow(10,arg);
			}
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			}
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""))
			        r2 = Number(arg2.toString().replace(".", ""))
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			}
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length } catch (e) { }
			    try { m += s2.split(".")[1].length } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			}
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2))
			    return (arg1 * m + arg2 * m) / m
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			}
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((arg1 * m - arg2 * m) / m).toFixed(n));
			}
			
			function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtAcc1_':
		    			if(!emp($('#txtAcc1_'+b_seq).val())&&$('#txtAcc1_'+b_seq).val().substr(0,4)>='1400' && $('#txtAcc1_'+b_seq).val().substr(0,4)<='1491'){
							q_box("accz.aspx", 'ticket', "95%", "95%", q_getMsg("popAccz"));
						}
			        break;
		    	}
			}
			
			function typea_field() {
		    	if($('#cmbTypea').val()=='2'){
		    		$('.typea2').show();
		    	}else{
		    		$('.typea2').hide();
		    	}
			}
			
			var row_bbsbbt = ''; //判斷是bbs或bbt增加欄位
		    var row_b_seq = ''; //判斷第幾個row
		    //插入欄位
		    function q_bbs_addrow(bbsbbt, row, topdown) {
		        //取得目前行
		        var rows_b_seq = dec(row) + dec(topdown);
		        if (bbsbbt == 'bbs') {
		            q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
		            //目前行的資料往下移動
		            for (var i = q_bbsCount - 1; i >= rows_b_seq; i--) {
		                for (var j = 0; j < fbbs.length; j++) {
		                    if (i != rows_b_seq)
		                        $('#' + fbbs[j] + '_' + i).val($('#' + fbbs[j] + '_' + (i - 1)).val());
		                    else
		                        $('#' + fbbs[j] + '_' + i).val('');
		                }
		            }
		        }
		        if (bbsbbt == 'bbt') {
		            q_gridAddRow(bbtHtm, 'tbbt', fbbt, 1, '', '', '', '__');
		            //目前行的資料往下移動
		            for (var i = q_bbtCount - 1; i >= rows_b_seq; i--) {
		                for (var j = 0; j < fbbt.length; j++) {
		                    if (i != rows_b_seq)
		                        $('#' + fbbt[j] + '__' + i).val($('#' + fbbt[j] + '__' + (i - 1)).val());
		                    else
		                        $('#' + fbbt[j] + '__' + i).val('');
		                }
		            }
		        }
		        $('#div_row').hide();
		        row_bbsbbt = '';
		        row_b_seq = '';
		    }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 390px;
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
                width: 560px;
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
                width: 13%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs input[type="text"] {
                width: 95%;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"], select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
            <table id="table_row"  class="table_row" style="width:100%;" border="1" cellpadding='1'  cellspacing='0'>
                <tr>
                    <td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
                </tr>
                <tr>
                    <td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
                </tr>
            </table>
        </div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewTotal'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewUnpay'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" />
						</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="unpay,0,1" style="text-align: right;">~unpay,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td class="rbnoshow"><span> </span><a id='lblTypea'class="lbl" > </a></td>
						<td class="rbnoshow"><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"   type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text"  class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn" > </a></td>
						<td colspan="4">
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text"  style="display:none;"/>
						</td>	
					</tr>
					<tr>
						<td><span> </span><a id="lblPart" class="lbl" > </a></td>
						<td>
							<select id="cmbPartno" class="txt c1"> </select>
							<input id="txtPart"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblSales2" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtSalesno2" type="text" style="float:left; width:50%;"/>
							<input id="txtSales2" type="text" style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg"  class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text" style="float:left; width:20%;"/>
							<input id="txtComp"  type="text" style="float:left; width:80%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><input type="button" id="btnFix"  value="單據匯入"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPayc' class="lbl" style="font-size: 14px;"> </a></td>
						<td colspan="2">
							<input id="txtPayc" type="text" style="float:left; width:45%;"/>
							<select id="cmbXpayc" style="float:left; width:10%;"> </select>
							<input id="txtPaydate" type="text" style="float:left; width:45%;"/>
						</td>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblVdate'class="lbl" > </a></td>
						<td>	<input id="txtVbdate" type="text"  class="txt c1"/></td>
						<td><input id="txtVedate" type="text"  class="txt c1"/></td>
						<td class="typea2"><span> </span><a id='lblEntryno' class="lbl"> </a></td>
						<td class="typea2"><input id="txtEntryno" type="text" class="txt c1 typea2"/></td>
					</tr>						
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text"  class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDiscount' class="lbl"> </a></td>
						<td><input id="txtDiscount" type="text"  class="txt num c1" /></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td><input id="txtTotalus" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblVccno' class="lbl"> </a></td>
						<td><input id="txtVccno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPic' class="lbl"> </a></td>
						<td><input id="txtPic"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3" ><textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height:50px;"> </textarea></td>
						<td class="td8">
							<input id="btnTgg" type="button" style="float: left;"/>
							<input id="btnUcc" type="button" style="float: left;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:120px;"><a id='lblPayno'> </a></td>
					
					<td align="center" style="width:90px;"><a id='lblDatea_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblChgitem'> </a></td>
					<!--<td align="center" style="width:60px;">#<a id='lblKind'> </a></td>-->
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMoneys'> </a></td>
					<td align="center" style="width:130px;"><a id='lblInvonos'> </a><BR><a id='lblTaxs'> </a></td>
					<td align="center" style="width:50px;"><a id='lblVtypes'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotals'> </a></td>
					<td align="center" ><a id='lblMemos'> </a></td>				
					<td align="center" style="width:120px;display:none;"><a id='lblBal'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProj_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*"  style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtPayno.*" type="text"  style="width: 95%;"/></td>
			
					<td><input id="txtDatea.*" type="text"  style="width: 95%;"/></td>
					<td>
						<input id="txtChgitemno.*" type="text" style="text-align: left; width: 80%;" />
						<input class="btn"  id="btnChgitemno.*" type="button" value='.' style=" font-weight: bold;width: 1%;" />
						<input id="txtChgitem.*" type="text" style="text-align: left; width: 95%;" />
					</td>
					<!--<td><select id="cmbKind.*" style="width: 95%;"> </select></td>-->	
					<td>
						<input id="txtMount.*" type="text" style="text-align: right; width: 95%;" />
						<input id="txtPrice.*" type="text" style="text-align: right; width: 95%;" />
					</td>
					<td>
						<input id="txtMoney.*" type="text" style="text-align: right; width: 95%;"/>
						<input id="txtDiscount.*" type="text" style="text-align: right; width: 95%;" />
					</td>
					<td>
						<input id="txtInvono.*" type="text" style="width: 95%;"/>
						<input id="txtTax.*" type="text" style="text-align: right; width: 95%;" />
					</td>
					<td><select id="cmbVtype.*" style="width: 95%;"> </select></td>
					<td><input id="txtTotal.*" type="text" style="text-align: right; width: 95%;" /></td>
					<td>
						<input id="txtMemo.*" type="text" style=" width: 95%;"/>	
						<input class="btn"  id="btnAcc.*" type="button" value='.' style="float: left; font-weight: bold;width:1%;" />
						<input type="text" id="txtAcc1.*"  style="float: left;width:40%;"/>
						<input type="text" id="txtAcc2.*"  style="float: left;width:40%;"/>
					</td>
					<td style="display:none"><input id="txtBal.*" type="text" style="width: 95%;" /></td>
					<td><input id="txtProj.*" type="text" style="float: left;"></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

