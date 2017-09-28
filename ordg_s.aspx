<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    var q_name = "ordg_s";
	var aPop = new Array(['txtCustno', '', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx'],['txtTggno', '', 'tgg', 'noa,nick', 'txtTggno,txtTgg', 'tgg_b.aspx']);
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

      	bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
        q_mask(bbmMask);
        $('#txtBdate').focus();
         
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_custno = $('#txtCustno').val();
        t_tggno = $('#txtTggno').val();
        t_contract= $('#txtContract').val();
        t_ordeno= $('#txtOrdeno').val();
        t_ordcno= $('#txtOrdcno').val();
        
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
        /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;
        /// 100.  .


        var t_where = " 1=1 " + q_sqlPara2("datea", t_bdate, t_edate) + q_sqlPara2("noa", t_noa)+ q_sqlPara2("custno", t_custno)+ q_sqlPara2("tggno", t_tggno)+ q_sqlPara2("ordeno", t_ordeno)
        					+ q_sqlPara2("ordcno", t_ordcno)+ q_sqlPara2("contract", t_contract);

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
					<td style="width:25%;" ><a id='lblDatea'>日期</a></td>
					<td>
						<input class="txt" id="txtBdate" type="text" style="width:93px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">～</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
			</tr>
            <tr class='seek_tr'>
					<td class='seek'  style="width:25%;"><a id='lblNoa'>單據編號</a></td>
					<td>
						<input class="txt" id="txtNoa" type="text" style="width:180px; font-size:medium;" />
					</td>
			</tr>
            <tr class='seek_tr'>
					<td class='seek'  style="width:25%;"><a id='lblCustno'>客戶編號</a></td>
					<td>
						<input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />
						&nbsp;<input class="txt" id="txtComp" type="text" style="width:115px;font-size:medium;" />
					</td>
			</tr>
			<tr class='seek_tr'>
					<td class='seek'  style="width:25%;"><a id='lblTggno'>供應商編號</a></td>
					<td>
						<input class="txt" id="txtTggno" type="text" style="width:90px; font-size:medium;" />
						&nbsp;<input class="txt" id="txtTgg" type="text" style="width:115px;font-size:medium;" />
					</td>
			</tr>
			<tr class='seek_tr'>
					<td class='seek'  style="width:25%;"><a id='lblOrdeno'>訂單編號</a></td>
					<td>
						<input class="txt" id="txtOrdeno" type="text" style="width:180px; font-size:medium;" />
					</td>
			</tr>
			<tr class='seek_tr'>
					<td class='seek'  style="width:25%;"><a id='lblOrdcno'>採購單號</a></td>
					<td>
						<input class="txt" id="txtOrdcno" type="text" style="width:180px; font-size:medium;" />
					</td>
			</tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
