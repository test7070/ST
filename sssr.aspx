<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'sssr', t_bbsTag = 'tbbs', t_content = "", afilter = [] , bbmKey = [], bbsKey = ['noa,noq'], as, brwCount2 = 23;
            var t_sqlname = 'sssr_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];

            aPop = new Array(['txtCno_', 'btnCno_', 'acomp', 'noa,acomp', 'txtCno_,txtAcomp_', 'acomp_b.aspx']);
			var t_authRun=false;
            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='z001'";
                    return;
                }
                if(!q_paraChk())
                    return;

                var t_where = "where=^^ a.noa='" + q_name + "' and a.sssno='"+r_userno+"' ^^";
				q_gt('authority', t_where, 0, 0, 0, "getauthRun", r_accy);
            });
            
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                if(t_authRun)
					mainBrow(6, t_content, t_sqlname, t_postname);
				else
					alert('無使用權限');
            }
            
            function mainPost() {
				q_getFormat();
				 bbsMask = [['txtStopdate', r_picd], ['txtReindate', r_picd]];
                q_mask(bbmMask);
				
			}

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'getauthRun':
						var as = _q_appendData("authority", "", true, true);
						if (as[0] != undefined) {
							if (as[0]["pr_run"] == "true"){
								t_authRun=true;
							}
						}
						if(r_rank>=8){
							t_authRun=true;
						}
						main();
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch

            }
            function bbsAssign() {
            	/*for(var j = 0; j < q_bbsCount; j++) {
            		
            	}*/
                _bbsAssign();
            }

            function btnOk() {
            				
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
                
            }

            function bbsSave(as) {
                if(!as['stopdate']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }
            function refresh() {
                _refresh();
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
                font-size: medium;
            }
            input[type="text"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<input class="txt c1"  id="txtNoa.*" type="hidden"  />
                    <input id="txtNoq.*" type="hidden" />
					<td class="td1" align="center" style="width:1%; max-width:20px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td class="td2" align="center" style="width:25%;"><a id='lblStopdate'> </a></td>
					<td class="td3" align="center" style="width:25%;"><a id='lblReindate'> </a></td>
					<!--<td class="td4" align="center" style="width:18%;"><a id='lblAcomp'></a></td>-->
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  /></td>
					<td class="td2"><input id="txtStopdate.*" type="text" class="txt c1" style="width:95%;"/></td>
					<td class="td3"><input id="txtReindate.*" type="text" class="txt c1" style="width:95%;"/></td>
					<!--<td class="td4">
						<input class="txt" id="txtCno.*" type="text" style="width:20%"/>
						<input class="txt" id="txtAcomp.*"type="text" style="width:65%;"/>
						<input id="btnCno.*" type="button" value="." style="width: 1%;" />
					</td>-->
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
