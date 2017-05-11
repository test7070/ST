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
            var q_name = "class5";
            var q_readonly = [];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 15;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            q_copy=1;

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_content=" where=^^isnull(enda,0)=0^^ ";
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus();
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
            	bbmNum = [
            		['txtShifttime', 3, 1, 1],['txtOstand', 6, 1, 1]
            		,['txtDoverhours', 3, 1, 1],['txtOverhours', 4, 1, 1]
            		,['txtDhoverhours', 3, 1, 1],['txtHoverhours', 4, 1, 1]
            		,['txtLate', 3, 0, 1],['txtLatenum', 2, 0, 1],['txtLatedfull', 3, 2, 1]
            		,['txtLate2', 3, 0, 1],['txtLate2dshour', 3, 2, 1],['txtLate2num', 2, 0, 1],['txtLate2dfull', 3, 2, 1]
            		,['txtLateallnum', 2, 0, 1],['txtLeave', 3, 0, 1]
            		,['txtVacanodhours', 2, 0, 1],['txtVacanonum', 2, 0, 1],['txtVacahalfdfull', 3, 2, 1]
            		,['txtMeals', 3, 0, 1],['txtMhours1', 2, 0, 1],['txtMhours2', 2, 0, 1]
            	];
            	q_getFormat();
            	bbmMask = [
            		['txtBtime', '99:99'], ['txtEtime', '99:99']
	            	, ['txtBresttime', '99:99'], ['txtEresttime', '99:99']
	            	, ['txtBresttime2', '99:99'], ['txtEresttime2', '99:99']
	            	, ['txtBresttime3', '99:99'], ['txtEresttime3', '99:99']
	            	, ['txtOvertime', '99:99'], ['txtMbtime1', '99:99'], ['txtMbtime2', '99:99']
            	];
                q_mask(bbmMask);
                
                $('#txtNoa').change(function(e) {
                    $(this).val($.trim($(this).val()).toUpperCase());
                    if ($(this).val().length > 0) {
                        t_where = "where=^^ noa='" + $(this).val() + "'^^";
                        q_gt('class5', t_where, 0, 0, 0, "checkClass5no_change", r_accy);
                    }
                });
                
                $('#txtBtime').change(function(e) {
                    if($(this).val()>'23:59'){
                    	alert('請輸入正確的'+q_getMsg('lblBtime')+'!!');
                    }
                });
                $('#txtEtime').change(function(e) {
                    if($(this).val()>'23:59'){
                    	alert('請輸入正確的'+q_getMsg('lblBtime')+'!!');
                    }
                });
                
                $('.resttime').change(function(e) {
                    if($(this).val()>'23:59'){
                    	alert('請輸入正確的'+q_getMsg('lblResttime')+'!!');
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
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'checkClass5no_change':
                        var as = _q_appendData("class5", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
                        }
                        break;
                    case 'checkClass5no_btnOk':
                        var as = _q_appendData("class5", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
                            Unlock();
                            return;
                        } else {
                            wrServer($('#txtNoa').val());
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                //q_box('class5_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtEdate').val('');
                $('#chkEnda').prop('checked',false);
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtClass5').focus();
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
            	$('#txtNoa').val($.trim($('#txtNoa').val()));
            	if(emp($('#txtNoa').val())){
            		alert('請輸入'+q_getMsg('lblNoa')+'!!');
            		return;
            	}
            	
            	if($('#txtBtime').val()>'23:59' || $('#txtEtime').val()>'23:59'){
					alert('請輸入正確的'+q_getMsg('lblBtime')+'!!');
				}
				
				if($('#chkEnda').prop('checked')){
					$('#txtEdate').val(q_date());
				}
            	
                Lock();
                if (q_cur == 1) {
                    t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    q_gt('class5', t_where, 0, 0, 0, "checkClass5no_btnOk", r_accy);
                } else {
                    wrServer($('#txtNoa').val());
                }
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
                refreshBbm();
            }

            function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
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
                width: 25%;
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
                width: 73%;
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
                width: 22%;
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
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview" style="float: left;  width:350px;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%"><a id='vewNamea'> </a></td>
						<td align="center" style="width:45%"><a id='vewBtime'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='namea'>~namea</td>
						<td align="center" id='btime etime'>~btime ~ ~etime</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 910px;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height: 1px;">
						<td style="width: 190px;"> </td>
						<td style="width: 60px;"> </td>
						<td style="width: 180px;"> </td>
						<td style="width: 60px;"> </td>
						<td style="width: 160px;"> </td>
						<td style="width: 60px;"> </td>
						<td style="width: 130px;"> </td>
						<td style="width: 60px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1" /></td>
						<td> </td>
						<td><span> </span><a id='lblEnda' class="lbl">停用</a></td>
						<td><input id="chkEnda" type="checkbox"></td>
						<td><input id="txtEdate" type="hidden"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td><input id="txtNamea" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBtime' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtBtime" type="text" class="txt c2"/>
							<a style="float: left;">　~　</a>
							<input id="txtEtime" type="text" class="txt c2"/>
						</td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIsshift' class="lbl">輪班</a></td>
						<td colspan="2">
							<input id="chkIsshift" type="checkbox"/>
							<span> </span><a id='lblShifttime' class="lbl" style="float: none;margin-left: 20px;">輪班時數</a>
							<span style="width: 60px;float: right;"> </span>
							<input id="txtShifttime" type="text" class="txt num c1" style="width: 60px;float: right;" />
						</td>
						<td> </td>
						<td><span> </span><a id='lblMeals' class="lbl">伙食費</a></td>
						<td><input id="txtMeals" type="text" class="txt num c1" style="width: 60px;" /></td>
						<td><span style="float: left;"> </span>元/餐</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBresttime' class="lbl">休息時間1</a></td>
						<td colspan="3">
							<input id="txtBresttime" type="text" class="txt c2 resttime"/>
							<a style="float: left;">　~　</a>
							<input id="txtEresttime" type="text" class="txt c2 resttime"/>
						</td>
						<td><span> </span><a id='lblMtime1' class="lbl">伙食給予起算時間1</a></td>
						<td><input id="txtMbtime1" type="text" class="txt c1"/></td>
						<td colspan="2">
							<span style="float: left;"> </span>
							<a id='lblMhours1' class="lbl" style="float: left;">超過</a>
							<span style="float: left;"> </span>
							<input id="txtMhours1" type="text" class="txt num c2"/>
							<span style="float: left;"> </span>
							<a id='lblMhours1-1' class="lbl" style="float: left;">H給予伙食</a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBresttime2' class="lbl">休息時間2</a></td>
						<td colspan="3">
							<input id="txtBresttime2" type="text" class="txt c2 resttime"/>
							<a style="float: left;">　~　</a>
							<input id="txtEresttime2" type="text" class="txt c2 resttime"/>
						</td>
						<td><span> </span><a id='lblMtime2' class="lbl">伙食給予起算時間2</a></td>
						<td><input id="txtMbtime2" type="text" class="txt c1"/></td>
						<td colspan="2">
							<span style="float: left;"> </span>
							<a id='lblMhours2' class="lbl" style="float: left;">超過</a>
							<span style="float: left;"> </span>
							<input id="txtMhours2" type="text" class="txt num c2"/>
							<span style="float: left;"> </span>
							<a id='lblMhours2-1' class="lbl" style="float: left;">H給予伙食</a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBresttime3' class="lbl">休息時間3</a></td>
						<td colspan="3">
							<input id="txtBresttime3" type="text" class="txt c2 resttime"/>
							<a style="float: left;">　~　</a>
							<input id="txtEresttime3" type="text" class="txt c2 resttime"/>
						</td>
						<td> </td>
					</tr>
					<tr style="background-color: antiquewhite;">
						<td><span> </span><a id='lblOvertime' class="lbl">加班開始時間</a></td>
						<td><input id="txtOvertime" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblOstand' class="lbl">加班時薪</a></td>
						<td><input id="txtOstand" type="text" class="txt num c1" /></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: antiquewhite;">
						<td><span> </span><a id='lblDoverhours' class="lbl">平日最多時數/天</a></td>
						<td><input id="txtDoverhours" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblOverhours' class="lbl">平日最多時數/月</a></td>
						<td><input id="txtOverhours" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblDhoverhours' class="lbl">假日最多時數/天</a></td>
						<td><input id="txtDhoverhours" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblHoverhours' class="lbl">假日最多時數/月</a></td>
						<td><input id="txtHoverhours" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: mediumturquoise;">
						<td><span> </span><a id='lblLate' class="lbl">遲到分鐘數不扣薪</a></td>
						<td><input id="txtLate" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblLatenum' class="lbl">上下月合計超過次數</a></td>
						<td><input id="txtLatenum" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblLatedfull' class="lbl">扣除%全勤獎金</a></td>
						<td><input id="txtLatedfull" type="text" class="txt num c1" /></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: mediumturquoise;">
						<td><span> </span><a id='lblLate2' class="lbl">遲到分鐘數扣薪</a></td>
						<td><input id="txtLate2" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblLate2dshour' class="lbl">扣%時薪</a></td>
						<td><input id="txtLate2dshour" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblLate2num' class="lbl">上下月合計超過次數</a></td>
						<td><input id="txtLate2num" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblLate2dfull' class="lbl">扣除%全勤獎金</a></td>
						<td><input id="txtLate2dfull" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: mediumturquoise;">
						<td><span> </span><a id='lblLateallnum' class="lbl">總次數扣全數全勤</a></td>
						<td><input id="txtLateallnum" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblLeave' class="lbl">超過分鐘數視曠職/事假</a></td>
						<td><input id="txtLeave" type="text" class="txt num c1" style="width: 60px;" /></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: darksalmon;">
						<td colspan="2">
							<a id='lblVacanodhours1' class="lbl" style="float: left;">當日請假</a>
							<span style="float: left;"> </span>
							<input id="txtVacanodhours" type="text" class="txt num c1" style="width: 50px;" />
							<span style="float: left;"> </span>
							<a id='lblVacanodhours2' class="lbl" style="float: left;">/H以內不扣全勤</a>
						</td>
						<td colspan="2">
							<a id='lblVacanonum1' class="lbl" style="float: left;">超過</a>
							<span style="float: left;"> </span>
							<input id="txtVacanonum" type="text" class="txt num c1" style="width: 50px;" />
							<span style="float: left;"> </span>
							<a id='lblVacanonum2' class="lbl" style="float: left;">次扣除全勤</a>
						</td>
						<td colspan="2" style="background-color: yellowgreen;">
							<span style="float: left;"> </span>
							<a id='lblVacahalfdfull1' class="lbl" style="float: left;">請假半天內扣</a>
							<span style="float: left;"> </span>
							<input id="txtVacahalfdfull" type="text" class="txt num c1" style="width: 50px;" />
							<span style="float: left;"> </span>
							<a id='lblVacahalfdfull2' class="lbl" style="float: left;">%全勤</a>
						</td>
						<td style="background-color: yellowgreen;"> </td>
						<td style="background-color: yellowgreen;"> </td>
						<td style="background-color: yellowgreen;"> </td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
