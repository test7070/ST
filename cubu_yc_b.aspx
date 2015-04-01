<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'cubu', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], t_count = 0, as, brwCount = -1;
			brwCount2 = 0;
			var t_sqlname = 'cubu';
			t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var decbbs = [];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtMount', 10, 2, 1], ['txtWeight', 10, 3, 1],['txtDime', 10, 2, 1], ['txtWidth', 10, 2, 1], ['txtRadius', 10, 2, 1], ['txtLengthb', 10, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			var Parent = window.parent;
			var cubBBsArray = '';
			var cubBBtArray = '';
			if (Parent.q_name && Parent.q_name == 'cub') {
				cubBBsArray = Parent.abbsNow;
				cubBBtArray = Parent.abbtNow;
			}
			aPop = new Array(
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,nick', 'txtCustno_,txtComp_', 'cust_b.aspx'],
				['txtOrdeno_', 'btnOrdeno_', 'view_ordes', 'noa,no2,custno,cust,spec,size,productno,product,radius,dime,width,lengthb', 'txtOrdeno_,txtNo2_,txtCustno_,txtComp_,txtSpec_,txtSize_,txtProductno_,txtProduct_,txtRadius_,txtDime_,txtWidth_,txtLengthb_', 'ordes_yc_seek_b.aspx?;;;1=0', '95%', '60%'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_', 'ucaucc_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (!q_paraChk())
					return;
				q_gt('style', '', 0, 0, 0, '');
				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function mainPost() {
				bbmMask = [];
				bbsMask = [['txtDatea', r_picd], ['txtStyle', 'A']];
				q_mask(bbmMask);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
			}

			var toFocusOrdeno = 0;
			function bbsAssign() {
				_bbsAssign();
				SetBBsReadonly(ReadOnlyUno);
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text((j + 1));
					if (Parent.q_name && Parent.q_name == 'cub') {
						$('#txtUno_' + j).change(function() {
							var thisuno = trim($(this).val());
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							var t_datea = $('#txtDatea_' + n).val();
							if (cubBBtArray[dec(thisuno) - 1] != undefined) {
								var temp_bbt = cubBBtArray[dec(thisuno) - 1];
								getUno(n, temp_bbt.uno, '');
								var t_datea = $('#txtDatea_' + n);
								if (trim($(this).val()) != '') {
									$('#txtProductno_' + n).val(temp_bbt.productno);
									$('#txtSpec_' + n).val(temp_bbt.spec);
									$('#txtClass_' + n).val(temp_bbt.class);
									if (trim(temp_bbt.productno) != '')
										q_popsChange($('#txtProductno_' + n));
									$('#txtDime_' + n).val(temp_bbt.dime);
								}
							}
							toFocusOrdeno = 1;
						}).focusout(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							var oUno = trim($(this).val());
							var t_datea = trim($('#txtDatea_' + n).val());
							if (oUno.length == 0 && t_datea.length > 0)
								getUno(n, '', t_datea);
						});
						$('#txtOrdeno_' + j).change(function() {
							var thisordeno = trim($(this).val());
							if (cubBBsArray[dec(thisordeno) - 1] != undefined) {
								var temp_bbs = cubBBsArray[dec(thisordeno) - 1];
								var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
								$(this).val(temp_bbs.ordeno);
								$('#txtNo2_' + n).val(temp_bbs.no2);
								$('#txtCustno_' + n).val(temp_bbs.custno);
								q_popsChange($('#txtCustno_' + n));
								$('#txtProductno_' + n).val(temp_bbs.productno);
								$('#txtProduct_' + n).val(temp_bbs.product);
								$('#txtSpec_' + n).val(temp_bbs.bspec);
								$('#txtRadius_' + n).val(temp_bbs.radius);
								$('#txtWidth_' + n).val(temp_bbs.width);
								$('#txtDime_' + n).val(temp_bbs.dime);
								$('#txtLengthb_' + n).val(temp_bbs.lengthb);
								$('#txtMount_' + n).val(temp_bbs.mount);
								$('#txtStyle_' + n).val(temp_bbs.style);
							}
						});
						
						$('#txtDatea_' + j).focusout(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							var thisVal = $.trim($(this).val());
							var DatePati = /^[0-9][0-9][0-9]\/[0-1][0-9]\/[0-3][0-9]$/g;
							if (thisVal == '') {
								$(this).val(q_date());
							} else {
								if (DatePati.test(thisVal)) {
									var t_year = dec(thisVal.substring(0, 3));
									var thisyear = dec(q_date().substring(0, 3));
									if (t_year < (thisyear - 1) || t_year > (thisyear + 1)) {
										q_msg($(this), '日期差距太大');
										$(this).val('');
										return;
									}
								} else {
									q_msg($(this), '日期格式錯誤');
									$(this).val('');
									return;
								}
							}
							var oUno = trim($('#txtUno_' + n).val());
							if (oUno.length == 0)
								getUno(n, '', $(this).val());
						});
					}
					
					$('#txtStyle_' + j).blur(function() {
						$('input[id*="txtProduct_"]').each(function() {
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
						});
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						ProductAddStyle(n);
					});
					
					$('#txtMount_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						var t_ordeno = $.trim($('#txtOrdeno_' + n).val());
						var t_no2 = $.trim($('#txtNo2_' + n).val());
						if (t_ordeno.length > 0) {
							for (var i = 0; i < cubBBsArray.length; i++) {
								if (cubBBsArray[i].ordeno == t_ordeno && cubBBsArray[i].no2 == t_no2) {
									var t_mount = dec($('#txtMount_' + n).val());
									if (t_mount > dec(cubBBsArray[i].mount)) {
										alert('數量不可大於訂單數量!!');
										$('#txtMount_' + n).val(dec(cubBBsArray[i].mount));
										break;
									}
								}
							}
						}
					});
					
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
					
				}
			}

			function btnOk() {
			    bbsReSort();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}
			
			function bbsReSort() {
				var a_productno = new Array();
				for (var i = 0; i < q_bbsCount; i++) {
					var thisProductno = $.trim($('#txtProductno_' + i).val());
					var valArray = new Array();
					for (var j = 0; j < fbbs.length; j++) {
						valArray[fbbs[j]] = $('#' + fbbs[j] + '_' + i).val();
					}
					a_productno.push([i, thisProductno, valArray]);
				}
				a_productno.sort(function(a, b) {
					return a[1].charCodeAt() - b[1].charCodeAt();
				});
				for (var k = 0; k < q_bbsCount; k++) {
					$('#btnMinus_' + k).click();
				};
				for (var s = 0; s < a_productno.length; s++) {
					for (var key in a_productno[s][2]) {
						$('#' + key + '_' + s).val(a_productno[s][2][key]);
					}
				}
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['ordeno']) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
			}

			function btnModi() {
				var t_key = q_getHref();
				if (!t_key)
					return;
				_btnModi(1);
				SetBBsReadonly(ReadOnlyUno);
				$('#btnOk').before($('#btnOk').clone().attr('id', 'btnOk2').show()).hide();
				$('#btnOk2').click(function() {
					var t_errMsg = '';
					for (var i = 0; i < q_bbsCount; i++) {
						$('#txtWorker_' + i).val(r_name);
						var t_datea = trim($('#txtDatea_' + i).val());
						var t_uno = trim($('#txtUno_' + i).val());
						var t_ordeno = trim($('#txtOrdeno_' + i).val());
						var t_mount = dec($('#txtMount_' + i).val());
						var t_weight = dec($('#txtWeight_' + i).val());
						if (t_datea.length != 9) {
							if ($.trim(Parent.$('#txtDatea').val()) != '')
								$('#txtDatea_' + i).val($.trim(Parent.$('#txtDatea').val()));
							else
								$('#txtDatea_' + i).val(q_date());
						}
						//不存檔提示!!
						if ((t_mount > 0) && (t_weight <= 0))
							t_errMsg += '第 ' + (i + 1) + " 筆重量小於等於0。\n";
						if ((t_mount > 0) && (t_uno.length == 0))
							t_errMsg += '第 ' + (i + 1) + " 筆批號為空。\n";
					}
					if ($.trim(t_errMsg).length > 0) {
						alert(t_errMsg);
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
                    //parent.$('#txtNoa').val()
                    var t_where = '';
                    for (var i = 0; i < q_bbsCount; i++) {
                        if ($.trim($('#txtUno_' + i).val()).length > 0)
                            t_where += (t_where.length > 0 ? ' or ' : '') + "(uno='" + $.trim($('#txtUno_' + i).val()) + "' and not(accy='" + r_accy + "' and tablea='cubu' and noa='" + $.trim($('#txtNoa_'+i).val()) + "'))";
                    }
                    if (t_where.length > 0)
                        q_gt('view_uccb', "where=^^" + t_where + "^^", 0, 0, 0, 'btnOk_checkuno');
                    else{
                        qbtnOk();
                        parent.$.fn.colorbox.close();
                    }
				});
			}

			function SetBBsReadonly(UnoArr) {
				for (var j = 0; j < UnoArr.length; j++) {
					var thisUno = $.trim(UnoArr[j]);
					for (var k = 0; k < q_bbsCount; k++) {
						var bbsUno = $.trim($('#txtUno_' + k).val());
						if (thisUno == bbsUno) {
							$('#btnMinus_' + k).attr('disabled', 'disabled');
							$('#txtUno_' + k).attr('readonly', true).css({
								'color' : t_color2,
								'background' : t_background2
							});
						}
					}
				}
			}

			function GetBBsUno() {
				var ReturnStr = '';
				var TmpArr = [];
				for (var i = 0; i < q_bbsCount; i++) {
					var thisVal = $.trim($('#txtUno_' + i).val());
					if (thisVal.length > 0) {
						TmpArr.push(thisVal);
					}
				}
				if (TmpArr.length > 0) {
					ReturnStr = "'" + TmpArr.toString().replace(/\,/g, "','") + "'";
					return ReturnStr;
				} else {
					return '';
				}
			}

			function refresh() {
				_refresh();
				//q_popPost('txtProductno_');
				$('input[id*="txtProduct_"]').each(function() {
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
					$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
				});
				var UnoList = $.trim(GetBBsUno());
				if (UnoList.length > 0) {
					var t_where = 'where=^^ (1=1) and (uno in(' + UnoList + '))^^';
					q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
				}
			}

			var StyleList = '';
			var t_uccArray = new Array;
			var ReadOnlyUno = [];
			function q_gtPost(t_postname) {
				switch (t_postname) {
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
                            qbtnOk();
                            parent.$.fn.colorbox.close();
                        }
                        break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						break;
					case 'deleUccy':
						var as = _q_appendData("uccy", "", true);
						if (as[0] != undefined) {
							ReadOnlyUno = new Array;
							for (var i = 0; i < as.length; i++) {
								var asUno = $.trim(as[i].uno);
								if (dec(as[i].gweight) > 0) {
									ReadOnlyUno.push(asUno);
								}
							}
						}
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						break;
				}  /// end switch
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
						if (toFocusOrdeno == 1)
							$('#txtGroupa_' + b_seq).focus();//2014/05/22  groupa移到ordeno前
						toFocusOrdeno = 0;
						break;
				}
			}

			function getUno(t_id, s_ouno, s_datea) {
				var t_buno = '　';
				var t_datea = '　';
				var t_style = '　';
				t_buno += s_ouno;
				t_datea += s_datea;
				t_style += $('#txtStyle_' + t_id).val();
				q_func('qtxt.query.getuno^^' + t_id, 'uno.txt,getuno,' + t_buno + ';' + t_datea + ';' + t_style + ';');
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					default:
						if (t_func.split('^^')[0] == 'qtxt.query.getuno') {
							var as = _q_appendData("tmp0", "", true, true);
							var t_id = t_func.split('^^')[1];
							if (as[0] != undefined) {
								if (as.length != 1) {
									alert('批號取得異常。');
								} else {
									$('#txtUno_' + t_id).val(as[0].uno);
								}
							}
						}
						break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt {
				float: left;
			}
			.c1 {
				width: 90%;
			}
			.c2 {
				width: 85%;
			}
			.c3 {
				width: 71%;
			}
			.c4 {
				width: 95%;
			}
			.num {
				text-align: right;
			}
			#dbbs {
				width: 1800px;
			}
			.btn {
				font-weight: bold;
			}
			#lblNo {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="dbbs">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: medium;'>
				<tr style='color:White; background:#003366;' >
					<td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td align="center" style="width:15px;"> </td>
					<td align="center" style="width:200px;"><a>批號</a></td>
					<td align="center" style="width:180px;"><a>訂單編號</a></td>
					<td align="center" style="width:100px;"><a id='lblCustno'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDatea'> </a></td>
					<td align="center" style="width:120px;"><a id='lblStoreno'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:30px;"><a id='lblStyle'> </a></td>
					<td align="center" style="width:100px;"><a id='lblSpec'> </a></td>
					<td align="center" style="width:180px;"><a id='lblSize'> </a></td>
					<td align="center" style="width:280px;">厚 X 寬 X 高 X 長</td>
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWeight'> </a></td>
					<td align="center" style="width:100px;display:none;"><a id='lblInweight'> </a></td>
					<td align="center" style="width:100px;display:none;"><a id='lblWaste'> </a></td>
					<td align="center" style="width:100px;display:none;"><a id='lblGmount'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMemo'> </a></td>
					
				</tr>
				<tr style="background:#cad3ff;font-size: 14px;">
					<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value="－" style="font-weight: bold;"/></td>
					<td style="text-align:center;">
						<a id="lblNo.*"> </a>
						<input type="text" id="txtNoa.*" class="txt c1" style="display:none;"/>
					</td>
					<td><input type="text" id="txtUno.*" class="txt c1"/></td>
					<td>
						<input id="btnOrdeno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtOrdeno.*" class="txt" style="width:60%;"/>
						<input type="text" id="txtNo2.*" class="txt" style="width:20%;"/>
					</td>
					<td>
						<input id="btnCustno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtCustno.*" class="txt c3"/>
						<input type="text" id="txtComp.*" class="txt c1"/>
					</td>
					<td><input type="text" id="txtDatea.*" class="txt c1"/></td>
					<td>
						<input id="btnStoreno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtStoreno.*" class="txt c3"/>
						<input type="text" id="txtStore.*" class="txt c1"/>
					</td>
					<td>
						<input id="btnProductno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtProductno.*" style="width:65%;"/>
						<input type="text" id="txtProduct.*" class="txt c4"/>
					</td>
					<td><input type="text" id="txtStyle.*" class="txt c1" style="text-align: center;"/></td>
					<td><input type="text" id="txtSpec.*" class="txt c4"/></td>
					<td><input type="text" id="txtSize.*" class="txt c4"/></td>
					<td>
						<input id="txtDime.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
						<a style="float: left;">X</a>
						<input id="txtWidth.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
						<a style="float: left;">X</a>
						<input id="txtRadius.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
						<a style="float: left;">X</a>
						<input id="txtLengthb.*" type="text" class="txt num c1" style="float: left;width:55px;"/>
					</td>
					<td><input type="text" id="txtMount.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtWeight.*" class="txt c1 num"/></td>
					<td style="display:none;">
						<input type="text" id="txtInweight.*" class="txt c1 num"/>
					</td>
					<td style="display:none;">
						<input type="text" id="txtWaste.*" class="txt c1 num"/>
					</td>
					<td style="display:none;">
						<input type="text" id="txtGmount.*" class="txt c1 num"/>
					</td>
					<td>
						<input type="text" id="txtMemo.*" class="txt c1"/>
						<input type="text" id="txtWorker.*" style="display:none;"/>
					</td>
					
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>