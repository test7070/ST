<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_salaryp_dj');

            });

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_salaryp_dj',
                    options : [{
                        type : '6',
                        name : 'xmon'
                    }, {
                        type : '2',
                        name : 'xsssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2',
                        name : 'xpartno',
                        dbf : 'part',
                        index : 'noa,part',
                        src : 'part_b.aspx'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                $('#txtXmon').mask(r_picm);
                if (window.parent.q_name == "salary")
                    $('#txtXmon').val(window.parent.$('#txtMon').val());

                var tmp = document.getElementById("btnOk");
                var tmpbtn = document.createElement("input");
                tmpbtn.id = "btnOk2"
                tmpbtn.type = "button"
                tmpbtn.value = "查詢"
                tmpbtn.style.cssText = "font-size: 16px; font-weight: bold; color: blue; cursor: pointer;";
                tmp.parentNode.insertBefore(tmpbtn, tmp);
                $('#btnOk').hide();

                var tmp = document.getElementById("btnWebPrint");
                var tmpbtn = document.createElement("input");
                tmpbtn.id = "btnWebPrint2"
                tmpbtn.type = "button"
                tmpbtn.value = "雲端列印"
                tmpbtn.style.cssText = "font-size:medium;color: #0000FF;";
                tmp.parentNode.insertBefore(tmpbtn, tmp);
                $('#btnWebPrint').hide();

                $('#btnOk2').click(function() {
                    q_gt('salary', "where=^^ mon = '" + $('#txtXmon').val() + "' and isnull(changedata,'')!='' ^^", 0, 0, 0, "getchangedata");
                });

                $('#btnWebPrint2').click(function() {
                    q_gt('salary', "where=^^ mon = '" + $('#txtXmon').val() + "' and isnull(changedata,'')!='' ^^", 0, 0, 0, "getchangedata2");
                });
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'getchangedata':
                        var as = _q_appendData("salary", "", true);
                        if (as[0] != undefined) {
                            alert('薪資內容有異動，薪資作業請重新匯入後再查詢!!');
                        } else {
                            $('#btnOk').click();
                        }
                        break;
                    case 'getchangedata2':
                        var as = _q_appendData("salary", "", true);
                        if (as[0] != undefined) {
                            alert('薪資內容有異動，薪資作業請重新匯入後再列印!!');
                        } else {
                            $('#btnWebPrint').click();
                        }
                        break;
                }
            }

		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

