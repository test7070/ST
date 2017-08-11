<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'bcchs', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
            var t_sqlname = 'bcchs_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = ['txtNoa','txtTggno','txtTgg','txtBccno','txtBccname','txtDatea','txtPrice','txtUnit','txtSprice','txtMemo','txtOdate'];
            var bbmNum = [];
            var bbsNum = [['txtQday', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = (location.origin==undefined?'':location.origin)+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";mon='"+q_date().substr(0,6)+"' and (caritemno='501' or caritemno='502') order by carno desc";
                    return;
                }
                if(!q_paraChk())
                    return;
				
				brwCount2 = 0;
            	brwCount = -1;
                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                
                bbsMask = [['txtQdate', r_picd],['txtQtime', '99:99']];
                q_mask(bbmMask);
                
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
                $('#btnClose').hide();
                
                $('#btnOk').click(function() {
                	location.href=location.href;
                });
                
                $('#btnClose').click(function() {
                	location.href=location.href;
                });
                
            }

            function q_gtPost(t_name) {

            }

            function bbsAssign() {
                for(var j = 0; j < q_bbsCount; j++) {
                	$('#checkApv_'+j).click(function() {
                		t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if($('#checkApv_'+b_seq).prop('checked')){
							var NowTime = new Date;
							var w_Hours = padL(NowTime.getHours(),'0',2); 
							var w_Minutes = padL(NowTime.getMinutes(),'0',2);
							$('#txtChkname_'+b_seq).val(r_name);
							$('#txtQdate_'+b_seq).val(q_date());
							$('#txtQtime_'+b_seq).val(w_Hours+':'+w_Minutes);
						}else{
							$('#txtChkname_'+b_seq).val('');
							$('#txtQdate_'+b_seq).val('');
							$('#txtQtime_'+b_seq).val('');
						}				
					});
                }
                _bbsAssign();
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['noa'] || !as['noq']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }

            function refresh() {
                _refresh();
            }

            function sum() {
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                for(var j = 0; j < q_bbsCount; j++) {
	                if(t_para){
	                	$('#checkApv_'+j).attr('disabled', 'disabled');
	                	$('#btnClose').hide();
	                }else{
	                	$('#checkApv_'+j).removeAttr('disabled');
	                	$('#btnClose').show();
	                }
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if(q_tables == 's')
                    bbsAssign();
            }
		</script>
		<style type="text/css">
            td a {
                font-size: 14px;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td2" align="center" style="width:7%;"><a id='lblTggno'> </a></td>
					<td class="td5" align="center" style="width:10%;"><a id='lblTgg'> </a></td>
					<td class="td6" align="center" style="width:7%;"><a id='lblBccno'> </a></td>
					<td class="td4" align="center" style="width:10%;"><a id='lblBccname'> </a></td>
					<td class="td2" align="center" style="width:5%;"><a id='lblDatea'> </a></td>
					<td class="td3" align="center" style="width:5%;"><a id='lblPrice'> </a></td>
					<td class="td8" align="center" style="width:3%;"><a id='lblUnit'> </a></td>
					<td class="td7" align="center" style="width:5%;"><a id='lblSprice'> </a></td>
					<td class="td2" align="center" style="width:15%;"><a id='lblMemo'> </a></td>
					<td class="td7" align="center" style="width:5%;"><a id='lblOdate'> </a></td>
					<td class="td7" align="center" style="width:5%;"><a id='lblQday'> </a></td>
					<td class="td7" align="center" style="width:2%;"><a id='lblApv'> </a></td>
					<td class="td2" align="center" style="width:10%;"><a id='lblNoa'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td2"><input class="txt" id="txtTggno.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td5"><input class="txt" id="txtTgg.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td6"><input class="txt" id="txtBccno.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td4"><input class="txt" id="txtBccname.*" type="text" style="width:95%; text-align:center"  /></td>
					<td class="td2"><input class="txt" id="txtDatea.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td3"><input class="txt" id="txtPrice.*" type="text" style="width:95%; text-align:right"  /></td>
					<td class="td8"><input class="txt" id="txtUnit.*" type="text" style="width:95%;"   /></td>
					<td class="td7"><input class="txt" id="txtSprice.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td2"><input class="txt" id="txtMemo.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td2"><input class="txt" id="txtOdate.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td2"><input class="txt" id="txtQday.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td2">
						<input class="btn" id="checkApv.*" type="checkbox"/>
					</td>
					<td class="td2">
						<input class="txt" id="txtNoa.*" type="text" style="width:95%; text-align: center;"  />
						<input class="txt" id="txtNoq.*" type="hidden"/>
						<input class="txt" id="txtQdate.*" type="hidden"/>
						<input class="txt" id="txtQtime.*" type="hidden"/>
						<input class="txt" id="txtChkname.*" type="hidden"/>
					</td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
