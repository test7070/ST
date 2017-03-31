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
        	q_tables = 's';
            var q_name = "eipflow";
            var q_readonly = ['txtNoa','txtStatus','txtWorker','txtWorker2','txtFilename'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 8;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root	
            aPop = new Array(['txtSno_', 'btnSno_', 'sss', 'noa,namea', '0txtSno_,txtNamea_', 'sss_b.aspx']);
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
                mainForm(1);
                // 1=Last  0=Top
            }
			
            function mainPost() {
            	bbmMask = [];
                q_mask(bbmMask);
                q_cmbParse("cmbAct",q_getPara('eip.act'),'s');
                q_gt('eipform', '', 0, 0, 0, "");
                q_gt('eipbase', '', 0, 0, 0, "");
                
                $('#combEpibaseno').change(function(e) {
                    if ($(this).val().length > 0) {
                        t_where = "where=^^ noa='" + $(this).val() + "'^^";
                        q_gt('eipbase', t_where, 0, 0, 0, "geteipbase", r_accy);
                    }
                });
                
                $('#btnFiles').change(function() {
                	if(q_cur==1 || q_cur==2){}else{return;}
                	file = $(this)[0].files[0];
					if(file){
						Lock(1);
						var ext = '';
						var extindex = file.name.lastIndexOf('.');
						if(extindex>=0){
							ext = file.name.substring(extindex,file.name.length);
						}
						$('#txtFilename').val(file.name);
						$('#txtFiles').val(file.name+'_'+Date.now().toString()+ext);
						
						fr = new FileReader();
						fr.fileName = $('#txtFiles').val();
					    fr.readAsDataURL(file);
					    fr.onprogress = function(e){
							if ( e.lengthComputable ) { 
								var per = Math.round( (e.loaded * 100) / e.total) ; 
								$('#FileList').children().last().find('progress').eq(0).attr('value',per);
							}; 
						}
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						}
						fr.onloadend = function(e){
							$('#FileList').children().last().find('progress').eq(0).attr('value',100);
							console.log(fr.fileName+':'+fr.result.length);
							var oReq = new XMLHttpRequest();
							oReq.upload.addEventListener("progress",function(e) {
								if (e.lengthComputable) {
									percentComplete = Math.round((e.loaded / e.total) * 100,0);
									$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
								}
							}, false);
							oReq.upload.addEventListener("load",function(e) {
								Unlock(1);
							}, false);
							oReq.upload.addEventListener("error",function(e) {
								alert("資料上傳發生錯誤!");
							}, false);
								
							oReq.timeout = 360000;
							oReq.ontimeout = function () { alert("Timed out!!!"); }
							oReq.open("POST", 'eipflow_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);//oReq.send(e.target.result);
						};
					}
					ShowDownlbl();
				});
            }
            
            var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + s4() + s4();};
			})();
			
			function ShowDownlbl() {				
				$('#lblDownload').hide();
				
				if(!emp($('#txtFiles').val()))
					$('#lblDownload').show();
										
				$('#lblDownload').click(function(e) {
					if(txtfiles.length>0)
						$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#txtFilename').val()+'&TempName='+$('#txtFiles').val());
					else
						alert('無資料...!!');
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
                	case 'eipform':
                		var as = _q_appendData("eipform", "", true);
                        if (as[0] != undefined) {
                            var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].formname;
		                    }
		                    q_cmbParse("cmbEpifomno", t_item);
		                    if(abbm[q_recno])
		                    	$('#cmbEpifomno').val(abbm[q_recno].epifomno);
                        }
                		break;
                	case 'eipbase':
                		var as = _q_appendData("eipbase", "", true);
                        if (as[0] != undefined) {
                            var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
		                    }
		                    q_cmbParse("combEpibaseno", t_item);
                        }
                		break;
                	case 'geteipbase':
                		var as = _q_appendData("eipbase", "", true);
                        if (as[0] != undefined) {
                        	$('#cmbEpifomno').val(as[0].epifomno);
                        	var ass = _q_appendData("eipbases", "", true);
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea,cmbAct', ass.length, ass, 'sno,namea,act', 'txtSno,txtNamea');
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
                q_box('eipflow_s.aspx', q_name + '_s', "500px", "320px", q_getMsg("popSeek"));
            }
            
             function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            $('#lblNo_' + i).text(i + 1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		            	
		            }
		        }
		        _bbsAssign();
		        ShowDownlbl();
		    }
		    
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#combEpibaseno').focus();
                refreshBbm();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtMemo').focus();
                refreshBbm();
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
                Lock();
                $('#txtNoa').val($.trim($('#txtNoa').val()));
            	var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtNamea', q_getMsg('lblNamea')]]);
                
                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock();
                    return;
                }
                
                if(q_cur==1){
					$('#txtWorker').val(r_name);
				}else{
					$('#txtWorker2').val(r_name);
				}
				
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
				else
					wrServer(s1);
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
		        if (!as['sno'] && !as['namea']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        
		        
		        return true;
		    }

            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
                for (var i = 0; i < brwCount; i++) {
                	if($('#vtissign_'+i).text()=="true")
                		$('#vtissign_'+i).text("V");
                	if($('#vtissign_'+i).text()=="false")
                		$('#vtissign_'+i).text("");
                }
                ShowDownlbl();
            }
            
            function refreshBbm() {
                if (q_cur == 1 || q_cur == 2) {
                    $('#combEpibaseno').removeAttr('disabled');
                	$('#combEpibaseno').css('background-color', 'rgb(255, 255, 255)');
                } else {
                    $('#combEpibaseno').attr('disabled','disabled');
                	$('#combEpibaseno').css('background-color', 'rgb(237, 237, 238)');
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
                width: 1260px;
            }
            .dview {
                float: left;
                width: 300px;
            }
            .tview {
            	width:100%;
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
                width: 600px;
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
                width: 99%;
                float: left;
            }
            .txt.c2 {
                width: 15%;
                float: left;
            }
            .txt.c3 {
                width: 85%;
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
			.dbbs {
				float: left;
                width: 900px;
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
			.dbbs tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                cursor: pointer;
            }
			
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            
            select{
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
						<td align="center" style="width:3%"><a id='vewChk'> </a></td>
						<td align="center" style="width:40%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:17%"><a id='vewIssign'> </a></td>
						<td align="center" style="width:30%"><a id='vewStatus'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='issign'>~issign</td>
						<td align="center" id="status">~status</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 120px"> </td>
						<td style="width: 125px"> </td>
						<td style="width: 120px"> </td>
						<td style="width: 125px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIssign' class="lbl"> </a></td>
						<td><input id="chkIssign"  type="checkbox" /></td>
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td><input id="txtStatus"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEpibaseno' class="lbl"> </a></td>
						<td><select id="combEpibaseno" class="txt c1"> </select></td>
						<td><span> </span><a id='lblEpifomno' class="lbl"> </a></td>
						<td><select id="cmbEpifomno" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFiles' class="lbl"> </a></td>
						<td style="text-align: left;" colspan="3">
							<span style="float: left;"> </span>
							<input type="file" id="btnFiles" class="btnFiles" value="選擇檔案"/>
							<input id="txtFiles" type="hidden"/>
							<a id="lblDownload" class='lbl btn' style="display: none;"> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFilesname' class="lbl"> </a></td>
						<td colspan="3"><input id="txtFilename"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:50px;"><a id='lblNo_s'> </a></td>
						<td style="width:330px;"><a id='lblSno_s'> </a></td>
						<td style="width:400px;"><a id='lblNamea_s'> </a></td>
						<td style="width:100px;"><a id='lblAct_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input type="button" id="btnMinus.*" style="font-size: medium; font-weight: bold;" value="－"/>
							<input type="text" id="txtNoq.*" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input type="text" id="txtSno.*" class="txt c1" style="width: 80%;"/>
							<input type="button" id="btnSno.*" style="font-size: medium; font-weight: bold;" value="."/>
						</td>
						<td><input type="text" id="txtNamea.*" class="txt c1" /></td>
						<td><select id="cmbAct.*" class="txt c1"> </select></td>
					</tr>
				</table>
			</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
		<input id="q_sys" type="hidden" />
	</body>
</html>
