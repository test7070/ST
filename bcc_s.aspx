<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = "bcc_s";
            aPop = new Array(['txtNoa', '', 'bcc', 'noa,product', 'txtNoa,txtProduct', 'bcc_b.aspx']);
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
				q_gt('bcctype', '', 0, 0, 0, "bcctype");
                //q_cmbParse("cmbTypea", '@全部,'+q_getPara('bcc.type'));
                $('#txtNoa').focus();
            }
            
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'bcctype':
						var as = _q_appendData("bcctype", "", true);
						if (as[0] != undefined) {
							var t_item = "@全部";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
							q_cmbParse("cmbTypea", t_item);
							if(abbm[q_recno])
								$("#cmbTypea").val(abbm[q_recno].typea);
						}
						break;
                }  /// end switch
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_typea = $('#cmbTypea').val();
				t_product = $.trim($('#txtProduct').val());
                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("typea", t_typea) ;
				if (t_product.length > 0)
                    t_where += " and patindex('%" + t_product + "%',product)>0";               
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
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblType'></a></td>
					<td><select id="cmbTypea" class="txt c1"  style="font-size:medium;width:215px;" ></select></td><!--<input class="txt" id="txtType" type="text" style="width:215px; font-size:medium;" />-->
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblProduct'></a></td>
					<td>
					<input class="txt" id="txtProduct" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
