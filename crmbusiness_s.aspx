﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
<script type="text/javascript">
    var q_name = "crmbusiness_s";

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

      bbmMask = [['txtDatea', r_picd],['txtEdatea', r_picd]];
        q_mask(bbmMask);
        $('#txtDatea').focus();
        $('#txtEdatea').focus();
		q_cmbParse("cmbStage", ",潛在機會,初步接洽,需求確認,建議/報價,談判協商,成交,失敗");
         
    }

    function q_seekStr() {   
        t_date = $('#txtDatea').val();
        t_noa = $('#txtNoa').val();
        t_name = $('#cmbStage').val();
        t_edate = $('#txtEdatea').val();

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("datea", t_date) + q_sqlPara2("stage", t_name) + q_sqlPara2("edatea", t_edate);

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
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblDatea'></a></td>
                <td><input class="txt" id="txtDatea" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblStage'></a></td>
                <td><select class="txt" id="cmbStage" type="text" style="width:215px; font-size:medium;"></select></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblEdatea'></a></td>
                <td><input class="txt" id="txtEdatea" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
