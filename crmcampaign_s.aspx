<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
<script type="text/javascript">
    var q_name = "crmcampaign_s";

    $(document).ready(function () {
        main();
    });         /// end ready

    function main() {
        mainSeek();
        q_gf('', q_name);
		
    }

    function q_gfPost() {
        q_getFormat();
        q_langShow();

		bbmMask = [['txtAdbdatea', r_picd], ['txtAdedatea', r_picd], ['txtBdatea', r_picd], ['txtEdatea', r_picd]];
        q_mask(bbmMask);
        $('#txtBdatea').focus();
        $('#txtEdatea').focus();
        $('#txtAdbdatea').focus();
        $('#txtAdedatea').focus();
		q_cmbParse("cmbTypea", ",廣告,直效行銷,活動,品牌聯盟,其他");
         
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_typea = $('#cmbTypea').val();
        t_bdatea = $('#txtBdatea').val();
        t_edatea = $('#txtEdatea').val();
        t_adbdatea = $('#txtAdbdatea').val();
        t_adedatea = $('#txtAdedatea').val();

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("typea", t_typea) + q_sqlPara2("bdatea", t_bdatea) + q_sqlPara2("edatea", t_edatea) + q_sqlPara2("adbdatea", t_adbdatea) + q_sqlPara2("adedatea", t_adedatea);

        t_where = ' where=^^' + t_where + '^^ ';
        return t_where;
    }
</script>
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
<div style='width:400px; text-align:center;padding:15px;' >
       <table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
               <tr class='seek_tr'>
                <td class='seek'  style="width:30%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:30%;"><a id='lblTypea'></a></td>
                <td><select class="txt" id="cmbTypea" type="text" style="width:215px; font-size:medium;"></select></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:30%;"><a id='lblAdbdatea'></a></td>
                <td><input class="txt" id="txtAdbdatea" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:30%;"><a id='lblAdedatea'></a></td>
                <td><input class="txt" id="txtAdedatea" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:30%;"><a id='lblBdatea'></a></td>
                <td><input class="txt" id="txtBdatea" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:30%;"><a id='lblEdatea'></a></td>
                <td><input class="txt" id="txtEdatea" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
