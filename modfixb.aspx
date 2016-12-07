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
		    this.errorHandler = null;
		    function onPageError(error) {
		        alert("An error occurred:\r\n" + error.Message);
		    }

		    q_tables = 's';
		    var q_name = "modfixb";
		    var q_readonly = ['txtNoa','txtDevice','txtPart'];
		    var q_readonlys = ['txtProduct','txtTgg'];
		    var bbmNum = [];
		    var bbsNum = [['txtPrice', 10, 1], ['txtMount', 10, 1], ['txtMoney', 10, 0]];
		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'noa';
		    brwCount2 = 8;
		    
		    aPop = new Array(	['txtDeviceno', 'lblDeviceno', 'modeq', 'noa,device', 'txtDeviceno,txtDevice', 'modeq_b.aspx'],
		    					['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
		    					['txtProductno_', 'btnProductno_', 'bcc', 'noa,product,price', 'txtProductno_,txtProduct_,txtPrice_', 'bcc_b.aspx'],
		    					['txtTggno_', 'btnTggno_', 'tgg', 'noa,nick', 'txtTggno_,txtTgg_', 'tgg_b.aspx']);
			
		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();
		        q_gt(q_name, q_content, q_sqlCount, 1);
		    });//   end Ready
		    
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(1);

		    }//  end Main()

		    function pop(form) {
		        
		    }

		    
            function mainPost() {
            	q_getFormat();
				bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd],['txtBtime','99:99'],['txtEdate', r_picd],['txtEtime','99:99'],['txtBadddate', r_picd],['txtBaddtime','99:99'],['txtEadddate', r_picd],['txtEaddtime','99:99']];
				q_mask(bbmMask);
				
				q_cmbParse("cmbWay", '委外,自修');
								
            }

		    function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                    break;                  
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
		    
			function q_stPost() {
               
            }
            
		    function bbsAssign() {
		       for (var i = 0; i < q_bbsCount; i++) {		       	
		        	$('#lblNo_'+i).text(i+1);

		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {		              		           
		                $('#txtMount_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtPrice_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtMoney_' + i).change(function (e) {
		                    sum();
		                });             
		            }//end if
		            
		        }//end for-loop
		        
		        _bbsAssign();
		    }
		    
		    function sum() {
		    	for (var j = 0; j < q_bbsCount; j++) {
					q_tr('txtMoney_' + j, q_mul(q_float('txtMount_' + j), q_float('txtPrice_' + j)));
				}
		    }
		    
			function bbsSave(as) {
		        if (!as['productno'] && !as['product']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        as['date'] = abbm2['date'];
		        return true;
		    }		    

		    function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
               	$('#txtDatea').val(q_date());              		    
			}
			
		    function btnModi() {
		        _btnModi();
		    }

		    function btnPrint() {
				q_box('z_modfixb_rs.aspx' + "?;;;noa='" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
		    }
		    
			function btnOk() {
				t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')],['txtDeviceno', q_getMsg('lblDeviceno')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
              	var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_modfixb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);  
            }
            
		    function wrServer(key_value) {
            	var i;
		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            
			function readonly(t_para, empty) {
		        _readonly(t_para, empty);	       
		    }
		    
		    function refresh(recno) {
		        _refresh(recno);
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
		    
			function _btnSeek() {
            	if (q_cur > 0 && q_cur < 4)
					return;
				q_box('modfixb_s.aspx', q_name + '_s', "500px", "320px", q_getMsg("popSeek"));
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
                width: 20%; 
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
                width: 850px;                
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
                height: 37px;
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
						<td align="center" style="width:15%; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:15%; color:black;"><a id='vewNoa'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='noa' style="text-align: center;">~noa</td>
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
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>											
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPart" class="lbl btn"> </a></td>
						<td>
							<input id="txtPartno"  type="text" style="width:40%;"/>
							<input id="txtPart"  type="text" style="width:60%;"/>
						</td>											
						<td><span> </span><a id='lblPaperno' class="lbl"> </a></td>
						<td><input id="txtPaperno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDeviceno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtDeviceno"  type="text" style="width:25%;"/>
							<input id="txtDevice"  type="text" style="width:75%;"/>
						</td>											
					</tr>
					<tr>
						<td><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
						<td><input id="txtOrdeno" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDescription' class="lbl"> </a></td>
						<td colspan="3"><input id="txtDescription" type="text" class="txt c1" /></td>		
					</tr>
					<tr>
						<td><span> </span><a id='lblWay' class="lbl"> </a></td>
						<td><select id="cmbWay"  class="txt c1"> </select></td>
						<td><span> </span><a id='lblContents' class="lbl"> </a></td>
						<td colspan="3"><input id="txtContents" type="text" class="txt c1" /></td>	
					</tr>
					<tr>
						<td><span> </span><a id='lblBtime' class="lbl"> </a></td>
						<td colspan="1">
							<input id="txtBdate"  type="text" style="width:60%;"/>
							<input id="txtBtime"  type="text" style="width:40%;"/>
						</td>	
						<td><span> </span><a id='lblEtime' class="lbl"> </a></td>
						<td colspan="1">
							<input id="txtEdate"  type="text" style="width:60%;"/>
							<input id="txtEtime"  type="text" style="width:40%;"/>
						</td>	
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBaddtime' class="lbl"> </a></td>
						<td colspan="1">
							<input id="txtBadddate"  type="text" style="width:60%;"/>
							<input id="txtBaddtime"  type="text" style="width:40%;"/>
						</td>	
						<td><span> </span><a id='lblEaddtime' class="lbl"> </a></td>
						<td colspan="1">
							<input id="txtEadddate"  type="text" style="width:60%;"/>
							<input id="txtEaddtime"  type="text" style="width:40%;"/>
						</td>	
						<td><span> </span><a id='lblAddworker' class="lbl"> </a></td>
						<td><input id="txtAddworker" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblQworker1" class="lbl"> </a></td>
						<td><input id="txtQworker1" type="text" class="txt c1"/></td>											
						<td><span> </span><a id="lblQworker2" class="lbl"> </a></td>
						<td><input id="txtQworker2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblQworker3" class="lbl"> </a></td>
						<td><input id="txtQworker3" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1200px;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:40px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:30px;"> </td>
					<td align="center" style="width:150px;"><a id='lblMechset_s'> </a></td>
					<td align="center" style="width:325px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:325px;"><a id='lblTggno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>					
					<td align="center" style="width:110px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblRetired_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input id="btnMinus.*" type="button" class="btn" value='-' style=" font-weight: bold;" />			
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtMechset.*" type="text" class="txt" style="width:98%;"/></td>
					<td>
						<input id="txtNoq.*" type="hidden" />			
						<input id="txtProductno.*" type="text" class="txt" style="width:25%;"/>
						<input id="txtProduct.*" type="text"  class="txt" style="width:55%;"/>
						<input id="btnProductno.*" type="button" value="..." style="width: 10%;" />
					</td>
					<td>
						<input id="txtTggno.*" type="text" class="txt" style="width:25%;"/>
						<input id="txtTgg.*"type="text" class="txt" style="width:55%;"/>
						<input id="btnTggno.*" type="button" value="..." style="width: 10%;" />
					</td>
					<td><input id="txtPrice.*" type="text" class="txt num c1" /></td>
					<td><input id="txtMount.*" type="text" class="txt num c1" /></td>
					<td><input id="txtMoney.*" type="text" class="txt num c1" /></td>	
					<td align="center"><input id="chkRetired.*" type="checkbox"/></td>				
				</tr>
				
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
