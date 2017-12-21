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
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtComp'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 3;
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
                
                $('#btnMergeacccs').click(function() {
                	langcopy();
                });
                
                $('#combLang').change(function() {
                	langcopy();
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
                    	
                    } 
                }
                _bbsAssign();
                langcopy();
                var t_width=14050;//總寬度
                var t_dwidth=0;//每隱藏一間公司少500
                //只會用到5間公司
                if(q_getPara('sys.project').toUpperCase()=='JO' || q_getPara('sys.project').toUpperCase()=='AD'){
                	//F之後的公司隱藏
                	//97=a,122=z
                	for(var i=97;i<=122;i++){
                		if(i>102){
                			var tclass=String.fromCharCode(i);
                			$('.comp-'+tclass).hide();
                			
                			t_dwidth=t_dwidth+500;
                		}
                	}
                }
                t_width=t_width-t_dwidth;
                $('.dbbs').css('width',t_width.toString()+'px');
                $('.topbbs').css('width',t_width.toString()+'px');
            }
            
            function langcopy() {
            	var tlbl1=q_getMsg('lblA01');
            	var tlbl2=q_getMsg('lblA02');
            	var tlbl3=q_getMsg('lblA03');
            	var tlbl4=q_getMsg('lblA04');
            	var tlbl5=q_getMsg('lblA05');
            	//65=A,90=Z
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
            	}
            	
            	
            	//txtAnick
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
                
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
                width: 14050px;
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
		<div class='topbbs' style="width: 14050px;margin-bottom: -2px;">
			<table id="topbbs" class='tbbs'>
				<tr style='color:white; background:#003366;'>
					<td align="center" style="width:445px;"><a id='lblAcc'> </a></td>
					<td align="center" style="width:500px;" class="comp-a"><a id='lablA01'> </a></td>
					<td align="center" style="width:500px;" class="comp-b"><a id='lablB01'> </a></td>
					<td align="center" style="width:500px;" class="comp-c"><a id='lablC01'> </a></td>
					<td align="center" style="width:500px;" class="comp-d"><a id='lablD01'> </a></td>
					<td align="center" style="width:500px;" class="comp-e"><a id='lablE01'> </a></td>
					<td align="center" style="width:500px;" class="comp-f"><a id='lablF01'> </a></td>
					<td align="center" style="width:500px;" class="comp-g"><a id='lablG01'> </a></td>
					<td align="center" style="width:500px;" class="comp-h"><a id='lablH01'> </a></td>
					<td align="center" style="width:500px;" class="comp-i"><a id='lablI01'> </a></td>
					<td align="center" style="width:500px;" class="comp-j"><a id='lablJ01'> </a></td>
					<td align="center" style="width:500px;" class="comp-k"><a id='lablK01'> </a></td>
					<td align="center" style="width:500px;" class="comp-l"><a id='lablL01'> </a></td>
					<td align="center" style="width:500px;" class="comp-m"><a id='lablM01'> </a></td>
					<td align="center" style="width:500px;" class="comp-n"><a id='lablN01'> </a></td>
					<td align="center" style="width:500px;" class="comp-o"><a id='lablO01'> </a></td>
					<td align="center" style="width:500px;" class="comp-p"><a id='lablP01'> </a></td>
					<td align="center" style="width:500px;" class="comp-q"><a id='lablQ01'> </a></td>
					<td align="center" style="width:500px;" class="comp-r"><a id='lablR01'> </a></td>
					<td align="center" style="width:500px;" class="comp-s"><a id='lablS01'> </a></td>
					<td align="center" style="width:500px;" class="comp-t"><a id='lablT01'> </a></td>
					<td align="center" style="width:500px;" class="comp-u"><a id='lablU01'> </a></td>
					<td align="center" style="width:500px;" class="comp-v"><a id='lablV01'> </a></td>
					<td align="center" style="width:500px;" class="comp-w"><a id='lablW01'> </a></td>
					<td align="center" style="width:500px;" class="comp-x"><a id='lablX01'> </a></td>
					<td align="center" style="width:500px;" class="comp-y"><a id='lablY01'> </a></td>
					<td align="center" style="width:500px;" class="comp-z"><a id='lablZ01'> </a></td>
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
					<td align="center" style="width:170px;"><a id='lblAcc1'> </a></td>
					<td align="center" style="width:200px;"><a id='lblAcc2'> </a></td>
					<td align="center" style="width:100px;" class="comp-a"><a id='lblA01'> </a></td>
					<td align="center" style="width:100px;" class="comp-a"><a id='lblA02'> </a></td>
					<td align="center" style="width:100px;" class="comp-a"><a id='lblA03'> </a></td>
					<td align="center" style="width:100px;" class="comp-a"><a id='lblA04'> </a></td>
					<td align="center" style="width:100px;" class="comp-a"><a id='lblA05'> </a></td>
					<td align="center" style="width:100px;" class="comp-b"><a id='lblB01'> </a></td>
					<td align="center" style="width:100px;" class="comp-b"><a id='lblB02'> </a></td>
					<td align="center" style="width:100px;" class="comp-b"><a id='lblB03'> </a></td>
					<td align="center" style="width:100px;" class="comp-b"><a id='lblB04'> </a></td>
					<td align="center" style="width:100px;" class="comp-b"><a id='lblB05'> </a></td>
					<td align="center" style="width:100px;" class="comp-c"><a id='lblC01'> </a></td>
					<td align="center" style="width:100px;" class="comp-c"><a id='lblC02'> </a></td>
					<td align="center" style="width:100px;" class="comp-c"><a id='lblC03'> </a></td>
					<td align="center" style="width:100px;" class="comp-c"><a id='lblC04'> </a></td>
					<td align="center" style="width:100px;" class="comp-c"><a id='lblC05'> </a></td>
					<td align="center" style="width:100px;" class="comp-d"><a id='lblD01'> </a></td>
					<td align="center" style="width:100px;" class="comp-d"><a id='lblD02'> </a></td>
					<td align="center" style="width:100px;" class="comp-d"><a id='lblD03'> </a></td>
					<td align="center" style="width:100px;" class="comp-d"><a id='lblD04'> </a></td>
					<td align="center" style="width:100px;" class="comp-d"><a id='lblD05'> </a></td>
					<td align="center" style="width:100px;" class="comp-e"><a id='lblE01'> </a></td>
					<td align="center" style="width:100px;" class="comp-e"><a id='lblE02'> </a></td>
					<td align="center" style="width:100px;" class="comp-e"><a id='lblE03'> </a></td>
					<td align="center" style="width:100px;" class="comp-e"><a id='lblE04'> </a></td>
					<td align="center" style="width:100px;" class="comp-e"><a id='lblE05'> </a></td>
					<td align="center" style="width:100px;" class="comp-f"><a id='lblF01'> </a></td>
					<td align="center" style="width:100px;" class="comp-f"><a id='lblF02'> </a></td>
					<td align="center" style="width:100px;" class="comp-f"><a id='lblF03'> </a></td>
					<td align="center" style="width:100px;" class="comp-f"><a id='lblF04'> </a></td>
					<td align="center" style="width:100px;" class="comp-f"><a id='lblF05'> </a></td>
					<td align="center" style="width:100px;" class="comp-g"><a id='lblG01'> </a></td>
					<td align="center" style="width:100px;" class="comp-g"><a id='lblG02'> </a></td>
					<td align="center" style="width:100px;" class="comp-g"><a id='lblG03'> </a></td>
					<td align="center" style="width:100px;" class="comp-g"><a id='lblG04'> </a></td>
					<td align="center" style="width:100px;" class="comp-g"><a id='lblG05'> </a></td>
					<td align="center" style="width:100px;" class="comp-h"><a id='lblH01'> </a></td>
					<td align="center" style="width:100px;" class="comp-h"><a id='lblH02'> </a></td>
					<td align="center" style="width:100px;" class="comp-h"><a id='lblH03'> </a></td>
					<td align="center" style="width:100px;" class="comp-h"><a id='lblH04'> </a></td>
					<td align="center" style="width:100px;" class="comp-h"><a id='lblH05'> </a></td>
					<td align="center" style="width:100px;" class="comp-i"><a id='lblI01'> </a></td>
					<td align="center" style="width:100px;" class="comp-i"><a id='lblI02'> </a></td>
					<td align="center" style="width:100px;" class="comp-i"><a id='lblI03'> </a></td>
					<td align="center" style="width:100px;" class="comp-i"><a id='lblI04'> </a></td>
					<td align="center" style="width:100px;" class="comp-i"><a id='lblI05'> </a></td>
					<td align="center" style="width:100px;" class="comp-j"><a id='lblJ01'> </a></td>
					<td align="center" style="width:100px;" class="comp-j"><a id='lblJ02'> </a></td>
					<td align="center" style="width:100px;" class="comp-j"><a id='lblJ03'> </a></td>
					<td align="center" style="width:100px;" class="comp-j"><a id='lblJ04'> </a></td>
					<td align="center" style="width:100px;" class="comp-j"><a id='lblJ05'> </a></td>
					<td align="center" style="width:100px;" class="comp-k"><a id='lblK01'> </a></td>
					<td align="center" style="width:100px;" class="comp-k"><a id='lblK02'> </a></td>
					<td align="center" style="width:100px;" class="comp-k"><a id='lblK03'> </a></td>
					<td align="center" style="width:100px;" class="comp-k"><a id='lblK04'> </a></td>
					<td align="center" style="width:100px;" class="comp-k"><a id='lblK05'> </a></td>
					<td align="center" style="width:100px;" class="comp-l"><a id='lblL01'> </a></td>
					<td align="center" style="width:100px;" class="comp-l"><a id='lblL02'> </a></td>
					<td align="center" style="width:100px;" class="comp-l"><a id='lblL03'> </a></td>
					<td align="center" style="width:100px;" class="comp-l"><a id='lblL04'> </a></td>
					<td align="center" style="width:100px;" class="comp-l"><a id='lblL05'> </a></td>
					<td align="center" style="width:100px;" class="comp-m"><a id='lblM01'> </a></td>
					<td align="center" style="width:100px;" class="comp-m"><a id='lblM02'> </a></td>
					<td align="center" style="width:100px;" class="comp-m"><a id='lblM03'> </a></td>
					<td align="center" style="width:100px;" class="comp-m"><a id='lblM04'> </a></td>
					<td align="center" style="width:100px;" class="comp-m"><a id='lblM05'> </a></td>
					<td align="center" style="width:100px;" class="comp-n"><a id='lblN01'> </a></td>
					<td align="center" style="width:100px;" class="comp-n"><a id='lblN02'> </a></td>
					<td align="center" style="width:100px;" class="comp-n"><a id='lblN03'> </a></td>
					<td align="center" style="width:100px;" class="comp-n"><a id='lblN04'> </a></td>
					<td align="center" style="width:100px;" class="comp-n"><a id='lblN05'> </a></td>
					<td align="center" style="width:100px;" class="comp-o"><a id='lblO01'> </a></td>
					<td align="center" style="width:100px;" class="comp-o"><a id='lblO02'> </a></td>
					<td align="center" style="width:100px;" class="comp-o"><a id='lblO03'> </a></td>
					<td align="center" style="width:100px;" class="comp-o"><a id='lblO04'> </a></td>
					<td align="center" style="width:100px;" class="comp-o"><a id='lblO05'> </a></td>
					<td align="center" style="width:100px;" class="comp-p"><a id='lblP01'> </a></td>
					<td align="center" style="width:100px;" class="comp-p"><a id='lblP02'> </a></td>
					<td align="center" style="width:100px;" class="comp-p"><a id='lblP03'> </a></td>
					<td align="center" style="width:100px;" class="comp-p"><a id='lblP04'> </a></td>
					<td align="center" style="width:100px;" class="comp-p"><a id='lblP05'> </a></td>
					<td align="center" style="width:100px;" class="comp-q"><a id='lblQ01'> </a></td>
					<td align="center" style="width:100px;" class="comp-q"><a id='lblQ02'> </a></td>
					<td align="center" style="width:100px;" class="comp-q"><a id='lblQ03'> </a></td>
					<td align="center" style="width:100px;" class="comp-q"><a id='lblQ04'> </a></td>
					<td align="center" style="width:100px;" class="comp-q"><a id='lblQ05'> </a></td>
					<td align="center" style="width:100px;" class="comp-r"><a id='lblR01'> </a></td>
					<td align="center" style="width:100px;" class="comp-r"><a id='lblR02'> </a></td>
					<td align="center" style="width:100px;" class="comp-r"><a id='lblR03'> </a></td>
					<td align="center" style="width:100px;" class="comp-r"><a id='lblR04'> </a></td>
					<td align="center" style="width:100px;" class="comp-r"><a id='lblR05'> </a></td>
					<td align="center" style="width:100px;" class="comp-s"><a id='lblS01'> </a></td>
					<td align="center" style="width:100px;" class="comp-s"><a id='lblS02'> </a></td>
					<td align="center" style="width:100px;" class="comp-s"><a id='lblS03'> </a></td>
					<td align="center" style="width:100px;" class="comp-s"><a id='lblS04'> </a></td>
					<td align="center" style="width:100px;" class="comp-s"><a id='lblS05'> </a></td>
					<td align="center" style="width:100px;" class="comp-t"><a id='lblT01'> </a></td>
					<td align="center" style="width:100px;" class="comp-t"><a id='lblT02'> </a></td>
					<td align="center" style="width:100px;" class="comp-t"><a id='lblT03'> </a></td>
					<td align="center" style="width:100px;" class="comp-t"><a id='lblT04'> </a></td>
					<td align="center" style="width:100px;" class="comp-t"><a id='lblT05'> </a></td>
					<td align="center" style="width:100px;" class="comp-u"><a id='lblU01'> </a></td>
					<td align="center" style="width:100px;" class="comp-u"><a id='lblU02'> </a></td>
					<td align="center" style="width:100px;" class="comp-u"><a id='lblU03'> </a></td>
					<td align="center" style="width:100px;" class="comp-u"><a id='lblU04'> </a></td>
					<td align="center" style="width:100px;" class="comp-u"><a id='lblU05'> </a></td>
					<td align="center" style="width:100px;" class="comp-v"><a id='lblV01'> </a></td>
					<td align="center" style="width:100px;" class="comp-v"><a id='lblV02'> </a></td>
					<td align="center" style="width:100px;" class="comp-v"><a id='lblV03'> </a></td>
					<td align="center" style="width:100px;" class="comp-v"><a id='lblV04'> </a></td>
					<td align="center" style="width:100px;" class="comp-v"><a id='lblV05'> </a></td>
					<td align="center" style="width:100px;" class="comp-w"><a id='lblW01'> </a></td>
					<td align="center" style="width:100px;" class="comp-w"><a id='lblW02'> </a></td>
					<td align="center" style="width:100px;" class="comp-w"><a id='lblW03'> </a></td>
					<td align="center" style="width:100px;" class="comp-w"><a id='lblW04'> </a></td>
					<td align="center" style="width:100px;" class="comp-w"><a id='lblW05'> </a></td>
					<td align="center" style="width:100px;" class="comp-x"><a id='lblX01'> </a></td>
					<td align="center" style="width:100px;" class="comp-x"><a id='lblX02'> </a></td>
					<td align="center" style="width:100px;" class="comp-x"><a id='lblX03'> </a></td>
					<td align="center" style="width:100px;" class="comp-x"><a id='lblX04'> </a></td>
					<td align="center" style="width:100px;" class="comp-x"><a id='lblX05'> </a></td>
					<td align="center" style="width:100px;" class="comp-y"><a id='lblY01'> </a></td>
					<td align="center" style="width:100px;" class="comp-y"><a id='lblY02'> </a></td>
					<td align="center" style="width:100px;" class="comp-y"><a id='lblY03'> </a></td>
					<td align="center" style="width:100px;" class="comp-y"><a id='lblY04'> </a></td>
					<td align="center" style="width:100px;" class="comp-y"><a id='lblY05'> </a></td>
					<td align="center" style="width:100px;" class="comp-z"><a id='lblZ01'> </a></td>
					<td align="center" style="width:100px;" class="comp-z"><a id='lblZ02'> </a></td>
					<td align="center" style="width:100px;" class="comp-z"><a id='lblZ03'> </a></td>
					<td align="center" style="width:100px;" class="comp-z"><a id='lblZ04'> </a></td>
					<td align="center" style="width:100px;" class="comp-z"><a id='lblZ05'> </a></td>
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
						<input id="txtAcc1.*" type="text" style="float:left;width: 85%;" />
					</td>
					<td><input id="txtAcc2.*" type="text" class="txt c1"/></td>
					<td class="comp-a"><input id="txtA01.*" type="text" class="txt num c1"/></td>
					<td class="comp-a"><input id="txtA02.*" type="text" class="txt num c1"/></td>
					<td class="comp-a"><input id="txtA03.*" type="text" class="txt num c1"/></td>
					<td class="comp-a"><input id="txtA04.*" type="text" class="txt num c1"/></td>
					<td class="comp-a"><input id="txtA05.*" type="text" class="txt num c1"/></td>
					<td class="comp-b"><input id="txtB01.*" type="text" class="txt num c1"/></td>
					<td class="comp-b"><input id="txtB02.*" type="text" class="txt num c1"/></td>
					<td class="comp-b"><input id="txtB03.*" type="text" class="txt num c1"/></td>
					<td class="comp-b"><input id="txtB04.*" type="text" class="txt num c1"/></td>
					<td class="comp-b"><input id="txtB05.*" type="text" class="txt num c1"/></td>
					<td class="comp-c"><input id="txtC01.*" type="text" class="txt num c1"/></td>
					<td class="comp-c"><input id="txtC02.*" type="text" class="txt num c1"/></td>
					<td class="comp-c"><input id="txtC03.*" type="text" class="txt num c1"/></td>
					<td class="comp-c"><input id="txtC04.*" type="text" class="txt num c1"/></td>
					<td class="comp-c"><input id="txtC05.*" type="text" class="txt num c1"/></td>
					<td class="comp-d"><input id="txtD01.*" type="text" class="txt num c1"/></td>
					<td class="comp-d"><input id="txtD02.*" type="text" class="txt num c1"/></td>
					<td class="comp-d"><input id="txtD03.*" type="text" class="txt num c1"/></td>
					<td class="comp-d"><input id="txtD04.*" type="text" class="txt num c1"/></td>
					<td class="comp-d"><input id="txtD05.*" type="text" class="txt num c1"/></td>
					<td class="comp-e"><input id="txtE01.*" type="text" class="txt num c1"/></td>
					<td class="comp-e"><input id="txtE02.*" type="text" class="txt num c1"/></td>
					<td class="comp-e"><input id="txtE03.*" type="text" class="txt num c1"/></td>
					<td class="comp-e"><input id="txtE04.*" type="text" class="txt num c1"/></td>
					<td class="comp-e"><input id="txtE05.*" type="text" class="txt num c1"/></td>
					<td class="comp-f"><input id="txtF01.*" type="text" class="txt num c1"/></td>
					<td class="comp-f"><input id="txtF02.*" type="text" class="txt num c1"/></td>
					<td class="comp-f"><input id="txtF03.*" type="text" class="txt num c1"/></td>
					<td class="comp-f"><input id="txtF04.*" type="text" class="txt num c1"/></td>
					<td class="comp-f"><input id="txtF05.*" type="text" class="txt num c1"/></td>
					<td class="comp-g"><input id="txtG01.*" type="text" class="txt num c1"/></td>
					<td class="comp-g"><input id="txtG02.*" type="text" class="txt num c1"/></td>
					<td class="comp-g"><input id="txtG03.*" type="text" class="txt num c1"/></td>
					<td class="comp-g"><input id="txtG04.*" type="text" class="txt num c1"/></td>
					<td class="comp-g"><input id="txtG05.*" type="text" class="txt num c1"/></td>
					<td class="comp-h"><input id="txtH01.*" type="text" class="txt num c1"/></td>
					<td class="comp-h"><input id="txtH02.*" type="text" class="txt num c1"/></td>
					<td class="comp-h"><input id="txtH03.*" type="text" class="txt num c1"/></td>
					<td class="comp-h"><input id="txtH04.*" type="text" class="txt num c1"/></td>
					<td class="comp-h"><input id="txtH05.*" type="text" class="txt num c1"/></td>
					<td class="comp-i"><input id="txtI01.*" type="text" class="txt num c1"/></td>
					<td class="comp-i"><input id="txtI02.*" type="text" class="txt num c1"/></td>
					<td class="comp-i"><input id="txtI03.*" type="text" class="txt num c1"/></td>
					<td class="comp-i"><input id="txtI04.*" type="text" class="txt num c1"/></td>
					<td class="comp-i"><input id="txtI05.*" type="text" class="txt num c1"/></td>
					<td class="comp-j"><input id="txtJ01.*" type="text" class="txt num c1"/></td>
					<td class="comp-j"><input id="txtJ02.*" type="text" class="txt num c1"/></td>
					<td class="comp-j"><input id="txtJ03.*" type="text" class="txt num c1"/></td>
					<td class="comp-j"><input id="txtJ04.*" type="text" class="txt num c1"/></td>
					<td class="comp-j"><input id="txtJ05.*" type="text" class="txt num c1"/></td>
					<td class="comp-k"><input id="txtK01.*" type="text" class="txt num c1"/></td>
					<td class="comp-k"><input id="txtK02.*" type="text" class="txt num c1"/></td>
					<td class="comp-k"><input id="txtK03.*" type="text" class="txt num c1"/></td>
					<td class="comp-k"><input id="txtK04.*" type="text" class="txt num c1"/></td>
					<td class="comp-k"><input id="txtK05.*" type="text" class="txt num c1"/></td>
					<td class="comp-l"><input id="txtL01.*" type="text" class="txt num c1"/></td>
					<td class="comp-l"><input id="txtL02.*" type="text" class="txt num c1"/></td>
					<td class="comp-l"><input id="txtL03.*" type="text" class="txt num c1"/></td>
					<td class="comp-l"><input id="txtL04.*" type="text" class="txt num c1"/></td>
					<td class="comp-l"><input id="txtL05.*" type="text" class="txt num c1"/></td>
					<td class="comp-m"><input id="txtM01.*" type="text" class="txt num c1"/></td>
					<td class="comp-m"><input id="txtM02.*" type="text" class="txt num c1"/></td>
					<td class="comp-m"><input id="txtM03.*" type="text" class="txt num c1"/></td>
					<td class="comp-m"><input id="txtM04.*" type="text" class="txt num c1"/></td>
					<td class="comp-m"><input id="txtM05.*" type="text" class="txt num c1"/></td>
					<td class="comp-n"><input id="txtN01.*" type="text" class="txt num c1"/></td>
					<td class="comp-n"><input id="txtN02.*" type="text" class="txt num c1"/></td>
					<td class="comp-n"><input id="txtN03.*" type="text" class="txt num c1"/></td>
					<td class="comp-n"><input id="txtN04.*" type="text" class="txt num c1"/></td>
					<td class="comp-n"><input id="txtN05.*" type="text" class="txt num c1"/></td>
					<td class="comp-o"><input id="txtO01.*" type="text" class="txt num c1"/></td>
					<td class="comp-o"><input id="txtO02.*" type="text" class="txt num c1"/></td>
					<td class="comp-o"><input id="txtO03.*" type="text" class="txt num c1"/></td>
					<td class="comp-o"><input id="txtO04.*" type="text" class="txt num c1"/></td>
					<td class="comp-o"><input id="txtO05.*" type="text" class="txt num c1"/></td>
					<td class="comp-p"><input id="txtP01.*" type="text" class="txt num c1"/></td>
					<td class="comp-p"><input id="txtP02.*" type="text" class="txt num c1"/></td>
					<td class="comp-p"><input id="txtP03.*" type="text" class="txt num c1"/></td>
					<td class="comp-p"><input id="txtP04.*" type="text" class="txt num c1"/></td>
					<td class="comp-p"><input id="txtP05.*" type="text" class="txt num c1"/></td>
					<td class="comp-q"><input id="txtQ01.*" type="text" class="txt num c1"/></td>
					<td class="comp-q"><input id="txtQ02.*" type="text" class="txt num c1"/></td>
					<td class="comp-q"><input id="txtQ03.*" type="text" class="txt num c1"/></td>
					<td class="comp-q"><input id="txtQ04.*" type="text" class="txt num c1"/></td>
					<td class="comp-q"><input id="txtQ05.*" type="text" class="txt num c1"/></td>
					<td class="comp-r"><input id="txtR01.*" type="text" class="txt num c1"/></td>
					<td class="comp-r"><input id="txtR02.*" type="text" class="txt num c1"/></td>
					<td class="comp-r"><input id="txtR03.*" type="text" class="txt num c1"/></td>
					<td class="comp-r"><input id="txtR04.*" type="text" class="txt num c1"/></td>
					<td class="comp-r"><input id="txtR05.*" type="text" class="txt num c1"/></td>
					<td class="comp-s"><input id="txtS01.*" type="text" class="txt num c1"/></td>
					<td class="comp-s"><input id="txtS02.*" type="text" class="txt num c1"/></td>
					<td class="comp-s"><input id="txtS03.*" type="text" class="txt num c1"/></td>
					<td class="comp-s"><input id="txtS04.*" type="text" class="txt num c1"/></td>
					<td class="comp-s"><input id="txtS05.*" type="text" class="txt num c1"/></td>
					<td class="comp-t"><input id="txtT01.*" type="text" class="txt num c1"/></td>
					<td class="comp-t"><input id="txtT02.*" type="text" class="txt num c1"/></td>
					<td class="comp-t"><input id="txtT03.*" type="text" class="txt num c1"/></td>
					<td class="comp-t"><input id="txtT04.*" type="text" class="txt num c1"/></td>
					<td class="comp-t"><input id="txtT05.*" type="text" class="txt num c1"/></td>
					<td class="comp-u"><input id="txtU01.*" type="text" class="txt num c1"/></td>
					<td class="comp-u"><input id="txtU02.*" type="text" class="txt num c1"/></td>
					<td class="comp-u"><input id="txtU03.*" type="text" class="txt num c1"/></td>
					<td class="comp-u"><input id="txtU04.*" type="text" class="txt num c1"/></td>
					<td class="comp-u"><input id="txtU05.*" type="text" class="txt num c1"/></td>
					<td class="comp-v"><input id="txtV01.*" type="text" class="txt num c1"/></td>
					<td class="comp-v"><input id="txtV02.*" type="text" class="txt num c1"/></td>
					<td class="comp-v"><input id="txtV03.*" type="text" class="txt num c1"/></td>
					<td class="comp-v"><input id="txtV04.*" type="text" class="txt num c1"/></td>
					<td class="comp-v"><input id="txtV05.*" type="text" class="txt num c1"/></td>
					<td class="comp-w"><input id="txtW01.*" type="text" class="txt num c1"/></td>
					<td class="comp-w"><input id="txtW02.*" type="text" class="txt num c1"/></td>
					<td class="comp-w"><input id="txtW03.*" type="text" class="txt num c1"/></td>
					<td class="comp-w"><input id="txtW04.*" type="text" class="txt num c1"/></td>
					<td class="comp-w"><input id="txtW05.*" type="text" class="txt num c1"/></td>
					<td class="comp-x"><input id="txtX01.*" type="text" class="txt num c1"/></td>
					<td class="comp-x"><input id="txtX02.*" type="text" class="txt num c1"/></td>
					<td class="comp-x"><input id="txtX03.*" type="text" class="txt num c1"/></td>
					<td class="comp-x"><input id="txtX04.*" type="text" class="txt num c1"/></td>
					<td class="comp-x"><input id="txtX05.*" type="text" class="txt num c1"/></td>
					<td class="comp-y"><input id="txtY01.*" type="text" class="txt num c1"/></td>
					<td class="comp-y"><input id="txtY02.*" type="text" class="txt num c1"/></td>
					<td class="comp-y"><input id="txtY03.*" type="text" class="txt num c1"/></td>
					<td class="comp-y"><input id="txtY04.*" type="text" class="txt num c1"/></td>
					<td class="comp-y"><input id="txtY05.*" type="text" class="txt num c1"/></td>
					<td class="comp-z"><input id="txtZ01.*" type="text" class="txt num c1"/></td>
					<td class="comp-z"><input id="txtZ02.*" type="text" class="txt num c1"/></td>
					<td class="comp-z"><input id="txtZ03.*" type="text" class="txt num c1"/></td>
					<td class="comp-z"><input id="txtZ04.*" type="text" class="txt num c1"/></td>
					<td class="comp-z"><input id="txtZ05.*" type="text" class="txt num c1"/></td>
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
