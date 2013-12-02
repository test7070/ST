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
			var q_readonly = ['textProduct','textCust'];
			var i, s1;
			aPop = new Array(
				['textProductno', '', 'ucc', 'noa,product', 'textProductno,textProduct', 'ucc_b.aspx'],
				['textCustno', '', 'cust', 'noa,comp', 'textCustno,textCust', 'cust_b.aspx']
			);
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
				var w = window.parent;
				w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color','red').css('font-size','initial');
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				$('#btnToSeek').click(function(){
					SeekStr();
				});
			}
			var SeekF = new Array();
			function mainPost(){
				q_getFormat();
				$('#textProductno').focus(function(){
					q_cur=1;
				}).blur(function(){
					q_cur=0;
				});
				$('#textCustno').focus(function(){
					q_cur=1;
				}).blur(function(){
					q_cur=0;
				});
				$('#seekTable td').children("input:text").each(function () {
					SeekF.push($(this).attr('id'));
				});
				SeekF.push('btnToSeek');
				$('#seekTable td').children("input:text").each(function () {
					$(this).bind('keydown', function (event) {
						keypress_bbm(event, $(this), SeekF, 'btnToSeek'); 
					});
				});
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
					case 'cubs':
						var as = _q_appendData("cubs", "", true);
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
					case 'cub':
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
					case 'vcc':
							for(var i = 0;i < abbs.length;i++){
								for(var k= 0;k<w.abbsNow.length;k++){
									if((abbs[i].noa == w.abbsNow[k].ordeno) && (abbs[i].no2 == w.abbsNow[k].no2)){
										abbs[i].notv = dec(abbs[i].notv) + dec(w.abbsNow[k].mount);
									}
								}
							}
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
						if (abbs[i].mount <= 0 || abbs[i].weight <= 0 || abbs[i].notv <=0) {
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
				size_change();
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
					case 'cub':
						var distinctArray = new Array;
						var inStr = '';
						for(var i=0;i<abbs.length;i++){distinctArray.push(abbs[i].noa+abbs[i].no2);}
						distinctArray = distinct(distinctArray);
						for(var i=0;i<distinctArray.length;i++){
							inStr += "'"+distinctArray[i]+"',";
						}
						inStr = inStr.substring(0,inStr.length-1);
						var t_noa = trim(w.$('#txtNoa').val());
						var t_where = "where=^^ 1=1 ";
						if(trim(inStr).length > 0){
							t_where += " and (ordeno+no2)in("+inStr+") ";
						}
						if(w.q_name == 'cut' || w.q_name == 'cub'){
							t_where += "and noa !='"+t_noa+"'";
						}
						t_where += " ^^";						
						q_gt('cubs', t_where, 0, 0, 0, "", r_accy);
						break;
					default:
						DetailValue();
						break;
				}
			}
			function seekData(seekStr){
				var newUrl = location.href.split(';');
				var newUrlStr = '';
				newUrl[3] = seekStr;
				for(var i = 0;i<newUrl.length;i++){
					newUrlStr += newUrl[i];
					if(i < newUrl.length-1)
						newUrlStr += ';';
				}
				location.href = newUrlStr;
			}
	
			function SeekStr(){
				t_ordeno = trim($('#textOrdeno').val());
				t_productno = trim($('#textProductno').val());
				t_custno = trim($('#textCustno').val());
				t_class = trim($('#textClass').val());
				t_radius = trim($('#textRadius').val());
				t_dime = trim($('#textDime').val());
				t_width = trim($('#textWidth').val());
				t_lengthb = trim($('#textLengthb').val());
				var t_where = " 1=1 " + q_sqlPara2("ordeno", t_ordeno)
									 + q_sqlPara2("productno", t_productno)
									 + q_sqlPara2("custno", t_custno)
									 + q_sqlPara2("class", t_class)
									 + q_sqlPara2("radius", t_radius)
									 + q_sqlPara2("dime", t_dime)
									 + q_sqlPara2("width", t_width)
									 + q_sqlPara2("lengthb", t_lengthb)
									 + q_sqlPara2("enda", "0")
									 + q_sqlPara2("kind", 'B2');
				seekData(t_where);
			}
			
			function distinct(arr1){
				var uniArray = [];
				for(var i=0;i<arr1.length;i++){
					var val = arr1[i];
					if($.inArray(val, uniArray)===-1){
						uniArray.push(val);
					}
				}
				return uniArray;
			}
			function size_change() {
				$('*[id="sizeTd"]').css('width','280px');
				for (var j = 0; j < q_bbsCount; j++) {
					$('#textSize1_' + j).show();
					$('#textSize2_' + j).show();
					$('#textSize3_' + j).show();
					$('#textSize4_' + j).show();
					$('#x1_' + j).show();
					$('#x2_' + j).show();
					$('#x3_' + j).show();
					$('#txtUno_'+j).css('width','280px');
					$('#textSize1_' + j).val($('#txtRadius_' + j).val());
					$('#textSize2_' + j).val($('#txtWidth_' + j).val());
					$('#textSize3_' + j).val($('#txtDime_' + j).val());
					$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
				}
			}

		</script>
		<style type="text/css">
		#seekForm{
			margin-left: auto;
			margin-right: auto;
			width:950px;
		}
		#seekTable{
			padding: 0px;
			border: 1px white double;
			border-spacing: 0;
			border-collapse: collapse;
			font-size: medium;
			color: blue;
			background: #cad3ff;
			width: 100%;
		}
		#seekTable tr {
			height: 35px;
		}
		.txt.c1{
			width:98%;
		}
		.txt.c2{
			width:95%;
		}
		.lbl{
			float:right;
		}
		.num{
			text-align:right;
		}
		input[type="button"] {	 
			font-size: medium;
		}
		#seekTable td{
			width:4%;
		}

		.StrX{
			margin-right:-2px;
			margin-left:-2px;
		}
		#seekTable .lbl{
			float:right;
		}
		#seekTable span{
			margin-right: 5px;
		}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:27px;">
					</td>
					<td align="center" style="width:3%;"> </td>
					<td align="center" style="width:12%;"><a id='lblProductno'></a>/<a id='lblProduct'></a></td>
					<td align="center" id="sizeTd" ><a id='lblSize'></a></td>
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
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:White; background:#003366;display:none;' >
					<td align="center">
					</td>
					<td align="center"> </td>
					<td align="center"><a id='lblProductno'></a>/<a id='lblProduct'></a></td>
					<td align="center" id="sizeTd" ><a id='lblUno'></a></td>
					<td align="center"><a id='lblSpec'></a></td>
					<td align="center"><a id='lblMount'></a></td>
					<td align="center"><a id='lblWeight'></a></td>
					<td align="center"><a id='lblNotv'></a></td>
					<td align="center"><a id='lblNoa'></a></td>
					<td align="center"><a id='lblCust'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:27px;" align="center">
						<input name="sel" id="radSel.*" type="radio" />
					</td>
					<td style="width:3%;">
						<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
					</td>
					<td style="width:12%;">
						<input class="txt"  id="txtProductno.*" type="text" style="width:98%;" />
						<input class="txt" id="txtProduct.*" type="text" style="width:98%;" />
					</td>
					<td id="sizeTd">
						<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >
							x
						</div>
						<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
						<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">
							x
						</div>
						<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">
							x
						</div>
						<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="text" style="display:none;"/>
						<input id="txtWidth.*" type="text" style="display:none;"/>
						<input id="txtDime.*" type="text" style="display:none;"/>
						<input id="txtLengthb.*" type="text" style="display:none;"/>
						<input class="txt" id="txtSize.*" type="text"  style="width:98%;" />
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
		<div id="seekForm">
			<table id="seekTable" border="0" cellpadding='0' cellspacing='0'>
				<tr>
					<td><span class="lbl">品名編號</span></td>
					<td colspan="3">
						<input id="textProductno" type="text" style="width:25%"/>
						<input id="textProduct" type="text" style="width:73%"/>
					</td>
					<td><span class="lbl">客戶</span></td>
					<td colspan="3">
						<input id="textCustno" type="text" style="width:25%"/>
						<input id="textCust" type="text" style="width:73%"/>
					</td>
				</tr>
				<tr>
					<td><span class="lbl">等級</span></td>
					<td><input id="textClass" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">短徑</span></td>
					<td><input id="textRadius" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">厚度</span></td>
					<td><input id="textDime" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">寬度</span></td>
					<td><input id="textWidth" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">長度</span></td>
					<td><input id="textLengthb" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">重量</span></td>
					<td><input id="textWeight" type="text" class="txt c1 num"/></td>
				</tr>
				<tr>
					<td colspan="12" align="center">
						<input type="button" id="btnToSeek" value="查詢">
					</td>
				</tr>
			</table>
			<div id="q_acDiv" style="display: none;"><div> </div></div>
		</div>
	</body>
</html>
