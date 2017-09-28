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

            var q_name = "salovertime";
            var q_readonly = ['txtNoa','txtJob','txtNamea','txtPartno','txtPart','txtJob','txtOdate','txtAddhr','txtDehr','txtWorker','txtWorker2'];
            var bbmNum = [['txtAddhr', 10, 1, 1], ['txtComphr', 10, 1, 1], ['txtSalaryhr', 10, 1, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea,partno,part,jobno,job', 'txtSssno,txtNamea,txtPartno,txtPart,txtJobno,txtJob,txtDatea', 'sss_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
               if (r_rank < 8 )
					q_content = "where=^^sssno='" + r_userno + "'^^";
				else
					q_content ='';
					
				q_gt(q_name, q_content, q_sqlCount, 1);
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
                bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd], ['txtEnddate', r_picd], ['txtBtime', '99:99'], ['txtEtime', '99:99']];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", ',1@補休,2@加班費');

                $('#txtBtime').blur(function() {
                    change_hr_used();
                    $('#cmbTypea').change();
                });

                $('#txtEtime').blur(function() {
                    change_hr_used();
                    $('#cmbTypea').change();
                });
                
                $('#txtDatea').change(function() {
                	if(!emp($('#txtDatea').val())){
	                	var t_carryforwards=dec(q_getPara('salvacause.carryforwards'))
	                	$('#txtEnddate').val(q_cdn($('#txtDatea').val(),t_carryforwards))
	                }
				});
				
				$('#cmbTypea').change(function() {
					if($('#cmbTypea').val()=='1'){
						$('#txtComphr').val($('#txtAddhr').val());
						$('#txtSalaryhr').val(0);
					}
						
					if($('#cmbTypea').val()=='2'){
						$('#txtSalaryhr').val($('#txtAddhr').val());
						$('#txtComphr').val(0);
					}
				});
                
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

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function q_popPost(s1) {
                switch (s1) {
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('salovertime_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtOdate').val(q_date());
                $('#txtDatea').val(q_date());
                var t_carryforwards=dec(q_getPara('salvacause.carryforwards'));
                $('#txtEnddate').val(q_cdn(q_date(),t_carryforwards))
                $('#txtSssno').focus();
                $('#cmbTypea').val('1');
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
				if(dec($('#txtDehr').val())>0){
					alert('已換休禁止修改');
					return;
				}
                _btnModi();
                $('#txtSssno').focus();
            }

            function btnPrint() {
                q_box('z_salovertime.aspx' + "?;;;;" + ";noa=" + $('#txtNoa').val(), '', "95%", "650px", q_getMsg("popPrint"));
            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')], ['txtSssno', q_getMsg('lblSss')]
                , ['txtBtime', q_getMsg('lblBtime')], ['txtEtime', q_getMsg('lblBtime')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                var t_noa = trim($('#txtNoa').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(r_rank < 8){
                	//$('.manager').hide();
                	$('#cmbTypea').attr('disabled', 'disabled');
                	$('#txtSalaryhr').attr('disabled', 'disabled');
                	$('#txtComphr').attr('disabled', 'disabled');
                	$('#txtEnddate').attr('disabled', 'disabled');
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
				if(dec($('#txtDehr').val())>0){
					alert('已換休禁止刪除');
					return;
				}
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            
            function change_hr_used() {
                if (!emp($('#txtBtime').val()) && !emp($('#txtEtime').val())) {
					if ($('#txtBtime').val() > $('#txtEtime').val()) {
						var time = $('#txtBtime').val()
						$('#txtBtime').val($('#txtEtime').val());
						$('#txtEtime').val(time);
					}
                    var use_hr = 0;
					use_hr = round(((dec($('#txtEtime').val().substr(0, 2)) - dec($('#txtBtime').val().substr(0, 2))) * 60 + dec($('#txtEtime').val().substr(3, 2)) - dec($('#txtBtime').val().substr(3, 2))) / 60, 1);
					
					//暫定以一小時為單位
					use_hr=Math.floor(use_hr);
					
                    $('#txtAddhr').val(use_hr);
				}
            }
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
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
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview" style="float: left;  width:30%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:43%"><a id='vewBtime'> </a></td>
						<td align="center" style="width:22%"><a id='vewNamea'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='btime etime'>~btime ~ ~etime</td>
						<td align="center" id='namea'>~namea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate"  type="text" class="txt c1" /></td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td ><span> </span><a id='lblSss' class="lbl btn"> </a></td>
						<td>
							<input id="txtSssno"  type="text"  class="txt c2"/>
							<input id="txtNamea"  type="text"  class="txt c3"/>
						</td>
						<td ><span> </span><a id='lblPart' class="lbl"> </a></td>
						<td>
							<input id="txtPartno"  type="text"  class="txt c2"/>
							<input id="txtPart"  type="text"  class="txt c3"/>
						</td>
						<td><span> </span><a id='lblJob' class="lbl"> </a></td>
						<td>
							<input id="txtJob"  type="text" class="txt c1" />
							<input id="txtJobno"  type="text" style="display:none;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td ><span> </span><a id='lblBtime' class="lbl"> </a></td>
						<td>
							<input id="txtBtime"  type="text" class="txt" style="width: 65px;"/>
							<a style="float:left;">~</a>
							<input id="txtEtime"  type="text" class="txt" style="width: 65px;"/>
						</td>
						<td><span> </span><a id='lblAddhr' class="lbl"> </a></td>
						<td><input id="txtAddhr"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
					<tr class="manager">
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" style="width: 98%;"> </select></td>
						<td><span> </span><a id='lblComphr' class="lbl"> </a></td>
						<td><input id="txtComphr"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblSalaryhr' class="lbl"> </a></td>
						<td><input id="txtSalaryhr"  type="text" class="txt num c1"/></td>
					</tr>
					<!--<tr class="manager">
						<td><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td><input id="txtEnddate"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDehr' class="lbl"> </a></td>
						<td><input id="txtDehr"  type="text" class="txt num c1" /></td>
					</tr>-->
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
