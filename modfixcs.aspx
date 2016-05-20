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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">    
            var q_name = "modfixcs";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 30;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_copy=1;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(
				
			);

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }

            function mainPost() {
            	bbmMask = [['txtDatea',r_picd]]
            	bbmNum = [];
                q_mask(bbmMask);
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('modfixcs_s.aspx', q_name + '_s', "500px", "300px", $('#btnSeek').val());
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtNoq').val('001');
                $('#txtDatea').focus();
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
				q_box('z_modfixcsp.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", $('#btnPrint').val());
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				//sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_midfixc') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
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
                width: 1260px;
            }
            .dview {
                float: left;
                width: 250px;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 1000px;
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
            /*.tbbm .tdZ {
                width: 2%;
            }*/
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
                width: 99%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
                width: 50%;
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
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
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
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'>開單日期</a></td>
						<td align="center" style="width:30%"><a id='vewNoa'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height: 1px;">
						<td style="width: 120px;"> </td>
						<td style="width: 160px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 160px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 160px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl">模具單號</a></td>
						<td>
							<input id="txtNoa"  type="text" class="txt c1" />
							<input id="txtNoq"  type="hidden" class="txt c1" />
						</td>
						<td><span> </span><a id='lblDatea' class="lbl">開單日期</a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblCode' class="lbl">需求單位</a></td>
						<td><input id="txtCode"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDetail' class="lbl">商標</a></td>
						<td><input id="txtDetail"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNob' class="lbl btn">模具編號</a></td>
						<td><input id="txtNob" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblModel' class="lbl">模具名稱</a></td>
						<td><input id="txtModel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblProduct' class="lbl">產品名稱</a></td>
						<td><input id="txtProduct" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblSpec' class="lbl">產品材質</a></td>
						<td><input id="txtSpec" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl">内容概述<br>申請原因</a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWay2' class="lbl">附件</a></td>
						<td><input id="txtWay2" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorktype' class="lbl">大弓說明</a></td>
						<td><input id="txtWorktype" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWheel' class="lbl">螺丝說明</a></td>
						<td><input id="txtWheel" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblProductno' class="lbl btn">產品編號</a></td>
						<td><input id="txtProductno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImages' class="lbl">圖片</a></td>
						<td><input id="txtImages" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblMount' class="lbl">數量</a></td>
						<td><input id="txtMount" type="text" class="txt num c1"/></td>
					</tr>
					<tr style="background-color: lightgreen;">
						<td colspan="8" style="color: crimson;">產品圖面</td>
					</tr>
					<tr style="background-color: lightgreen;">
						<td><span> </span><a id='lblBtime' class="lbl">圖面主辦</a></td>
						<td><input id="txtBtime" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblBdate' class="lbl">完成日期</a></td>
						<td><input id="txtBdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblEtime' class="lbl">備註記事</a></td>
						<td><input id="txtEtime" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblEdate' class="lbl">模具交期</a></td>
						<td><input id="txtEdate" type="text" class="txt c1"/></td>
					</tr>
					<tr style="background-color: orange;">
						<td colspan="8" style="color: crimson;">ABS手板製造及確認</td>
					</tr>
					<tr style="background-color: orange;">
						<td><span> </span><a id='lblMech2' class="lbl">負責主辦人</a></td>
						<td><input id="txtMech2" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorktype2' class="lbl">完成日期</a></td>
						<td><input id="txtWorktype2" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: pink;">
						<td colspan="8" style="color: crimson;">模流分析</td>
					</tr>
					<tr style="background-color: pink;">
						<td><span> </span><a id='lblBtime2' class="lbl">負責主辦人</a></td>
						<td><input id="txtBtime2" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblEtime2' class="lbl">完成日期</a></td>
						<td><input id="txtEtime2" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: lightblue;">
						<td colspan="8" style="color: crimson;">模 具 圖 面 製 作</td>
					</tr>
					<tr style="background-color: lightblue;">
						<td><span> </span><a id='lblWay3' class="lbl">圖面負責主辦人/預定交期</a></td>
						<td><input id="txtWay3" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblBdate2' class="lbl">開始日期</a></td>
						<td><input id="txtBdate2" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblEdate2' class="lbl">完成日期</a></td>
						<td><input id="txtEdate2" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: lightblue;">
						<td><span> </span><a id='lblMemo2' class="lbl">備註記事</a></td>
						<td><input id="txtMemo2" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorktype3' class="lbl">訂模架</a></td>
						<td><input id="txtWorktype3" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMech3' class="lbl">使用機台</a></td>
						<td><input id="txtMech3" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: cadetblue;">
						<td colspan="8" style="color: crimson;">CNC加工</td>
					</tr>
					<tr style="background-color: cadetblue;">
						<td><span> </span><a id='lblBtime3' class="lbl">負責主辦人</a></td>
						<td><input id="txtBtime3" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblBdate3' class="lbl">完成日期</a></td>
						<td><input id="txtBdate3" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: palevioletred;">
						<td colspan="8" style="color: bisque;">模具製作</td>
					</tr>
					<tr style="background-color: palevioletred;">
						<td><span> </span><a id='lblEtime3' class="lbl">負責主辦人</a></td>
						<td><input id="txtEtime3" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblEdate3' class="lbl">交期</a></td>
						<td><input id="txtEdate3" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMemo3' class="lbl">備註記事</a></td>
						<td colspan="3"><input id="txtMemo3" type="text" class="txt c1"/></td>
					</tr>
					<tr style="background-color: antiquewhite;">
						<td colspan="8" style="color: crimson;">試 模 改 善</td>
					</tr>
					<tr style="background-color: antiquewhite;">
						<td><span> </span><a id='lblMech4' class="lbl">現進度</a></td>
						<td><input id="txtMech4" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblBdate4' class="lbl">試模日期1</a></td>
						<td><input id="txtBdate4" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblEdate4' class="lbl">試模日期2</a></td>
						<td><input id="txtEdate4" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblBtime4' class="lbl">試模日期3</a></td>
						<td><input id="txtBtime4" type="text" class="txt c1"/></td>
					</tr>
					<tr style="background-color: antiquewhite;">
						<td><span> </span><a id='lblMemo4' class="lbl">備註</a></td>
						<td colspan="7"><input id="txtMemo4" type="text" class="txt c1" /></td>
					</tr>
					<tr style="background-color: antiquewhite;">
						<td><span> </span><a id='lblWorktype4' class="lbl">制作LOGO</a></td>
						<td><input id="txtWorktype4" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker4' class="lbl">底壳打上字麦</a></td>
						<td><input id="txtWorker4" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFrame' class="lbl">定位环</a></td>
						<td><input id="txtFrame" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMech' class="lbl">驗證紀錄</a></td>
						<td><input id="txtMech" type="text" class="txt c1"/></td>
					</tr>
					<tr style="background-color: lightgoldenrodyellow;">
						<td><span> </span><a id='lblWay' class="lbl">大弓組配</a></td>
						<td><input id="txtWay" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker3' class="lbl">功能測試</a></td>
						<td><input id="txtWorker3" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblEtime4' class="lbl">護片組配</a></td>
						<td><input id="txtEtime4" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWay4' class="lbl">外觀確認</a></td>
						<td><input id="txtWay4" type="text" class="txt c1"/></td>
					</tr>
					<tr style="background-color: darkseagreen;">
						<td><span> </span><a id='lblImagememo' class="lbl">圖示說明</a></td>
						<td colspan="7"><input id="txtImagememo" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
