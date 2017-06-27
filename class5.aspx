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
            brwCount2 = 5;
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
            		,['txtMeals', 3, 0, 1],['txtMhours1', 2, 0, 1],['txtMhours2', 2, 0, 1]
            		
            		,['txtWorkday', 2, 0, 1],['txtRestday', 2, 0, 1]
            		
            		,['txtLate', 3, 0, 1],['txtLatenoallmin', 3, 0, 1],['txtLatenoallnum', 3, 0, 1]
            		,['txtLate2', 3, 0, 1],['txtLate2dsmoney', 5, 0, 1],['txtLate2dshour', 3, 2, 1]
            		,['txtLate2dnmoney', 5, 0, 1],['txtLate2dnhour', 3, 2, 1]
            		,['txtLatemin', 3, 0, 1],['txtLatenum', 3, 0, 1],['txtLatedmoney', 5, 0, 1],['txtLatedfull', 3, 2, 1]
            		,['txtLate2min', 3, 0, 1],['txtLate2num', 3, 0, 1],['txtLate2dmoney', 5, 0, 1],['txtLate2dfull', 3, 2, 1]
            		,['txtLateallmin', 3, 0, 1],['txtLatemalldmoney', 5, 0, 1],['txtLatemalldfull', 3, 2, 1]
            		,['txtLateallnum', 3, 0, 1],['txtLatenalldmoney', 5, 0, 1],['txtLatenalldfull', 3, 2, 1]
            		
            		,['txtEarly', 3, 0, 1],['txtEarlynoallmin', 3, 0, 1],['txtEarlynoallnum', 3, 0, 1]
            		,['txtEarly2', 3, 0, 1],['txtEarly2dsmoney', 5, 0, 1],['txtEarly2dshour', 3, 2, 1]
            		,['txtEarly2dnmoney', 5, 0, 1],['txtEarly2dnhour', 3, 2, 1]
            		,['txtEarlynum', 3, 0, 1],['txtEarlyndmoney', 5, 0, 1],['txtEarlyndfull', 3, 2, 1]
            		
            		,['txtVacanodhours', 3, 0, 1],['txtVacadsmoney', 5, 0, 1],['txtVacadshour', 3, 2, 1]
            		,['txtVacanum', 3, 0, 1],['txtVacandmoney', 5, 0, 1],['txtVacandfull', 3, 2, 1]
            		,['txtVacahours', 3, 0, 1],['txtVacahdmoney', 5, 0, 1],['txtVacahdfull', 3, 2, 1]
            		,['txtVacadays', 3, 0, 1],['txtVacaddmoney', 5, 0, 1],['txtVacaddfull', 3, 2, 1]
            		
            		,['txtSicknodhours', 3, 0, 1],['txtSickdsmoney', 5, 0, 1],['txtSickdshour', 3, 2, 1]
            		,['txtSicknum', 3, 0, 1],['txtSickndmoney', 5, 0, 1],['txtSickndfull', 3, 2, 1]
            		,['txtSickhours', 3, 0, 1],['txtSickhdmoney', 5, 0, 1],['txtSickhdfull', 3, 2, 1]
            		,['txtSickdays', 3, 0, 1],['txtSickddmoney', 5, 0, 1],['txtSickddfull', 3, 2, 1]
            		
            		,['txtLeavedsmoney', 5, 0, 1],['txtLeavedshour', 3, 2, 1]
            		,['txtLeavendmoney', 5, 0, 1],['txtLeavendfull', 3, 2, 1]
            		
            		,['txtFclocknodnum', 3, 0, 1],['txtFclockdsmoney', 5, 0, 1],['txtFclockdshour', 3, 2, 1]
            		,['txtFclockdnum', 3, 0, 1],['txtFclockndmoney', 5, 0, 1],['txtFclockndfull', 3, 2, 1]
            	];
            	bbsNum = [
            		['txtShifthours', 3, 1, 1],['txtOstand', 6, 1, 1]
            		,['txtDoverhours', 3, 1, 1],['txtOverhours', 4, 1, 1]
            		,['txtDhoverhours', 3, 1, 1],['txtHoverhours', 4, 1, 1]
            		,['txtMeals', 3, 0, 1],['txtMhours1', 2, 0, 1],['txtMhours2', 2, 0, 1]
            		
            		,['txtWorkday', 2, 0, 1],['txtRestday', 2, 0, 1]
            		
            		,['txtLate', 3, 0, 1],['txtLatenoallmin', 3, 0, 1],['txtLatenoallnum', 3, 0, 1]
            		,['txtLate2', 3, 0, 1],['txtLate2dsmoney', 5, 0, 1],['txtLate2dshour', 3, 2, 1]
            		,['txtLate2dnmoney', 5, 0, 1],['txtLate2dnhour', 3, 2, 1]
            		,['txtLatemin', 3, 0, 1],['txtLatenum', 3, 0, 1],['txtLatedmoney', 5, 0, 1],['txtLatedfull', 3, 2, 1]
            		,['txtLate2min', 3, 0, 1],['txtLate2num', 3, 0, 1],['txtLate2dmoney', 5, 0, 1],['txtLate2dfull', 3, 2, 1]
            		,['txtLateallmin', 3, 0, 1],['txtLatemalldmoney', 5, 0, 1],['txtLatemalldfull', 3, 2, 1]
            		,['txtLateallnum', 3, 0, 1],['txtLatenalldmoney', 5, 0, 1],['txtLatenalldfull', 3, 2, 1]
            		
            		,['txtEarly', 3, 0, 1],['txtEarlynoallmin', 3, 0, 1],['txtEarlynoallnum', 3, 0, 1]
            		,['txtEarly2', 3, 0, 1],['txtEarly2dsmoney', 5, 0, 1],['txtEarly2dshour', 3, 2, 1]
            		,['txtEarly2dnmoney', 5, 0, 1],['txtEarly2dnhour', 3, 2, 1]
            		,['txtEarlynum', 3, 0, 1],['txtEarlyndmoney', 5, 0, 1],['txtEarlyndfull', 3, 2, 1]
            		
            		,['txtVacanodhours', 3, 0, 1],['txtVacadsmoney', 5, 0, 1],['txtVacadshour', 3, 2, 1]
            		,['txtVacanum', 3, 0, 1],['txtVacandmoney', 5, 0, 1],['txtVacandfull', 3, 2, 1]
            		,['txtVacahours', 3, 0, 1],['txtVacahdmoney', 5, 0, 1],['txtVacahdfull', 3, 2, 1]
            		,['txtVacadays', 3, 0, 1],['txtVacaddmoney', 5, 0, 1],['txtVacaddfull', 3, 2, 1]
            		
            		,['txtSicknodhours', 3, 0, 1],['txtSickdsmoney', 5, 0, 1],['txtSickdshour', 3, 2, 1]
            		,['txtSicknum', 3, 0, 1],['txtSickndmoney', 5, 0, 1],['txtSickndfull', 3, 2, 1]
            		,['txtSickhours', 3, 0, 1],['txtSickhdmoney', 5, 0, 1],['txtSickhdfull', 3, 2, 1]
            		,['txtSickdays', 3, 0, 1],['txtSickddmoney', 5, 0, 1],['txtSickddfull', 3, 2, 1]
            		
            		,['txtLeavedsmoney', 5, 0, 1],['txtLeavedshour', 3, 2, 1]
            		,['txtLeavendmoney', 5, 0, 1],['txtLeavendfull', 3, 2, 1]
            		
            		,['txtFclocknodnum', 3, 0, 1],['txtFclockdsmoney', 5, 0, 1],['txtFclockdshour', 3, 2, 1]
            		,['txtFclockdnum', 3, 0, 1],['txtFclockndmoney', 5, 0, 1],['txtFclockndfull', 3, 2, 1]
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
                
                q_cmbParse("cmbKind",'mon@按月,half@按上下期');
                q_cmbParse("cmbKind",'mon@按月,half@按上下期','s');
                
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
			<div class="dview" id="dview" style="float: left; width:330px;">
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
			<div class='dbbm' style="width: 1260px;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height: 1px;">
						<td style="width: 165px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 200px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 200px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 140px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 140px;"> </td>
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
						<td colspan="2"><input id="btnBBsin" type="button" value="插入/更新表身紀錄欄"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td><input id="txtNamea" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td colspan="5" style="color: red;">※存檔確定後，表頭資料會更新到最新的生效日資料，請在存檔前確認表身更新的內容資料。</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBtime' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtBtime" type="text" class="txt c2"/>
							<a style="float: left;">　~　</a>
							<input id="txtEtime" type="text" class="txt c2"/>
						</td>
						<td><span> </span><a id='lblWorkweek' class="lbl">工作日</a></td>
						<td colspan="5">
							<input id="chkWmon" type="checkbox" style="float: left;"/>
							<span style="float: left;"> </span>
							<a id='lblWmon' class="lbl" style="float: left;">一</a>
							<span style="float: left;"> </span>
							<!----------------------------------------->
							<input id="chkWtue" type="checkbox" style="float: left;"/>
							<span style="float: left;"> </span>
							<a id='lblWtue' class="lbl" style="float: left;">二</a>
							<span style="float: left;"> </span>
							<!----------------------------------------->
							<input id="chkWwed" type="checkbox" style="float: left;"/>
							<span style="float: left;"> </span>
							<a id='lblWwed' class="lbl" style="float: left;">三</a>
							<span style="float: left;"> </span>
							<!----------------------------------------->
							<input id="chkWthu" type="checkbox" style="float: left;"/>
							<span style="float: left;"> </span>
							<a id='lblWthu' class="lbl" style="float: left;">四</a>
							<span style="float: left;"> </span>
							<!----------------------------------------->
							<input id="chkWfri" type="checkbox" style="float: left;"/>
							<span style="float: left;"> </span>
							<a id='lblWfri' class="lbl" style="float: left;">五</a>
							<span style="float: left;"> </span>
							<!----------------------------------------->
							<input id="chkWsat" type="checkbox" style="float: left;"/>
							<span style="float: left;"> </span>
							<a id='lblWsat' class="lbl" style="float: left;">六</a>
							<span style="float: left;"> </span>
							<!----------------------------------------->
							<input id="chkWsun" type="checkbox" style="float: left;"/>
							<span style="float: left;"> </span>
							<a id='lblWsun' class="lbl" style="float: left;">日</a>
							<span style="float: left;"> </span>
							<!----------------------------------------->
						</td>
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
						<td><span> </span><a id='lblMeals' class="lbl">伙食費</a></td>
						<td><input id="txtMeals" type="text" class="txt num c1" style="width: 60px;" /></td>
						<td><span style="float: left;"> </span>元/餐</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBresttime2' class="lbl">休息時間2</a></td>
						<td colspan="3">
							<input id="txtBresttime2" type="text" class="txt c2 resttime"/>
							<a style="float: left;">　~　</a>
							<input id="txtEresttime2" type="text" class="txt c2 resttime"/>
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
						<td><span> </span><a id='lblBresttime3' class="lbl">休息時間3</a></td>
						<td colspan="3">
							<input id="txtBresttime3" type="text" class="txt c2 resttime"/>
							<a style="float: left;">　~　</a>
							<input id="txtEresttime3" type="text" class="txt c2 resttime"/>
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
					<!------------------------------------------------------------------------->
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
						<td> </td>
					</tr>
					<!------------------------------------------------------------------------->
					<tr style="background-color: aquamarine;">
						<td><span> </span><a id='lblIsshift' class="lbl">輪班</a></td>
						<td colspan="3">
							<input id="chkIsshift" type="checkbox" style="float: left;"/>
							<span style="float: left;"> </span>
							<a id='lblShifthours' class="lbl" style="float: left;margin-left: 20px;">輪班時數/天</a>
							<span style="width: 10px;float: left;"> </span>
							<input id="txtShifthours" type="text" class="txt num c1" style="width: 60px;float: left;" />
						</td>
						<td colspan="2">
							<a id='lblWorkday' class="lbl" style="float: left;">工作日數</a>
							<span style="float: left;"> </span>
							<input id="txtWorkday" type="text" class="txt c1" style="width: 60px;"/>
							<span style="float: left;"> </span>
							<a id='lblRestday' class="lbl" style="float: left;">休息日數</a>
							<span style="float: left;"> </span>
							<input id="txtRestday" type="text" class="txt c1" style="width: 60px;"/>
						</td>
						<td colspan="4"> </td>
					</tr>
					<!------------------------------------------------------------------------->
					<tr style="background-color: azure;">
						<td><span> </span><a id='lblKind' class="lbl">合計期別</a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td>
							<input id="txtVacanonum" type="hidden"/>
							<input id="txtVacahalfdfull" type="hidden"/>
							<input id="txtLeave" type="hidden"/>
						</td>
						<td colspan="7"> </td>
					</tr>
					<!------------------------------------------------------------------------->
					<tr style="background-color: lavender;">
						<td><span> </span><a class="lbl">遲到</a></td>
						<td colspan="9"> </td>
					</tr>
					<tr style="background-color: lavender;">
						<td> </td>
						<td><span> </span><a class="lbl">不扣薪：</a></td>
						<td><span> </span><a class="lbl">按日</a></td>
						<td colspan="2"><input id="txtLate" type="text" class="txt num c1" style="width:40px;"/>分內不扣薪</td>
						<td colspan="5"> </td>
					</tr>
					<tr style="background-color: lavender;">
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">依期別</a></td>
						<td colspan="2"><input id="txtLatenoallmin" type="text" class="txt num c1" style="width:40px;" />分內不扣薪</td>
						<td colspan="2"><input id="txtLatenoallnum" type="text" class="txt num c1" style="width:40px;" />次內不扣薪</td>
						<td colspan="3"> </td>
					</tr>
					<tr style="background-color: lavender;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: lavender;">
						<td> </td>
						<td><span> </span><a class="lbl">扣薪：</a></td>
						<td><span> </span><a class="lbl">每</a></td>
						<td><input id="txtLate2" type="text" class="txt num c1" style="width: 40px;">分計算</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtLate2dsmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定時薪%</a></td>
						<td><input id="txtLate2dshour" type="text" class="txt num c1" style="width:85px;" /></td>
						<td colspan="2"> </td>
					</tr>
					<tr style="background-color: lavender;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">依次計</a></td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtLate2dnmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定時薪%</a></td>
						<td><input id="txtLate2dnhour" type="text" class="txt num c1" style="width:85px;" /></td>
						<td colspan="2"> </td>
					</tr>
					<tr style="background-color: lavender;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: lavender;">
						<td colspan="2"><span> </span><a class="lbl">遲到全勤扣款：</a></td>
						<td><span> </span><a class="lbl">期別1</a></td>
						<td><input id="txtLatemin" type="text" class="txt num c1" style="width: 40px;">分內</td>
						<td>
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtLatenum" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">次，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtLatedmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtLatedfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: lavender;">
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">期別2</a></td>
						<td><input id="txtLate2min" type="text" class="txt num c1" style="width: 40px;">分內</td>
						<td>
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtLate2num" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">次，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtLate2dmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtLate2dfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: lavender;height: 1px;">
						<td colspan="2"> </td>
						<td colspan="8"><hr></td>
					</tr>
					<tr style="background-color: lavender;">
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">按月</a></td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtLateallmin" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總分鐘數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtLatemalldmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtLatemalldfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: lavender;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtLateallnum" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總次數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtLatenalldmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtLatenalldfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<!------------------------------------------------------------------------->
					<tr style="background-color: lightskyblue;">
						<td><span> </span><a class="lbl">早退</a></td>
						<td colspan="9"> </td>
					</tr>
					<tr style="background-color: lightskyblue;">
						<td> </td>
						<td><span> </span><a class="lbl">不扣薪：</a></td>
						<td><span> </span><a class="lbl">按日</a></td>
						<td colspan="2"><input id="txtEarly" type="text" class="txt num c1" style="width:40px;"/>分內不扣薪</td>
						<td colspan="5"> </td>
					</tr>
					<tr style="background-color: lightskyblue;">
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">依期別</a></td>
						<td colspan="2"><input id="txtEarlynoallmin" type="text" class="txt num c1" style="width:40px;" />分內不扣薪</td>
						<td colspan="2"><input id="txtEarlynoallnum" type="text" class="txt num c1" style="width:40px;" />次內不扣薪</td>
						<td colspan="3"> </td>
					</tr>
					<tr style="background-color: lightskyblue;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: lightskyblue;">
						<td> </td>
						<td><span> </span><a class="lbl">扣薪：</a></td>
						<td><span> </span><a class="lbl">每</a></td>
						<td><input id="txtEarly2" type="text" class="txt num c1" style="width: 40px;">分計算</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtEarly2dsmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定時薪%</a></td>
						<td><input id="txtEarly2dshour" type="text" class="txt num c1" style="width:85px;" /></td>
						<td colspan="2"> </td>
					</tr>
					<tr style="background-color: lightskyblue;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">依次計</a></td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtEarly2dnmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定時薪%</a></td>
						<td><input id="txtEarly2dnhour" type="text" class="txt num c1" style="width:85px;" /></td>
						<td colspan="2"> </td>
					</tr>
					<tr style="background-color: lightskyblue;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: lightskyblue;">
						<td colspan="2"><span> </span><a class="lbl">早退全勤扣款：</a></td>
						<td> </td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtEarlynum" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總次數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtEarlyndmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtEarlyndfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<!------------------------------------------------------------------------->
					<tr style="background-color: lavenderblush;">
						<td><span> </span><a class="lbl">事假</a></td>
						<td colspan="9"> </td>
					</tr>
					<tr style="background-color: lavenderblush;">
						<td> </td>
						<td><span> </span><a class="lbl">不扣薪：</a></td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td colspan="2">
							<input id="txtVacanodhours" type="text" class="txt num c1" style="width: 40px;" />
							<span style="float: left;"> </span>
							<a style="float: left;">時內不扣薪</a>
						</td>
						<td colspan="5"> </td>
					</tr>
					<tr style="background-color: lavenderblush;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: lavenderblush;">
						<td> </td>
						<td><span> </span><a class="lbl">扣薪：</a></td>
						<td> </td>
						<td><span> </span><a class="lbl">依時扣</a></td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtVacadsmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定時薪%</a></td>
						<td><input id="txtVacadshour" type="text" class="txt num c1" style="width:85px;" /></td>
						<td colspan="2"> </td>
					</tr>
					<tr style="background-color: lavenderblush;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: lavenderblush;">
						<td colspan="2"><span> </span><a class="lbl">事假全勤扣款：</a></td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtVacanum" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總次數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtVacandmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtVacandfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: lavenderblush;">
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtVacahours" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總時數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtVacahdmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtVacahdfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: lavenderblush;">
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtVacadays" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總天數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtVacaddmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtVacaddfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<!------------------------------------------------------------------------->
					<tr style="background-color: lemonchiffon;">
						<td> </td>
						<td colspan="3">
							<input id="chkIsvstotal" type="checkbox" style="float: left;">
							<a class="lbl" style="float: left;">事病假總次/時/天數合計全勤扣款</a>
						</td>
						<td colspan="6"> </td>
					</tr>
					<!------------------------------------------------------------------------->
					<tr style="background-color: lightgreen;">
						<td><span> </span><a class="lbl">病假</a></td>
						<td colspan="9"> </td>
					</tr>
					<tr style="background-color: lightgreen;">
						<td> </td>
						<td><span> </span><a class="lbl">不扣薪：</a></td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td colspan="2">
							<input id="txtSicknodhours" type="text" class="txt num c1" style="width: 40px;" />
							<span style="float: left;"> </span>
							<a style="float: left;">時內不扣薪</a>
						</td>
						<td colspan="5"> </td>
					</tr>
					<tr style="background-color: lightgreen;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: lightgreen;">
						<td> </td>						
						<td><span> </span><a class="lbl">扣薪：</a></td>
						<td> </td>
						<td><span> </span><a class="lbl">依時扣</a></td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtSickdsmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定時薪%</a></td>
						<td><input id="txtSickdshour" type="text" class="txt num c1" style="width:85px;" /></td>
						<td colspan="2"> </td>
					</tr>
					<tr style="background-color: lightgreen;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: lightgreen;">
						<td colspan="2"><span> </span><a class="lbl">病假全勤扣款：</a></td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtSicknum" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總次數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtSickndmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtSickndfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: lightgreen;">
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtSickhours" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總次數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtSickhdmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtSickhdfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: lightgreen;">
						<td> </td>
						<td> </td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtSickdays" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總天數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtSickddmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtSickddfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<!------------------------------------------------------------------------->
					<tr style="background-color: lightpink;">
						<td><span> </span><a class="lbl">曠職</a></td>
						<td colspan="9"> </td>
					</tr>
					<tr style="background-color: lightpink;">
						<td> </td>
						<td><span> </span><a class="lbl">扣薪：</a></td>
						<td> </td>
						<td><span> </span><a class="lbl">依時扣</a></td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtLeavedsmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定時薪%</a></td>
						<td><input id="txtLeavedshour" type="text" class="txt num c1" style="width:85px;" /></td>
						<td colspan="2"> </td>
					</tr>
					<tr style="background-color: lightpink;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: lightpink;">
						<td colspan="2"><span> </span><a class="lbl">曠職全勤扣款：</a></td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td><span> </span><a class="lbl">每次扣</a></td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtLeavendmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtLeavendfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td colspan="2"> </td>
					</tr>
					<!------------------------------------------------------------------------->
					<tr style="background-color: linen;">
						<td><span> </span><a class="lbl">忘刷</a></td>
						<td colspan="9"> </td>
					</tr>
					<tr style="background-color: linen;">
						<td> </td>
						<td><span> </span><a class="lbl">不扣薪：</a></td>
						<td><span> </span><a class="lbl">依期別</a></td>
						<td colspan="2">
							<input id="txtFclocknodnum" type="text" class="txt num c1" style="width:40px;" />
							<span style="float: left;"> </span>
							<a style="float: left;">次內不扣薪</a>
						</td>
						<td colspan="5"> </td>
					</tr>
					<tr style="background-color: linen;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: linen;">
						<td> </td>
						<td><span> </span><a class="lbl">扣薪：</a></td>
						<td> </td>
						<td><span> </span><a class="lbl">依次計</a></td>
						<td> </td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtFclockdsmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定時薪%</a></td>
						<td><input id="txtFclockdshour" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
					<tr style="background-color: linen;height: 1px;">
						<td> </td>
						<td colspan="9"><hr></td>
					</tr>
					<tr style="background-color: linen;">
						<td colspan="2"><span> </span><a class="lbl">忘刷全勤扣款：</a></td>
						<td><span> </span><a class="lbl">每期別</a></td>
						<td colspan="2">
							<a style="float: left;">超過</a><span style="float: left;"> </span>
							<input id="txtFclockdnum" type="text" class="txt num c1" style="width: 40px;">
							<span style="float: left;"> </span>
							<a style="float: left;">總次數，扣</a>
						</td>
						<td><span> </span><a class="lbl">固定金額</a></td>
						<td><input id="txtFclockndmoney" type="text" class="txt num c1" style="width:85px;" /></td>
						<td><span> </span><a class="lbl">固定全勤%</a></td>
						<td><input id="txtFclockndfull" type="text" class="txt num c1" style="width:85px;" /></td>
						<td> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 8580px;">
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:20px;">表頭</td>
					<td style="width:100px;"><a id='lblBdate_s'>生效日</a></td>
					<td style="width:150px;"><a id='lblBtime_s'>上班時間</a></td>
					<td style="width:280px;"><a id='lblWorkweek_s'>工作日</a></td>
					<td style="width:150px;"><a id='lblBresttime_s'>休息時間1</a></td>
					<td style="width:150px;"><a id='lblBresttime2_s'>休息時間2</a></td>
					<td style="width:150px;"><a id='lblBresttime3_s'>休息時間3</a></td>
					<!--------------------------------------------------------------------->
					<td style="width:80px;"><a id='lblMeals_s'>伙食費</a></td>
					<td style="width:80px;"><a id='lblMtime1_s'>伙食給予1<br>起算時間</a></td>
					<td style="width:80px;"><a id='lblMhours1_s'>伙食給予1<br>超過H</a></td>
					<td style="width:80px;"><a id='lblMtime2_s'>伙食給予2<br>起算時間</a></td>
					<td style="width:80px;"><a id='lblMhours2_s'>伙食給予2<br>超過H</a></td>
					<!---------------------------------------------------------------------->
					<td style="width:80px;"><a id='lblOvertime_s'>加班<br>開始時間</a></td>
					<td style="width:80px;"><a id='lblOstand_s'>加班時薪</a></td>
					<td style="width:90px;"><a id='lblDoverhours_s'>平日<br>最多時數/天</a></td>
					<td style="width:90px;"><a id='lblOverhours_s'>平日<br>最多時數/月</a></td>
					<td style="width:90px;"><a id='lblDhoverhours_s'>假日<br>最多時數/天</a></td>
					<td style="width:90px;"><a id='lblHoverhours_s'>假日<br>最多時數/月</a></td>
					<!---------------------------------------------------------------------->
					<td style="width:50px;"><a id='lblIsshift_s'>輪班</a></td>
					<td style="width:80px;"><a id='lblShifthours_s'>輪班時數<br>/天</a></td>
					<td style="width:80px;"><a id='lblWorkday_s'>工作日數</a></td>
					<td style="width:80px;"><a id='lblRestday_s'>休息日數</a></td>
					<!----------------------------------------------------------------------->
					<td style="width:90px;"><a id='lblKind_s'>合計期別</a></td>
					<!----------------------------------------------------------------------->
					<td style="width:90px;"><a id='lblLate_s'>遲到X分<br>內不扣薪</a></td>
					<td style="width:100px;"><a id='lblLatenoallmin_s'>期別中遲到X<br>分內不扣薪</a></td>
					<td style="width:100px;"><a id='lblLatenoallnum_s'>期別中遲到X<br>次內不扣薪</a></td>
					<td style="width:100px;"><a id='lblLate2_s'>每間隔X分鐘<br>計算扣薪</a></td>
					<td style="width:90px;"><a id='lblLate2dsmoney_s'>依X次扣<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblLate2dshour_s'>依X次扣<br>固定時薪%</a></td>
					<td style="width:90px;"><a id='lblLate2dnmoney_s'>依遲到數扣<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblLate2dnhour_s'>依遲到數扣<br>固定時薪%</a></td>
					
					<td style="width:90px;"><a id='lblLatemin_s'>期別1<br>遲到X分內</a></td>
					<td style="width:90px;"><a id='lblLatenum_s'>超過X次數</a></td>
					<td style="width:90px;"><a id='lblLatedmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblLatedfull_s'>扣全勤<br>固定%</a></td>
					<td style="width:90px;"><a id='lblLate2min_s'>期別2<br>遲到X分內</a></td>
					<td style="width:90px;"><a id='lblLate2num_s'>超過X次數</a></td>
					<td style="width:90px;"><a id='lblLate2dmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblLate2dfull_s'>扣全勤<br>固定%</a></td>
					<td style="width:90px;"><a id='lblLateallmin_s'>按月超過<br>總分數</a></td>
					<td style="width:90px;"><a id='lblLatemalldmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblLatemalldfull_s'>扣全勤<br>固定%</a></td>
					<td style="width:90px;"><a id='lblLateallnum_s'>按月超過<br>總次數</a></td>
					<td style="width:90px;"><a id='lblLatenalldmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblLatenalldfull_s'>扣全勤<br>固定%</a></td>
					<!----------------------------------------------------------------------->
					<td style="width:90px;"><a id='lblEarly_s'>早退X分<br>內不扣薪</a></td>
					<td style="width:100px;"><a id='lblEarlynoallmin_s'>期別中早退X<br>分內不扣薪</a></td>
					<td style="width:100px;"><a id='lblEarlynoallnum_s'>期別中早退X<br>次內不扣薪</a></td>
					<td style="width:100px;"><a id='lblEarly2_s'>每間隔X分鐘<br>計算扣薪</a></td>
					<td style="width:90px;"><a id='lblEarly2dsmoney_s'>依X次扣<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblEarly2dshour_s'>依X次扣<br>固定時薪%</a></td>
					<td style="width:90px;"><a id='lblEarly2dnmoney_s'>依早退數扣<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblEarly2dnhour_s'>依早退數扣<br>固定時薪%</a></td>
					<td style="width:90px;"><a id='lblEarlynum_s'>按月超過<br>總次數</a></td>
					<td style="width:90px;"><a id='lblEarlyndmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblEarlyndfull_s'>扣全勤<br>固定%</a></td>
					<!----------------------------------------------------------------------->
					<td style="width:90px;"><a id='lblVacanodhours_s'>事假X時<br>內不扣薪</a></td>
					<td style="width:90px;"><a id='lblVacadsmoney_s'>事假依時扣<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblVacadshour_s'>事假依時扣<br>固定時薪%</a></td>
					<td style="width:90px;"><a id='lblVacanum_s'>每期別事假<br>超過總次數</a></td>
					<td style="width:90px;"><a id='lblVacandmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblVacandfull_s'>扣全勤<br>固定%</a></td>
					<td style="width:90px;"><a id='lblVacahours_s'>每期別事假<br>超過總時數</a></td>
					<td style="width:90px;"><a id='lblVacahdmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblVacahdfull_s'>扣全勤<br>固定%</a></td>
					<td style="width:90px;"><a id='lblVacadays_s'>每期別事假<br>超過總天數</a></td>
					<td style="width:90px;"><a id='lblVacaddmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblVacaddfull_s'>扣全勤<br>固定%</a></td>
					<!----------------------------------------------------------------------->
					<td style="width:90px;"><a id='lblIsvstotal_s'>事病假全勤<br>總次數合扣</a></td>
					<!----------------------------------------------------------------------->
					<td style="width:90px;"><a id='lblSicknodhours_s'>病假X時<br>內不扣薪</a></td>
					<td style="width:90px;"><a id='lblSickadsmoney_s'>病假依時扣<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblSickdshour_s'>病假依時扣<br>固定時薪%</a></td>
					<td style="width:90px;"><a id='lblSicknum_s'>每期別病假<br>超過總次數</a></td>
					<td style="width:90px;"><a id='lblSickndmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblSickndfull_s'>扣全勤<br>固定%</a></td>
					<td style="width:90px;"><a id='lblSickhours_s'>每期別病假<br>超過總時數</a></td>
					<td style="width:90px;"><a id='lblSickhdmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblSickhdfull_s'>扣全勤<br>固定%</a></td>
					<td style="width:90px;"><a id='lblSickdays_s'>每期別病假<br>超過總天數</a></td>
					<td style="width:90px;"><a id='lblSickddmoney_s'>扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblSickddfull_s'>扣全勤<br>固定%</a></td>
					<!----------------------------------------------------------------------->
					<td style="width:90px;"><a id='lblLeavedsmoney_s'>曠職依時扣<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblLeavedshour_s'>曠職依時扣<br>固定時薪%</a></td>
					<td style="width:90px;"><a id='lblLeavendmoney_s'>曠職扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblLeavendful_s'>曠職扣全勤<br>固定%</a></td>
					<!----------------------------------------------------------------------->
					<td style="width:100px;"><a id='lblFclocknodnum_s'>忘刷期別中<br>X次內不扣薪</a></td>
					<td style="width:90px;"><a id='lblFclockdsmoney_s'>忘刷依次扣<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblFclockdshour_s'>忘刷依次扣<br>固定時薪%</a></td>
					<td style="width:90px;"><a id='lblFclockdnum_s'>每期別忘刷<br>超過總次數</a></td>
					<td style="width:90px;"><a id='lblFclockndmoney_s'>忘刷扣全勤<br>固定金額</a></td>
					<td style="width:90px;"><a id='lblFclockndfull_s'>忘刷扣全勤<br>固定%</a></td>
					<!----------------------------------------------------------------------->
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
					<td>
						<input id="chkWmon.*" type="checkbox" style="float: left;"/>
						<span style="float: left;"> </span>
						<a id='lblWmon_s.*' class="lbl" style="float: left;">一</a>
						<span style="float: left;"> </span>
						<!----------------------------------------->
						<input id="chkWtue.*" type="checkbox" style="float: left;"/>
						<span style="float: left;"> </span>
						<a id='lblWtue_s.*' class="lbl" style="float: left;">二</a>
						<span style="float: left;"> </span>
						<!----------------------------------------->
						<input id="chkWwed.*" type="checkbox" style="float: left;"/>
						<span style="float: left;"> </span>
						<a id='lblWwed_s.*' class="lbl" style="float: left;">三</a>
						<span style="float: left;"> </span>
						<!----------------------------------------->
						<input id="chkWthu.*" type="checkbox" style="float: left;"/>
						<span style="float: left;"> </span>
						<a id='lblWthu_s.*' class="lbl" style="float: left;">四</a>
						<span style="float: left;"> </span>
						<!----------------------------------------->
						<input id="chkWfri.*" type="checkbox" style="float: left;"/>
						<span style="float: left;"> </span>
						<a id='lblWfri_s.*' class="lbl" style="float: left;">五</a>
						<span style="float: left;"> </span>
						<!----------------------------------------->
						<input id="chkWsat.*" type="checkbox" style="float: left;"/>
						<span style="float: left;"> </span>
						<a id='lblWsat_s.*' class="lbl" style="float: left;">六</a>
						<span style="float: left;"> </span>
						<!----------------------------------------->
						<input id="chkWsun.*" type="checkbox" style="float: left;"/>
						<span style="float: left;"> </span>
						<a id='lblWsun_s.*' class="lbl" style="float: left;">日</a>
						<span style="float: left;"> </span>
						<!----------------------------------------->
					</td>
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
					<!--------------------------------------------------------------------------->
					<td><input id="txtMeals.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMbtime1.*" type="text" class="txt c1"/></td>
					<td><input id="txtMhours1.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMbtime2.*" type="text" class="txt c1"/></td>
					<td><input id="txtMhours2.*" type="text" class="txt num c1"/></td>
					<!--------------------------------------------------------------------------->
					<td><input id="txtOvertime.*" type="text" class="txt c1"/></td>
					<td><input id="txtOstand.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDoverhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtOverhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDhoverhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtHoverhours.*" type="text" class="txt num c1"/></td>
					<!------------------------------------------------------------------------>
					<td><input id="chkIsshift.*" type="checkbox"/></td>
					<td><input id="txtShifthours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtWorkday.*" type="text" class="txt num c1"/></td>
					<td><input id="txtRestday.*" type="text" class="txt num c1"/></td>
					<!----------------------------------------------------------------------->
					<td><select id="cmbKind.*" class="txt c1"> </select></td>
					<!----------------------------------------------------------------------->
					<td><input id="txtLate.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatenoallmin.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatenoallnum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2dsmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2dshour.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2dnmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2dnhour.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatemin.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatenum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatedmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatedfull.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2min.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2num.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2dmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLate2dfull.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLateallmin.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatemalldmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatemalldfull.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLateallnum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatenalldmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLatenalldfull.*" type="text" class="txt num c1"/></td>
					<!----------------------------------------------------------------------->
					<td><input id="txtEarly.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarlynoallmin.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarlynoallnum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarly2.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarly2dsmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarly2dshour.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarly2dnmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarly2dnhour.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarlynum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarlyndmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEarlyndfull.*" type="text" class="txt num c1"/></td>
					<!----------------------------------------------------------------------->
					<td><input id="txtVacanodhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacadsmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacadshour.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacanum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacandmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacandfull.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacahours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacahdmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacahdfull.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacadays.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacaddmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtVacaddfull.*" type="text" class="txt num c1"/></td>
					<!----------------------------------------------------------------------->
					<td><input id="chkIsvstotal.*" type="checkbox"/></td>
					<!----------------------------------------------------------------------->
					<td><input id="txtSicknodhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickdsmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickdshour.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSicknum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickndmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickndfull.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickhours.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickhdmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickhdfull.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickdays.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickddmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtSickddfull.*" type="text" class="txt num c1"/></td>
					<!----------------------------------------------------------------------->
					<td><input id="txtLeavedsmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLeavedshour.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLeavendmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtLeavendfull.*" type="text" class="txt num c1"/></td>
					<!----------------------------------------------------------------------->
					<td><input id="txtFclocknodnum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtFclockdsmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtFclockdshour.*" type="text" class="txt num c1"/></td>
					<td><input id="txtFclockdnum.*" type="text" class="txt num c1"/></td>
					<td><input id="txtFclockndmoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtFclockndfull.*" type="text" class="txt num c1"/></td>
					<!----------------------------------------------------------------------->
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
