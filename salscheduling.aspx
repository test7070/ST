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
            var q_name = "salscheduling";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_desc = 1;
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array();


            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                brwCount2 = 3;
                q_brwCount();
                q_gt('class5', "where=^^1=1^^", 0, 1);
                //q_gt(q_name, q_content, q_sqlCount, 1);
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }///  end Main()

            function mainPost() {
                q_getFormat();
                document.title='輪休時數設定';
                
                bbmMask = [['txtMon', r_picm]];
                q_mask(bbmMask);
            }
            
            function q_popPost(s1) {
                switch (s1) {
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }
            
			var t_class5='@';
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'class5':
                		var as = _q_appendData('class5', '', true);
						for ( i = 0; i < as.length; i++) {
							t_class5 = t_class5 + (t_class5.length > 0 ? ',' : '') + as[i].noa + '@' +as[i].noa +'.'+ as[i].namea;
						}
						
						q_cmbParse("cmbD01", t_class5,'s');
						q_cmbParse("cmbD02", t_class5,'s');
						q_cmbParse("cmbD03", t_class5,'s');
						q_cmbParse("cmbD04", t_class5,'s');
						q_cmbParse("cmbD05", t_class5,'s');
						q_cmbParse("cmbD06", t_class5,'s');
						q_cmbParse("cmbD07", t_class5,'s');
						q_cmbParse("cmbD08", t_class5,'s');
						q_cmbParse("cmbD09", t_class5,'s');
						q_cmbParse("cmbD10", t_class5,'s');
						q_cmbParse("cmbD11", t_class5,'s');
						q_cmbParse("cmbD12", t_class5,'s');
						q_cmbParse("cmbD13", t_class5,'s');
						q_cmbParse("cmbD14", t_class5,'s');
						q_cmbParse("cmbD15", t_class5,'s');
						q_cmbParse("cmbD16", t_class5,'s');
						q_cmbParse("cmbD17", t_class5,'s');
						q_cmbParse("cmbD18", t_class5,'s');
						q_cmbParse("cmbD19", t_class5,'s');
						q_cmbParse("cmbD20", t_class5,'s');
						q_cmbParse("cmbD21", t_class5,'s');
						q_cmbParse("cmbD22", t_class5,'s');
						q_cmbParse("cmbD23", t_class5,'s');
						q_cmbParse("cmbD24", t_class5,'s');
						q_cmbParse("cmbD25", t_class5,'s');
						q_cmbParse("cmbD26", t_class5,'s');
						q_cmbParse("cmbD27", t_class5,'s');
						q_cmbParse("cmbD28", t_class5,'s');
						q_cmbParse("cmbD29", t_class5,'s');
						q_cmbParse("cmbD30", t_class5,'s');
						q_cmbParse("cmbD31", t_class5,'s');
						
                		q_gt(q_name, q_content, q_sqlCount, 1);
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            function btnOk() {
                var t_err = q_chkEmpField([['txtMon', q_getMsg('lblMon')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
                
                if(q_cur==1)
                	$('#txtWorker').val(r_name)
                else 
                	$('#txtWorker2').val(r_name)
                	
                sum();
                
                var t_noa = trim($('#txtNoa').val());
                var t_mon = trim($('#txtMon').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_salscheduling') + (t_mon.length == 0 ? q_date() : t_mon), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('salscheduling_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        

                    }
                }
                _bbsAssign();
                
                //目前沒有客戶使用排班表 只有使用 設定當月班別時數
                $('.sss').hide();
                $('.dclass5').hide();
                $('.dbbs').css('width','350px');
            }
            
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtMon').val(q_date().substr(0,r_lenm));
                $('#txtMon').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                    
                _btnModi();
                $('#txtDatea').focus();
                
            }

            function btnPrint() {
                //q_box('z_salscheduling.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['sssno'] && !as['namea'] && !as['class5no'] && !as['class5']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0, t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                } // j
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
                width: 150px;
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
                width: 400px;
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
            .txt.c2 {
                width: 50%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 20%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
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
                width: 2820px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"], select {
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
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:95%"><a id='vewMon'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='mon'>~mon</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text" class="txt c1" /></td>
						<td style="display: none;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td style="display: none;"><input id="txtNoa" type="text" class="txt c1" /></td>
						<td> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:40px;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:200px;display: none;" class='sss'><a id='lblSss_s'> </a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD01_s'>01</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD02_s'>02</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD03_s'>03</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD04_s'>04</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD05_s'>05</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD06_s'>06</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD07_s'>07</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD08_s'>08</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD09_s'>09</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD10_s'>10</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD11_s'>11</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD12_s'>12</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD13_s'>13</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD14_s'>14</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD15_s'>15</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD16_s'>16</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD17_s'>17</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD18_s'>18</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD19_s'>19</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD20_s'>20</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD21_s'>21</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD22_s'>22</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD23_s'>23</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD24_s'>24</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD25_s'>25</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD26_s'>26</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD27_s'>27</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD28_s'>28</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD29_s'>29</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD30_s'>30</a></td>
					<td align="center" style="width:80px;display: none;" class='dclass5'><a id='lblD31_s'>31</a></td>
					<td align="center" style="width:200px;" class='class5'><a id='lblClass5_s'> </a></td>
					<td align="center" style="width:90px;" class='horus'><a id='lblHours_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td style="display: none;" class='sss'>
						<input class="btn"  id="btnSssno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtSssno.*" style="width:35%; float:left;"/>
						<input type="text" id="txtNamea.*" style="width:45%; float:left;"/>
					</td>
					<td style="display: none;" class='dclass5'><select id='cmbD01.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD02.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD03.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD04.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD05.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD06.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD07.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD08.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD09.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD10.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD11.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD12.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD13.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD14.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD15.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD16.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD17.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD18.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD19.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD20.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD21.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD22.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD23.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD24.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD25.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD26.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD27.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD28.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD29.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD30.*' style="width: 100%;"> </select></td>
					<td style="display: none;" class='dclass5'><select id='cmbD31.*' style="width: 100%;"> </select></td>
					<td class='class5'>
						<input class="btn"  id="btnClass5no.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtClass5no.*"  style="width:35%; float:left;"/>
						<input type="text" id="txtClass5.*"  style="width:45%; float:left;"/>
					</td>
					<td class='horus'>
						<input id="txtHours.*" type="text" style="width:95%;float:left;text-align: right;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
