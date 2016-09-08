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

        q_tables = 's';
        var q_name="crmcampaign";
        var q_readonly = ['txtWorker', 'txtWorker2'];
        var q_readonlys = [];
        var bbmNum = [['txtTotal',10,0,1]];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_desc = 1; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
       brwCount2 = 10;
        //ajaxPath = ""; //  execute in Root
        
        aPop = new Array(['txtListnoa_', 'btnListnoa_', 'crmlist', 'noa,namea', 'txtListnoa_,txtListname_', 'crmlist_b.aspx']);
		
        $(document).ready(function () {

            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            $('#txtNoa').focus
        });


        //////////////////   end Ready
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }
            mainForm(1); // 1=Last  0=Top
        }  ///  end Main()


        function mainPost() { 
           q_getFormat();
           bbmMask = [['txtAdbdate', r_picd], ['txtAdedate', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
           q_mask(bbmMask);
           q_cmbParse("cmbTypea", ",廣告,直效行銷,活動,品牌聯盟,其他");
           q_cmbParse("cmbStatus", ",已提案,準備啟動,已啟動,已完成,已取消,擱置");
           $('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
                    		q_gt('crmcampaign', t_where, 0, 0, 0, "checkCrmcampaignno_change", r_accy);
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
                });
        }

        function q_boxClose( s2) { 
            var ret; 
            switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'checkCrmcampaignno_change':
                		var as = _q_appendData("crmcampaign", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].namea);
                        }
                		break;
                case 'checkCrmcampaignno_btnOk':
                		var as = _q_appendData("crmcampaign", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].namea);
                            Unlock();
                            return;
                        }else{
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
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('crmcampaign_s.aspx', q_name + '_s', "500px", "380px", q_getMsg( "popSeek"));
        }

        function btnIns() {
            _btnIns();
            refreshBbm();
            $('#txtNoa').focus();
            $('#txtAdbdate').val(q_date());
            $('#txtAdedate').val(q_date());
            $('#txtBdate').val(q_date());
            $('#txtEdate').val(q_date());

            $('#txtBdate').focus();
            $('#txtEdate').focus();
            $('#txtAdbdate').focus();
            $('#txtAdedate').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            refreshBbm();
            $('#txtNamea').focus();
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
            	if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
				}else{
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
					Unlock();
					return;
				}
				if(q_cur==1){
				    $('#txtWorker').val(r_name);
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('crmcampaign', t_where, 0, 0, 0, "checkCrmcampaignno_btnOk", r_accy);

                }else{
                    $('#txtWorker2').val(r_name);
                	wrServer($('#txtNoa').val());

                }
            }

        function bbsAssign() {
                _bbsAssign();
        }
        function bbsSave(as) {
                t_err = '';
                if (!as['listnoa'] && !as['listname']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
         }
        function wrServer( key_value) {
            var i;
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
             _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }
        function refresh(recno) {
            _refresh(recno);
			refreshBbm();
        }
        function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
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

        function btnSeek(){
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
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 5px solid gray;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview tr {
                height: 25px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 620px;
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
                width: 90%;
                float: left;
            }
            .txt.c2 {
                width: 70%;
                float: right;
            }
            .txt.c3 {
                width: 50%;
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
            .dbbs {
                width: 100%;
            }
            .tbbs a {
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
        <div class="dview" id="dview" style="float: left;  width:30%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewNamea'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='namea'>~namea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm'>
        <table class="tbbm"  id="tbbm">
            <tr>
               <td><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td><input id="txtNoa"  type="text" class="txt c1" /></td>
               <td><span> </span><a id='lblStatus' class="lbl"> </a></td>
               <td><select id="cmbStatus" class="txt c1"> </select></td>
            </tr>
            <tr>
               <td><span> </span><a id='lblTypea' class="lbl"> </a></td>
               <td><select id="cmbTypea" class="txt c1"> </select></td>
               <td><span> </span><a id='lblTotal' class="lbl"></a></td>
               <td><input id="txtTotal"  type="text" class="txt num c1" /></td>
            </tr>
            <tr>
			   <td><span> </span><a id='lblNamea' class="lbl"></a></td>
               <td colspan="2"><input id="txtNamea"  type="text" class="txt c7"  /></td>
            </tr>
            <tr>
			   <td><span> </span><a id='lblAdbdate' class="lbl"></a></td>
               <td><input id="txtAdbdate"  type="text" class="txt c1"  /></td>
               <td><span> </span><a id='lblAdedate' class="lbl"></a></td>
               <td><input id="txtAdedate"  type="text" class="txt c1"  /></td>
            </tr>
            <tr>
			   <td><span> </span><a id='lblBdate' class="lbl"></a></td>
               <td><input id="txtBdate"  type="text" class="txt c1"  /></td>
               <td><span> </span><a id='lblEdate' class="lbl"></a></td>
               <td><input id="txtEdate"  type="text" class="txt c1"  /></td>
            </tr>
            <tr>
				<td><span> </span><a id='lblEcontent' class="lbl"> </a></td>
				<td colspan="3"><textarea id='txtEcontent' cols="10" rows="5" style="width:95%;height: 50px;"> </textarea></td>
			</tr>
            <tr>
				<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
				<td  colspan="3"><input id="txtMemo"  type="text" class="txt c7"  /></td>
			</tr>
            <tr>
				<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
				<td><input id="txtWorker"  type="text" class="txt c1" /></td>
				<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
				<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
			</tr>

        </table>
        </div>
        </div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:6px;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:10px;"><a id='lblListnoa_s'> </a></td>
					<td align="center" style="width:10px;"><a id='lblListname_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
				
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td align="center" style="width:200px;">
						<input class="txt c6" id="txtListnoa.*" maxlength='30'type="text" style="width:80%;" />
						<input class="btn" id="btnListnoa.*" type="button" value='...' style=" font-weight: bold;" />
					</td>
					<td  style="width:250px;"><input class="txt c7" id="txtListname.*" type="text" /></td>
				</tr>
			</table>
		</div>
        <input id="q_sys" type="hidden" />    
</body>
</html>
            