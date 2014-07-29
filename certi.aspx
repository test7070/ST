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
			q_tables = 's';
			var q_name = "certi";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [['txtNetweight', 10, 2, 1]
             ,['txtC', 10, 2, 1],['txtSi', 10, 2, 1],['txtMn', 10, 2, 1],['txtP', 10, 2, 1],['txtS', 10, 2, 1]
             ,['txtNi', 10, 2, 1],['txtCr', 10, 2, 1],['txtMo', 10, 2, 1],['txtN', 10, 2, 1],['txtCu', 10, 2, 1]];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			/*   aPop = new Array(['txtStraddrno', 'lblStraddr', 'straddr_rj', 'noa', 'txtStraddrno', 'straddr_rj_b.aspx'],
			 ['txtEndaddrno', 'lblEndaddr', 'endaddr_rj', 'noa', 'txtEndaddrno', 'endaddr_rj_b.aspx'],
			 ['txtProductno', 'lblProductno', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],
			 ['txtSalesno_', '', 'sss', 'noa,namea', 'txtSalesno_,txtSales_', 'sss_b.aspx'],
			 ['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick', 'txtCustno,txtCust', 'cust_b.aspx']);
			 */
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}
			function mainPost() {
				q_getFormat();
				q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd]];
				//上方插入空白行
				$('#lblTop_row').mousedown(function(e) {
					if (e.button == 0) {
						mouse_div = false;
						q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
					}
				});
				//下方插入空白行
				$('#lblDown_row').mousedown(function(e) {
					if (e.button == 0) {
						mouse_div = false;
						q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
					}
				});
				$('#lblTop_row').hover(function(e) {
					$(this).css('background', 'orange');
				}, function(e) {
					$(this).css('background', 'white');
				});
				$('#lblDown_row').hover(function(e) {
					$(this).css('background', 'orange');
				}, function(e) {
					$(this).css('background', 'white');
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
					default:
						break;
				}
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
				if(q_cur==1)
				    $('#txtWorker').val(r_name);
				else
				    $('#txtWorker2').val(r_name);
				
				var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('certi_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
			}
			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
				    $('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnMinus_' + j).bind('contextmenu', function(e) {
							e.preventDefault();
							mouse_div = false;
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
					}
				}
				_bbsAssign();
			}
			function btnIns() {
				_btnIns();
				$('#txtNoa').focus();
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNoa').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
				$('#txtNoa').focus();
			}
			function btnPrint() {
				q_box('z_certi.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
			}
			function wrServer(key_value) {
				var i;
				$('#txtNoa').val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			function bbsSave(as) {
				if (!as['datea']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			function sum() {
			}
			function refresh(recno) {
				_refresh(recno);
			}
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
			function btnMinus(id) {
				_btnMinus(id);
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
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 350px;
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
                width: 600px;
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
                width: 20%;
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
                width: 1200px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
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
        <div id='dmain'>
            <div class="dview" id="dview" >
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
                        <td align="center" style="width:150px; color:black;"><a id='vewStraddr'> </a></td>
                        <td align="center" style="width:150px; color:black;"><a id='vewEndaddr'> </a></td>
                        <td align="center" style="width:150px; color:black;"><a id='vewProductno'> </a></td>
                        <td align="center" style="width:120px; color:black;">客戶</td>
                    </tr>
                    <tr>
                        <td>
                        <input id="chkBrow.*" type="checkbox" />
                        </td>
                        <td style="text-align: center;" id='noa'>~noa</td>
                        <td style="text-align: left;" id='straddr'>~straddr</td>
                        <td style="text-align: left;" id='endaddr'>~endaddr</td>
                        <td style="text-align: left;" id='product'>~product</td>
                        <td style="text-align: left;" id='nick'>~nick</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm"  id="tbbm">
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td><input id="txtNoa" type="text" class="txt c1" /></td>
                        <td><span> </span><a id='lblDatea' class="lbl"> </a></td>
                        <td><input id="txtDatea" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td style="width:33%;">
                        <div style="background:pink;" >
                            <table>
                                <tr>
                                    <td style="width:45%;"><span> </span><a id='lblProductno' class="lbl"> </a></td>
                                    <td style="width:45%;"><input id="txtProductno" type="text" class="txt c1" /></td>
                                    <td style="width:5%;"></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblProduct' class="lbl"> </a></td>
                                    <td><input id="txtProduct" type="text" class="txt c1" /></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblTypea' class="lbl"> </a></td>
                                    <td><input id="txtTypea" type="text" class="txt c1" /></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblFinish' class="lbl"> </a></td>
                                    <td><input id="txtFinish" type="text" class="txt c1" /></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblNetweight' class="lbl"> </a></td>
                                    <td><input id="txtNetweight" type="text" class="txt c1 num" /></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblHeat' class="lbl"> </a></td>
                                    <td><input id="txtHeat" type="text" class="txt c1" /></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblSpec' class="lbl"> </a></td>
                                    <td><input id="txtSpec" type="text" class="txt c1" /></td>
                                </tr>
                                <tr></tr>
                                <tr></tr>
                                <tr></tr>
                            </table>
                        </div>
                        </td>
                        <td style="width:33%;">
                        <div style="background:burlywood;" >
                            <table>
                                <tr>
                                    <td style="width:45%;"><span> </span><a id='lblC' class="lbl"> </a></td>
                                    <td style="width:45%;"><input id="txtC" type="text" class="txt c1 num" /></td>
                                    <td style="width:5%;"></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblSi' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtSi" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblMn' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtMn" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblP' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtP" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblS' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtS" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblNi' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtNi" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblCr' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtCr" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblMo' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtMo" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblN' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtN" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblCu' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtCu" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        </td>
                        <td style="width:33%;">
                        <div>
                            <table>
                                <tr>
                                    <td style="width:45%;"><span> </span><a id='lblTs' class="lbl"> </a></td>
                                    <td style="width:45%;"><input id="txtTs" type="text" class="txt c1 num" /></td>
                                    <td style="width:5%;"></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblYs' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtYs" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblEl' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtEl" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblHrb' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtHrb" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id='lblHv' class="lbl"> </a></td>
                                    <td>
                                    <input id="txtHv" type="text" class="txt c1 num" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        </td>
                    </tr>      
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"></td>
                    <td align="center" style="width:80px;"><a id='lblUno_s'> </a></td>
                </tr>
                <tr  style='background:#cad3ff;'>
                    <td align="center">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
                    <input type="text" id="txtUno.*" style="width:95%;"/>
                    </td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
