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
        var q_name = "ucca";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [['txtMount', 10, 0,1],['txtMoney', 10, 0,1]];
        var bbmMask = [['txtTodate', '999/99/99']]; 
        var bbsMask = [['txtBeginmount', 15, 0,1],['txtBeginmoney', 15, 0,1],['txtLastmount', 15, 0,1],['txtLastmoney', 15, 0,1],['txMakeless', 15, 0,1]];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        aPop = new Array(['txtNou', 'lblNou', 'ucc', 'noa,product', 'txtNou', 'ucc_b.aspx']);
        //ajaxPath = ""; //  execute in Root
		brwCount2 = 10;
		
        $(document).ready(function () {
			bbmKey = ['noa'];
			bbsKey = ['noa', 'noq'];
			q_brwCount();
			 q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            $('#txtNoa').focus();
        });

        //////////////////   end Ready
        function main() {
            if (dataErr) {
                dataErr = false;
                return;
            }
            mainForm(0); // 1=Last  0=Top
        }  ///  end Main()


        function mainPost() {
            q_getFormat();
        	bbsMask = [['txtTodate', r_picd]];
            q_mask(bbmMask);
			q_cmbParse("cmbTypea", ' ,商品,製成品,在製品,原料,物料,下腳品,加工,費用');
				
			q_gt('acomp', '', 0, 0, 0, "",r_accy);
			
			$('#btnPre').click(function() {
                    t_where = "noa='" + $('#txtNoa').val() + "'";
                    q_box("uccab.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'uccab', "95%", "95%", "生產配方");
            });
			
            $('#txtNoa').change(function(e){
                $(this).val($.trim($(this).val()).toUpperCase());    	
				if($(this).val().length>0){
					t_where="where=^^ noa='"+$(this).val()+"'^^";
                    q_gt('ucca', t_where, 0, 0, 0, "checkUccano_change", r_accy);
					/*if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
					}else{
						Lock();
						alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
						Unlock();
					}*/
				}
			});
			$('#cmbTypea').change(function(e){
    			if($('#cmbTypea').val()=='商品'){
                     $('.isT1').hide();
                     $('.isT11').show();
                }else if($('#cmbTypea').val()=='原料' || $('#cmbTypea').val()=='物料'){
                         $('.isT2').hide();
                         $('.isT21').show();
                }else if($('#cmbTypea').val()=='在製品'){
                         $('.isT3').hide();
                         $('.isT31').show();
                }else if($('#cmbTypea').val()=='製成品' || $('#cmbTypea').val()=='加工'){
                         $('.isT4').hide();
                         $('.isT41').show();
                }else{
                         $('.isT5').hide();
                }
                        
                if($('#cmbTypea').val()=='製成品' || $('#cmbTypea').val()=='在製品' || $('#cmbTypea').val()=='下腳品' || $('#cmbTypea').val()=='加工'){
                    $('#lblSalecost').show();
                    $('#txtSalecost').show();
                    $('#btnPre').show();
                }else{
                    $('#lblSalecost').hide();
                    $('#txtSalecost').hide();
                    $('#btnPre').hide();
                }
            });
		} 
        function q_boxClose(s2) { 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'acomp':
		                var as = _q_appendData("acomp", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
		                    }
		                    q_cmbParse("cmbCno", t_item, 's');
		                    refresh(q_recno);  /// 第一次需要重新載入
		                }
		                break;
            	case 'checkUccano_change':
                		var as = _q_appendData("ucca", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].product);
                        }
                		break;
                case 'checkUccano_btnOk':
                		var as = _q_appendData("ucca", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].product);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('uccaz_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }
        
        function bbsAssign() {
			for (var i = 0; i < q_bbsCount; i++) {
				if (!$('#btnMinus_' + j).hasClass('isAssign')) {
					$('#btnMinus_' + i).click(function (e) {
		                   t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							$('#cmbCno_'+b_seq).val('');
					});
					$('#cmbCno_' + i).change(function (e) {
		                   t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							$('#txtBeginmount_'+b_seq).val(0);
							$('#txtBeginmoney_'+b_seq).val(0);
							$('#txtLastmount_'+b_seq).val(0);
							$('#txtLastmoney_'+b_seq).val(0);
					});
				}
			}
			_bbsAssign();
		}

        function btnIns() {
            _btnIns();
            refreshBbm();
            $('#txtNoa').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            refreshBbm();
            $('#txtProduct').focus();
        }

        function btnPrint() {
			//q_box('z_ucca.aspx?;;;'+r_accy, '', "95%", "95%", q_getMsg("popPrint"));
        }
        
        function q_stPost() {
			if (!(q_cur == 1 || q_cur == 2))
				return false;
                Unlock();
		}
            
        function btnOk() {
 			Lock(); 
            $('#txtNoa').val($.trim($('#txtNoa').val()));   	
            /*if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
			}else{
				alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
				Unlock();
				return;
			}*/
			if(q_cur==1){
				t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
				q_gt('ucca', t_where, 0, 0, 0, "checkUccano_btnOk", r_accy);
			}else{
				wrServer($('#txtNoa').val());
			}
        }

        function wrServer(key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }
        
        function bbsSave(as) {
			if (!as['cno']) {
				as[bbsKey[1]] = '';
				return;
			}
			q_nowf();
			return true;
		}
        
        function refresh(recno) {
            _refresh(recno);
            refreshBbm();
            if($('#cmbTypea').val()=='商品'){
                     $('.isT1').hide();
                     $('.isT11').show();
            }else if($('#cmbTypea').val()=='原料' || $('#cmbTypea').val()=='物料'){
                     $('.isT2').hide();
                     $('.isT21').show();
            }else if($('#cmbTypea').val()=='在製品'){
                     $('.isT3').hide();
                     $('.isT31').show();
            }else if($('#cmbTypea').val()=='製成品' || $('#cmbTypea').val()=='加工'){
                     $('.isT4').hide();
                     $('.isT41').show();
            }else{
                     $('.isT5').hide();
            }
            if($('#cmbTypea').val()=='製成品' || $('#cmbTypea').val()=='在製品' || $('#cmbTypea').val()=='下腳品' || $('#cmbTypea').val()=='加工'){
                    $('#lblSalecost').show();
                    $('#txtSalecost').show();
                    $('#btnPre').show();
            }else{
                    $('#lblSalecost').hide();
                    $('#txtSalecost').hide();
                    $('#btnPre').hide();
            }
        }
		function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
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
                width: 1024px;
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
                width: 1024px;
                margin: -1px;
                border: 1px black solid;
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
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
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
                width: 95%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 980px;
            }
            .tbbs a {
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left; "  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>                
                <td align="center" style="width:15%"><a id='vewNoa'></a></td>
                <td align="center" style="width:60%"><a id='vewProduct'></a></td>
                <td align="center" style="width:7%"><a id='vewUnit'></a></td>
                <td align="center" style="width:13%"><a id='vewType'></a></td>          
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='noa' style="text-align: left;">~noa</td>
                   <td align="center" id='product' style="text-align: left;">~product</td>
                   <td align="center" id='unit'>~unit</td>
                   <td align="center" id='typea'>~typea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>   
            <tr>
               <td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
               <td class="td2"><input id="txtNoa"  type="text" class="txt c1" /></td>
               <!--<td class="td1"><span> </span><a id='lblNou' class="lbl btn"> </a></td>
               <td class="td2"><input id="txtNou"  type="text" class="txt c1" /></td>-->
               <td class="td3"></td>
               <td class="td4"></td>
               <td class="td5"></td>
               <td class="td6"></td>
               <td class="td7"></td>
               <td class="td8"><input id="btnPre" type="button" value='生產配方' style="display: none;"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblProduct' class="lbl"> </a></td>
               <td class="td2" colspan='3'><input id="txtProduct" type="text" class="txt c1" /></td>
               <td class="td5"><span> </span><a id='lblUnit' class="lbl"> </a></td>
               <td class="td6"><input id="txtUnit"  type="text" class="txt c1" /></td>
               <td class="td7"><span> </span><a id='lblVccacc' class="lbl"> </a></td>
               <td class="td8"><input id="txtVccacc"  type="text" class="txt c1" /></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblType' class="lbl"> </a></td>
               <td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
               <td class="td3"><span> </span><a id='lblBeginmount' class="lbl"> </a></td>
               <td class="td4"><input id="txtBeginmount"  type="text" class="txt c1 num" /></td>
               <td class="td5"><span> </span><a id='lblBeginmoney' class="lbl"> </a></td>
               <td class="td6"><input id="txtBeginmoney"  type="text" class="txt c1 num" /></td>
               <td class="td7"><span> </span><a id='lblRc2acc' class="lbl"> </a></td>
               <td class="td8"><input id="txtRc2acc"  type="text" class="txt c1" /></td>

            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblWages' class="lbl">直接加工</a></td>
               <td class="td2"><input id="txtWages"  type="text" class="txt c1 num" /></td>
               <td class="td3"><span> </span><a id='lblMakeless' class="lbl">製造費用</a></td>
               <td class="td4"><input id="txtMakeless"  type="text" class="txt c1 num" /></td>
               <td class="td5"><span> </span><a id='lblSafe_mount' class="lbl">安全存量</a></td>
               <td class="td6"><input id="txtSafe_mount"  type="text" class="txt c1 num" /></td>
               <td class="td7"><span> </span><a id='lblPrice' class="lbl">售價</a></td>
               <td class="td8"><input id="txtPrice"  type="text" class="txt c1 num" /></td>
            </tr>
            <tr>
               <td class="td1 isT11 isT11 isT4 isT2 isT5 isT3"><span> </span><a id='lblCost_pers' class="lbl">成本率</a></td>
               <td class="td2 isT11 isT11 isT4 isT2 isT5 isT3"><input id="txtCost_pers"  type="text" class="txt c1 num" /></td>
               <td class="td3 isT1 isT4 isT21 isT5 isT3"><span> </span><a id='lblMin_use' class="lbl">最小用量</a></td>
               <td class="td4 isT1 isT4 isT21 isT5 isT3"><input id="txtMin_use"  type="text" class="txt c1 num" /></td>
               <td class="td5"></td>
               <td class="td6"><input id="chkFix_make" type="checkbox"/><span> </span><a id='lblEnda'>定量生產</a></td>
            </tr>
            <tr class="isT1 isT41 isT2 isT5 isT3">
               <td class="td1"><span> </span><a id='lblDay_prod' class="lbl">日產量</a></td>
               <td class="td2"><input id="txtDay_prod"  type="text" class="txt c1 num" /></td>
               <td class="td3"><span> </span><a id='lblLastmount' class="lbl">產銷日差</a></td>
               <td class="td4"><input id="txtLastmount"  type="text" class="txt c1 num" /></td>
               <td class="td5"><span> </span><a id='lblU_p_day' class="lbl">製造日程</a></td>
               <td class="td6"><input id="txtU_p_day"  type="text" class="txt c1 num" /></td>
               <td class="td7"><span> </span><a id='lblMin_prod' class="lbl">最低產量</a></td>
               <td class="td8"><input id="txtMin_prod"  type="text" class="txt c1 num" /></td>
            </tr>
            <tr>
               <td class="td1 isT1 isT4 isT2 isT5 isT31"><span> </span><a id='lblTodrcr2' class="lbl">轉入製成品代碼</a></td>
               <td class="td2 isT1 isT4 isT2 isT5 isT31"><input id="txtTodrcr2"  type="text" class="txt c1" /></td>
               <td class="td3 isT1 isT4 isT2 isT5 isT31"><span> </span><a id='lblTodate' class="lbl">轉入日期</a></td>
               <td class="td4 isT1 isT4 isT2 isT5 isT31"><input id="txtTodate"  type="text" class="txt c1" /></td>
               <td class="td5 isT1 isT4 isT2 isT5 isT31"><span> </span><a id='lblBokrate' class="lbl">期出約當完成率</a></td>
               <td class="td6 isT1 isT4 isT2 isT5 isT31"><input id="txtBokrate"  type="text" class="txt c1 num" /></td>
               <td class="td7"><span> </span><a id='lblLokrate' class="lbl">期末約當完成率</a></td>
               <td class="td8"><input id="txtLokrate"  type="text" class="txt c1 num" /></td>
            </tr>
            <tr>
                <td><span> </span><a id='lblMemo_z' class="lbl">產品規格</a></td>
                <td colspan='7'><textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblSalecost' class="lbl" style="display: none;">指定原料成本</a></td>
               <td class="td2"><input id="txtSalecost"  type="text" class="txt c1 num" style="display: none;" /></td>
            </tr>
        </table>
        </div>
        </div> 
        <!--<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:100px;"><a id='lblAcomp'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMon'> </a></td>
					<td align="center" style="width:200px;"><a id='lblBeginmount'> </a></td>
					<td align="center" style="width:200px;"><a id='lblBeginmoney'> </a></td>
					<td class="isVU2" align="center" style="width:200px;display: none;"><a id='lblLastmount'>期末數量</a></td>
					<td class="isVU2" align="center" style="width:200px;display: none;"><a id='lblLastmoney'>期末金額</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><select id="cmbCno.*" class="txt c1" style="font-size: medium;"> </select></td>
					<td><input type="text" id="txtMon.*" style="width:97%;" /></td>
					<td ><input type="text" id="txtBeginmount.*" style="width:97%;text-align: right;" /></td>
					<td><input type="text" id="txtBeginmoney.*" style="width:97%;text-align: right;" /></td>
					<td class="isVU2" style="display: none;"><input type="text" id="txtLastmount.*" style="width:97%;text-align: right;" /></td>
					<td class="isVU2" style="display: none;"><input type="text" id="txtLastmoney.*" style="width:97%;text-align: right;" /></td>
				</tr>
			</table>
		</div>-->
        <input id="q_sys" type="hidden" />    
</body>
</html>
