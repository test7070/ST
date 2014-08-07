<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_drvp');
            });
            
            /*var t_ordeno=typeof(q_getId()[3])=='undefined'?'':q_getId()[3];
            t_ordeno  =  t_ordeno.replace('noa=','');*/
           var t_ordeno='#non#',t_handle='#non#',t_handle2='#non#',t_store='#non#';
           var chk_vcce,chk_handle,chk_handle2,chk_store;
           
           if (window.parent.q_name == 'drv') {
           		t_ordeno+=window.parent.chk_vcce;
           		chk_handle=window.parent.chk_handle;
           		chk_handle2=window.parent.chk_handle2;
           		chk_store=window.parent.chk_store;
           		
                for(var i =0 ;i<chk_handle.length;i++){
                	t_handle+=chk_handle[i].noa+"^"+chk_handle[i].handle+"#"
                }
                for(var i =0 ;i<chk_handle2.length;i++){
                	t_handle2+=chk_handle2[i].noa+"^"+chk_handle2[i].handle+"#"
                }
                for(var i =0 ;i<chk_store.length;i++){
                	t_store+=chk_store[i].noa+"-"+chk_store[i].no2+"^"+chk_store[i].store+"#"
                }
           }
           window.parent.chk_handle
            
            function q_gfPost() {
               $('#q_report').q_report({
					fileName : 'z_drvp',
					options : [{
						type : '0', //[1]
						name : 'xordeno',
						value : t_ordeno
					},{
						type : '0', //[2]
						name : 'xhandle',
						value : t_handle
					},{
						type : '0', //[3]
						name : 'xhandle2',
						value : t_handle2
					},{
						type : '0', //[4]
						name : 'xstore',
						value : t_store
					}]
				});
                q_popAssign();
                
                $('#btnOk').click();
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
           
          