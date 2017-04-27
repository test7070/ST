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
			
			t_acomp = new Array();
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'ucaissued');
                $('#q_report').hide();
                $('.prt').hide();
                q_gt('acomp','', 0, 0, 0, "", r_accy);
            });
            function q_gfPost() {
                $('#q_report').q_report({
                        fileName : 'ucaissued',
                        options : []
                    });
                    q_popAssign();
                    q_langShow();
                    
                   	var t_key = q_getHref();
					if(t_key[1] != undefined){
						$('#txtBnoa').val(t_key[1]);
						$('#txtEnoa').val(t_key[1]);
					}
	                    
                    $('#btnIssued').click(function(e) {
                    	var cbxAcomp = new Array();
			            var t_Acomp='';
			            $('#chkAcomp input:checkbox:checked').each(function(i){
				            cbxAcomp[i] = this.value;
				        });
				        for (var i = 0; i < cbxAcomp.length; i++) {
							t_Acomp=t_Acomp+'^'+cbxAcomp[i];
						}
                    	if((cbxAcomp.length=='0')){
							alert('公司未選擇');
							return;
					    }
					    var t_bnoa=!emp($('#txtBnoa').val())?trim($('#txtBnoa').val()):'#non';
					    var t_enoa=!emp($('#txtEnoa').val())?trim($('#txtEnoa').val()):'#non';
					    q_func('qtxt.query.issued', 'ucaissued.txt,issued,'+encodeURI(t_Acomp)+';'+encodeURI(t_bnoa)+';'+encodeURI(t_enoa));
					    $('#btnIssued').attr('disabled','disabled').val('匯入中...');
                	});
            }
            function q_funcPost(t_func, result) {
            	switch(t_func) {
                    case 'qtxt.query.issued':
                    	alert('發行完成');
                    	$('#btnIssued').removeAttr('disabled').val('發行');
                        break;
                    
                    default:
                    	break;
                }
		    }
		    		    
            function q_gtPost(t_name) {
                switch (t_name) { 
                	case 'acomp':
                        var as = _q_appendData("acomp", "", true)
                        if (as[0] != undefined) {
                            z_acomp = ' @';
                            z_acomph='';
                            for (var i = 0; i < as.length; i++) {
                            	z_acomph=z_acomph+('<input type="checkbox" value="'+as[i].noa+'" style="width:25px;height:15px;float:left;"><span style="width:280px;height:30px;display:block;float:left;">'+as[i].acomp+'</span>')
                                z_acomp += ',' + as[i].noa + '@' + as[i].acomp;
                            }
                        }
                        $('.chkAcomp').html(z_acomph);
                		break;
                }
            }
                        
			function q_boxClose(t_name) {
            }
            
		</script>
	</head>
	
<body ondragstart="return false" draggable="false"
        ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
        ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div id="ucf">
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:450px">
					<tr>
						<td align="center" style="width:20%"><a id="lblNoa" class="lbl" style="font-size: medium;">選擇件號</a></td>
						<td align="left" style="width:80%">
							<input id="txtBnoa"  type="text"  class="txt" style="width:40%"/> ~
							<input id="txtEnoa"  type="text"  class="txt" style="width:40%"/>
						</td>
					</tr>
					<tr>
		               <td align="center"><a id='lblAcomp' class="lbl" style="font-size: medium;">公司</a></td>
		               <td>
		               		<div id="chkAcomp" style="width: 330px; display: block; float: left;" class="chkAcomp">
		               		</div>
		               </td>
		            </tr>
					<tr>
						<td align="center" colspan="2">
							<input id="btnIssued" type="button" style="font-size: medium;" value="發行"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>