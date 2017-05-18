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
        	q_tables = 's'; //106/5/11改用bbs當作調整內容        
            var q_name = "class5";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
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
                bbsKey = ['noa', 'noq'];
                q_brwCount();
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
            		['txtShifthours', 3, 1, 1],['txtOstand', 6, 1, 1]
            		,['txtDoverhours', 3, 1, 1],['txtOverhours', 4, 1, 1]
            		,['txtDhoverhours', 3, 1, 1],['txtHoverhours', 4, 1, 1]
            		,['txtLate', 3, 0, 1],['txtLatenum', 2, 0, 1],['txtLatedfull', 3, 2, 1]
            		,['txtLate2', 3, 0, 1],['txtLate2dshour', 3, 2, 1],['txtLate2num', 2, 0, 1],['txtLate2dfull', 3, 2, 1]
            		,['txtLateallnum', 2, 0, 1],['txtLeave', 3, 0, 1]
            		,['txtVacanodhours', 2, 0, 1],['txtVacanonum', 2, 0, 1],['txtVacahalfdfull', 3, 2, 1]
            		,['txtMeals', 3, 0, 1],['txtMhours1', 2, 0, 1],['txtMhours2', 2, 0, 1]
            	];
            	bbsNum = [
            		['txtShifthours', 3, 1, 1],['txtOstand', 6, 1, 1]
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
            		['txtBtime', '99:99'], ['txtEtime', '99:99'], ['txtBdate', r_picd]
	            	, ['txtBresttime', '99:99'], ['txtEresttime', '99:99']
	            	, ['txtBresttime2', '99:99'], ['txtEresttime2', '99:99']
	            	, ['txtBresttime3', '99:99'], ['txtEresttime3', '99:99']
	            	, ['txtOvertime', '99:99'], ['txtMbtime1', '99:99'], ['txtMbtime2', '99:99']
            	];
            	bbsMask = [
            		['txtBtime', '99:99'], ['txtEtime', '99:99'], ['txtBdate', r_picd]
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
                
                $('#btnBBsin').click(function() {
                	if(q_cur==1 || q_cur==2){
	                	var t_bdate=$('#txtBdate').val();
	                	if(t_bdate.length>0){
	                		var t_n=-1,i_n=-1;
	                		for (var i = 0; i < q_bbsCount; i++) {
	                			if($('#txtBdate_'+i).val()==t_bdate){
	                				t_n=i;
	                				for (var j = 0; j < fbbm.length; j++) {
	                					if(fbbm[j]!='txtNoa' && fbbm[j]!='txtNamea' && fbbm[j]!='txtBdate' ){
	                						if(fbbm[j].substr(0,3)=='chk'){
	                							$('#'+fbbm[j]+'_'+i).prop('checked',$('#'+fbbm[j]).prop('checked'));
	                						}else{
	                							$('#'+fbbm[j]+'_'+i).val($('#'+fbbm[j]).val());
	                						}
	                					}
	                				}
	                				break;
	                			}
	                			if(emp($('#txtBdate_'+i).val()) && i_n==-1){
	                				i_n=i;
	                			}
	                		}
	                		if(t_n==-1){
	                			if(i_n==-1){
	                				i_n=q_bbsCount;
	                				$('#btnPlus').click();
	                			}
	                			
	                			for (var j = 0; j < fbbm.length; j++) {
	                				if(fbbm[j]!='txtNoa' && fbbm[j]!='txtNamea'){
	                					if(fbbm[j].substr(0,3)=='chk'){
	                						$('#'+fbbm[j]+'_'+i_n).prop('checked',$('#'+fbbm[j]).prop('checked'));
	                					}else{
	                						$('#'+fbbm[j]+'_'+i_n).val($('#'+fbbm[j]).val());
	                					}
	                				}
	                			}
	                		}
	                		
	                		t_update=true;
	                	}
	                }
				});
            }
            
            function bbmnewdata() {
            	var t_bdate='',t_n=-1;
            	for (var i = 0; i < q_bbsCount; i++) {
            		if($('#txtBdate_'+i).val()>t_bdate){
            			t_bdate=$('#txtBdate_'+i).val();
            			t_n=i;
            		}
            	}
            	if(t_bdate.length>0){
            		for (var j = 0; j < fbbm.length; j++) {
	                	if(fbbm[j]!='txtNoa' && fbbm[j]!='txtNamea'){
	                		if(fbbm[j].substr(0,3)=='chk'){
	                			$('#'+fbbm[j]).prop('checked',$('#'+fbbm[j]+'_'+t_n).prop('checked'));
	                		}else{
	                			$('#'+fbbm[j]).val($('#'+fbbm[j]+'_'+t_n).val());
	                		}
	                	}
	                }
            	}else{
            		for (var j = 0; j < fbbm.length; j++) {
	                	if(fbbm[j]!='txtNoa' && fbbm[j]!='txtNamea'){
	                		if(fbbm[j].substr(0,3)=='chk'){
	                			$('#'+fbbm[j]).prop('checked',false);
	                		}else{
	                			$('#'+fbbm[j]).val('');
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
                        	bbmnewdata();
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
            
            function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            $('#lblNo_' + i).text(i + 1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		            	$('#btnShowbbm_'+i).click(function() {
		            		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_bdate=$('#txtBdate_'+b_seq).val();
		            		
		            		if(t_bdate.length>0){
			            		for (var j = 0; j < fbbm.length; j++) {
				                	if(fbbm[j]!='txtNoa' && fbbm[j]!='txtNamea'){
				                		if(fbbm[j].substr(0,3)=='chk'){
				                			$('#'+fbbm[j]).prop('checked',$('#'+fbbm[j]+'_'+b_seq).prop('checked'));
				                		}else{
				                			$('#'+fbbm[j]).val($('#'+fbbm[j]+'_'+b_seq).val());
				                		}
				                	}
				                }
			            	}
		            		$('.bbstr').css('background','#cad3ff');
		            		$('#tr_'+b_seq).css('background','red');
						});
		            }
		        }
		        _bbsAssign();
		    }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').focus();
                $('#txtBdate').val(q_date());
                t_update=false;
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtClass5').focus();
                t_update=false;
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
			
			var t_update=false;
            function btnOk() {
            	$('#txtNoa').val($.trim($('#txtNoa').val()));
            	if(emp($('#txtNoa').val())){
            		alert('請輸入'+q_getMsg('lblNoa')+'!!');
            		return;
            	}
            	
            	if(emp($('#txtBdate').val())){
            		alert('請輸入生效日!!');
            		return;
            	}
            	
            	if($('#txtBtime').val()>'23:59' || $('#txtEtime').val()>'23:59'){
					alert('請輸入正確的'+q_getMsg('lblBtime')+'!!');
				}
				
				if(!t_update){
					if(!confirm("尚未點選【插入/更新表身記錄欄】，是否繼續?\n(表頭資料將清除，只顯示表身最新的生效日資料!!)")){
						return;
					}
				}
            	
                Lock();
                if (q_cur == 1) {
                    t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    q_gt('class5', t_where, 0, 0, 0, "checkClass5no_btnOk", r_accy);
                } else {
                	bbmnewdata();
                    wrServer($('#txtNoa').val());
                }
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            
            function bbsSave(as) {
		        if (!as['bdate']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        return true;
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
                if(t_para){
                	$('#btnBBsin').attr('disabled','disabled');
                }else{
                	$('#btnBBsin').removeAttr('disabled');
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
						<td> </td>
						<td colspan="2">
							<a id='lblBdate' class="lbl" style="float: left;">生效日</a>
							<span style="float: left;"> </span>
							<input id="txtBdate" type="text" class="txt c1" style="width: 100px;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td><input id="txtNamea" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td colspan="2"><input id="btnBBsin" type="button" value="插入/更新表身紀錄欄"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBtime' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtBtime" type="text" class="txt c2"/>
							<a style="float: left;">　~　</a>
							<input id="txtEtime" type="text" class="txt c2"/>
						</td>
						<td colspan="4" style="color: red;">※存檔確定後，表頭資料會更新到最新的生效日資料，<BR>　請在存檔前確認表身更新的內容資料。</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIsshift' class="lbl">輪班</a></td>
						<td colspan="2">
							<input id="chkIsshift" type="checkbox"/>
							<span> </span><a id='lblShifthours' class="lbl" style="float: none;margin-left: 20px;">輪班時數</a>
							<span style="width: 60px;float: right;"> </span>
							<input id="txtShifthours" type="text" class="txt num c1" style="width: 60px;float: right;" />
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
							<span style="float: left;"> </span>
							<a style="float: left;">(午休)</a>
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
						<td><span> </span><a id='lblLatenum' class="lbl">上下月次數各超過</a></td>
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
						<td><span> </span><a id='lblLate2num' class="lbl">上下月次數各超過</a></td>
						<td><input id="txtLate2num" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblLate2dfull' class="lbl">扣除%全勤獎金</a></td>
						<td><input id="txtLate2dfull" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: mediumturquoise;">
						<td><span> </span><a id='lblLateallnum' class="lbl">總次數扣全數全勤</a></td>
						<td><input id="txtLateallnum" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblLeave' class="lbl">超過分鐘數視事假</a></td>
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
		<div class='dbbs' style="width: 2820px;">
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:20px;">表頭</td>
					<td style="width:100px;"><a id='lblBdate_s'>生效日</a></td>
					<td style="width:150px;"><a id='lblBtime_s'>時間</a></td>
					<td style="width:50px;"><a id='lblIsshift_s'>輪班</a></td>
					<td style="width:80px;"><a id='lblShifthours_s'>輪班時數</a></td>
					<td style="width:150px;"><a id='lblBresttime_s'>休息時間1</a></td>
					<td style="width:150px;"><a id='lblBresttime2_s'>休息時間2</a></td>
					<td style="width:150px;"><a id='lblBresttime3_s'>休息時間3</a></td>
					<td style="width:80px;"><a id='lblMeals_s'>伙食費</a></td>
					<td style="width:80px;"><a id='lblMtime1_s'>伙食給予1<br>起算時間</a></td>
					<td style="width:80px;"><a id='lblMhours1_s'>伙食給予1<br>超過H</a></td>
					<td style="width:80px;"><a id='lblMtime2_s'>伙食給予2<br>起算時間</a></td>
					<td style="width:80px;"><a id='lblMhours2_s'>伙食給予2<br>超過H</a></td>
					<td style="width:80px;"><a id='lblOvertime_s'>加班<br>開始時間</a></td>
					<td style="width:80px;"><a id='lblOstand_s'>加班時薪</a></td>
					<td style="width:90px;"><a id='lblDoverhours_s'>平日<br>最多時數/天</a></td>
					<td style="width:90px;"><a id='lblOverhours_s'>平日<br>最多時數/月</a></td>
					<td style="width:90px;"><a id='lblDhoverhours_s'>假日<br>最多時數/天</a></td>
					<td style="width:90px;"><a id='lblHoverhours_s'>假日<br>最多時數/月</a></td>
					<td style="width:80px;"><a id='lblLate_s'>遲到Min.<br>不扣薪</a></td>
					<td style="width:85px;"><a id='lblLatenum_s'>上下月遲到<br>各超過次數</a></td>
					<td style="width:80px;"><a id='lblLatedfull_s'>扣除全勤<br>獎金%</a></td>
					<td style="width:80px;"><a id='lblLate2_s'>遲到Min.<br>扣薪</a></td>
					<td style="width:80px;"><a id='lblLate2dshour_s'>扣%時薪</a></td>
					<td style="width:85px;"><a id='lblLate2num_s'>上下月遲到<br>各超過次數</a></td>
					<td style="width:80px;"><a id='lblLate2dfull_s'>扣除全勤<br>獎金%</a></td>
					<td style="width:85px;"><a id='lblLateallnum_s'>總次數扣<br>全額全勤</a></td>
					<td style="width:100px;"><a id='lblLeave_s'>超過分鐘數<br>視事假</a></td>
					<td style="width:90px;"><a id='lblVacanodhours_s'>當日請假<br>不扣全勤/H</a></td>
					<td style="width:80px;"><a id='lblVacanonum_s'>超過次數<br>扣除全勤</a></td>
					<td style="width:80px;"><a id='lblVacahalfdfull_s'>請假半天<br>扣%全勤</a></td>
				</tr>
				<tr id="tr.*" class="bbstr" style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="btnShowbbm.*" type="button" value="."/></td>
					<td><input id="txtBdate.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtBtime.*" type="text" class="txt c1" style="width: 60px;"/><a style="float: left;">~</a>
						<input id="txtEtime.*" type="text" class="txt c1" style="width: 60px;"/>
					</td>
					<td><input id="chkIsshift.*" type="checkbox"/></td>
					<td><input id="txtShifthours.*" type="text" class="txt num c1"/></td>
					<td>
						<input id="txtBresttime.*" type="text" class="txt c1" style="width: 60px;"/><a style="float: left;">~</a>
						<input id="txtEresttime.*" type="text" class="txt c1" style="width: 60px;"/>
					</td>
					<td>
						<input id="txtBresttime2.*" type="text" class="txt c1" style="width: 60px;"/><a style="float: left;">~</a>
						<input id="txtEresttime2.*" type="text" class="txt c1" style="width: 60px;"/>
					</td>
					<td>
						<input id="txtBresttime3.*" type="text" class="txt c1" style="width: 60px;"/><a style="float: left;">~</a>
						<input id="txtEresttime3.*" type="text" class="txt c1" style="width: 60px;"/>
					</td>
					<td><input id="txtMeals.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMbtime1.*" type="text" class="txt c1"/></td>
					<td><input id="txtMhours1.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMbtime2.*" type="text" class="txt c1"/></td>
					<td><input id="txtMhours2.*" type="text" class="txt num c1"/></td>
					<td><input id="txtOvertime.*" type="text" class="txt c1"/></td>
					<td><input id="txtOstand.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDoverhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtOverhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDhoverhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtHoverhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatenum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatedfull.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2dshour.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2num.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2dfull.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLateallnum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLeave.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacanodhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacanonum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacahalfdfull.*" type="text" class="txt num c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
