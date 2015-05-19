<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

            var q_name = "umma";
            var q_readonly = ['txtVccbno','txtAccno','txtNoa', 'txtWorker','txtWorker2','txtAcc2','txtDdate','txtDiscount'];
            var bbmNum = [['txtMoney', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtDiscount', 10, 0, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //ajaxPath = "";
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
            ,['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2,txtMount', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_content="where=^^1=1^^";
                q_gt(q_name, q_content, q_sqlCount, 1)
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
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                q_gt('acomp', '', 0, 0, 0, "");
                
                $("#cmbCno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                
                $('#txtMoney').change(function() {
                	if(!emp($('#txtMoney').val()) && (emp($('#txtTotal').val()) || dec($('#txtTotal').val())==0)){
                		q_tr('txtTotal',$('#txtMoney').val());
                	}
				});
                
                $('#lblAccno').click(function() {
                	if(!emp($('#txtAccno').val()))
                    	q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_1', 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                });
                        
                $('#lblVccbno').click(function() {
                	if(!emp($('#txtVccbno').val()))
                    	q_box('vccb.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtVccbno').val()), '', "95%", "95%", "折讓作業");
                });
                
                $('#txtAcc1').change(function() {
					var patt = /^(\d{4})([^\.,.]*)$/g;
					$(this).val($(this).val().replace(patt,"$1.$2"));
	            	sum();
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        break;
                }  /// end switch
            }
            
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            
            function btnOk() {
            	Lock(1,{opacity:0});
                if ($.trim($('#txtNick').val()).length == 0)
                    $('#txtNick').val($('#txtComp').val());
                $('#txtAcomp').val($('#cmbCno').find(":selected").text());

                if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
					
                sum();
                
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }
                
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_umma') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('umma_s.aspx', q_name + '_s', "450px", "400px", q_getMsg("popSeek"));
            }
			
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtMon').val(q_date().substr(0, 6));
                $('#txtDatea').focus();
                $('#cmbCno').get(0).selectedIndex=1;
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
				q_box('z_umma.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function sum() {
            	
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
					
                } else {
                    
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
			
			function q_popPost(s1) {
		    	switch (s1) {
		    	}
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 490px;
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
                width: 700px;
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
                width: 23%;
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDiscount'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewBalancet'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" />
						</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
						<td id="discount,0,1" style="text-align: right;">~discount,0,1</td>
						<td id="balance,0,1" style="text-align: right;">~balance,0,1</td>
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
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"   type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl" > </a></td>
						<td colspan="3">
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text"  style="display:none;"/>
						</td>	
					</tr>
					<tr>
						<td><span> </span><a id="lblCust"  class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno" type="text" style="float:left; width:20%;"/>
							<input id="txtComp"  type="text" style="float:left; width:80%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIdate' class="lbl"> </a></td>
						<td><input id="txtIdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td><input id="txtInvono" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcc1' class="lbl btn"> </a></td>
						<td>
							<input id="txtAcc1" type="text"  class="txt c1" style="width: 49%;"/>
							<input id="txtAcc2" type="text"  class="txt c1" style="width: 49%;"/>
						</td>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3" ><textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height:50px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDdate' class="lbl"> </a></td>
						<td><input id="txtDdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDiscount' class="lbl"> </a></td>
						<td><input id="txtDiscount" type="text"  class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblVccbno' class="lbl btn"> </a></td>
						<td><input id="txtVccbno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

