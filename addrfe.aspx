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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
            q_tables = 's';
            var q_name = "addr";
            var q_readonly = ['txtNoa'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtCustprice', 10, 3], ['txtTggprice', 10, 3], ['txtDriverprice', 10, 3], ['txtDriverprice2', 10, 3],['txtCommission',10,3]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';

            aPop = new Array(['txtStraddrno', 'lblStraddr', 'straddr_rj', 'noa', 'txtStraddrno', 'straddr_rj_b.aspx'],
                             ['txtEndaddrno', 'lblEndaddr', 'endaddr_rj', 'noa', 'txtEndaddrno', 'endaddr_rj_b.aspx'],
                             ['txtProductno', 'lblProductno', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],
                             ['txtSalesno_', '', 'sss', 'noa,namea', 'txtSalesno_,txtSales_', 'sss_b.aspx'],
                             ['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick', 'txtCustno,txtCust', 'cust_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_getFormat();
                q_mask(bbmMask);
                bbsMask = [['txtDatea', r_picd]];
 
                 //上方插入空白行
                $('#lblTop_row').mousedown(function(e) {
                    if(e.button==0){
                        mouse_div=false;
                        q_bbs_addrow(row_bbsbbt,row_b_seq,0);
                    }
                 });
                //下方插入空白行
                $('#lblDown_row').mousedown(function(e) {
                    if(e.button==0){
                        mouse_div=false;
                        q_bbs_addrow(row_bbsbbt,row_b_seq,1);
                    }
                });
                $('#lblTop_row').hover(function(e){
                    $(this).css('background','orange');
                },function(e){
                    $(this).css('background','white');
                });
                $('#lblDown_row').hover(function(e){
                    $(this).css('background','orange');
                },function(e){
                    $(this).css('background','white');
                });
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'z_addr':
                        var as = _q_appendData("authority", "", true);
                        if(as[0] != undefined && (as[0].pr_run=="1" || as[0].pr_run=="true")){
                            q_box("z_addr.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy,'z_addr', "95%", "95%", q_getMsg("popPrint"));
                            return;
                        }
                        q_box("z_addr2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy,'z_addr2', "95%", "95%", q_getMsg("popPrint"));
                        break;
                    case 'getNoa':
                        var as = _q_appendData("addr", "", true);
                        if (as[0] != undefined){      
                            var num = as[0].noa.substring(1,4);
                            var string = "0123476789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                            var n = string.indexOf(num.substring(0,1));
                            var value = n*100+parseInt(num.substring(1,3))+1;
                            n = string.substring(Math.floor(value/100),Math.floor(value/100)+1);
                            var m = (value%100<10?'0':'')+(value%100);
                            //alert((value%100)+'\n'+n+'\n'+m);
                            $('#txtNoa').val('A'+n+m);
                            wrServer('A'+n+m);
                        }else{
                            $('#txtNoa').val('A001');
                            wrServer('A001');
                        }    
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        try{
                            t_array = JSON.parse(t_name);
                            switch(t_array.type){
                                case 'isDuplicate':
                                    var as = _q_appendData("addr", "", true);
                                    if (as[0] != undefined){
                                        alert('【'+t_array.straddrno+'】【'+t_array.endaddrno+'】【'+t_array.productno+'】已存在。');
                                        Unlock(1);
                                        return;
                                    }else{
                                       // q_gtnoa(q_name,'A');
                                        /*q_gt('addr', "where=^^ noa='"+t_array.noa+"' ^^", 0, 0, 0, JSON.stringify({
                                            type : 'checkNoa',
                                            noa : t_array.noa,
                                            straddrno : t_array.straddrno,
                                            endaddrno : t_array.endaddrno,
                                            productno : t_array.productno
                                        }), r_accy);*/
                                       
                                       q_gt('addr', "order=^^noa desc^^", 1, 0, 0, 'getNoa', r_accy);
                                    }
                                    break;
                                case 'checkNoa':
                                    var as = _q_appendData("addr", "", true);
                                    if (as[0] != undefined){
                                        alert('已存在 '+as[0].noa+' '+as[0].addr);
                                        Unlock(1);
                                        return;
                                    }else{
                                        wrServer($('#txtNoa').val());
                                    }
                                    break;
                            }
                        }catch(e){
                            //alert(e.message);
                        }
                        break;
                    }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
                Lock(1,{opacity:0});
                var t_noa = $.trim($('#txtNoa').val());
                var t_straddrno = $.trim($('#txtStraddrno').val());
                var t_endaddrno = $.trim($('#txtEndaddrno').val());
                var t_productno = $.trim($('#txtProductno').val());
                          
                $('#txtStraddrno').val(t_straddrno); 
                $('#txtStraddr').val(t_straddrno);
                $('#txtEndaddrno').val(t_endaddrno);     
                $('#txtEndaddr').val(t_endaddrno);      
                if(q_cur==1){
                    json = JSON.stringify({
                        type : 'isDuplicate',
                        noa : t_noa,
                        straddrno : t_straddrno,
                        endaddrno : t_endaddrno,
                        productno : t_productno
                    });
                    t_where="where=^^ straddrno='"+t_straddrno+"' and endaddrno='"+t_endaddrno+"' and productno='"+t_productno+"'^^";
                    q_gt('addr', t_where, 0, 0, 0, json, r_accy);
                }else{
                    wrServer($('#txtNoa').val());
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('addr_rj_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#btnMinus_' + j).bind('contextmenu',function(e) {
                            e.preventDefault();
                            mouse_div=false;
                            ////////////控制顯示位置
                            $('#div_row').css('top',e.pageY);
                            $('#div_row').css('left',e.pageX);
                            ////////////
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            $('#div_row').show();
                            row_b_seq=b_seq;
                            row_bbsbbt='bbs';
                        });
                        $('#txtDatea_'+j).datepicker();
                    }

                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtNoa').attr('readonly', 'readonly').css('color','green').css('background','rgb(237,237,237)');
                $('#txtNoa').focus();
            }

            function btnPrint() {
                q_box("z_addrfep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'addr', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txtNoa').val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function sum() {
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
                width: 500px; 
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
                width: 450px;
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
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                font-size:medium;
            }
            .dbbs {
                width: 1200px;
            }
            .tbbs a {
                font-size: medium;
            }
            
            .num {
                text-align: right;
            }
            input[type="text"],input[type="button"] {
                font-size:medium;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >   
        <div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
            <table id="table_row"  class="table_row" style="width:100%;" border="1" cellpadding='1'  cellspacing='0'>
                <tr>
                    <td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
                </tr>
                <tr>
                    <td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
                </tr>
            </table>
        </div>

        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain'>
            <div class="dview" id="dview" >
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:150px; color:black;"><a id='vewProductno'> </a></td>
                        <td align="center" style="width:150px; color:black;"><a id='vewStraddr'> </a></td>
                        <td align="center" style="width:150px; color:black;"><a id='vewEndaddr'> </a></td>
                        
                        <td align="center" style="width:120px; color:black;">客戶</td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" /></td>
                        <td style="text-align: center;" id='noa'>~noa</td>
                        <td style="text-align: left;" id='straddr'>~straddr</td>
                        <td style="text-align: left;" id='endaddr'>~endaddr</td>
                        <td style="text-align: left;" id='product'>~product</td>
                        <td style="text-align: left;" id='nick'>~nick</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm"  id="tbbm">
                    <tr>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td colspan="2"><input id="txtNoa" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblStraddr' class="lbl btn"> </a></td>
                        <td colspan="3">
                            <input id="txtStraddrno" type="text" class="txt c1"/>
                            <input id="txtStraddr" type="text" style="display:none;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblEndaddr' class="lbl btn"> </a></td>
                        <td colspan="3">
                            <input id="txtEndaddrno" type="text" class="txt c1"/>
                            <input id="txtEndaddr" type="text" style="display:none;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblProductno' class="lbl btn"> </a></td>
                        <td colspan="3">
                            <input id="txtProductno" type="text" style="float:left; width:40%;"/>
                            <input id="txtProduct" type="text" style="float:left; width:60%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
                        <td colspan="3">
                            <input id="txtCustno" type="text" style="float:left; width:40%;"/>
                            <input id="txtCust" type="text" style="float:left; width:60%;"/>
                            <input id="txtNick" type="text" style="display:none;"/>                            
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:80px;"><a id='lblDatea_s'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblCustunit_tb'> </a><br>計價方式</td>
                    <td align="center" style="width:80px;"><a id='lblCustprice_tb'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblDriverunit2_tb'> </a><br>計價方式</td>
                    <td align="center" style="width:80px;"><a id='lblDriverprice2_tb'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblDriverunit_tb'> </a><br>計價方式</td>
                    <td align="center" style="width:80px;"><a id='lblDriverprice_tb'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblTggunit_tb'> </a><br>計價方式</td>
                    <td align="center" style="width:80px;"><a id='lblTggprice_tb'> </a></td>
                    <td align="center" style="width:80px;">米/噸</td>
                    <td align="center" style="width:150px;"><a id='lblMemo_s'> </a></td>
                </tr>
                <tr  style='background:#cad3ff;'>
                    <td align="center">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><input type="text" id="txtDatea.*" style="width:95%;"/></td>
                    <td><select id="cmbCustunit.*" style="width:95%;"> </select></td>
                    <td><input type="text" id="txtCustprice.*" style="width:95%;text-align:right;"/></td>
                    <td><select id="cmbDriverunit2.*" style="width:95%;"> </select></td>
                    <td><input type="text" id="txtDriverprice2.*" style="width:95%;text-align:right;"/></td>
                    <td><select id="cmbDriverunit.*" style="width:95%;"> </select></td>
                    <td><input type="text" id="txtDriverprice.*" style="width:95%;text-align:right;"/></td>
                    <td><select id="cmbTggunit.*" style="width:95%;"> </select></td>
                    <td><input type="text" id="txtTggprice.*" style="width:95%;text-align:right;"/></td>
                    <td><input type="text" id="txtCommission.*" style="width:95%;text-align:right;"/></td>
                    <td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
