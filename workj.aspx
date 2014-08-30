<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;

            q_tables = 't';
            var q_name = "workj";
            var q_readonly = ['txtNoa'];
            var q_readonlys = [];
            var q_readonlyt = [];
            var bbmNum = [];
            var bbsNum = [['txtMount',10,2,1],['txtWeight',10,2,1]];
            var bbtNum = [['txtMount',10,2,1],['txtWeight',10,2,1]];
            var bbmMask = [['txtOdate','999/99/99'],['txtDatea','999/99/99']];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 6;

            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtPicno_', 'btnPicno_', 'img', 'noa', 'txtPicno_', 'img_b.aspx']
            	,['txtProductno__', 'btnProduct__', 'ucc', 'noa,product', 'txtProductno__,txtProduct__', 'ucc_b.aspx']
            	,['txtUno__', 'btnUno__', 'view_uccc2', 'uno,productno,product,spec,emount,eweight', 'txtUno__,txtProductno__,txtProduct__,,txtMount__,txtWeight__', 'uccc_seek_b2.aspx?;;;1=0', '95%', '60%']
            	,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtCust,txtNick', 'cust_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
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
                q_mask(bbmMask);
            }
			function q_popPost(id) {
                switch (id) {
                	case 'txtPicno_':
                		var n = b_seq;
                		var t_picno = $('#txtPicno_'+n).val();
                		var t_para = $('#txtImgpara_'+n).val();
                		var t_imgsrc = $('#txtImgsrc_'+n).val();
                		if(t_imgsrc.length==0){
                			t_imgsrc = r_userno+'-'+guid();
                			$('#txtImgsrc_'+n).val(t_imgsrc);
                		}
                		if(t_picno.length>0 && t_para.length>0){
		                	q_func( 'imgfe.gen',t_imgsrc+','+t_picno+','+t_para.replace(/\,/g,'^'));
                		}
                    default:
                        break;
                }
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'imgfe.gen':
                		if(result.length>0)
	                		for(var i=0;i<q_bbsCount;i++){
	                			if($('#txtImgsrc_'+i).val()==result){
	                				$('#imgPic_'+i).attr('src','../images/fe/'+result+'.jpg?'+(new Date()).getTime());
	                				break;
	                			}
	                		}
                		break;
                    default:
                        break;
                }
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

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('workj_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtOdate').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box("z_workjp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'workj', "95%", "95%", m_print);
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock();
                    return;
                }
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workj') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['imgsrc']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                for(var i=0;i<q_bbsCount;i++){
                	if($('#imgPic_'+i).attr('src')!=undefined && $('#imgPic_'+i).attr('src').length==0 && $('#txtImgsrc_'+i).val().length>0)
                		$('#imgPic_'+i).attr('src','../images/fe/'+$('#txtImgsrc_'+i).val()+'.jpg');
                	if($('#imgPic_'+i).attr('src')!=undefined && $('#imgPic_'+i).attr('src').length>0 && $('#txtImgsrc_'+i).val().length==0)
                		$('#imgPic_'+i).attr('src','');
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
            }

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                        $('#txtPicno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtPicno_', '');
                            $('#btnPicno_'+n).click();
                        });
                    	$('#txtPicno_'+i).change(function(e){
                    		var n = $(this).attr('id').replace('txtPicno_', '');
                    		var t_picno = $('#txtPicno_'+n).val();
                    		var t_para = $('#txtImgpara_'+n).val();
                    		var t_imgsrc = $('#txtImgsrc_'+n).val();
                    		if(t_imgsrc.length==0){
                    			t_imgsrc = r_userno+'-'+guid();
                    			$('#txtImgsrc_'+n).val(t_imgsrc);
                    		}
                    		if(t_picno.length>0 && t_para.length>0){
			                	q_func( 'imgfe.gen',t_imgsrc+','+t_picno+','+t_para.replace(/\,/g,'^'));
                    		}
                    	});
                    	$('#txtImgpara_'+i).change(function(e){
                    		var n = $(this).attr('id').replace('txtImgpara_', '');
                    		var t_picno = $('#txtPicno_'+n).val();
                    		var t_para = $('#txtImgpara_'+n).val();
                    		var t_imgsrc = $('#txtImgsrc_'+n).val();
                    		if(t_imgsrc.length==0){
                    			t_imgsrc = r_userno+'-'+guid();
                    			$('#txtImgsrc_'+n).val(t_imgsrc);
                    		}
                    		if(t_picno.length>0 && t_para.length>0){
			                	q_func( 'imgfe.gen',t_imgsrc+','+t_picno+','+t_para.replace(/\,/g,'^'));
                    		}
                    	});
                    }
                }
                _bbsAssign();
            }
			var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
			})();
			function imgDisplay(obj){
				$(obj).hide();
			}
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtProductno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno__', '');
                            $('#btnProduct__'+n).click();
                        });
                        $('#txtUno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtUno__', '');
                            $('#btnUno__'+n).click();
                        });
                    }
                }
                _bbtAssign();
            }


            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
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
                height: 30%;
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
            .txt.c2 {
                width: 130%;
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
                width: 100%;
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
                width: 100%;
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
                width: 100%;
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
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewCust'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:100px; color:black;"><a id='vewOdate'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='odate' style="text-align: center;">~odate</td>
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
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblOdate" class="lbl"> </a></td>
						<td><input id="txtOdate"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtCustno"  type="text"  class="txt" style="width:45%;float:left;"/>
							<input id="txtCust"  type="text"  class="txt" style="width:55%;float:left;"/>
							<input id="txtNick"  type="text"  class="txt" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblSite" class="lbl"> </a></td>
						<td><input id="txtSite"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblTagcolor" class="lbl"> </a></td>
						<td><input id="txtTagcolor"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTrantype" class="lbl"> </a></td>
						<td colspan="2"><input id="txtTrantype"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblChktype" class="lbl"> </a></td>
						<td colspan="2"><input id="txtChktype"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"></td>
						<td style="width:80px;"><a id='lbl_product'>品名</a></td>
						<td style="width:150px;"><a id='lbl_pic'>形狀</a></td>
						<td style="width:80px;"><a id='lbl_picno'>形狀編號</a></td>
						<td style="width:100px;"><a id='lbl_imgpara'>參數</a></td>
						<td style="width:80px;"><a id='lbl_lengthb'>單支長</a></td>
						<td style="width:80px;"><a id='lbl_monnt'>數量</a></td>
						<td style="width:80px;"><a id='lbl_weight'>重量</a></td>
						<td style="width:80px;"><a id='lbl_timea'>時間</a></td>
						<td style="width:200px;"><a id='lbl_memo'>備註</a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
							<input id="txtImgsrc.*"  type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input class="txt" id="txtProductno.*" type="text" style="width:95%;"/>
							<input class="txt" id="txtProduct.*" type="text" style="width:95%;"/>
							<input id="btnProduct.*" type="button" style="display:none;">
						</td>
						<td><img id="imgPic.*" src="" style="width:100px;height:100px;"/></td>
						<td>
							<input class="txt" id="txtPicno.*" type="text" style="width:95%;"/>
							<input id="btnPicno.*" type="button" style="display:none;">
						</td>
						<td><input class="txt" id="txtImgpara.*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtLengthb.*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtMount.*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtWeight.*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtTimea.*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtMemo.*" type="text" style="width:95%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"></td>
						<td style="width:150px; text-align: center;">批號</td>
						<td style="width:150px; text-align: center;">品名</td>
						<td style="width:100px; text-align: center;">數量</td>
						<td style="width:100px; text-align: center;">重量</td>
						<td style="width:430px; text-align: center;">備註</td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input class="txt" id="txtUno..*" type="text" style="width:95%;"/>
							<input id="btnUno..*" type="button" style="display:none;">
						</td>
						<td>
							<input class="txt" id="txtProductno..*" type="text" style="width:45%;float:left;"/>
							<input class="txt" id="txtProduct..*" type="text" style="width:45%;float:left;"/>
							<input id="btnProduct..*" type="button" style="display:none;">
						</td>
						<td><input class="txt" id="txtMount..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtWeight..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtMemo..*" type="text" style="width:95%;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
