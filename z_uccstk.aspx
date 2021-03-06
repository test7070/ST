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
            var t_style = '';
            var t_ucc = '';
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_uccstk');

            });
            function q_gfPost() {
                q_gt('style', '', 0, 0, 0, "");
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                case 'style':
                    t_style = '';
                    var as = _q_appendData("style", "", true);
                    for ( i = 0; i < as.length; i++) {
                        t_style += (t_style.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + '.' + as[i].product;
                    }
                    q_gt('ucc', '', 0, 0, 0, "");
                    break;
                case 'ucc':
                    t_ucc = '';
                    var as = _q_appendData("ucc", "", true);
                    for ( i = 0; i < as.length; i++) {
                        t_ucc += (t_ucc.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + '.' + as[i].product;
                    }
                    loadFinish();
                    break;
                }
            }

            function loadFinish() {
                $('#q_report').q_report({
                    fileName : 'z_uccstk',
                    options : [{//1 [1]
                        type : '6',
                        name : 'xdate'
                    }, {//2 [2]
                        type : '5',
                        name : 'xkind',
                        value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
                    }, {//3 [3]
                        type : '5',
                        name : 'xproductno',
                        value : [q_getPara('report.all')].concat(t_ucc.split(','))
                    }, {//4 [4]
                        type : '8',
                        name : 'xstyle',
                        value : t_style.split(',')
                    }, {//5 [5][6]
                        type : '1',
                        name : 'dime'
                    }, {//6 [7][8]
                        type : '1',
                        name : 'width'
                    }, {//7 [9][10]
                        type : '1',
                        name : 'length'
                    }, {//8 [11][12]
                        type : '1',
                        name : 'radius'
                    }, {
                        type : '1', //[13][14] 9
                        name : 'ydate'
                    }, {
                        type : '8', //[15] 10
                        name : 'yitype',
                        value : q_getPara('uccc.itype').split(',')
                    }, {
                        type : '8', //[16]  11
                        name : 'yproductno',
                        value : t_ucc.split(',')
                    }]
                });
                q_popAssign();
                q_langShow();

                $('#txtYdate1').mask('999/99/99');
                $('#txtYdate1').datepicker();
                $('#txtYdate2').mask('999/99/99');
                $('#txtYdate2').datepicker();

                $('#txtXdate').mask('999/99/99');
                $('#txtXdate').datepicker();
                $('#txtXdate').val(q_date());
                $('#chkXstyle').children('input').attr('checked', 'checked');

                $('#txtDime1').css('text-align', 'right');
                $('#txtDime2').css('text-align', 'right').val(999999);
                $('#txtWidth1').css('text-align', 'right');
                $('#txtWidth2').css('text-align', 'right').val(999999);
                $('#txtLength1').css('text-align', 'right');
                $('#txtLength2').css('text-align', 'right').val(999999);
                $('#txtRadius1').css('text-align', 'right');
                $('#txtRadius2').css('text-align', 'right').val(999999);

                $('#chkYitype').children('input').eq(0).attr('checked', 'checked');
                $('#chkYitype').children('input').eq(1).attr('checked', 'checked');
                $('#chkYstyle').children('input').attr('checked', 'checked');
                
                $('<input id="btnOk2" type="button" value="查詢" style="font-size: 16px; font-weight: bold; color: blue; cursor: pointer;"/>').insertBefore('#btnOk');
            	$('#btnOk').hide();
            	$('#btnOk2').click(function(e){
            		switch($('#q_report').data('info').radioIndex) {
                        case 2:
                        	if(q_getPara('sys.project').toUpperCase()=='BD'){
                        		//隆昊
                        		$('#btnOk').click();
                        	}
                        	else{
                        		//裕承隆
                        		Lock(1);
	                        	//q_func('qtxt.query.uccstk_1', 'uccstk.txt,uccstk_1,'+$('#txtXdate').val());
	                            $.ajax({
				                    url: 'uccstk.aspx?date='+$('#txtXdate').val()+'&db='+q_db,
				                    type: 'POST',
				                    dataType: 'text',
				                    timeout: 600000,
				                    success: function(data){
				                       alert(data);
				                    },
				                    complete: function(){ 
				                    	Unlock(1);                
				                    },
				                    error: function(jqXHR, exception) {
				                        var errmsg = this.url+'資料讀取異常。\n';
				                        if (jqXHR.status === 0) {
				                            alert(errmsg+'Not connect.\n Verify Network.');
				                        } else if (jqXHR.status == 404) {
				                            alert(errmsg+'Requested page not found. [404]');
				                        } else if (jqXHR.status == 500) {
				                            alert(errmsg+'Internal Server Error [500].');
				                        } else if (exception === 'parsererror') {
				                            alert(errmsg+'Requested JSON parse failed.');
				                        } else if (exception === 'timeout') {
				                            alert(errmsg+'Time out error.');
				                        } else if (exception === 'abort') {
				                            alert(errmsg+'Ajax request aborted.');
				                        } else {
				                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
				                        }
				                    }
				                });	
                        	}
                        	
                            break;
                        default:
                           	$('#btnOk').click();
                            break;
                    }
            	});
            }
            function q_boxClose(s2) {
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                case 'qtxt.query.uccstk_1':
                    var as = _q_appendData("tmp0", "", true);
                    if (as[0] != undefined) {
                        alert(as[0].memo);
                    } else {
                        alert('error!');
                    }
                    Unlock(1);
                    break;
                default:
                    break;
                }
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<a style="color:darkred;">製管派令有輸入【代工】，單價一律為0。</a>
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>