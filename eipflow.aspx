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
            var q_readonly = ['txtNoa','txtStatus','txtWorker','txtWorker2','txtFilename','txtSssno','txtNamea','txtDatea','txtBdate'];
            var q_readonlys = ['txtAct2'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 10;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root	
            aPop = new Array(['txtSno_', '', 'sss', 'noa,namea', '0txtSno_,txtNamea_', 'sss_b.aspx']);
			q_copy=1;
			
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                
                if (r_rank < 8){
                	if(q_content.length>0){
						q_content = "where=^^sssno='" + r_userno + "' and "+replaceAll(q_content,'where=^^','');
					}
                }
				
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
                
                q_cmbParse("cmbImportant",'普通,重要,很重要');
                q_cmbParse("cmbAct",q_getPara('eip.act'),'s');
                
                q_gt('eipform', '', 0, 0, 0, "");
                q_gt('eipbase', '', 0, 0, 0, "");
                
                $('#combEpibaseno').change(function(e) {
					if(q_cur==1 || q_cur==2){
						if ($(this).val().length > 0) {
							t_where = "where=^^ noa='" + $(this).val() + "'^^";
							q_gt('eipbase', t_where, 0, 0, 0, "geteipbase", r_accy);
						}
					}
                });
                
                $('#btnFormwrite').click(function() {
                	if($('#cmbEpifomno').val()!=''){
                		var t_tablea='eip'+$('#cmbEpifomno').find("option:selected").text();
                		var t_noa=$('#txtNoa').val();
                		t_where = "noa='" + t_noa + "'";
						q_box(t_tablea+".aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'eip', "95%", "95%", "");
					}
				});
				
				$('#cmbEpifomno').change(function() {
					var t_tablea='eip'+$('#cmbEpifomno').find("option:selected").text();
					$('#combOrdeno').text('');
					if(t_tablea.length>0){
						//抓取選擇的eiptable
						t_where = "where=^^ noa not in (select ordeno from eipflow where epifomno='"+$('#cmbEpifomno').find("option:selected").text()+"' and noa!='"+$('#txtNoa').val()+"')^^";
						q_gt(t_tablea, t_where, 0, 0, 0, "get"+t_tablea, r_accy,1);
						var as = _q_appendData(t_tablea, "", true);
						var t_item = "@";
						for (i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa;
						}
						q_cmbParse("combOrdeno", t_item);
					}
				});
				
				$('#combOrdeno').change(function() {
					if(q_cur==1 || q_cur==2){
						$('#txtOrdeno').val($('#combOrdeno').val())
					}
					$('#combOrdeno')[0].selectedIndex=0;
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
					if($('#txtFilename').val().length>0 && $('#txtFiles').val().length>0)
						$('#xdownload').attr('src','eipflow_download.aspx?FileName='+$('#txtFilename').val()+'&TempName='+$('#txtFiles').val());
					else
						alert('無資料...!!');
				});
			}
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'eip':
                		var t_tablea='eip'+$('#cmbEpifomno').find("option:selected").text();
						$('#combOrdeno').text('');
						if(t_tablea.length>0){
							//抓取選擇的eiptable
							t_where = "where=^^ noa not in (select ordeno from eipflow where epifomno='"+$('#cmbEpifomno').find("option:selected").text()+"' and noa!='"+$('#txtNoa').val()+"')^^";
							q_gt(t_tablea, t_where, 0, 0, 0, "get"+t_tablea, r_accy,1);
							var as = _q_appendData(t_tablea, "", true);
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa;
							}
							q_cmbParse("combOrdeno", t_item);
						}
                		break;
                	case 'sssall':
                		b_ret = getb_ret();
                        ///  q_box() 執行後，選取的資料
                        if (!b_ret || b_ret.length == 0){
                        	b_pop='';
                        	return;	
                        }
                        //q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea', b_ret.length, b_ret, 'noa,namea', 'txtSno,txtNamea');
                        
                        var n=box_n;
                        box_n='';
                        var t_sssno = '', t_namea='';
						for (var i = 0; i < b_ret.length; i++) {
							t_sssno=t_sssno+(t_sssno.length>0?';':'')+b_ret[i].noa;
							t_namea=t_namea+(t_namea.length>0?';':'')+b_ret[i].namea;
							
						}
						$('#txtSno_' + n).val(t_sssno);
						$('#txtNamea_' + n).val(t_namea);
                		break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop='';
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
            
            var box_n='';
            function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#btnSno_' + i).click(function() {
                        	t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							box_n=b_seq;
                            q_box("sssall_check_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;", 'sssall', "50%", "650px", q_getMsg('popSssallcheck'));
                        });
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
                $('#txtSssno').val(r_userno);
                $('#txtNamea').val(r_name);
                $('#txtDatea').val(q_date());
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
                
                /*var t_bbsStatus=-1,t_bbstoflow=-1;
                for (var i = 0; i < q_bbsCount; i++) {
                	if($('#chkEnda_'+i).prop('checked')){
                		t_bbsStatus=i;
                	}
                	if(!emp($('#txtSno_'+i).val())){
                		t_bbstoflow=i;
                	}
                	
				}
				if(t_bbsStatus>-1 && q_cur!=1 && $('#chkIssign').prop('checked')){
					if(t_bbsStatus==t_bbstoflow){
						if(!confirm("簽核已到結束，確定後將會再重送簽核，是否繼續?")){
							Unlock();
	                    	return;
						}
					}else{
						if(!confirm("簽核已到第"+(t_bbsStatus+1)+"層，確定後將會重送簽核，是否繼續?")){
							Unlock();
	                    	return;
						}
					}
				}*/
                
                if(q_cur==1){
					$('#txtWorker').val(r_name);
				}else{
					$('#txtWorker2').val(r_name);
				}
				
				/*
				for (var i = 0; i < q_bbsCount; i++) {
					$('#txtStatus_'+i).val('');
					$('#txtMemo_'+i).val('');
					$('#chkEnda_'+i).prop('checked',false);
				}
				$('#txtStatus').val('');
				$('#chkEnda').prop('checked',false);
				$('#txtEdate').val('');
				if($('#chkIssign').prop('checked'))
					$('#txtBdate').val(q_date());
				$('#chkIsbreak').prop('checked',false);
				$('#chkIshide').prop('checked',false);
				*/
				
				if($('#chkIssign').prop('checked') && emp($('#txtBdate').val())){
					$('#txtBdate').val(q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2));
					$('#txtStatus').val('送出簽核');
				}
				if(!$('#chkIssign').prop('checked'))
					$('#txtBdate').val('');
				
				
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
                if(t_para){
                	$('#btnFiles').attr('disabled','disabled');
                	$('#btnViewdoc').removeAttr('disabled');
                }else{
                	$('#btnFiles').removeAttr('disabled');
                	$('#btnViewdoc').attr('disabled','disabled');
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
                width: 1260px;
            }
            .dview {
                float: left;
                width: 500px;
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
                width: 610px;
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
                width: 750px;
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
			<div class="dview" id="dview" style="float: left; " >
				<table class="tview" id="tview"  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:3%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:10%"><a id='vewIssign'> </a></td>
						<td align="center" style="width:55%"><a id='vewStatus'> </a></td>
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
				<table class="tbbm" id="tbbm"  border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 130px"> </td>
						<td style="width: 170px"> </td>
						<td style="width: 130px"> </td>
						<td style="width: 170px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIssign' class="lbl"> </a></td>
						<td><input id="chkIssign" type="checkbox" /></td>
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td><input id="txtStatus" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImportant' class="lbl"> </a></td>
						<td><select id="cmbImportant" class="txt c1"> </select></td>
						<td><span> </span><a id='lblEpifomno' class="lbl"> </a></td>
						<td><select id="cmbEpifomno" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
						<td>
							<input id="txtOrdeno" type="text" class="txt c1" style="width: 145px;"/>
							<select id="combOrdeno" class="txt c1" style="width: 20px;"> </select>
						</td>
						<td> </td>
						<td><input id="btnFormwrite" type="button"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFiles' class="lbl"> </a></td>
						<td style="text-align: left;" colspan="2">
							<span style="float: left;"> </span>
							<input type="file" id="btnFiles" class="btnFiles" value="選擇檔案"/>
							<input id="txtFiles" type="hidden"/>
							<a id="lblDownload" class='lbl btn' style="display: none;"> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFilesname' class="lbl"> </a></td>
						<td colspan="3"><input id="txtFilename" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSssno' class="lbl"> </a></td>
						<td><input id="txtSssno" type="text" class="txt c1" style="width: 48%;"/>
							<input id="txtNamea" type="text" class="txt c1" style="width: 48%;"/>
							<input id="txtWorker" type="hidden" class="txt c1"/>
							<input id="chkEnda" type="checkbox" style="display: none;" />
							<input id="txtEdate" type="hidden" class="txt c1"/>
							<input id="chkIsbreak" type="checkbox" style="display: none;" />
							<input id="chkIshide" type="checkbox" style="display: none;" />
						</td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td><input id="txtBdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblEpibaseno' class="lbl"> </a></td>
						<td><select id="combEpibaseno" class="txt c1"> </select></td>
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
						<td style="width:100px;"><a id='lblAct2_s'> </a></td>
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
						<td>
							<select id="cmbAct.*" class="txt c1"> </select>
							<input type="hidden" id="txtStatus.*"/>
							<input type="hidden" id="txtMemo.*"/>
							<input type="checkbox" id="chkEnda.*" style="display: none;" />
						</td>
						<td><input type="text" id="txtAct2.*" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
		<input id="q_sys" type="hidden" />
	</body>
</html>
