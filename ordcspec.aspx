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

            var q_name = "ordcspec";
            var q_readonly = ['txtNoa'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 15;
            aPop = new Array();

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }  
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'checkClass':
                        var as = _q_appendData("class", "", true);
                        if (as[0] != undefined){
                            alert('已存在 '+as[0].noa+' '+as[0].class);
                            Unlock(1);
                            return;
                        }else{
                            wrServer($('#txtNoa').val());
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                } 
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('class_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtClass').focus();
            }

            function btnPrint() {
                q_box('z_class.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {    
                Lock(1,{opacity:0}); 
                $('#txtNoa').val($.trim($('#txtNoa').val()));       
                
                if(q_cur==1){
                    t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('class', t_where, 0, 0, 0, "checkClass", r_accy);
                }else{
                    wrServer($('#txtNoa').val());
                }
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
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
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
            function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
                    if(regex.test(str))
                        return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                    str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
                    if(regex.test(str))
                        return 4
                }
                return 0;//錯誤
            }
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 250px; 
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
                width: 700px;
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
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewNoa"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewMon"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewTgg"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewProductno"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewProduct"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewPrice"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewClass"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewSpec"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewTypea"> </a></td>
                    </tr>
                    <tr>
                        <td ><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="noa" style="text-align: center;">~noa</td>
                        <td id="mon" style="text-align: center;">~mon</td>
                        <td id="tgg" style="text-align: center;">~tgg</td>
                        <td id="productno" style="text-align: center;">~productno</td>
                        <td id="product" style="text-align: center;">~product</td>
                        <td id="price" style="text-align: center;">~price</td>
                        <td id="class" style="text-align: center;">~class</td>
                        <td id="spec" style="text-align: center;">~spec</td>
                        <td id="typea" style="text-align: center;">~typea</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td><input id="txtNoa"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMon" class="lbl"> </a></td>
                        <td><input id="txtMon"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblTgg" class="lbl"> </a></td>
                        <td><input id="txtTgg"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblProductno" class="lbl"> </a></td>
                        <td><input id="txtProductno"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblProduct" class="lbl"> </a></td>
                        <td><input id="txtProduct"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblPrice" class="lbl"> </a></td>
                        <td><input id="txtPrice"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblClass" class="lbl"> </a></td>
                        <td><input id="txtClass"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblSpec" class="lbl"> </a></td>
                        <td><input id="txtSpec"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lbltypea" class="lbl"> </a></td>
                        <td><input id="txtTypea"  type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
