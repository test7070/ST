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
        <script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_tables = 's';
            var q_name = "quat";
            var q_readonly = ['txtComp', 'txtAcomp','txtSales','txtWorker'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 15, 0, 1],['txtTax', 10, 0, 1],['txtTotal', 15, 0, 1],['txtTotalus', 15, 2, 1],['txtWeight', 15, 3, 1]];
            var bbsNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],['textSize4', 10, 2, 1],['txtMount', 10, 0, 1],['txtWeight', 15, 3, 1],['txtPrice', 10, 2, 1],['txtTheory', 15, 3, 1],['txtTotal', 15, 2, 1]];
            var bbmMask = [];
            var bbsMask = [['txtStyle','A']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_', 'ucc_b.aspx'],
            ['txtUno_', 'btnUno_', 'uccc', 'view_uccc', 'txtUno_', 'uccc_seek_b.aspx?;;;1=0','95%','60%'],
            ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
            ['txtSales', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
            ['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no3'];
                q_brwCount();
				q_gt('style','',0,0,0,'');
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
            });
            
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                var t_money=0;
                for(var j = 0; j < q_bbsCount; j++) {
                	if($('#txtUnit_' + j).val().toUpperCase() == 'KG'){
                		q_tr('txtTotal_'+j ,q_float('txtWeight_'+j)*q_float('txtPrice_'+j));
                	}else{
                		q_tr('txtTotal_'+j ,q_float('txtMount_'+j)*q_float('txtPrice_'+j));
                	}
					t_money+=q_float('txtTotal_'+j);
                }  // j
				q_tr('txtMoney' ,t_money);
				q_tr('txtTotal' ,q_float('txtMoney')+q_float('txtTax'));
				q_tr('txtTotalus' ,q_float('txtTotal')*q_float('txtFloata'));
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbStype", q_getPara('orde.stype')); 
                //q_cmbParse("cmbCoin", q_getPara('sys.coin'));     
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));  
                q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));  
                q_cmbParse("cmbKind", q_getPara('sys.stktype')); 
                $('#txtFloata').change(function () {sum();});
				$('#txtTotal').change(function () {sum();});
                //變動尺寸欄位
				$('#cmbKind').change(function () {
		        	size_change();
				});
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }
			var StyleList = '';
			var t_uccArray = new Array;
            function q_gtPost(t_name) {
                switch (t_name) {
	            	case 'style' :
            			var as = _q_appendData("style", "", true);
            			StyleList = new Array();
            			StyleList = as;
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
                    	t_uccArray = _q_appendData("ucc", "", true);
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('quatst_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }
            
            function combPaytype_chg() {
            	 var cmb = document.getElementById("combPaytype")
	            if (!q_cur) 
	                cmb.value = '';
	            else
	                $('#txtPaytype').val(cmb.value);
	            cmb.value = '';
            }
            
            function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function getTheory(b_seq){
				t_Radius = $('#txtRadius_'+b_seq).val();
				t_Width = $('#txtWidth_'+b_seq).val();
				t_Dime = $('#txtDime_'+b_seq).val();
				t_Lengthb = $('#txtLengthb_'+b_seq).val();
				t_Mount = $('#txtMount_'+b_seq).val();
				t_Style = $('#txtStyle_'+b_seq).val();
				t_Stype = ($('#cmbStype').find("option:selected").text() == '外銷'?1:0);
                t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting={
					calc:StyleList,
					ucc:t_uccArray,
					radius:t_Radius,
					width:t_Width,
					dime:t_Dime,
					lengthb:t_Lengthb,
					mount:t_Mount,
					style:t_Style,
					stype:t_Stype,
					productno:t_Productno,
					round:3
				};
				q_tr('txtTheory_'+b_seq ,theory_st(theory_setting));
				var t_Product = $('#txtProduct_' + b_seq).val();
				if(t_Product.indexOf('管') > -1 && dec($('#txtWeight_' + b_seq).val()) == 0){
					$('#txtWeight_' + b_seq).val($('#txtTheory_' + b_seq).val());
				}
			}

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtUnit_' + j).change(function () {sum();});
            		  	$('#txtMount_' + j).change(function () {sum();});
				        $('#txtWeight_' + j).change(function () {sum();});
				        $('#txtPrice_' + j).change(function () {sum();});
				        $('#txtTotal_' + j).change(function () {sum();});
						$('#txtStyle_' + j).blur(function(){
							$('input[id*="txtProduct_"]').each(function() {
								thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
				               	$(this).attr('OldValue',$('#txtProductno_'+thisId).val());
							});
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							ProductAddStyle(n);
						});
						//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
			            $('#textSize1_' + j).change(function () {
			            	var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
			                if ($('#cmbKind').val().substr(0,1)=='A'){	
			            		q_tr('txtDime_'+n ,q_float('textSize1_'+n));
							}else if($('#cmbKind').val().substr(0,1)=='B'){
			            		q_tr('txtRadius_'+n ,q_float('textSize1_'+n));	
							}
							q_tr('txtTheory_'+n ,getTheory(n));
						});
						$('#textSize2_' + j).change(function () {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if ($('#cmbKind').val().substr(0,1)=='A'){	
			            		q_tr('txtWidth_'+n ,q_float('textSize2_'+n));	
							}else if($('#cmbKind').val().substr(0,1)=='B'){
			            		q_tr('txtWidth_'+n ,q_float('textSize2_'+n));	
							}
							q_tr('txtTheory_'+n ,getTheory(n));
						});
						$('#textSize3_' + j).change(function () {
			            	var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
			                if ($('#cmbKind').val().substr(0,1)=='A'){	
			            		q_tr('txtLengthb_'+n ,q_float('textSize3_'+n));	
							}else if( $('#cmbKind').val().substr(0,1)=='B'){
			            		q_tr('txtDime_'+n ,q_float('textSize3_'+n));		
							}else{
			            		q_tr('txtLengthb_'+n ,q_float('textSize3_'+n));
							}
							q_tr('txtTheory_'+n ,getTheory(n));
						});
			            $('#textSize4_' + j).change(function () {
			            	var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
			                if ($('#cmbKind').val().substr(0,1)=='A'){	
			            		q_tr('txtRadius_'+n ,q_float('textSize4_'+n));	
							}else if( $('#cmbKind').val().substr(0,1)=='B'){
			            		q_tr('txtLengthb_'+n ,q_float('textSize4_'+n));	
							}
							q_tr('txtTheory_'+n ,getTheory(n));
						});
			            $('#txtMount_' + j).change(function () {
			            	var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							q_tr('txtTheory_'+n ,getTheory(n));
						});
						//-------------------------------------------------------------------------------------
					}
				}
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
            	size_change();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val('1');
				$('#txtAcomp').val((q_getPara('sys.comp').substring(0,3)=='裕承隆'?q_getPara('sys.comp').substring(0,3):q_getPara('sys.comp').substring(0,2)));
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
                size_change();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['productno']) {
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
				//q_popPost('txtProductno_');
				$('input[id*="txtProduct_"]').each(function(){
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
					$(this).attr('OldValue',$('#txtProductno_'+thisId).val());
				});
            }
            
			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function(){
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
		                	$(this).attr('OldValue',$('#txtProductno_'+thisId).val());
						});
                        if(trim($('#txtStyle_' + b_seq).val()).length != 0)
                        	ProductAddStyle(b_seq);
						$('#txtStyle_' + b_seq).focus();
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
			if(q_cur==1 || q_cur==2){
				$('input[id*="textSize"]').removeAttr('disabled');
			}else{
				$('input[id*="textSize"]').attr('disabled', 'disabled');
			}
			$('#cmbKind').val((($('#cmbKind').val())?$('#cmbKind').val():q_getPara('vcc.kind')));
			var t_kind = (($('#cmbKind').val())?$('#cmbKind').val():'');
			t_kind = t_kind.substr(0, 1);				
		  	if(t_kind=='A'){
            	$('#lblSize_help').text(q_getPara('sys.lblSizea'));
	        	for (var j = 0; j < q_bbsCount; j++) {
	            	$('#textSize1_'+j).show();
	            	$('#textSize2_'+j).show();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).hide();
			        $('#x1_'+j).show();
			        $('#x2_'+j).show();
			        $('#x3_'+j).hide();
			        $('#Size').css('width','230px');
			        $('#textSize1_'+j).val($('#txtDime_'+j).val());
			        $('#textSize2_'+j).val($('#txtWidth_'+j).val());
			        $('#textSize3_'+j).val($('#txtLengthb_'+j).val());
			        $('#textSize4_'+j).val(0);
			        $('#txtRadius_'+j).val(0);
				}
			}else if(t_kind=='B'){
				$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
			    for (var j = 0; j < q_bbsCount; j++) {
			    	$('#textSize1_'+j).show();
	            	$('#textSize2_'+j).show();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).show();
			        $('#x1_'+j).show();
			        $('#x2_'+j).show();
			        $('#x3_'+j).show();
			        $('#Size').css('width','310px');
			        $('#textSize1_'+j).val($('#txtRadius_'+j).val());
			        $('#textSize2_'+j).val($('#txtWidth_'+j).val());
			        $('#textSize3_'+j).val($('#txtDime_'+j).val());
			        $('#textSize4_'+j).val($('#txtLengthb_'+j).val());
				}
			}else{//鋼筋和鋼胚
				$('#lblSize_help').text(q_getPara('sys.lblSizec'));
	            for (var j = 0; j < q_bbsCount; j++) {
	            	$('#textSize1_'+j).hide();
	            	$('#textSize2_'+j).hide();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).hide();
			        $('#x1_'+j).hide();
			        $('#x2_'+j).hide();
			        $('#x3_'+j).hide();
			        $('#Size').css('width','70px');
			        $('#textSize1_'+j).val(0);
			        $('#txtDime_'+j).val(0);
			        $('#textSize2_'+j).val(0);
			        $('#txtWidth_'+j).val(0);
			        $('#textSize3_' + j).val($('#txtLengthb_'+j).val());
			        $('#textSize4_'+j).val(0);
			        $('#txtRadius_'+j).val(0);
				}
			}
		}
        </script> 
   <style type="text/css">
        #dmain {
                /*overflow: auto;*/
            }
            .dview {
                float: left;
                width: 28%;
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
                width: 70%;
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
                color: black;
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
                width: 48%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
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
            	float:left;
                width: 90%;
                text-align:center;
            }
            .txt.c7 {
                width: 95%;
                float: left;
            }
            .txt.c8 {
            	float:left;
                width: 65px;
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
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .dbbs {
                width: 1500px;
                float:left;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
    </style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain'>
        <div class="dview" id="dview">
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='custno comp,4'>~custno ~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' >
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr class="tr1">
               <td class="td1"><span> </span><a id='lblStype' class="lbl"></a></td>
               <td class="td2"><select id="cmbStype" class="txt c1"></select></td>
               <td class="td3"></td>
               <td class="td4"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td5"><input id="txtDatea" type="text"  class="txt c1"/></td>
               <td class="td6"></td>
               <td class="td7"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td8"><input id="txtNoa" type="text" class="txt c1"/></td> 
            </tr>    
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn" ></a></td>
               <td class="td2" colspan="2"><input id="txtCno"  type="text"  class="txt c4"/>
               <input id="txtAcomp"  type="text" class="txt c5"/></td>
               <td class="td4"><span> </span><a id='lblFloata' class="lbl"></a></td>
               <td class="td5"><select id="cmbCoin" class="txt c1" onchange='coin_chg()'></select></td>                 
               <td class="td6"><input id="txtFloata"  type="text"  class="txt num c1" /></td>                 
               <td class="td7"><span> </span><a id='lblContract' class="lbl"></a></td>
               <td class="td8"><input id="txtContract"  type="text"  class="txt c1"/></td> 
            </tr>
           <tr class="tr3">
                <td class="td1"><span> </span><a id="lblCust" class="lbl btn"></a></td>
                <td class="td2" colspan="2"><input id="txtCustno" type="text" class="txt c4"/>
                <input id="txtComp"  type="text" class="txt c5"/></td>
                <td class="td4"><span> </span><a id='lblPaytype' class="lbl"></a></td>
                <td class="td5"><input id="txtPaytype" type="text" class="txt c1" /></td> 
                <td class="td6"><select id="combPaytype" class="txt c1" onchange="combPaytype_chg();"></select></td> 
                <td class="td7"><span> </span><a id='lblTrantype' class="lbl"></a></td>
                <td class="td8"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td> 
            </tr>
            <tr class="tr4">
                <td class="td1"><span> </span><a id="lblSales" class="lbl btn"></a></td>
                <td class="td2" colspan="2"><input id="txtSalesno" type="text" class="txt c4"/> 
                <input id="txtSales" type="text" class="txt c5"/></td> 
                <td class="td4"><span> </span><a id='lblTel' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtTel"  type="text" class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblFax' class="lbl"></a></td>
                <td class="td8"><input id="txtFax"  type="text"  class="txt c1"/></td>
            </tr>
            <tr class="tr5">
                <td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
                <td class="td2"><input id="txtPost" type="text"  class="txt c1"></td>
                <td class="td3" colspan='4' ><input id="txtAddr" type="text"  class="txt c1" /></td>
                <td class="td7"><span> </span><a id='lblKind' class="lbl"> </a></td>
               	<td class="td8"><select id="cmbKind" class="txt c1"> </select></td>
            </tr>
            <tr class="tr6">
                <td class="td1"><span> </span><a id='lblAddr2' class="lbl"></a></td>
                <td class="td2"><input id="txtPost2"  type="text"  class="txt c1"/></td>
                <td class="td3" colspan='4'><input id="txtAddr2"  type="text"  class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblApv' class="lbl"></a></td>
                <td class="td8"><input id="txtApv"  type="text"  class="txt c1" disabled="disabled"/></td> 
            </tr>
            <tr class="tr7">
                <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
                <td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c1" /></td> 
                <td class="td4"><span> </span><a id='lblTax' class="lbl"></a></td>
                <td class="td5"><input id="txtTax" type="text"  class="txt num c1" /></td>
                <td class="td6"><select id="cmbTaxtype" class="txt c1"></select></td>
                <td class="td7"><span> </span><a id='lblTotal' class="lbl"></a></td>
                <td class="td8"><input id="txtTotal" type="text"  class="txt num c1" />
                </td> 
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblTotalus' class="lbl"></a></td>
                <td class="td2" colspan='2'><input id="txtTotalus" type="text"  class="txt num c1" /></td> 
                <td class="td4"><span> </span><a id='lblWeight' class="lbl"></a></td>
                <td class="td5" colspan='2' ><input id="txtWeight"  type="text"  class="txt num c1" /></td>
                <td class="td7"><span> </span><a id='lblWorker' class="lbl"></a></td>
                <td class="td8"><input id="txtWorker"  type="text" class="txt c1" /></td> 
            </tr>
            <tr class="tr9">
            	<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
                <td class="td2" colspan='7' ><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"></textarea></td>
                </tr>
        </table>
        </div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
              <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:13%;"><a id='lblUno_st'></a></td>
                <td align="center" style="width:8%;"><a id='lblProductno_st'></a></td>
                <td align="center" style="width:30px;"><a id='lblStyle_st'></a></td>
                <td align="center" style="width:12%;"><a id='lblProduct_st'></a></td>
                <td align="center" style="width:16%;" id='Size'><a id='lblSize_help'> </a><BR><a id='lblSize_st'> </a></td>
                <td align="center" style="width:4%;"><a id='lblUnit_st'></a></td>
                <td align="center" style="width:5%;"><a id='lblMount_st'></a></td>
                <td align="center" style="width:8%;"><a id='lblWeight_st'></a></td>
                <td align="center" style="width:6%;"><a id='lblPrice_st'></a></td>
                <td align="center" style="width:8%;"><a id='lblTotal_st'></a></td>
                <td align="center"><a id='lblMemo_st'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td>
                	<input class="txt c5" id="txtUno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnUno.*" type="button" value='.' style="width:1%;"/>
                	<input type="text" id="txtNo3.*"  class="txt c7" style="display:none;" />
                </td>
                <td>
					<input class="btn"  id="btnProduct.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                    <input type="text" id="txtProductno.*"  style="width:70%; float:left;"/>
                    <input id="txtClass.*" type="text" style="width: 93%;"/>
				</td>
                <td ><input id="txtStyle.*" type="text" class="txt c6"/></td>
                <td ><input id="txtProduct.*" type="text" class="txt c7"/></td>
                <td><input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/><div id="x1.*" style="float: left"> x</div>
                		<input class="txt num c8" id="textSize2.*" type="text" disabled="disabled"/><div id="x2.*" style="float: left"> x</div>
                        <input class="txt num c8" id="textSize3.*" type="text" disabled="disabled"/><div id="x3.*" style="float: left"> x</div>
                         <input class="txt num c8" id="textSize4.*" type="text" disabled="disabled"/>
                         <!--上為虛擬下為實際-->
                         <input id="txtRadius.*" type="hidden"/>
                		<input  id="txtWidth.*" type="hidden"/>
                        <input  id="txtDime.*" type="hidden"/>
                         <input id="txtLengthb.*" type="hidden"/>
                         <input class="txt c1" id="txtSpec.*" type="text"/>
                </td>
                <td ><input id="txtUnit.*" type="text" class="txt c7"/></td>
                <td ><input id="txtMount.*" type="text"  class="txt num c7"/></td>
                <td ><input id="txtWeight.*" type="text"  class="txt num c7" /></td>
                <td ><input id="txtPrice.*" type="text" class="txt num c7" /></td>
                <td ><input id="txtTotal.*" type="text" class="txt num c7" />
                                      <input id="txtTheory.*" type="text" class="txt num c7" /></td>
                
                <td><input id="txtMemo.*" type="text" class="txt c7"/>
                <input class="txt" id="txtOrdeno.*" type="text" style="width:65%;" />
                <input class="txt" id="txtNo2.*" type="text" style="width:20%;" />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
