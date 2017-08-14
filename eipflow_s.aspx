<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script type="text/javascript">
            var q_name = "eipflow_s";

            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
                q_gt('eipform', '', 0, 0, 0, "");
                q_cmbParse("cmbIssign", '@全部,1@已送簽,2@未送簽');
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'eipform':
                        var as = _q_appendData("eipform", "", true);
                        if (as[0] != undefined) {
                            var t_item = "@全部";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].formname;
                            }
                            q_cmbParse("cmbEpifomno", t_item);
                        }
                        break;
                }
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_issign = $('#cmbIssign').val();
                t_epifomno = $('#cmbEpifomno').val();

                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("epifomno", t_epifomno);
                if (t_issign == '1')
                    t_where = t_where + " and isnull(issign,0)=1 ";
                if (t_issign == '1')
                    t_where = t_where + " and isnull(issign,0)=0 ";
                    
				if (r_rank < 8){
					t_where = t_where + " and sssno='" + r_userno + "' ";
                }

                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblIssign'> </a></td>
					<td><select id="cmbIssign" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblEpifomno'> </a></td>
					<td><select id="cmbEpifomno" style="width:215px; font-size:medium;" > </select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
