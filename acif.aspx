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

            q_tables = 's';
            var q_name = "acif";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtComp','txtCoin'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 4;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(
            	['txtCno', 'lblAcomp', 'acomp', 'noa,acomp,nick,coin', 'txtCno,txtComp,txtNick,txtCoin', 'acomp_b.aspx'],
            	['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_,txtA01_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                
            }).mousedown(function (e) {
		        if (!$('#div_row').is(':hidden')) {
		            if (mouse_div) {
		                $('#div_row').hide();
		            }
		            mouse_div = true;
		        }
		    });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtYeara', r_pic],['txtCoin', 'AAA']];
                q_mask(bbmMask);
                var prec=dec(q_getPara('accc.prec'));
                bbsNum = [
                	['txtA01', 15, prec, 1],['txtB01', 15, prec, 1],['txtC01', 15, prec, 1],['txtD01', 15, prec, 1],['txtE01', 15, prec, 1],['txtF01', 15, prec, 1],['txtG01', 15, prec, 1],['txtH01', 15, prec, 1],['txtI01', 15, prec, 1],['txtJ01', 15, prec, 1],['txtK01', 15, prec, 1],['txtL01', 15, prec, 1],['txtM01', 15, prec, 1],['txtN01', 15, prec, 1],['txtO01', 15, prec, 1],['txtP01', 15, prec, 1],['txtQ01', 15, prec, 1],['txtR01', 15, prec, 1],['txtS01', 15, prec, 1],['txtT01', 15, prec, 1],['txtU01', 15, prec, 1],['txtV01', 15, prec, 1],['txtW01', 15, prec, 1],['txtX01', 15, prec, 1],['txtY01', 15, prec, 1],['txtZ01', 15, prec, 1]
	                ,['txtA02', 15, prec, 1],['txtB02', 15, prec, 1],['txtC02', 15, prec, 1],['txtD02', 15, prec, 1],['txtE02', 15, prec, 1],['txtF02', 15, prec, 1],['txtG02', 15, prec, 1],['txtH02', 15, prec, 1],['txtI02', 15, prec, 1],['txtJ02', 15, prec, 1],['txtK02', 15, prec, 1],['txtL02', 15, prec, 1],['txtM02', 15, prec, 1],['txtN02', 15, prec, 1],['txtO02', 15, prec, 1],['txtP02', 15, prec, 1],['txtQ02', 15, prec, 1],['txtR02', 15, prec, 1],['txtS02', 15, prec, 1],['txtT02', 15, prec, 1],['txtU02', 15, prec, 1],['txtV02', 15, prec, 1],['txtW02', 15, prec, 1],['txtX02', 15, prec, 1],['txtY02', 15, prec, 1],['txtZ02', 15, prec, 1]
	                ,['txtA03', 15, prec, 1],['txtB03', 15, prec, 1],['txtC03', 15, prec, 1],['txtD03', 15, prec, 1],['txtE03', 15, prec, 1],['txtF03', 15, prec, 1],['txtG03', 15, prec, 1],['txtH03', 15, prec, 1],['txtI03', 15, prec, 1],['txtJ03', 15, prec, 1],['txtK03', 15, prec, 1],['txtL03', 15, prec, 1],['txtM03', 15, prec, 1],['txtN03', 15, prec, 1],['txtO03', 15, prec, 1],['txtP03', 15, prec, 1],['txtQ03', 15, prec, 1],['txtR03', 15, prec, 1],['txtS03', 15, prec, 1],['txtT03', 15, prec, 1],['txtU03', 15, prec, 1],['txtV03', 15, prec, 1],['txtW03', 15, prec, 1],['txtX03', 15, prec, 1],['txtY03', 15, prec, 1],['txtZ03', 15, prec, 1]
	                ,['txtA04', 15, 5, 1],['txtB04', 15, 5, 1],['txtC04', 15, 5, 1],['txtD04', 15, 5, 1],['txtE04', 15, 5, 1],['txtF04', 15, 5, 1],['txtG04', 15, 5, 1],['txtH04', 15, 5, 1],['txtI04', 15, 5, 1],['txtJ04', 15, 5, 1],['txtK04', 15, 5, 1],['txtL04', 15, 5, 1],['txtM04', 15, 5, 1],['txtN04', 15, 5, 1],['txtO04', 15, 5, 1],['txtP04', 15, 5, 1],['txtQ04', 15, 5, 1],['txtR04', 15, 5, 1],['txtS04', 15, 5, 1],['txtT04', 15, 5, 1],['txtU04', 15, 5, 1],['txtV04', 15, 5, 1],['txtW04', 15, 5, 1],['txtX04', 15, 5, 1],['txtY04', 15, 5, 1],['txtZ04', 15, 5, 1]
	                ,['txtA05', 15, prec, 1],['txtB05', 15, prec, 1],['txtC05', 15, prec, 1],['txtD05', 15, prec, 1],['txtE05', 15, prec, 1],['txtF05', 15, prec, 1],['txtG05', 15, prec, 1],['txtH05', 15, prec, 1],['txtI05', 15, prec, 1],['txtJ05', 15, prec, 1],['txtK05', 15, prec, 1],['txtL05', 15, prec, 1],['txtM05', 15, prec, 1],['txtN05', 15, prec, 1],['txtO05', 15, prec, 1],['txtP05', 15, prec, 1],['txtQ05', 15, prec, 1],['txtR05', 15, prec, 1],['txtS05', 15, prec, 1],['txtT05', 15, prec, 1],['txtU05', 15, prec, 1],['txtV05', 15, prec, 1],['txtW05', 15, prec, 1],['txtX05', 15, prec, 1],['txtY05', 15, prec, 1],['txtZ05', 15, prec, 1]
                ];
                
                $('#btnMergeacccs').click(function() {
                	if(!emp($('#txtCno').val()) && !emp($('#txtYeara').val())){
						var t_hostname=location.hostname;
	                	q_func('qtxt.query.acif', 'acif.txt,acif,' 
							+encodeURI(q_getPara('sys.project').toUpperCase())
							+';'+encodeURI($('#txtCno').val())
							+';'+encodeURI($('#txtYeara').val())
							+';'+encodeURI(r_len)
							+';'+encodeURI(t_hostname)
							+';'+encodeURI(q_db)
							+';'+encodeURI(r_userno)
						);
					}else{
						alert('【公司編號】與【立帳年度】禁止空白!!');
					}
                });
                
                $('#combLang').change(function() {
                	langcopy();
				});
				
				//上方插入空白行
		        $('#lblTop_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
		            }
		        });
		        //下方插入空白行
		        $('#lblDown_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
		            }
		        });
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                } 
            }

            function btnOk() {
                var t_err = q_chkEmpField([['txtYeara', q_getMsg('lblYeara')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
                
               	var t_noa = trim($('#txtNoa').val());
		        var t_year = trim($('#txtYeara').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll('IF' + (t_year.length == 0 ? q_date().substr(0,r_len) : t_year), '/', ''));
		        else
		            wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('acif_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')){
                    	$('.num').change(function() {
                    		sum();
						});
						
						$('#btnMinus_' + j).bind('contextmenu', function (e) {
							if (e.button == 2) {
								e.preventDefault();
			                    mouse_div = true;
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
							}
		                });
                    }
                }
                _bbsAssign();
                langcopy();
            }
            
            function langcopy() {
            	var tlbl1=q_getMsg('lblA01');
            	var tlbl2=q_getMsg('lblA02');
            	var tlbl3=q_getMsg('lblA03');
            	var tlbl4=q_getMsg('lblA04');
            	var tlbl5=q_getMsg('lblA05');
            	//65=A,90=Z
            	
            	var t_hidea=0;//本公司隱藏內容
            	for(var i=65;i<=90;i++){
            		var tlbl=String.fromCharCode(i);
            		$('#lbl'+tlbl+'01').text(tlbl1);
            		$('#lbl'+tlbl+'02').text(tlbl2);
            		$('#lbl'+tlbl+'03').text(tlbl3);
            		$('#lbl'+tlbl+'04').text(tlbl4);
            		$('#lbl'+tlbl+'05').text(tlbl5);
            		
            		var t_comp=$('#txt'+tlbl+'nick').val().length>0?$('#txt'+tlbl+'nick').val():$('#txt'+tlbl+'comp').val();
            		var t_coin=$('#txt'+tlbl+'coin').val();
            		var t_cno=$('#txt'+tlbl+'cno').val();
            		
            		$('#labl'+tlbl+'01').html(tlbl+(t_comp.length>0?' '+t_comp:'')+(t_coin.length>0?'<BR>'+t_coin:''));
            		
            		//隱藏本公司或幣別相同 的 匯率與轉換後
            		var ttlbl=String.fromCharCode(i).toLowerCase();
            		if((t_cno==$('#txtCno').val() || t_coin==$('#txtCoin').val()) && t_cno.length>0){
            			$('.f'+ttlbl+'4').hide();
            			$('.f'+ttlbl+'5').hide();
            			$('#topbbs .comp-'+ttlbl+'').css('width','360px');
            			t_hidea=q_add(t_hidea,240);
            		}else{
            			$('#topbbs .comp-'+ttlbl+'').css('width','600px');
            		}
            	}
            	
            	var t_width=16645;//總寬度
                var t_dwidth=0;//每隱藏一間公司少600
                //只會用到5間公司
                if(q_getPara('sys.project').toUpperCase()=='JO' || q_getPara('sys.project').toUpperCase()=='AD'){
                	//F之後的公司隱藏
                	//97=a,122=z
                	for(var i=97;i<=122;i++){
                		if(i>102){
                			var tclass=String.fromCharCode(i);
                			$('.comp-'+tclass).hide();
                			
                			t_dwidth=t_dwidth+600;
                		}
                	}
                }
                t_width=t_width-t_dwidth-t_hidea;
                $('.dbbs').css('width',t_width.toString()+'px');
                $('#tbbs').css('width',t_width.toString()+'px')
                $('.topbbs').css('width',t_width.toString()+'px');
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtYeara').focus();
                
                if(q_date().slice(-5)<'03/01'){
                	$('#txtYeara').val(('0000'+(dec(q_date().substr(0,r_len))-1).toString()).slice(-1*r_len));
                }else{
                	$('#txtYeara').val(q_date().substr(0,r_len));
                }
                
                var t_db=q_db.toLocaleUpperCase();
                q_gt('acomp', "where=^^(dbname='"+t_db+"' or not exists (select * from acomp where dbname='"+t_db+"')) ^^ stop=1", 0, 0, 0, "cno_acomp",r_accy,1);
                
                var as = _q_appendData("acomp", "", true);
				if (as[0] != undefined) {
					$('#txtCno').val(as[0].noa);
					$('#txtComp').val(as[0].acomp);
					$('#txtNick').val(as[0].nick);
					$('#txtCoin').val(as[0].coin);
				}
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                sum();
            }

            function btnPrint() {
				q_box('z_acifp.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['acc1'] && !as['acc2']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
			
			function sum() {
				var prec=dec(q_getPara('accc.prec'));
				//65=A,90=Z
				var t_maxcno=90; //避免不必要的計算時間
				if(q_getPara('sys.project').toUpperCase()=='JO' || q_getPara('sys.project').toUpperCase()=='AD'){
					t_maxcno=69; //只用5間公司
				}
            	for(var i=65;i<=t_maxcno;i++){
            		var tcno=String.fromCharCode(i);
            		var t1_1=0,t1_2=0,t1_3=0,t1_5=0;//大類合計
					var t2_1=0,t2_2=0,t2_3=0,t2_5=0;//中類合計
					var s_1=0,s_2=0,s_3=0,s_5=0;//特殊2和3合計
					for (var j = 0; j < q_bbsCount; j++) {
						//---------------------------------------------------------------------------
						$('#txt'+tcno+'03_'+j).val(dec($('#txt'+tcno+'01_'+j).val())-dec($('#txt'+tcno+'02_'+j).val()));
						$('#txt'+tcno+'05_'+j).val(round(q_mul(dec($('#txt'+tcno+'03_'+j).val()),dec($('#txt'+tcno+'04_'+j).val())),prec));
						//-----------------------------------------------------------------------------
						var tacc1=$('#txtAcc1_'+j).val();
						var tacc2=$('#txtAcc2_'+j).val();
						var tm01=dec($('#txt'+tcno+'01_'+j).val());
						var tm02=dec($('#txt'+tcno+'02_'+j).val());
						var tm03=dec($('#txt'+tcno+'03_'+j).val());
						var tm04=dec($('#txt'+tcno+'04_'+j).val());
						var tm05=dec($('#txt'+tcno+'05_'+j).val());
						
						if((tacc1.toUpperCase().indexOf('X')>0 || tacc1=='') && (tacc2.indexOf('合計：')>0 || tacc2.indexOf('總計：')>0)){
							//合計 和 總計
							if(tacc2.indexOf('負債及權益-總計：')>-1){
								$('#txt'+tcno+'01_'+j).val(s_1);
								$('#txt'+tcno+'02_'+j).val(s_2);
								$('#txt'+tcno+'03_'+j).val(s_3);
								$('#txt'+tcno+'05_'+j).val(s_5);
								
								s_1=0,s_2=0,s_3=0,s_5=0;
								t2_1=0,t2_2=0,t2_3=0,t2_5=0;
								t1_1=0,t1_2=0,t1_3=0,t1_5=0;
							}else if(tacc2.indexOf('合計：')>0){
								$('#txt'+tcno+'01_'+j).val(t2_1);
								$('#txt'+tcno+'02_'+j).val(t2_2);
								$('#txt'+tcno+'03_'+j).val(t2_3);
								$('#txt'+tcno+'05_'+j).val(t2_5);
								
								t2_1=0,t2_2=0,t2_3=0,t2_5=0;
							}else if(tacc2.indexOf('總計：')>0){
								$('#txt'+tcno+'01_'+j).val(t1_1);
								$('#txt'+tcno+'02_'+j).val(t1_2);
								$('#txt'+tcno+'03_'+j).val(t1_3);
								$('#txt'+tcno+'05_'+j).val(t1_5);
								
								t2_1=0,t2_2=0,t2_3=0,t2_5=0;
								t1_1=0,t1_2=0,t1_3=0,t1_5=0;
							}
							
						}else if (tacc1.length>0 && tacc1.toUpperCase().indexOf('X')==-1){
							//一般科目
							var s1=tacc1.substr(0,1);
							var s2=tacc1.substr(0,2);
							
							t1_1=q_add(t1_1,tm01);
							t1_2=q_add(t1_2,tm02);
							t1_3=q_add(t1_3,tm03);
							t1_5=q_add(t1_5,tm05);
								
							t2_1=q_add(t2_1,tm01);
							t2_2=q_add(t2_2,tm02);
							t2_3=q_add(t2_3,tm03);
							t2_5=q_add(t2_5,tm05);
							
							if(s1=='2' || s1=='3'){
								s_1=q_add(s_1,tm01);
								s_2=q_add(s_2,tm02);
								s_3=q_add(s_3,tm03);
								s_5=q_add(s_5,tm05);
							}
						}
						
						//合併總金額
	                	var bmoney=0;
	                	bmoney=dec($('#txtA05_'+j).val())+dec($('#txtB05_'+j).val())+dec($('#txtC05_'+j).val())+
	                	dec($('#txtD05_'+j).val())+dec($('#txtE05_'+j).val())+dec($('#txtF05_'+j).val())+
	                	dec($('#txtG05_'+j).val())+dec($('#txtH05_'+j).val())+dec($('#txtI05_'+j).val())+
	                	dec($('#txtJ05_'+j).val())+dec($('#txtK05_'+j).val())+dec($('#txtL05_'+j).val())+
	                	dec($('#txtM05_'+j).val())+dec($('#txtN05_'+j).val())+dec($('#txtO05_'+j).val())+
	                	dec($('#txtP05_'+j).val())+dec($('#txtQ05_'+j).val())+dec($('#txtR05_'+j).val())+
	                	dec($('#txtS05_'+j).val())+dec($('#txtT05_'+j).val())+dec($('#txtU05_'+j).val())+
	                	dec($('#txtV05_'+j).val())+dec($('#txtW05_'+j).val())+dec($('#txtX05_'+j).val())+
	                	dec($('#txtY05_'+j).val())+dec($('#txtZ05_'+j).val());
	                	$('#txtBmoney_'+j).val(bmoney);
	                	$('#txtEmoney_'+j).val(bmoney+(dec($('#txtDmoney_'+j).val())-dec($('#txtDmoney_'+j).val())));
					}
				}
			}

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$('#btnMergeacccs').attr('disabled', 'disabled');
                	$('#div_row').hide();
                }else{
                	$('#btnMergeacccs').removeAttr('disabled');
                }
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
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.acif':
                	var as = _q_appendData("tmp0", "", true, true);
                	if (as[0] != undefined) {
                		$('#txtAcno').val(as[0].acno);
                		$('#txtBcno').val(as[0].bcno);
                		$('#txtCcno').val(as[0].ccno);
                		$('#txtDcno').val(as[0].dcno);
                		$('#txtEcno').val(as[0].ecno);
                		$('#txtFcno').val(as[0].fcno);
                		$('#txtGcno').val(as[0].gcno);
                		$('#txtHcno').val(as[0].hcno);
                		$('#txtIcno').val(as[0].icno);
                		$('#txtJcno').val(as[0].jcno);
                		$('#txtKcno').val(as[0].kcno);
                		$('#txtLcno').val(as[0].lcno);
                		$('#txtMcno').val(as[0].mcno);
                		$('#txtNcno').val(as[0].ncno);
                		$('#txtOcno').val(as[0].ocno);
                		$('#txtPcno').val(as[0].pcno);
                		$('#txtQcno').val(as[0].qcno);
                		$('#txtRcno').val(as[0].rcno);
                		$('#txtScno').val(as[0].scno);
                		$('#txtTcno').val(as[0].tcno);
                		$('#txtUcno').val(as[0].ucno);
                		$('#txtVcno').val(as[0].vcno);
                		$('#txtWcno').val(as[0].wcno);
                		$('#txtXcno').val(as[0].xcno);
                		$('#txtYcno').val(as[0].ycno);
                		$('#txtZcno').val(as[0].zcno);
                		
                		$('#txtAcomp').val(as[0].acomp);
                		$('#txtBcomp').val(as[0].bcomp);
                		$('#txtCcomp').val(as[0].ccomp);
                		$('#txtDcomp').val(as[0].dcomp);
                		$('#txtEcomp').val(as[0].ecomp);
                		$('#txtFcomp').val(as[0].fcomp);
                		$('#txtGcomp').val(as[0].gcomp);
                		$('#txtHcomp').val(as[0].hcomp);
                		$('#txtIcomp').val(as[0].icomp);
                		$('#txtJcomp').val(as[0].jcomp);
                		$('#txtKcomp').val(as[0].kcomp);
                		$('#txtLcomp').val(as[0].lcomp);
                		$('#txtMcomp').val(as[0].mcomp);
                		$('#txtNcomp').val(as[0].ncomp);
                		$('#txtOcomp').val(as[0].ocomp);
                		$('#txtPcomp').val(as[0].pcomp);
                		$('#txtQcomp').val(as[0].qcomp);
                		$('#txtRcomp').val(as[0].rcomp);
                		$('#txtScomp').val(as[0].scomp);
                		$('#txtTcomp').val(as[0].tcomp);
                		$('#txtUcomp').val(as[0].ucomp);
                		$('#txtVcomp').val(as[0].vcomp);
                		$('#txtWcomp').val(as[0].wcomp);
                		$('#txtXcomp').val(as[0].xcomp);
                		$('#txtYcomp').val(as[0].ycomp);
                		$('#txtZcomp').val(as[0].zcomp);
                		
                		$('#txtAnick').val(as[0].anick);
                		$('#txtBnick').val(as[0].bnick);
                		$('#txtCnick').val(as[0].cnick);
                		$('#txtDnick').val(as[0].dnick);
                		$('#txtEnick').val(as[0].enick);
                		$('#txtFnick').val(as[0].fnick);
                		$('#txtGnick').val(as[0].gnick);
                		$('#txtHnick').val(as[0].hnick);
                		$('#txtInick').val(as[0].inick);
                		$('#txtJnick').val(as[0].jnick);
                		$('#txtKnick').val(as[0].knick);
                		$('#txtLnick').val(as[0].lnick);
                		$('#txtMnick').val(as[0].mnick);
                		$('#txtNnick').val(as[0].nnick);
                		$('#txtOnick').val(as[0].onick);
                		$('#txtPnick').val(as[0].pnick);
                		$('#txtQnick').val(as[0].qnick);
                		$('#txtRnick').val(as[0].rnick);
                		$('#txtSnick').val(as[0].snick);
                		$('#txtTnick').val(as[0].tnick);
                		$('#txtUnick').val(as[0].unick);
                		$('#txtVnick').val(as[0].vnick);
                		$('#txtWnick').val(as[0].wnick);
                		$('#txtXnick').val(as[0].xnick);
                		$('#txtYnick').val(as[0].ynick);
                		$('#txtZnick').val(as[0].znick);
                		
                		$('#txtAcoin').val(as[0].acoin);
                		$('#txtBcoin').val(as[0].bcoin);
                		$('#txtCcoin').val(as[0].ccoin);
                		$('#txtDcoin').val(as[0].dcoin);
                		$('#txtEcoin').val(as[0].ecoin);
                		$('#txtFcoin').val(as[0].fcoin);
                		$('#txtGcoin').val(as[0].gcoin);
                		$('#txtHcoin').val(as[0].hcoin);
                		$('#txtIcoin').val(as[0].icoin);
                		$('#txtJcoin').val(as[0].jcoin);
                		$('#txtKcoin').val(as[0].kcoin);
                		$('#txtLcoin').val(as[0].lcoin);
                		$('#txtMcoin').val(as[0].mcoin);
                		$('#txtNcoin').val(as[0].ncoin);
                		$('#txtOcoin').val(as[0].ocoin);
                		$('#txtPcoin').val(as[0].pcoin);
                		$('#txtQcoin').val(as[0].qcoin);
                		$('#txtRcoin').val(as[0].rcoin);
                		$('#txtScoin').val(as[0].scoin);
                		$('#txtTcoin').val(as[0].tcoin);
                		$('#txtUcoin').val(as[0].ucoin);
                		$('#txtVcoin').val(as[0].vcoin);
                		$('#txtWcoin').val(as[0].wcoin);
                		$('#txtXcoin').val(as[0].xcoin);
                		$('#txtYcoin').val(as[0].ycoin);
                		$('#txtZcoin').val(as[0].zcoin);
                		
                		//清除表身
                		for (var j = 0; j < q_bbsCount; j++) {
                			$('#btnMinus_'+j).click();
                		}
                		
                		for (var i = 0; i < as.length; i++) {
                			if(as[i].tacc1=='1ZZ.' || as[i].tacc1=='2ZZ.' || as[i].tacc1=='3ZZ.'){ //資產-總計： & 負債-總計： & 權益-總計：
                				as[i].acc1='';
                			}	
                		}
                		
                		q_gridAddRow(bbsHtm, 'tbbs'
                		, 'txtAcc1,txtAcc2,txtA01,txtA02,txtA03,txtA04,txtA05,txtB01,txtB02,txtB03,txtB04,txtB05,txtC01,txtC02,txtC03,txtC04,txtC05,txtD01,txtD02,txtD03,txtD04,txtD05,txtE01,txtE02,txtE03,txtE04,txtE05,txtF01,txtF02,txtF03,txtF04,txtF05,txtG01,txtG02,txtG03,txtG04,txtG05,txtH01,txtH02,txtH03,txtH04,txtH05,txtI01,txtI02,txtI03,txtI04,txtI05,txtJ01,txtJ02,txtJ03,txtJ04,txtJ05,txtK01,txtK02,txtK03,txtK04,txtK05,txtL01,txtL02,txtL03,txtL04,txtL05,txtM01,txtM02,txtM03,txtM04,txtM05,txtN01,txtN02,txtN03,txtN04,txtN05,txtO01,txtO02,txtO03,txtO04,txtO05,txtP01,txtP02,txtP03,txtP04,txtP05,txtQ01,txtQ02,txtQ03,txtQ04,txtQ05,txtR01,txtR02,txtR03,txtR04,txtR05,txtS01,txtS02,txtS03,txtS04,txtS05,txtT01,txtT02,txtT03,txtT04,txtT05,txtU01,txtU02,txtU03,txtU04,txtU05,txtV01,txtV02,txtV03,txtV04,txtV05,txtW01,txtW02,txtW03,txtW04,txtW05,txtX01,txtX02,txtX03,txtX04,txtX05,txtY01,txtY02,txtY03,txtY04,txtY05,txtZ01,txtZ02,txtZ03,txtZ04,txtZ05'
                		, as.length, as
                		, 'acc1,acc2,a01,a02,a03,a04,a05,b01,b02,b03,b04,b05,c01,c02,c03,c04,c05,d01,d02,d03,d04,d05,e01,e02,e03,e04,e05,f01,f02,f03,f04,f05,g01,g02,g03,g04,g05,h01,h02,h03,h04,h05,i01,i02,i03,i04,i05,j01,j02,j03,j04,j05,k01,k02,k03,k04,k05,l01,l02,l03,l04,l05,m01,m02,m03,m04,m05,n01,n02,n03,n04,n05,o01,o02,o03,o04,o05,p01,p02,p03,p04,p05,q01,q02,q03,q04,q05,r01,r02,r03,r04,r05,s01,s02,s03,s04,s05,t01,t02,t03,t04,t05,u01,u02,u03,u04,u05,v01,v02,v03,v04,v05,w01,w02,w03,w04,w05,x01,x02,x03,x04,x05,y01,y02,y03,y04,y05,z01,z02,z03,z04,z05', 'txtAcc1', '');
                		
                		sum();
                	}else{
                		alert('無會計資料!!');
                	}
                	langcopy();
                	break;
                }
			}
			
			var mouse_div = true; //控制滑鼠消失div
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
                width: 120px;
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
                width: 690px;
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
            }
            .dbbs {
                width: 16645px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"],select {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            #div_row{
				display:none;
				width:750px;
				background-color: #ffffff;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
			.table_row tr td .lbl.btn {
                color: #000000;
                font-weight: bolder;
                font-size: medium;
                cursor: pointer;
            }
            .table_row tr td .lbl.btn:hover {
                color: #FF8F19;
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
						<td align="center" style="width:80px; color:black;"><a id='vewYeara'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="yeara" style="text-align: center;">~yeara</td>
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
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/> </td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblYeara' class="lbl"> </a></td>
						<td><input id="txtYeara" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblCno' class="lbl"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="btnMergeacccs" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCoin' class="lbl"> </a></td>
						<td><input id="txtCoin" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtComp" type="text" class="txt c1"/>
							<input id="txtNick" type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtMemo" type="text" class="txt c1"/>
							
							<input id="txtAcno" type="hidden" class="txt c1"/><input id="txtBcno" type="hidden" class="txt c1"/><input id="txtCcno" type="hidden" class="txt c1"/>
							<input id="txtDcno" type="hidden" class="txt c1"/><input id="txtEcno" type="hidden" class="txt c1"/><input id="txtFcno" type="hidden" class="txt c1"/>
							<input id="txtGcno" type="hidden" class="txt c1"/><input id="txtHcno" type="hidden" class="txt c1"/><input id="txtIcno" type="hidden" class="txt c1"/>
							<input id="txtJcno" type="hidden" class="txt c1"/><input id="txtKcno" type="hidden" class="txt c1"/><input id="txtLcno" type="hidden" class="txt c1"/>
							<input id="txtMcno" type="hidden" class="txt c1"/><input id="txtNcno" type="hidden" class="txt c1"/><input id="txtOcno" type="hidden" class="txt c1"/>
							<input id="txtPcno" type="hidden" class="txt c1"/><input id="txtQcno" type="hidden" class="txt c1"/><input id="txtRcno" type="hidden" class="txt c1"/>
							<input id="txtScno" type="hidden" class="txt c1"/><input id="txtTcno" type="hidden" class="txt c1"/><input id="txtUcno" type="hidden" class="txt c1"/>
							<input id="txtVcno" type="hidden" class="txt c1"/><input id="txtWcno" type="hidden" class="txt c1"/><input id="txtXcno" type="hidden" class="txt c1"/>
							<input id="txtYcno" type="hidden" class="txt c1"/><input id="txtZcno" type="hidden" class="txt c1"/>
							
							<input id="txtAcomp" type="hidden" class="txt c1"/><input id="txtBcomp" type="hidden" class="txt c1"/><input id="txtCcomp" type="hidden" class="txt c1"/>
							<input id="txtDcomp" type="hidden" class="txt c1"/><input id="txtEcomp" type="hidden" class="txt c1"/><input id="txtFcomp" type="hidden" class="txt c1"/>
							<input id="txtGcomp" type="hidden" class="txt c1"/><input id="txtHcomp" type="hidden" class="txt c1"/><input id="txtIcomp" type="hidden" class="txt c1"/>
							<input id="txtJcomp" type="hidden" class="txt c1"/><input id="txtKcomp" type="hidden" class="txt c1"/><input id="txtLcomp" type="hidden" class="txt c1"/>
							<input id="txtMcomp" type="hidden" class="txt c1"/><input id="txtNcomp" type="hidden" class="txt c1"/><input id="txtOcomp" type="hidden" class="txt c1"/>
							<input id="txtPcomp" type="hidden" class="txt c1"/><input id="txtQcomp" type="hidden" class="txt c1"/><input id="txtRcomp" type="hidden" class="txt c1"/>
							<input id="txtScomp" type="hidden" class="txt c1"/><input id="txtTcomp" type="hidden" class="txt c1"/><input id="txtUcomp" type="hidden" class="txt c1"/>
							<input id="txtVcomp" type="hidden" class="txt c1"/><input id="txtWcomp" type="hidden" class="txt c1"/><input id="txtXcomp" type="hidden" class="txt c1"/>
							<input id="txtYcomp" type="hidden" class="txt c1"/><input id="txtZcomp" type="hidden" class="txt c1"/>
							
							<input id="txtAnick" type="hidden" class="txt c1"/><input id="txtBnick" type="hidden" class="txt c1"/><input id="txtCnick" type="hidden" class="txt c1"/>
							<input id="txtDnick" type="hidden" class="txt c1"/><input id="txtEnick" type="hidden" class="txt c1"/><input id="txtFnick" type="hidden" class="txt c1"/>
							<input id="txtGnick" type="hidden" class="txt c1"/><input id="txtHnick" type="hidden" class="txt c1"/><input id="txtInick" type="hidden" class="txt c1"/>
							<input id="txtJnick" type="hidden" class="txt c1"/><input id="txtKnick" type="hidden" class="txt c1"/><input id="txtLnick" type="hidden" class="txt c1"/>
							<input id="txtMnick" type="hidden" class="txt c1"/><input id="txtNnick" type="hidden" class="txt c1"/><input id="txtOnick" type="hidden" class="txt c1"/>
							<input id="txtPnick" type="hidden" class="txt c1"/><input id="txtQnick" type="hidden" class="txt c1"/><input id="txtRnick" type="hidden" class="txt c1"/>
							<input id="txtSnick" type="hidden" class="txt c1"/><input id="txtTnick" type="hidden" class="txt c1"/><input id="txtUnick" type="hidden" class="txt c1"/>
							<input id="txtVnick" type="hidden" class="txt c1"/><input id="txtWnick" type="hidden" class="txt c1"/><input id="txtXnick" type="hidden" class="txt c1"/>
							<input id="txtYnick" type="hidden" class="txt c1"/><input id="txtZnick" type="hidden" class="txt c1"/>
							
							<input id="txtAcoin" type="hidden" class="txt c1"/><input id="txtBcoin" type="hidden" class="txt c1"/><input id="txtCcoin" type="hidden" class="txt c1"/>
							<input id="txtDcoin" type="hidden" class="txt c1"/><input id="txtEcoin" type="hidden" class="txt c1"/><input id="txtFcoin" type="hidden" class="txt c1"/>
							<input id="txtGcoin" type="hidden" class="txt c1"/><input id="txtHcoin" type="hidden" class="txt c1"/><input id="txtIcoin" type="hidden" class="txt c1"/>
							<input id="txtJcoin" type="hidden" class="txt c1"/><input id="txtKcoin" type="hidden" class="txt c1"/><input id="txtLcoin" type="hidden" class="txt c1"/>
							<input id="txtMcoin" type="hidden" class="txt c1"/><input id="txtNcoin" type="hidden" class="txt c1"/><input id="txtOcoin" type="hidden" class="txt c1"/>
							<input id="txtPcoin" type="hidden" class="txt c1"/><input id="txtQcoin" type="hidden" class="txt c1"/><input id="txtRcoin" type="hidden" class="txt c1"/>
							<input id="txtScoin" type="hidden" class="txt c1"/><input id="txtTcoin" type="hidden" class="txt c1"/><input id="txtUcoin" type="hidden" class="txt c1"/>
							<input id="txtVcoin" type="hidden" class="txt c1"/><input id="txtWcoin" type="hidden" class="txt c1"/><input id="txtXcoin" type="hidden" class="txt c1"/>
							<input id="txtYcoin" type="hidden" class="txt c1"/><input id="txtZcoin" type="hidden" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>	
				</table>
			</div>
		</div>
		<!--VVV抬頭用VVV-->
		<div class='topbbs' style="width: 16645px;margin-bottom: -2px;">
			<table id="topbbs" class='tbbs'>
				<tr style='color:white; background:#003366;'>
					<td align="center" style="width:445px;"><a id='lblAcc'> </a></td>
					<td align="center" style="width:550px;" class="comp-a"><a id='lablA01'> </a></td>
					<td align="center" style="width:550px;" class="comp-b"><a id='lablB01'> </a></td>
					<td align="center" style="width:550px;" class="comp-c"><a id='lablC01'> </a></td>
					<td align="center" style="width:550px;" class="comp-d"><a id='lablD01'> </a></td>
					<td align="center" style="width:550px;" class="comp-e"><a id='lablE01'> </a></td>
					<td align="center" style="width:550px;" class="comp-f"><a id='lablF01'> </a></td>
					<td align="center" style="width:550px;" class="comp-g"><a id='lablG01'> </a></td>
					<td align="center" style="width:550px;" class="comp-h"><a id='lablH01'> </a></td>
					<td align="center" style="width:550px;" class="comp-i"><a id='lablI01'> </a></td>
					<td align="center" style="width:550px;" class="comp-j"><a id='lablJ01'> </a></td>
					<td align="center" style="width:550px;" class="comp-k"><a id='lablK01'> </a></td>
					<td align="center" style="width:550px;" class="comp-l"><a id='lablL01'> </a></td>
					<td align="center" style="width:550px;" class="comp-m"><a id='lablM01'> </a></td>
					<td align="center" style="width:550px;" class="comp-n"><a id='lablN01'> </a></td>
					<td align="center" style="width:550px;" class="comp-o"><a id='lablO01'> </a></td>
					<td align="center" style="width:550px;" class="comp-p"><a id='lablP01'> </a></td>
					<td align="center" style="width:550px;" class="comp-q"><a id='lablQ01'> </a></td>
					<td align="center" style="width:550px;" class="comp-r"><a id='lablR01'> </a></td>
					<td align="center" style="width:550px;" class="comp-s"><a id='lablS01'> </a></td>
					<td align="center" style="width:550px;" class="comp-t"><a id='lablT01'> </a></td>
					<td align="center" style="width:550px;" class="comp-u"><a id='lablU01'> </a></td>
					<td align="center" style="width:550px;" class="comp-v"><a id='lablV01'> </a></td>
					<td align="center" style="width:550px;" class="comp-w"><a id='lablW01'> </a></td>
					<td align="center" style="width:550px;" class="comp-x"><a id='lablX01'> </a></td>
					<td align="center" style="width:550px;" class="comp-y"><a id='lablY01'> </a></td>
					<td align="center" style="width:550px;" class="comp-z"><a id='lablZ01'> </a></td>
					<td align="center" style="width:600px;"><a id='lblMerge'> </a></td>
				</tr>
			</table>
		</div>
		<!--^^^抬頭用^^^-->
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:40px;"> </td>
					<td align="center" style="width:140px;"><a id='lblAcc1'> </a></td>
					<td align="center" style="width:230px;"><a id='lblAcc2'> </a></td>
					<td align="center" style="width:120px;" class="comp-a fa1"><a id='lblA01'> </a></td>
					<td align="center" style="width:120px;" class="comp-a fa2"><a id='lblA02'> </a></td>
					<td align="center" style="width:120px;" class="comp-a fa3"><a id='lblA03'> </a></td>
					<td align="center" style="width:120px;" class="comp-a fa4"><a id='lblA04'> </a></td>
					<td align="center" style="width:120px;" class="comp-a fa5"><a id='lblA05'> </a></td>
					<td align="center" style="width:120px;" class="comp-b fb1"><a id='lblB01'> </a></td>
					<td align="center" style="width:120px;" class="comp-b fb2"><a id='lblB02'> </a></td>
					<td align="center" style="width:120px;" class="comp-b fb3"><a id='lblB03'> </a></td>
					<td align="center" style="width:120px;" class="comp-b fb4"><a id='lblB04'> </a></td>
					<td align="center" style="width:120px;" class="comp-b fb5"><a id='lblB05'> </a></td>
					<td align="center" style="width:120px;" class="comp-c fc1"><a id='lblC01'> </a></td>
					<td align="center" style="width:120px;" class="comp-c fc2"><a id='lblC02'> </a></td>
					<td align="center" style="width:120px;" class="comp-c fc3"><a id='lblC03'> </a></td>
					<td align="center" style="width:120px;" class="comp-c fc4"><a id='lblC04'> </a></td>
					<td align="center" style="width:120px;" class="comp-c fc5"><a id='lblC05'> </a></td>
					<td align="center" style="width:120px;" class="comp-d fd1"><a id='lblD01'> </a></td>
					<td align="center" style="width:120px;" class="comp-d fd2"><a id='lblD02'> </a></td>
					<td align="center" style="width:120px;" class="comp-d fd3"><a id='lblD03'> </a></td>
					<td align="center" style="width:120px;" class="comp-d fd4"><a id='lblD04'> </a></td>
					<td align="center" style="width:120px;" class="comp-d fd5"><a id='lblD05'> </a></td>
					<td align="center" style="width:120px;" class="comp-e fe1"><a id='lblE01'> </a></td>
					<td align="center" style="width:120px;" class="comp-e fe2"><a id='lblE02'> </a></td>
					<td align="center" style="width:120px;" class="comp-e fe3"><a id='lblE03'> </a></td>
					<td align="center" style="width:120px;" class="comp-e fe4"><a id='lblE04'> </a></td>
					<td align="center" style="width:120px;" class="comp-e fe5"><a id='lblE05'> </a></td>
					<td align="center" style="width:120px;" class="comp-f ff1"><a id='lblF01'> </a></td>
					<td align="center" style="width:120px;" class="comp-f ff2"><a id='lblF02'> </a></td>
					<td align="center" style="width:120px;" class="comp-f ff3"><a id='lblF03'> </a></td>
					<td align="center" style="width:120px;" class="comp-f ff4"><a id='lblF04'> </a></td>
					<td align="center" style="width:120px;" class="comp-f ff5"><a id='lblF05'> </a></td>
					<td align="center" style="width:120px;" class="comp-g fg1"><a id='lblG01'> </a></td>
					<td align="center" style="width:120px;" class="comp-g fg2"><a id='lblG02'> </a></td>
					<td align="center" style="width:120px;" class="comp-g fg3"><a id='lblG03'> </a></td>
					<td align="center" style="width:120px;" class="comp-g fg4"><a id='lblG04'> </a></td>
					<td align="center" style="width:120px;" class="comp-g fg5"><a id='lblG05'> </a></td>
					<td align="center" style="width:120px;" class="comp-h fh1"><a id='lblH01'> </a></td>
					<td align="center" style="width:120px;" class="comp-h fh2"><a id='lblH02'> </a></td>
					<td align="center" style="width:120px;" class="comp-h fh3"><a id='lblH03'> </a></td>
					<td align="center" style="width:120px;" class="comp-h fh4"><a id='lblH04'> </a></td>
					<td align="center" style="width:120px;" class="comp-h fh5"><a id='lblH05'> </a></td>
					<td align="center" style="width:120px;" class="comp-i fi1"><a id='lblI01'> </a></td>
					<td align="center" style="width:120px;" class="comp-i fi2"><a id='lblI02'> </a></td>
					<td align="center" style="width:120px;" class="comp-i fi3"><a id='lblI03'> </a></td>
					<td align="center" style="width:120px;" class="comp-i fi4"><a id='lblI04'> </a></td>
					<td align="center" style="width:120px;" class="comp-i fi5"><a id='lblI05'> </a></td>
					<td align="center" style="width:120px;" class="comp-j fj1"><a id='lblJ01'> </a></td>
					<td align="center" style="width:120px;" class="comp-j fj2"><a id='lblJ02'> </a></td>
					<td align="center" style="width:120px;" class="comp-j fj3"><a id='lblJ03'> </a></td>
					<td align="center" style="width:120px;" class="comp-j fj4"><a id='lblJ04'> </a></td>
					<td align="center" style="width:120px;" class="comp-j fj5"><a id='lblJ05'> </a></td>
					<td align="center" style="width:120px;" class="comp-k fk1"><a id='lblK01'> </a></td>
					<td align="center" style="width:120px;" class="comp-k fk2"><a id='lblK02'> </a></td>
					<td align="center" style="width:120px;" class="comp-k fk3"><a id='lblK03'> </a></td>
					<td align="center" style="width:120px;" class="comp-k fk4"><a id='lblK04'> </a></td>
					<td align="center" style="width:120px;" class="comp-k fk5"><a id='lblK05'> </a></td>
					<td align="center" style="width:120px;" class="comp-l fl1"><a id='lblL01'> </a></td>
					<td align="center" style="width:120px;" class="comp-l fl2"><a id='lblL02'> </a></td>
					<td align="center" style="width:120px;" class="comp-l fl3"><a id='lblL03'> </a></td>
					<td align="center" style="width:120px;" class="comp-l fl4"><a id='lblL04'> </a></td>
					<td align="center" style="width:120px;" class="comp-l fl5"><a id='lblL05'> </a></td>
					<td align="center" style="width:120px;" class="comp-m fm1"><a id='lblM01'> </a></td>
					<td align="center" style="width:120px;" class="comp-m fm2"><a id='lblM02'> </a></td>
					<td align="center" style="width:120px;" class="comp-m fm3"><a id='lblM03'> </a></td>
					<td align="center" style="width:120px;" class="comp-m fm4"><a id='lblM04'> </a></td>
					<td align="center" style="width:120px;" class="comp-m fm5"><a id='lblM05'> </a></td>
					<td align="center" style="width:120px;" class="comp-n fn1"><a id='lblN01'> </a></td>
					<td align="center" style="width:120px;" class="comp-n fn2"><a id='lblN02'> </a></td>
					<td align="center" style="width:120px;" class="comp-n fn3"><a id='lblN03'> </a></td>
					<td align="center" style="width:120px;" class="comp-n fn4"><a id='lblN04'> </a></td>
					<td align="center" style="width:120px;" class="comp-n fn5"><a id='lblN05'> </a></td>
					<td align="center" style="width:120px;" class="comp-o fo1"><a id='lblO01'> </a></td>
					<td align="center" style="width:120px;" class="comp-o fo2"><a id='lblO02'> </a></td>
					<td align="center" style="width:120px;" class="comp-o fo3"><a id='lblO03'> </a></td>
					<td align="center" style="width:120px;" class="comp-o fo4"><a id='lblO04'> </a></td>
					<td align="center" style="width:120px;" class="comp-o fo5"><a id='lblO05'> </a></td>
					<td align="center" style="width:120px;" class="comp-p fp1"><a id='lblP01'> </a></td>
					<td align="center" style="width:120px;" class="comp-p fp2"><a id='lblP02'> </a></td>
					<td align="center" style="width:120px;" class="comp-p fp3"><a id='lblP03'> </a></td>
					<td align="center" style="width:120px;" class="comp-p fp4"><a id='lblP04'> </a></td>
					<td align="center" style="width:120px;" class="comp-p fp5"><a id='lblP05'> </a></td>
					<td align="center" style="width:120px;" class="comp-q fq1"><a id='lblQ01'> </a></td>
					<td align="center" style="width:120px;" class="comp-q fq2"><a id='lblQ02'> </a></td>
					<td align="center" style="width:120px;" class="comp-q fq3"><a id='lblQ03'> </a></td>
					<td align="center" style="width:120px;" class="comp-q fq4"><a id='lblQ04'> </a></td>
					<td align="center" style="width:120px;" class="comp-q fq5"><a id='lblQ05'> </a></td>
					<td align="center" style="width:120px;" class="comp-r fr1"><a id='lblR01'> </a></td>
					<td align="center" style="width:120px;" class="comp-r fr2"><a id='lblR02'> </a></td>
					<td align="center" style="width:120px;" class="comp-r fr3"><a id='lblR03'> </a></td>
					<td align="center" style="width:120px;" class="comp-r fr4"><a id='lblR04'> </a></td>
					<td align="center" style="width:120px;" class="comp-r fr5"><a id='lblR05'> </a></td>
					<td align="center" style="width:120px;" class="comp-s fs1"><a id='lblS01'> </a></td>
					<td align="center" style="width:120px;" class="comp-s fs2"><a id='lblS02'> </a></td>
					<td align="center" style="width:120px;" class="comp-s fs3"><a id='lblS03'> </a></td>
					<td align="center" style="width:120px;" class="comp-s fs4"><a id='lblS04'> </a></td>
					<td align="center" style="width:120px;" class="comp-s fs5"><a id='lblS05'> </a></td>
					<td align="center" style="width:120px;" class="comp-t ft1"><a id='lblT01'> </a></td>
					<td align="center" style="width:120px;" class="comp-t ft2"><a id='lblT02'> </a></td>
					<td align="center" style="width:120px;" class="comp-t ft3"><a id='lblT03'> </a></td>
					<td align="center" style="width:120px;" class="comp-t ft4"><a id='lblT04'> </a></td>
					<td align="center" style="width:120px;" class="comp-t ft5"><a id='lblT05'> </a></td>
					<td align="center" style="width:120px;" class="comp-u fu1"><a id='lblU01'> </a></td>
					<td align="center" style="width:120px;" class="comp-u fu2"><a id='lblU02'> </a></td>
					<td align="center" style="width:120px;" class="comp-u fu3"><a id='lblU03'> </a></td>
					<td align="center" style="width:120px;" class="comp-u fu4"><a id='lblU04'> </a></td>
					<td align="center" style="width:120px;" class="comp-u fu5"><a id='lblU05'> </a></td>
					<td align="center" style="width:120px;" class="comp-v fv1"><a id='lblV01'> </a></td>
					<td align="center" style="width:120px;" class="comp-v fv2"><a id='lblV02'> </a></td>
					<td align="center" style="width:120px;" class="comp-v fv3"><a id='lblV03'> </a></td>
					<td align="center" style="width:120px;" class="comp-v fv4"><a id='lblV04'> </a></td>
					<td align="center" style="width:120px;" class="comp-v fv5"><a id='lblV05'> </a></td>
					<td align="center" style="width:120px;" class="comp-w fw1"><a id='lblW01'> </a></td>
					<td align="center" style="width:120px;" class="comp-w fw2"><a id='lblW02'> </a></td>
					<td align="center" style="width:120px;" class="comp-w fw3"><a id='lblW03'> </a></td>
					<td align="center" style="width:120px;" class="comp-w fw4"><a id='lblW04'> </a></td>
					<td align="center" style="width:120px;" class="comp-w fw5"><a id='lblW05'> </a></td>
					<td align="center" style="width:120px;" class="comp-x fx1"><a id='lblX01'> </a></td>
					<td align="center" style="width:120px;" class="comp-x fx2"><a id='lblX02'> </a></td>
					<td align="center" style="width:120px;" class="comp-x fx3"><a id='lblX03'> </a></td>
					<td align="center" style="width:120px;" class="comp-x fx4"><a id='lblX04'> </a></td>
					<td align="center" style="width:120px;" class="comp-x fx5"><a id='lblX05'> </a></td>
					<td align="center" style="width:120px;" class="comp-y fy1"><a id='lblY01'> </a></td>
					<td align="center" style="width:120px;" class="comp-y fy2"><a id='lblY02'> </a></td>
					<td align="center" style="width:120px;" class="comp-y fy3"><a id='lblY03'> </a></td>
					<td align="center" style="width:120px;" class="comp-y fy4"><a id='lblY04'> </a></td>
					<td align="center" style="width:120px;" class="comp-y fy5"><a id='lblY05'> </a></td>
					<td align="center" style="width:120px;" class="comp-z fz1"><a id='lblZ01'> </a></td>
					<td align="center" style="width:120px;" class="comp-z fz2"><a id='lblZ02'> </a></td>
					<td align="center" style="width:120px;" class="comp-z fz3"><a id='lblZ03'> </a></td>
					<td align="center" style="width:120px;" class="comp-z fz4"><a id='lblZ04'> </a></td>
					<td align="center" style="width:120px;" class="comp-z fz5"><a id='lblZ05'> </a></td>
					<td align="center" style="width:150px;"><a id='lblBmoney'> </a></td>
					<td align="center" style="width:150px;"><a id='lblDmoney'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCmoney'> </a></td>
					<td align="center" style="width:150px;"><a id='lblEmoney'> </a></td>
					
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnAcc.*" type="button" value="." style="float:left;width: 10px;"/>
						<input id="txtAcc1.*" type="text" style="float:left;width: 84%;" />
					</td>
					<td><input id="txtAcc2.*" type="text" class="txt c1"/></td>
					<td class="comp-a fa1"><input id="txtA01.*" type="text" class="txt num c1"/></td>
					<td class="comp-a fa2"><input id="txtA02.*" type="text" class="txt num c1"/></td>
					<td class="comp-a fa3"><input id="txtA03.*" type="text" class="txt num c1"/></td>
					<td class="comp-a fa4"><input id="txtA04.*" type="text" class="txt num c1"/></td>
					<td class="comp-a fa5"><input id="txtA05.*" type="text" class="txt num c1"/></td>
					<td class="comp-b fb1"><input id="txtB01.*" type="text" class="txt num c1"/></td>
					<td class="comp-b fb2"><input id="txtB02.*" type="text" class="txt num c1"/></td>
					<td class="comp-b fb3"><input id="txtB03.*" type="text" class="txt num c1"/></td>
					<td class="comp-b fb4"><input id="txtB04.*" type="text" class="txt num c1"/></td>
					<td class="comp-b fb5"><input id="txtB05.*" type="text" class="txt num c1"/></td>
					<td class="comp-c fc1"><input id="txtC01.*" type="text" class="txt num c1"/></td>
					<td class="comp-c fc2"><input id="txtC02.*" type="text" class="txt num c1"/></td>
					<td class="comp-c fc3"><input id="txtC03.*" type="text" class="txt num c1"/></td>
					<td class="comp-c fc4"><input id="txtC04.*" type="text" class="txt num c1"/></td>
					<td class="comp-c fc5"><input id="txtC05.*" type="text" class="txt num c1"/></td>
					<td class="comp-d fd1"><input id="txtD01.*" type="text" class="txt num c1"/></td>
					<td class="comp-d fd2"><input id="txtD02.*" type="text" class="txt num c1"/></td>
					<td class="comp-d fd3"><input id="txtD03.*" type="text" class="txt num c1"/></td>
					<td class="comp-d fd4"><input id="txtD04.*" type="text" class="txt num c1"/></td>
					<td class="comp-d fd5"><input id="txtD05.*" type="text" class="txt num c1"/></td>
					<td class="comp-e fe1"><input id="txtE01.*" type="text" class="txt num c1"/></td>
					<td class="comp-e fe2"><input id="txtE02.*" type="text" class="txt num c1"/></td>
					<td class="comp-e fe3"><input id="txtE03.*" type="text" class="txt num c1"/></td>
					<td class="comp-e fe4"><input id="txtE04.*" type="text" class="txt num c1"/></td>
					<td class="comp-e fe5"><input id="txtE05.*" type="text" class="txt num c1"/></td>
					<td class="comp-f ff1"><input id="txtF01.*" type="text" class="txt num c1"/></td>
					<td class="comp-f ff2"><input id="txtF02.*" type="text" class="txt num c1"/></td>
					<td class="comp-f ff3"><input id="txtF03.*" type="text" class="txt num c1"/></td>
					<td class="comp-f ff4"><input id="txtF04.*" type="text" class="txt num c1"/></td>
					<td class="comp-f ff5"><input id="txtF05.*" type="text" class="txt num c1"/></td>
					<td class="comp-g fg1"><input id="txtG01.*" type="text" class="txt num c1"/></td>
					<td class="comp-g fg2"><input id="txtG02.*" type="text" class="txt num c1"/></td>
					<td class="comp-g fg3"><input id="txtG03.*" type="text" class="txt num c1"/></td>
					<td class="comp-g fg4"><input id="txtG04.*" type="text" class="txt num c1"/></td>
					<td class="comp-g fg5"><input id="txtG05.*" type="text" class="txt num c1"/></td>
					<td class="comp-h fh1"><input id="txtH01.*" type="text" class="txt num c1"/></td>
					<td class="comp-h fh2"><input id="txtH02.*" type="text" class="txt num c1"/></td>
					<td class="comp-h fh3"><input id="txtH03.*" type="text" class="txt num c1"/></td>
					<td class="comp-h fh4"><input id="txtH04.*" type="text" class="txt num c1"/></td>
					<td class="comp-h fh5"><input id="txtH05.*" type="text" class="txt num c1"/></td>
					<td class="comp-i fi1"><input id="txtI01.*" type="text" class="txt num c1"/></td>
					<td class="comp-i fi2"><input id="txtI02.*" type="text" class="txt num c1"/></td>
					<td class="comp-i fi3"><input id="txtI03.*" type="text" class="txt num c1"/></td>
					<td class="comp-i fi4"><input id="txtI04.*" type="text" class="txt num c1"/></td>
					<td class="comp-i fi5"><input id="txtI05.*" type="text" class="txt num c1"/></td>
					<td class="comp-j fj1"><input id="txtJ01.*" type="text" class="txt num c1"/></td>
					<td class="comp-j fj2"><input id="txtJ02.*" type="text" class="txt num c1"/></td>
					<td class="comp-j fj3"><input id="txtJ03.*" type="text" class="txt num c1"/></td>
					<td class="comp-j fj4"><input id="txtJ04.*" type="text" class="txt num c1"/></td>
					<td class="comp-j fj5"><input id="txtJ05.*" type="text" class="txt num c1"/></td>
					<td class="comp-k fk1"><input id="txtK01.*" type="text" class="txt num c1"/></td>
					<td class="comp-k fk2"><input id="txtK02.*" type="text" class="txt num c1"/></td>
					<td class="comp-k fk3"><input id="txtK03.*" type="text" class="txt num c1"/></td>
					<td class="comp-k fk4"><input id="txtK04.*" type="text" class="txt num c1"/></td>
					<td class="comp-k fk5"><input id="txtK05.*" type="text" class="txt num c1"/></td>
					<td class="comp-l fl1"><input id="txtL01.*" type="text" class="txt num c1"/></td>
					<td class="comp-l fl2"><input id="txtL02.*" type="text" class="txt num c1"/></td>
					<td class="comp-l fl3"><input id="txtL03.*" type="text" class="txt num c1"/></td>
					<td class="comp-l fl4"><input id="txtL04.*" type="text" class="txt num c1"/></td>
					<td class="comp-l fl5"><input id="txtL05.*" type="text" class="txt num c1"/></td>
					<td class="comp-m fm1"><input id="txtM01.*" type="text" class="txt num c1"/></td>
					<td class="comp-m fm2"><input id="txtM02.*" type="text" class="txt num c1"/></td>
					<td class="comp-m fm3"><input id="txtM03.*" type="text" class="txt num c1"/></td>
					<td class="comp-m fm4"><input id="txtM04.*" type="text" class="txt num c1"/></td>
					<td class="comp-m fm5"><input id="txtM05.*" type="text" class="txt num c1"/></td>
					<td class="comp-n fn1"><input id="txtN01.*" type="text" class="txt num c1"/></td>
					<td class="comp-n fn2"><input id="txtN02.*" type="text" class="txt num c1"/></td>
					<td class="comp-n fn3"><input id="txtN03.*" type="text" class="txt num c1"/></td>
					<td class="comp-n fn4"><input id="txtN04.*" type="text" class="txt num c1"/></td>
					<td class="comp-n fn5"><input id="txtN05.*" type="text" class="txt num c1"/></td>
					<td class="comp-o fo1"><input id="txtO01.*" type="text" class="txt num c1"/></td>
					<td class="comp-o fo2"><input id="txtO02.*" type="text" class="txt num c1"/></td>
					<td class="comp-o fo3"><input id="txtO03.*" type="text" class="txt num c1"/></td>
					<td class="comp-o fo4"><input id="txtO04.*" type="text" class="txt num c1"/></td>
					<td class="comp-o fo5"><input id="txtO05.*" type="text" class="txt num c1"/></td>
					<td class="comp-p fp1"><input id="txtP01.*" type="text" class="txt num c1"/></td>
					<td class="comp-p fp2"><input id="txtP02.*" type="text" class="txt num c1"/></td>
					<td class="comp-p fp3"><input id="txtP03.*" type="text" class="txt num c1"/></td>
					<td class="comp-p fp4"><input id="txtP04.*" type="text" class="txt num c1"/></td>
					<td class="comp-p fp5"><input id="txtP05.*" type="text" class="txt num c1"/></td>
					<td class="comp-q fq1"><input id="txtQ01.*" type="text" class="txt num c1"/></td>
					<td class="comp-q fq2"><input id="txtQ02.*" type="text" class="txt num c1"/></td>
					<td class="comp-q fq3"><input id="txtQ03.*" type="text" class="txt num c1"/></td>
					<td class="comp-q fq4"><input id="txtQ04.*" type="text" class="txt num c1"/></td>
					<td class="comp-q fq5"><input id="txtQ05.*" type="text" class="txt num c1"/></td>
					<td class="comp-r fr1"><input id="txtR01.*" type="text" class="txt num c1"/></td>
					<td class="comp-r fr2"><input id="txtR02.*" type="text" class="txt num c1"/></td>
					<td class="comp-r fr3"><input id="txtR03.*" type="text" class="txt num c1"/></td>
					<td class="comp-r fr4"><input id="txtR04.*" type="text" class="txt num c1"/></td>
					<td class="comp-r fr5"><input id="txtR05.*" type="text" class="txt num c1"/></td>
					<td class="comp-s fs1"><input id="txtS01.*" type="text" class="txt num c1"/></td>
					<td class="comp-s fs2"><input id="txtS02.*" type="text" class="txt num c1"/></td>
					<td class="comp-s fs3"><input id="txtS03.*" type="text" class="txt num c1"/></td>
					<td class="comp-s fs4"><input id="txtS04.*" type="text" class="txt num c1"/></td>
					<td class="comp-s fs5"><input id="txtS05.*" type="text" class="txt num c1"/></td>
					<td class="comp-t ft1"><input id="txtT01.*" type="text" class="txt num c1"/></td>
					<td class="comp-t ft2"><input id="txtT02.*" type="text" class="txt num c1"/></td>
					<td class="comp-t ft3"><input id="txtT03.*" type="text" class="txt num c1"/></td>
					<td class="comp-t ft4"><input id="txtT04.*" type="text" class="txt num c1"/></td>
					<td class="comp-t ft5"><input id="txtT05.*" type="text" class="txt num c1"/></td>
					<td class="comp-u fu1"><input id="txtU01.*" type="text" class="txt num c1"/></td>
					<td class="comp-u fu2"><input id="txtU02.*" type="text" class="txt num c1"/></td>
					<td class="comp-u fu3"><input id="txtU03.*" type="text" class="txt num c1"/></td>
					<td class="comp-u fu4"><input id="txtU04.*" type="text" class="txt num c1"/></td>
					<td class="comp-u fu5"><input id="txtU05.*" type="text" class="txt num c1"/></td>
					<td class="comp-v fv1"><input id="txtV01.*" type="text" class="txt num c1"/></td>
					<td class="comp-v fv2"><input id="txtV02.*" type="text" class="txt num c1"/></td>
					<td class="comp-v fv3"><input id="txtV03.*" type="text" class="txt num c1"/></td>
					<td class="comp-v fv4"><input id="txtV04.*" type="text" class="txt num c1"/></td>
					<td class="comp-v fv5"><input id="txtV05.*" type="text" class="txt num c1"/></td>
					<td class="comp-w fw1"><input id="txtW01.*" type="text" class="txt num c1"/></td>
					<td class="comp-w fw2"><input id="txtW02.*" type="text" class="txt num c1"/></td>
					<td class="comp-w fw3"><input id="txtW03.*" type="text" class="txt num c1"/></td>
					<td class="comp-w fw4"><input id="txtW04.*" type="text" class="txt num c1"/></td>
					<td class="comp-w fw5"><input id="txtW05.*" type="text" class="txt num c1"/></td>
					<td class="comp-x fx1"><input id="txtX01.*" type="text" class="txt num c1"/></td>
					<td class="comp-x fx2"><input id="txtX02.*" type="text" class="txt num c1"/></td>
					<td class="comp-x fx3"><input id="txtX03.*" type="text" class="txt num c1"/></td>
					<td class="comp-x fx4"><input id="txtX04.*" type="text" class="txt num c1"/></td>
					<td class="comp-x fx5"><input id="txtX05.*" type="text" class="txt num c1"/></td>
					<td class="comp-y fy1"><input id="txtY01.*" type="text" class="txt num c1"/></td>
					<td class="comp-y fy2"><input id="txtY02.*" type="text" class="txt num c1"/></td>
					<td class="comp-y fy3"><input id="txtY03.*" type="text" class="txt num c1"/></td>
					<td class="comp-y fy4"><input id="txtY04.*" type="text" class="txt num c1"/></td>
					<td class="comp-y fy5"><input id="txtY05.*" type="text" class="txt num c1"/></td>
					<td class="comp-z fz1"><input id="txtZ01.*" type="text" class="txt num c1"/></td>
					<td class="comp-z fz2"><input id="txtZ02.*" type="text" class="txt num c1"/></td>
					<td class="comp-z fz3"><input id="txtZ03.*" type="text" class="txt num c1"/></td>
					<td class="comp-z fz4"><input id="txtZ04.*" type="text" class="txt num c1"/></td>
					<td class="comp-z fz5"><input id="txtZ05.*" type="text" class="txt num c1"/></td>
					<td><input id="txtBmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtCmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEmoney.*" type="text" class="txt num c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
