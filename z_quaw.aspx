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
            aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx'], ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx'], ['txtXtireno', '', 'view_tirestatus', 'noa', 'txtXtireno', 'tirestk_b.aspx']);
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_quaw',
                    options : [
                    	{
	                        type : '6', //[1]
	                        name : 'xmon'
	                    }, {
							type : '5', //[2]
							name : 'xcoin',
							value : coinItem.split(',')
						}, {
	                        type : '2',	//[3][4]
	                        name : 'xuca',
	                        dbf : 'uca',
	                        index : 'noa,product',
	                        src : 'uca_b.aspx'
                    	}
                    ]
                });
                q_popAssign();
				q_getFormat();
				q_langShow();

                $('#txtXmon').mask(r_picm);
                $('#txtXmon').val(q_date().substr(0,r_lenm));
                
            }

            function q_boxClose(t_name) {
            }
			
			var coinItem='';
			var firstRun=false;
            function q_gtPost(t_name) {
				switch (t_name) {
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						coinItem = "#non@本幣";
						for ( i = 0; i < as.length; i++) {
							coinItem = coinItem + (coinItem.length > 0 ? ',' : '') + as[i].coin + '@' + as[i].coin;
						}
						firstRun = true;
						break;
				}
				if (coinItem.length > 0 && firstRun) {
					q_gf('', 'z_quaw');
				}
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