<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            /*aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx']
             ,['txtXcarplateno', 'lblXcarplate', 'carplate', 'noa,carplate,driver', 'txtXcarplateno', 'carplate_b.aspx']
             ,['txtXproductno', 'lblXproductno', 'fixucc', 'noa,namea', 'txtXproductno', 'fixucc_b.aspx']);*/
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_anasss');

            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_anasss',
                    options : [{
                        type : '1', //[1][2]
                        name : 'xage',
                    }, {
                        type : '1', //[3][4]
                        name : 'xyear'
                    }, {
                        type : '6', //[5]
                        name : 'wage'
                    }, {
                        type : '6', //[6]
                        name : 'wyear'
                    }, {
                        type : '5', //[7]
                        name : 'type',
                        value : ['根據新進與總離職人數', '根據上月員工人數', '根據本月員工人數', '根據基準年月區間人數']
                    }, {
                        type : '1', //[8][9]
                        name : 'xmon'
                    }, {
                        type : '1', //[10][11]
                        name : 'bmon'
                    }, {
                        type : '8', //[12]
                        name : 'sex',
                        value : ['男', '女']
                    }, {
                        type : '1', //[13][14]
                        name : 'smon'
                    }, {
                        type : '8', //[15]
                        name : 'clerk',
                        value : ['現況在職', '現況離職']
                    }, {
                        type : '2', //[16][17]
                        name : 'sssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '8', //[18]
                        name : 'xoption',
                        value : ["in@在職", "out@離職"]
                    }, {
                        type : '5', //[19]
                        name : 'xsort',
                        value : ["noa@編號", "partno@部門"]
                    }, {
                        type : '0', //[20]
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '0', //[21]
                        name : 'name',
                        value : r_name
                    }, {
                        type : '0', //[22]
                        name : 'r_len',
                        value : r_len
                    }, {
						type : '0',//[23]
                        name : 'xproject',
                        value : q_getPara('sys.project').toUpperCase()
                    }]
                });
                $('#chkXoption').children('input').attr('checked', 'checked');
                $('#chkSex').children('input').attr('checked', 'checked');
                $('#chkClerk').children('input').attr('checked', 'checked');
                q_popAssign();
				q_getFormat();
				q_langShow();

                $('#txtXage1').val('20');
                $('#txtXage2').val('50');
                $('#txtXyear1').val('1');
                $('#txtXyear2').val('10');
                $('#txtWage').val('5');
                $('#txtWyear').val('1');

                $('#txtXmon1').mask(r_picm);
                $('#txtXmon2').mask(r_picm);
                $('#txtSmon1').mask(r_picm);
                $('#txtSmon2').mask(r_picm);
                $('#txtBmon1').mask('99');
                $('#txtBmon2').mask('99');
                $('#txtBmon1').val('01');
                $('#txtBmon2').val('12');

                $('#txtXmon1').val(q_date().substr(0,r_lenm));
                $('#txtSmon1').val(q_date().substr(0,r_lenm));
                $('#txtXmon2').val(q_date().substr(0,r_lenm));
                $('#txtSmon2').val(q_date().substr(0,r_lenm));
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

