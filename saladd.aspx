<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "saladd";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtNamea'];
            var bbmNum = [['txtHours', 10, 1, 1],['txtHr_special', 10, 1, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 10;
            q_copy = 1;

            aPop = new Array(['txtSssno', 'lblSssno', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']);

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
            }

            var x_datea = '#non', x_sssno = '#non';
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBtime', '99:99'], ['txtEtime', '99:99']];
                q_mask(bbmMask);
                
                if(r_rank<8){
                	q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtNamea','txtHours','txtHr_special'];
                }

                q_cmbParse("cmbTypea", ",工作日,休息日,例假日,國定假日");

                $('#txtDatea').blur(function() {
                    if(q_cur == 1 || q_cur == 2) {
						change_typea();
                    }
                });

                $('#txtBtime').blur(function() {
                    if (q_cur == 1 || q_cur == 2) {
                    	if($('#txtBtime').val()>'24:00')
                    		$('#txtBtime').val('00:00');
                        change_hrours();
                    }
                });

                $('#txtEtime').blur(function() {
                	if($('#txtEtime').val()>'24:00')
                    	$('#txtEtime').val('24:00');
                    if (q_cur == 1 || q_cur == 2) {
                        change_hrours();
                    }
                });
                
                $('#cmbTypea').change(function() {
                	if (q_cur == 1 || q_cur == 2) {
                        change_hrours();
                    }
                });
            }
            
            function change_typea() {
				var t_date = $('#txtDatea').val();
				var t_restday=false;//休息日 預設禮拜六
				var t_sumday=false;//例假日 預設禮拜日
				var t_holiday=false;//國定假日
				var t_workday=false;//工作天
				
				if(r_len==3){
            		if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0){
            			t_sumday=true;
            		}else{
            			t_sumday=false;
            		}
            		if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6){
            			t_restday=true;
            		}else{
            			t_restday=false;
            		}
            	}else{
            		if(new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2))-1,dec(t_date.substr(8,2))).getDay()==0){
            			t_sumday=true;
            		}else{
            			t_sumday=false;
            		}
            		if(new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2))-1,dec(t_date.substr(8,2))).getDay()==6){
            			t_restday=true;
            		}else{
            			t_restday=false;
            		}
            	}
				
				q_gt('holiday', "where=^^noa='" + t_date + "' ^^", 0, 0, 0, "", r_accy,1);
				var as = _q_appendData("holiday", "", true);
				if(as[0]!=undefined){
            		if(as[0].iswork=='true'){
            			t_workday=true;
            		}else{
            			t_holiday=true;
            		}
            	}
            	
            	if((r_len==3 && $('#txtNoa').val()>='105/12/23') || (r_len==4 && $('#txtNoa').val()>='2016/12/23')){
	            	if(t_workday){
	            		$('#cmbTypea').val('工作日');
	            	}else{
	            		if(t_holiday){
	            			$('#cmbTypea').val('國定假日');
	            		}else{
	            			$('#cmbTypea').val('工作日');
	            			
		            		if(t_restday){
		            			$('#cmbTypea').val('休息日');
		            		}
		            		if(t_sumday){
		            			$('#cmbTypea').val('例假日');
		            		}
	            		}
	            	}
            	}else{
            		if(t_workday){
	            		$('#cmbTypea').val('工作日');
	            	}else{
	            		if(t_holiday){
	            			$('#cmbTypea').val('國定假日');
	            		}else{
	            			$('#cmbTypea').val('工作日');
	            			if(t_restday){
	            				$('#cmbTypea').val('');
	            			}
		            		if(t_sumday){
		            			$('#cmbTypea').val('例假日');
		            		}
	            		}
            		}
            	}
			}
			
            function change_hrours() {
                if (!emp($('#txtBtime').val()) && !emp($('#txtEtime').val())) {
                    if ($('#txtBtime').val() > $('#txtEtime').val()) {
                        var time = $('#txtBtime').val()
                        $('#txtBtime').val($('#txtEtime').val());
                        $('#txtEtime').val(time);
                    }
                    var ONE_HOUR = 1000 * 60 * 60;
                    // 1小時的毫秒數
                    var ONE_MIN = 1000 * 60;
                    // 1分鐘的毫秒數

                    var Bdatetime = new Date(0, 0, 0, $('#txtBtime').val().substr(0, 2), $('#txtBtime').val().substr(3, 2), 0);
                    var Edatetime = new Date(0, 0, 0, $('#txtEtime').val().substr(0, 2), $('#txtEtime').val().substr(3, 2), 0);

                    var diff = Edatetime - Bdatetime;

                    var hours = Math.floor(diff / ONE_HOUR);
                    if (hours > 0)
                        diff = diff - (hours * ONE_HOUR);

                    var mins = Math.floor(diff / ONE_MIN);
                    if (mins > 0)
                        mins = mins / 60;

                    var t_hours = hours + mins;
                    $('#txtHours').val(round(t_hours, 1));
                    
                    if((r_len==3 && $('#txtNoa').val()>='105/12/23') || (r_len==4 && $('#txtNoa').val()>='2016/12/23')){
		            	var t_typea=$('#cmbTypea').val();
		            	if(t_typea=='休息日'){
		            		t_hours=Math.ceil(t_hours/4)*4;
		            	}else if(t_typea=='例假日' || t_typea=='國定假日'){
		            		if(t_hours<=8){
		            			t_hours=8;
		            		}
		            	}
		            	t_hours=round(t_hours, 1);
		            	$('#txtHours').val(t_hours);
	            	}else{
	            		if(t_typea=='例假日' || t_typea=='國定假日'){
		            		if(t_hours<=8){
		            			t_hours=8;
		            		}
		            	}
	            	}
                }
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
                }// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('saladd_s.aspx', q_name + '_s', "500px", "60%", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                if (q_getPara('sys.project').toUpperCase() != 'RK') {
                    $('#txtDatea').val(q_date());
                    change_typea();
                }
                $('#chkIsapv').prop('checked', false);
            }

            function btnModi() {
                x_datea = $('#txtDatea').val();
                x_sssno = $('#txtSssno').val();
                _btnModi();
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;

                if (q_getPara('sys.project').toUpperCase() != 'DJ') {//07/07 不更新到salpresents
                    x_datea = x_datea.length == 0 ? '#non' : x_datea;
                    x_sssno = x_sssno.length == 0 ? '#non' : x_sssno;

                    q_func('qtxt.query.updatesalpresent', 'saladd.txt,updatesalpresent,' + encodeURI(x_datea) + ';' + encodeURI(x_sssno));

                    if (q_cur == 1 || q_cur == 2)
                        q_func('qtxt.query.updatesalpresent', 'saladd.txt,updatesalpresent,' + encodeURI($('#txtDatea').val()) + ';' + encodeURI($('#txtSssno').val()));

                    x_datea = '#non', x_sssno = '#non';
                }

                if (q_getPara('sys.project').toUpperCase() == 'DJ' && $('#txtDatea').val().length > 0 && $('#chkIsapv').prop('checked')) {
                    q_func('qtxt.query.changedata', 'salary.txt,changedata_dj,' + encodeURI($('#txtDatea').val().substr(0, r_lenm)) + ';' + encodeURI(q_date() + '變動' + $('#txtNoa').val() + '加班單作業') + ';1');
                }
            }

            function btnOk() {
                var t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')], ['txtSssno', q_getMsg('lblSssno')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());

                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else {
                    $('#txtWorker2').val(r_name);
                }

                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_saladd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);

                if (q_cur == 1 || q_cur == 2) {
                    if (!q_authRun(3) && r_rank < 8) {
                        $('#chkIsapv').attr('disabled', 'disabled');
                    }
                }
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
                x_datea = $('#txtDatea').val();
                x_sssno = $('#txtSssno').val();
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
                border-width: 0px;
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
                padding: 5px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 550px;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
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
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:1%; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:35%; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%; color:black;"><a id='vewNamea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='namea' style="text-align: center;">~namea</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSssno" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSssno"  type="text" style="width:50%;"/>
							<input id="txtNamea"  type="text" style="width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTime" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtBtime" type="text" style="float:left; width:32%;"/>
							<span style="float:left; display:block; width:3%; height:inherit; color:blue; font-size:14px; text-align:center;">~</span>
							<input id="txtEtime" type="text" style="float:left; width:32%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblHours' class="lbl"> </a></td>
						<td><input id="txtHours" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblIsapv' class="lbl"> </a></td>
						<td><input id="chkIsapv" type="checkbox"/></td>
					</tr>
					<!--加班單換休欄位暫不開放------------------------------------------->
					<tr style="display: none;">
						<td><span> </span><a id='lblHr_special' class="lbl"> </a></td>
						<td><input id="txtHr_special" type="text" class="txt num c1"/></td>
					</tr>
					<!--加班單換休欄位暫不開放------------------------------------------->
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text" class="txt c1"/></td>
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
		<input id="q_sys" type="hidden" />
	</body>
</html>
