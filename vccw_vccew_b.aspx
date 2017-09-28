<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'vccews', t_bbsTag = 'tbbs', t_content = " field=  datea,cno,acomp,custno,comp,post,addr,post2,addr2,addr_post,zip_post,paytype,trantype,tel,fax,salesno,sales,cardealno,cardeal,carno,taxtype,coin,floata,ordewno,no2,bccno,bccname,unit,mount,weight,price,storeno,store,vccewno,memo order=datea ", afilter = [], bbsKey = ['noa'], as;
            //, t_where = '';
            var t_sqlname = 'vccw_vccew_load';
            t_postname = q_name;
            brwCount2 = 0;
            brwCount = -1;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var bbsNum = [['txtPaysale', 10, 0], ['txtTotal', 10, 0], ['txtOpay', 10, 0]];
            var i, s1;

            $(document).ready(function() {
                if (location.href.indexOf('?') < 0 )// debug
                {
                    location.href = location.href + "?;;;where=^^1=0^^";
                    return;
                }
                if (!q_paraChk())
                    return;
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                
                if(q_getId()[3]=='')
                	t_content='where=^^1=1^^';
                
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
                
                $('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtBccno_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
                
                $('#btnNext').hide();
                $('#btnBott').hide();
                $('#btnPrev').hide();
                $('#btnTop').hide();
            }

            function bbsAssign() {
                _bbsAssign();
            }

            function q_gtPost() {

            }

            function refresh() {
                _refresh();
            }
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 18%;
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
                width: 80%;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 48%;
                float: left;
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
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center"><a id='lblDatea'> </a></td>
					<td align="center"><a id='lblOrdewno'> </a>/<a id='lblNo2'> </a></td>
					<td align="center"><a id='lblBccno'> </a>/<a id='lblBccname'> </a></td>
					<td align="center"><a id='lblUnit'> </a></td>
					<td align="center"><a id='lblMount'> </a></td>
					<td align="center"><a id='lblWeight'> </a></td>
					<td align="center"><a id='lblPrice'> </a></td>
					<td align="center"><a id='lblVccewno'> </a></td>
					<td align="center"><a id='lblCust'> </a></td>
					<td align="center"><a id='lblMemo'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;" align="center"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:8%;"><input class="txt" id="txtDatea.*" type="text" style="width:96%;"/></td>
					<td style="width:15%;">
						<input class="txt"  id="txtOrdewno.*" type="text" style="width:98%;" />
						<input class="txt" id="txtNo2.*" type="text" style="width:98%;" />
					</td>
					<td style="width:15%;">
						<input class="txt"  id="txtBccno.*" type="text" style="width:98%;" />
						<input class="txt" id="txtBccname.*" type="text" style="width:98%;" />
					</td>
					<td style="width:4%;"><input class="txt" id="txtUnit.*" type="text" style="width:94%;"/></td>
					<td style="width:8%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
					<td style="width:8%;"><input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/></td>
					<td style="width:8%;"><input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/></td>
					<td style="width:8%;"><input class="txt" id="txtVccewno.*" type="text" style="width:96%;"/></td>
					<td style="width:15%;"><input class="txt" id="txtComp.*" type="text" style="width:96%; text-align:left;"/></td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:98%;"/>
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
