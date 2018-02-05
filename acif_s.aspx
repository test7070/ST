<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			aPop = new Array(
			);
			var q_name = "acif_s";

			$(document).ready(function() {
				main();
			});

			function main() {
				mainSeek();
				q_gf('', q_name);
				$('#txtNoa').focus();
			}

			function q_gfPost() {
				bbmMask = [['txtYeara', r_pic],];
                q_mask(bbmMask);
				q_getFormat();
				q_langShow();
			}

			function q_seekStr() {
				var t_noa = $('#txtNoa').val();
				var t_yeara = $.trim($('#txtYeara').val());
				
				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)+ q_sqlPara2("yeara", t_yeara);
				
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
					<td class='seek' style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /> </td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblYeara'> </a></td>
					<td><input class="txt" id="txtYeara" type="text" style="width:215px; font-size:medium;" />	</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>