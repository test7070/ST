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
            var q_name = 'vccs', t_bbsTag = 'tbbs', t_content = " field=datea,typea,productno,product,spec,dime,width,lengthb,unit,mount,weight,noa,noq,ordeno,no2,price,theory,datea,custno,style,class,uno,total,memo", afilter = [], bbsKey = ['noa', 'noq'], as;
            //, t_where = '';
            var t_sqlname = 'vccs';
            t_postname = q_name;
            brwCount = -1;
            //brwCount2 = 10;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            $(document).ready(function() {
                if (!q_paraChk())
                    return;

                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

            function bbsAssign() {
                _bbsAssign();
            }

            function q_gtPost() {

            }

            function refresh() {
                _refresh();
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
                
                for (var j = 0; j < abbs.length; j++) {
					if($('#combTypea_'+j).length<1)
						continue;
						
					q_cmbParse("combTypea_"+j, q_getPara('vcc.typea'));	// 需在 main_form() 後執行，才會載入 系統參數
			        
			        if(!emp($('#txtTypea_'+j).val()))
			        	$('#combTypea_'+j).val($('#txtTypea_'+j).val());
			        else
			        	$('#combTypea_'+j).text('');
			        
					$('#combTypea_'+j).attr('disabled', 'disabled');
		            $('#combTypea_'+j).css('background', t_background2);
		        }
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center"><a id='lblDatea'> </a></td>
					<td align="center"><a id='lblTypea'> </a></td>
					<td align="center"><a id='lblNoa'> </a></td>
					<td align="center"><a id='lblProduct'> </a></td>
					<td align="center"><a id='lblUnit'> </a></td>
					<td align="center"><a id='lblMount'> </a></td>
					<td align="center"><a id='lblPrice'> </a></td>
					<td align="center"><a id='lblTotal'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:5%;"><input class="txt" id="txtDatea.*" type="text" style="width:98%;"/></td>
					<td style="width:4%;">
						<select id="combTypea.*" class="txt" style="width:98%;"> </select>
						<input class="txt" id="txtTypea.*" type="hidden"  style="width:98%;"/>
					</td>
					<td style="width:13%;">
						<input class="txt" id="txtNoa.*" type="text" style="width:98%;"/>
						<input class="txt" id="txtNoq.*" type="hidden"  style="width:98%;"/>
						<input id="recno.*" type="hidden" />
					</td>
					<td style="width:15%;"><input class="txt" id="txtProduct.*" type="text" style="width:98%;" /></td>
					<td style="width:4%;"><input class="txt" id="txtUnit.*" type="text" style="width:94%;"/></td>
					<td style="width:8%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
					<td style="width:8%;"><input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/></td>
					<td style="width:8%;"><input class="txt" id="txtTotal.*" type="text" style="width:96%; text-align:right;"/></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
