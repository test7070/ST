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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_salary');

                $('#q_report').click(function(e) {
                    if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1) {
                        if (window.parent.q_name == 'salary') {
                            var wParent = window.parent.document;
                            $('#txtXnoa').val(wParent.getElementById("txtNoa").value);
                        }
                    } else {
                        $('#Xnoa').hide();
                        $('#txtXnoa').val('');
                    }
                    if ($(".select")[0].nextSibling.innerText == '個人薪資表(本國)') {
                        $('#btnSendmail').show();
                    } else {
                        $('#btnSendmail').hide();
                    }
                });
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_salary',
                    options : [{
                        type : '6',
                        name : 'xmon'
                    }, {
                        type : '5',
                        name : 'xperson',
                        value : (('').concat(new Array("本國", "日薪"))).split(',')
                    }, {
                        type : '5',
                        name : 'xkind',
                        value : (('').concat(new Array("本月", "上期", "下期"))).split(',')
                    }, {
                        type : '2',
                        name : 'sssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '1',
                        name : 'date'
                    }, {
                        type : '5',
                        name : 'xorder',
                        value : (('').concat(new Array("部門", "員工編號"))).split(',')
                    }, {
                        type : '2',
                        name : 'xpartno',
                        dbf : 'part',
                        index : 'noa,part',
                        src : 'part_b.aspx'
                    }, {
                        type : '6',
                        name : 'xyear'
                    }, {
                        type : '6',
                        name : 'xnoa'
                    }, {
                        type : '5',
                        name : 'service',
                        value : (('').concat(new Array("#non@全部", "1@在職", "0@離職"))).split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                if (r_len == 4) {
                    $.datepicker.r_len = 4;
                    //$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }

                $('#txtXmon').mask(r_picm);
                $('#txtDate1').mask(r_picd);
                $('#txtDate1').datepicker();
                $('#txtDate2').mask(r_picd);
                $('#txtDate2').datepicker();
                $('#txtXyear').mask(r_pic);
                
                $('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXmon').val(q_date().substr(0,r_lenm));
                $('#txtXyear').val(q_date().substr(0,r_len));
                $('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0, r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1));

                if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1) {
                    if (window.parent.q_name == 'salary') {
                        var wParent = window.parent.document;
                        $('#txtXnoa').val(wParent.getElementById("txtNoa").value);
                    }
                } else {
                    $('#Xnoa').hide();
                    $('#txtXnoa').val('');
                }

                $('#btnSendmail').click(function() {
                    var t_mom = emp($('#txtXmon').val()) ? '#non' : $('#txtXmon').val();
                    var t_bsno = emp($('#txtSssno1a').val()) ? '#non' : $('#txtSssno1a').val();
                    var t_esno = emp($('#txtSssno2a').val()) ? '#non' : $('#txtSssno2a').val();
                    var t_kind = emp($('#Xkind select').val()) ? '#non' : $('#Xkind select').val();
                    if (t_mom.length > 0 && t_bsno.length > 0 && t_esno.length > 0 && t_kind.length > 0) {
                        q_func('salary.sendmail', t_mom + ',' + t_bsno + ',' + t_esno + ',' + t_kind);
                        $('#btnSendmail').attr('disabled', 'disabled').val('發送中...');
                    }
                });

            }

            function q_funcPost(t_func, result) {
                if (t_func == 'salary.sendmail') {
                    alert('發送完成!!!');
                    $('#btnSendmail').removeAttr('disabled').val(q_getMsg("btnSendmail"));
                    return;
                }
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"></div>
				<input id="btnSendmail" type="button" style="display: none;"/>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

