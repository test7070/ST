<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'view_ordes', t_bbsTag = 'tbbs', t_content = " field=accy,noa,no2,productno,product,sizea,unit,price,weight,memo,mount,total,datea,cancel,type,custno,indate,enda,odate,spec,no3,quatno,size,dime,width,lengthb,c1,notv,style,uno,source,classa,issale,slit,iscut,theory,apv,radius,gweight,class,comp,cust,mechno,mech,tdmount,kind,amemo,acoin,afloata", afilter = [], bbsKey = ['noa'], as;
			//, t_where = '';
			var t_sqlname = 'ordests_load';
			t_postname = q_name;
			brwCount2 = 0;
			brwCount = -1;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
			$(document).ready(function() {
				if (!q_paraChk())
					return;
				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function bbsAssign() {
				_bbsAssign();
				for (var j = 0; j < q_bbsCount; j++) {
				}
			}

			function q_gtPost(t_name) {
				switch(t_name){
					case 'ordes2cut':
						var as = _q_appendData("ordes2cut", "", true);
						DetailValue(as);
						break;
				}
			}

			function DetailValue(gtArray){
				var w = window.parent;
				switch(w.q_name){
					case 'cut':
						if(gtArray.length > 0){
							for(var i = 0;i < abbs.length;i++){
								for(var k= 0;k<gtArray.length;k++){
									if((abbs[i].noa == gtArray[k].ordeno) && (abbs[i].no2 == gtArray[k].no2)){
										abbs[i].mount = dec(abbs[i].mount) - dec(gtArray[k].mount);
										abbs[i].weight = dec(abbs[i].weight) - dec(gtArray[k].weight);
									}
								}
							}
						}
						break;
					default:
						break;
				}
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtOrdeno_' + j).val() == abbs[i].noa && w.$('#txtNo2_' + j).val() == abbs[i].no2) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
						if (abbs[i].mount <= 0 || abbs[i].weight <= 0) {
							abbs.splice(i, 1);
							i--;
						}

					}
					maxAbbsCount = abbs.length;
				}
				_refresh();
				for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtProductno_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
			}

			var maxAbbsCount = 0;
			function refresh() {
				//_refresh();
				var w = window.parent;
				switch(w.q_name){
					case 'cut':
						var distinctArray = new Array;
						var inStr = '';
						for(var i=0;i<abbs.length;i++){distinctArray.push(abbs[i].noa);}
						distinctArray = distinct(distinctArray);
						for(var i=0;i<distinctArray.length;i++){
							inStr += "'"+distinctArray[i]+"',";
						}
						inStr = inStr.substring(0,inStr.length-1);
						var t_noa = trim(w.$('#txtNoa').val());
						var t_where = "where=^^ 1=1 ";
						if(trim(inStr).length > 0){
							t_where += " and ordeno in("+inStr+") ";
						}
						if(w.q_name == 'cut'){
							t_where += "and noa !='"+t_noa+"'";
						}
						t_where += " ^^";						
						q_gt('ordes2cut', t_where, 0, 0, 0, "", r_accy);
						break;
					default:
						DetailValue();
						break;
				}
			}
			
			function distinct(arr1) {
				for (var i = 0; i < arr1.length; i++) {
					if ((arr1.indexOf(arr1[i]) != arr1.lastIndexOf(arr1[i])) || arr1[i] == '') {
						arr1.splice(i, 1);
						i--;
					}
				}
				return arr1;
			}

		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;">
						<input type="checkbox" id="checkAllCheckbox"/>
					</td>
					<td align="center" style="width:3%;"> </td>
					<td align="center" style="width:12%;"><a id='lblProductno'></a>/<a id='lblProduct'></a></td>
					<td align="center" style="width:23%;"><a id='lblUno'></a>/<a id='lblSize'></a></td>
					<td align="center" style="width:6%;"><a id='lblSpec'></a></td>
					<td align="center" style="width:6%;"><a id='lblMount'></a></td>
					<td align="center" style="width:8%;"><a id='lblWeight'></a></td>
					<td align="center" style="width:8%;"><a id='lblNotv'></a></td>
					<td align="center" style="width:11%;"><a id='lblNoa'></a></td>
					<td align="center" style="width:8%;"><a id='lblCust'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
			</table>
		</div>
		<div  id="dbbs" style="overflow: scroll;height:550px;" >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;display:none;' >
					<td align="center">
					<input type="checkbox" id="checkAllCheckbox"/>
					</td>
					<td align="center"> </td>
					<td align="center"><a id='lblProductno'></a>/<a id='lblProduct'></a></td>
					<td align="center"><a id='lblUno'></a></td>
					<td align="center"><a id='lblSpec'></a></td>
					<td align="center"><a id='lblMount'></a></td>
					<td align="center"><a id='lblWeight'></a></td>
					<td align="center"><a id='lblNotv'></a></td>
					<td align="center"><a id='lblNoa'></a></td>
					<td align="center"><a id='lblCust'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;" align="center">
						<input id="chkSel.*" type="checkbox"/>
					</td>
					<td style="width:3%;">
						<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
					</td>
					<td style="width:12%;">
						<input class="txt"  id="txtProductno.*" type="text" style="width:98%;" />
						<input class="txt" id="txtProduct.*" type="text" style="width:98%;" />
					</td>
					<td style="width:23%;">
						<input class="txt" id="txtUno.*" type="text"  style="width:98%;" />
						<input class="txt" id="txtRadius.*" type="text"  style="width:20%;text-align:right;" />
						x
						<input class="txt" id="txtWidth.*" type="text"  style="width:20%;text-align:right;" />
						x
						<input class="txt" id="txtDime.*" type="text"  style="width:20%;text-align:right;" />
						x
						<input class="txt" id="txtLengthb.*" type="text"  style="width:20%;text-align:right;" />
					</td>
					<td style="width:6%;">
						<input class="txt" id="txtSpec.*" type="text"  style="width:94%;text-align:center;" />
					</td>
					<td style="width:6%;">
						<input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/>
					</td>
					<td style="width:8%;">
						<input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/>
					</td>
					<td style="width:8%;">
						<input class="txt" id="txtNotv.*" type="text" style="width:96%; text-align:right;"/>
					</td>
					<td style="width:11%;">
						<input class="txt" id="txtNoa.*" type="text" style="width:98%;"/>
						<input class="txt" id="txtNo2.*" type="text"  style="width:98%;"/>
					</td>
					<td style="width:8%;">
						<input class="txt" id="txtCust.*" type="text" style="width:96%; text-align:left;"/>
					</td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:98%;"/>
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>
