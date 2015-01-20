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
			aPop = new Array(
				['textBccno', '', 'bcc', 'noa,product', 'textBccno,textProduct', 'bcc_b.aspx'], 
				['textTggno', '', 'tgg', 'noa,comp', 'textTggno,textTgg', 'tgg_b.aspx']
			);
			
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'bcch_b');

                $('#q_report').hide();
                $('.prt').hide();
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'bcch_b',
                    options : []
                });
                q_popAssign();
                q_langShow();
                
                $('#textProduct').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
                $('#textTgg').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');

                $('#textBdate').mask('999/99/99');
                $('#textEdate').mask('999/99/99');

                $('#textBdate').val(q_date().substr(0, 3) + '/01/01');
                $('#textEdate').val(q_date());

                $('#btnToSeek').click(function(e) {
                	var if_src='bcch_chk.aspx?'+q_getId()[0]+';'+q_getId()[1]+';'+q_getId()[2]+';';
                	//條件
                	var bdate=emp($('#textBdate').val())?'':$('#textBdate').val();
                	var edate=emp($('#textEdate').val())?'char(255)':$('#textEdate').val();
                	var bccno=emp($('#textBccno').val())?'':$('#textBccno').val();
                	var tggno=emp($('#textTggno').val())?'':$('#textTggno').val();
                	
                	if_src+="isnull(qdate,'')='' and (datea between '"+bdate+"' and '"+edate+"') ";
                	if(bccno.length>0)
                		if_src+="and bccno='"+bccno+"' ";
                	if(tggno.length>0)
                		if_src+="and tggno='"+tggno+"' ";
                	
                	if_src+=";"+q_getId()[4];
                	
                    document.getElementById("if1").src = if_src;
                });

                $('#btnXauthority').click(function(e) {
                    $('#btnAuthority').click();
                });
            }

            function q_gtPost(t_name) {
                switch (t_name) {

                }
            }

            function q_funcPost(t_func, result) {
            }

            function q_boxClose(t_name) {
            }

		</script>
		<style type="text/css">
            #seekForm {
                margin-left: auto;
                margin-right: auto;
                width: 1200px;
            }
            #seekTable {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            #seekTable tr {
                height: 35px;
            }
            .txt.c1 {
                width: 98%;
            }
            .txt.c2 {
                width: 95%;
            }
            .lbl {
                float: right;
            }
            .num {
                text-align: right;
            }
            input[type="button"] {
                font-size: medium;
            }
            #seekTable td {
               /* width: 4%;*/
            }

            .StrX {
                margin-right: -2px;
                margin-left: -2px;
            }
            #seekTable .lbl {
                float: right;
            }
            #seekTable span {
                margin-right: 5px;
            }
		</style>
	</head>

	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:1200px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div id="header" align="center">
				<iframe id="if1" frameborder="0" scrolling="no" width="100%" style="height: 700px;"> </iframe>
			</div>
			<div id="seekForm">
				<table id="seekTable" border="0" cellpadding='0' cellspacing='0'>
					<tr style="height: 1px;">
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
						<td style="width: 150px;"> </td>
					</tr>
					<tr>
						<td><span class="lbl"><a id='lblDatea_s' class="lbl"> </a></span></td>
						<td colspan="3">
							<input id="textBdate" type="text" style="width:35%"/>
							~
							<input id="textEdate" type="text" style="width:35%"/>
						</td>
					</tr>
					<tr>
						<td><span class="lbl"><a id='lblBcc_s' class="lbl"> </a></span></td>
						<td><input id="textBccno" type="text"/></td>
						<td colspan="2"><input id="textProduct" type="text" class='txt c1'/></td>
						<td><span class="lbl"><a id='lblTgg_s' class="lbl"> </a></span></td>
						<td><input id="textTggno" type="text"/></td>
						<td colspan="2"><input id="textTgg" type="text" class='txt c1'/></td>
					</tr>
					<tr>
						<td colspan="12" align="center">
						<input type="button" id="btnToSeek" value="查詢">
						</td>
					</tr>
				</table>
				<div id="q_acDiv" style="display: none;">
			</div>
			<input id="btnXauthority" type="button" style="float:left; width:80px;font-size: medium;"/>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>