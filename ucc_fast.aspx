<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">

			var q_name = "ucc";
			
			aPop = new Array(['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);

			$(document).ready(function() {		
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
			});
			
			var based_count=8;
			var b_store=[],b_color=[],b_size=[];
			function q_gfPost() {
				q_getFormat();
                q_langShow();
                q_popAssign();
                q_cur=2;
                
                q_cmbParse("cmbTypea", q_getPara('ucc.typea'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
                
				q_gt('size', "", 0, 0, 0,'size', r_accy);
				q_gt('color', "", 0, 0, 0,'color', r_accy);
				q_gt('store', "", 0, 0, 0,'store', r_accy);
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
				q_gt('uccga', '', 0, 0, 0, "");
				q_gt('uccgb', '', 0, 0, 0, "");
				q_gt('uccgc', '', 0, 0, 0, "");
                
                //事件/////////////////////////////////////////////////////////
				$('#txtSaleprice').keyup(function() {
					var tmp=$('#txtSaleprice').val();
					tmp=tmp.match(/\d{1,10}\.{0,1}\d{0,2}/);
					$('#txtSaleprice').val(tmp);
				});
				$('#txtInprice').keyup(function() {
					var tmp=$('#txtInprice').val();
					tmp=tmp.match(/\d{1,10}\.{0,1}\d{0,2}/);
					$('#txtInprice').val(tmp);
				});
				$('#txtStdmount').keyup(function() {
					var tmp=$('#txtStdmount').val();
					tmp=tmp.match(/\d{1,10}\.{0,1}\d{0,2}/);
					$('#txtStdmount').val(tmp);
				});
				$('#txtUweight').keyup(function() {
					var tmp=$('#txtUweight').val();
					tmp=tmp.match(/\d{1,10}\.{0,1}\d{0,3}/);
					$('#txtUweight').val(tmp);
				});
				$('#txtSafemount').keyup(function() {
					var tmp=$('#txtSafemount').val();
					tmp=tmp.match(/\d{1,10}\.{0,1}\d{0,2}/);
					$('#txtSafemount').val(tmp);
				});
				$('#txtDays').keyup(function() {
					var tmp=$('#txtDays').val();
					tmp=tmp.match(/\d{1,10}/);
					$('#txtDays').val(tmp);
				});
				
				$('#txtNoa').change(function() {
					q_gt('ucc', "where=^^ noa like '"+$('#txtNoa').val()+"%' ^^", 0, 0, 0, "ucc_checknoa");
				});
				
				$('#btnBased').click(function() {
					if(emp($('#txtNoa').val())){
						alert('物品編號沒有輸入!!');
						return;
					}
					if(emp($('#txtProduct').val())){
						alert('物品名稱沒有輸入!!');
						return;
					}
					b_store=[],b_color=[],b_size=[];
					for(var i=0;i<a_color.length;i++){
						if($('#color_chk'+i).prop('checked'))
							b_color.push(a_color[i]);
					}
					if(b_color.length==0){
						alert('顏色尚未選定');
						return;
					}
					
					for(var i=0;i<a_size.length;i++){
						if($('#size_chk'+i).prop('checked'))
							b_size.push(a_size[i]);
					}
					if(b_size.length==0){
						alert('尺寸尚未選定');
						return;
					}
					
					for(var i=0;i<a_store.length;i++){
						if($('#store_chk'+i).prop('checked'))
							b_store.push(a_store[i]);
					}
					if(b_store.length==0){
						alert('倉庫尚未選定');
						return;
					}
					
					var string = "<table id='based_table' style='width:880px;'>";
					string+='<tr id="based_header">';
					string+='<td id="based_store" align="center" style="width:125px; color:black;">倉庫</td>';
					string+='<td id="based_noa" align="center" style="width:140px; color:black;">物品編號</td>';
					string+='<td id="based_product" align="center" style="width:200px; color:black;">物品名稱</td>';
					string+='<td id="based_color" align="center" style="width:100px; color:black;">顏色</td>';
					string+='<td id="based_size" align="center" style="width:100px; color:black;">尺寸</td>';
					string+='<td id="based_mount" align="center" style="width:100px; color:black;">數量</td>';
					string+='</tr>';
					
					based_count=0;
					for(var i=0;i<b_store.length;i++){
						for(var j=0;j<b_color.length;j++){
							for(var k=0;k<b_size.length;k++){
								string+='<tr id="based_tr'+based_count+'">';
								string+='<td id="based_store'+based_count+'" style="text-align: center;">'+b_store[i].store+' <input id="textStoreno'+based_count+'"  type="hidden" value="'+b_store[i].noa+'" /></td>';
								string+='<td id="based_noa'+based_count+'" style="text-align: center;">'+$('#txtNoa').val()+'-'+b_color[j].noa+'-'+b_size[k].noa+' <input id="textNoa'+based_count+'"  type="hidden" value="'+$('#txtNoa').val()+'-'+b_color[j].noa+'-'+b_size[k].noa+'" /></td>';
								string+='<td id="based_product'+based_count+'" style="text-align: center;">'+$('#txtProduct').val()+'</td>';
								string+='<td id="based_color'+based_count+'" style="text-align: center;">'+b_color[j].color+' <input id="textColorno'+based_count+'"  type="hidden" value="'+b_color[j].noa+'" /></td>';
								string+='<td id="based_size'+based_count+'" style="text-align: center;">'+b_size[k].size+' <input id="textSizeno'+based_count+'"  type="hidden" value="'+b_size[k].noa+'" /></td>';
								string+='<td id="based_mount'+based_count+'" style="text-align: center;"><input id="textMount'+based_count+'"  type="text" class="txt num c1" style="width: 100px;"/></td>';
								string+='</tr>';
								based_count++;
							}
						}
					}
					
					string+='</table>';
					$('#based').html(string);
					
					var SeekF= new Array();
					$('#based_table td').children("input:text").each(function() {
						if($(this).attr('disabled')!='disabled')
							SeekF.push($(this).attr('id'));
					});
					
					SeekF.push('btnUccsave');
					$('#based_table td').children("input:text").each(function() {
						$(this).keyup(function() {
							var tmp=$(this).val();
							tmp=tmp.match(/\d{1,10}\.{0,1}\d{0,2}/);
							$(this).val(tmp);
						});
							
						$(this).mousedown(function(e) {
							$(this).focus();
							$(this).select();
						});
							
						$(this).bind('keydown', function(event) {
							keypress_bbm(event, $(this), SeekF, SeekF[$.inArray($(this).attr('id'),SeekF)+1]);	
						});
					});
				});
				
				$('#btnUccsave').click(function() {
					if(b_store.length==0 || b_color.length==0 || b_size.length==0){
						alert('沒有資料可建立!!');
						return;
					}
					
					if(confirm("確定要批次建立?")){
						var t_stk='';
						for(var i=0;i<based_count;i++){
							t_stk=t_stk+(t_stk.length>0?'^^':'');
							t_stk=t_stk+$('#textNoa'+i).val()+'##'+
							$('#textStoreno'+i).val()+'##'+
							$('#textColorno'+i).val()+'##'+
							$('#textSizeno'+i).val()+'##'+
							$('#textMount'+i).val();
						}
						var ucc_tmp='';
						ucc_tmp=	$('#txtNoa').val()+';'+$('#txtProduct').val()+';'+$('#txtEngpro').val()+';'+$('#txtTggno').val()+';'+$('#txtTgg').val()+';'
						+$('#txtSpec').val()+';'+$('#txtUnit').val()+';'+$('#cmbTypea').val()+';'+$('#txtUweight').val()+';'+$('#txtStdmount').val()+';'
						+$('#txtStyle').val()+';'+$('#txtDays').val()+';'+$('#txtSafemount').val()+';'+$('#cmbCoin').val()+';'+$('#txtInprice').val()+';'
						+$('#txtSaleprice').val()+';'+$('#txtArea').val()+';'+$('#cmbTrantype').val()+';'+$('#cmbGroupano').val()+';'+$('#cmbGroupbno').val()+';'
						+$('#cmbGroupcno').val()+';'+$('#txtRc2acc').val()+';'+$('#txtVccacc').val()+';'+$('#txtMemo').val();
						
						q_func('qtxt.query.ucc_pos_fast', 'ucc.txt,ucc_pos_fast,'+ucc_tmp+';'+t_stk+';'+r_name+';'+q_date());
					}
				});
            }
            
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			var init_color=false,init_size=false,init_store=false,init_based=false;
			var a_color=[],a_size=[],a_store=[];
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno])
							$('#cmbCoin').val(abbm[q_recno].coin);
						
						break;
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						if (as[0] != undefined) {
							var t_item = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
							q_cmbParse("cmbGroupano", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupano").val(abbm[q_recno].groupano);
							}
						}
						break;
					case 'uccgb':
						//中類
						var as = _q_appendData("uccgb", "", true);
						if (as[0] != undefined) {
							var t_item = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
							q_cmbParse("cmbGroupbno", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupbno").val(abbm[q_recno].groupbno);
							}
						}
						break;
					case 'uccgc':
						//小類
						var as = _q_appendData("uccgc", "", true);
						if (as[0] != undefined) {
							var t_item = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
							q_cmbParse("cmbGroupcno", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupcno").val(abbm[q_recno].groupcno);
							}
						}
						break;
					/////////////////////////////////////////////////////////////////////////////////////////
					case 'ucc_checknoa':
						var as = _q_appendData("ucc", "", true);
						if (as[0] != undefined) {
							alert("物品編號已存!!");
							$('#txtNoa').val('');
							$('#txtNoa').focus();
						}
						break;
					/////////////////////////////////////////////////////////////////////////////////////////
					case 'color':
						a_color = _q_appendData("color", "", true);
						var string = "<table id='color_table' style='width:183px;'>";
	                    string+='<tr id="color_header">';
	                    string+='<td id="color_chk" align="center" style="width:20px; color:black;">選</td>';
	                    string+='<td id="color_noa" align="center" style="width:45px; color:black;">編號</td>';
	                    string+='<td id="color_color" align="center" style="width:60px; color:black;">顏色</td>';
	                    string+='</tr>';
	                    for(var i=0;i<a_color.length;i++){
	                    	string+='<tr id="color_tr'+i+'">';
	                        string+='<td style="text-align: center;"><input id="color_chk'+i+'" class="color_chk" type="checkbox"/></td>';
	                        string+='<td id="color_noa'+i+'" style="text-align: center;">'+a_color[i].noa+'</td>';
	                        string+='<td id="color_color'+i+'" style="text-align: center;">'+a_color[i].color+'</td>';
	                        string+='</tr>';
	                    }
	                    string+='</table>';
                    	$('#color').append(string);
                    	init_color=true;
						break;
					case 'size':
						a_size = _q_appendData("size", "", true);
						var string = "<table id='size_table' style='width:183px;'>";
	                    string+='<tr id="size_header">';
	                    string+='<td id="size_chk" align="center" style="width:20px; color:black;">選</td>';
	                    string+='<td id="size_noa" align="center" style="width:45px; color:black;">編號</td>';
	                    string+='<td id="size_size" align="center" style="width:60px; color:black;">尺寸</td>';
	                    string+='</tr>';
	                    for(var i=0;i<a_size.length;i++){
	                    	string+='<tr id="size_tr'+i+'">';
	                        string+='<td style="text-align: center;"><input id="size_chk'+i+'" class="size_chk" type="checkbox"/></td>';
	                        string+='<td id="size_noa'+i+'" style="text-align: center;">'+a_size[i].noa+'</td>';
	                        string+='<td id="size_size'+i+'" style="text-align: center;">'+a_size[i].size+'</td>';
	                        string+='</tr>';
	                    }
	                    string+='</table>';
                    	$('#size').append(string);
                    	init_size=true;
						break;
					case 'store':
						a_store = _q_appendData("store", "", true);
						var string = "<table id='store_table' style='width:183px;'>";
	                    string+='<tr id="store_header">';
	                    string+='<td id="store_chk" align="center" style="width:20px; color:black;">選</td>';
	                    string+='<td id="store_noa" align="center" style="width:45px; color:black;">編號</td>';
	                    string+='<td id="store_store" align="center" style="width:60px; color:black;">倉庫</td>';
	                    string+='</tr>';
	                    for(var i=0;i<a_store.length;i++){
	                    	string+='<tr id="store_tr'+i+'">';
	                        string+='<td style="text-align: center;"><input id="store_chk'+i+'" class="store_chk" type="checkbox"/></td>';
	                        string+='<td id="store_noa'+i+'" style="text-align: center;">'+a_store[i].noa+'</td>';
	                        string+='<td id="store_store'+i+'" style="text-align: center;">'+a_store[i].store+'</td>';
	                        string+='</tr>';
	                    }
	                    string+='</table>';
                    	$('#store').append(string);
                    	init_store=true;
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if(init_color && init_size && init_store && !init_based){
					init_based=true;
					var string = "<table id='based_table' style='width:880px;'>";
					string+='<tr id="based_header">';
					string+='<td id="based_store" align="center" style="width:125px; color:black;">倉庫</td>';
					string+='<td id="based_noa" align="center" style="width:140px; color:black;">物品編號</td>';
					string+='<td id="based_product" align="center" style="width:200px; color:black;">物品名稱</td>';
					string+='<td id="based_color" align="center" style="width:100px; color:black;">顏色</td>';
					string+='<td id="based_size" align="center" style="width:100px; color:black;">尺寸</td>';
					string+='<td id="based_mount" align="center" style="width:100px; color:black;">數量</td>';
					string+='</tr>';
					for(var i=0;i<based_count;i++){
						string+='<tr id="based_tr'+i+'">';
	                    string+='<td id="based_store'+i+'" style="text-align: center;"></td>';
						string+='<td id="based_noa'+i+'" style="text-align: center;"></td>';
						string+='<td id="based_product'+i+'" style="text-align: center;"></td>';
						string+='<td id="based_color'+i+'" style="text-align: center;"></td>';
						string+='<td id="based_size'+i+'" style="text-align: center;"></td>';
						string+='<td id="based_mount'+i+'" style="text-align: center;"></td>';
						string+='</tr>';
					}
					string+='</table>';
					$('#based').append(string);
				}
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.ucc_pos_fast':
                		alert("批次建立完成!!");
                	break;
                }
			}
			
		</script>
		<style type="text/css">
			.dbbm {
				float: left;
				width: 98%;
				margin: -1px;
				border: 1px black solid;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 9%;
			}
			.tbbm .tdZ {
				width: 2%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			
			#color_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #color_table tr {
                height: 30px;
            }
            #color_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: pink;
                color: blue;
            }
            
            #size_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #size_table tr {
                height: 30px;
            }
            #size_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: lightblue;
                color: blue;
            }
            
            #store_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #store_table tr {
                height: 30px;
            }
            #store_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: antiquewhite;
                color: blue;
            }
            
            #based_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #based_table tr {
                height: 30px;
            }
            #based_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: wheat;
                color: blue;
            }
		</style>
	</head>
	<body>
		<div id='q_menu'> </div>
		<div id='q_acDiv'> </div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>
		<input type='button' id='btnBased' style='font-size:16px;' value='套用'/>
		<input type='button' id='btnUccsave' style='font-size:16px;' value='批次建立'/>
		<P> </P>
		<table style="width:1100px;">
			<tr>
				<td valign="top">
					<div id="base" style="float:left;width:900px;">
						<table class="tbbm"	id="tbbm" border="0" cellpadding='2' cellspacing='0'>
							<tr>
								<td><a id='lblNoa' class="lbl"> </a></td>
								<td colspan="5"><input type="text" id="txtNoa" class="txt c3"/></td>
							</tr>
							<tr> 
								<td><a id='lblProduct' class="lbl"> </a></td>
								<td colspan='5'><input	type="text" id="txtProduct" class="txt c1"/></td>
							</tr>
							<tr>
								<td><a id='lblEngpro' class="lbl"> </a></td>
								<td colspan='5' ><input	type="text" id="txtEngpro" class="txt c1"/></td>
							</tr>
							<tr>
								<td><a id='lblTggno' class="lbl btn"> </a></td>
								<td><input id="txtTggno" type="text" class="txt c1"/></td>
								<td colspan='4'><input id="txtTgg"	type="text" style="width: 97%;"/></td>
							</tr>
							<tr>
								<td><a id='lblSpec' class="lbl"> </a></td>
								<td colspan='3'><input	type="text" id="txtSpec"	class="txt c1"/></td>
								<td><a id='lblUnit' class="lbl"> </a></td>
								<td><input	type="text" id="txtUnit" class="txt c1"/></td>
							</tr>
							<tr>
								<td><a id='lblType' class="lbl"> </a></td>
								<td><select id="cmbTypea" class="txt c1"> </select></td>
								<td><a id='lblUweight' class="lbl"> </a></td>
								<td><input	type="text" id="txtUweight"	class="txt num c1"/></td>
								<td><a id='lblStdmount' class="lbl"> </a></td>
								<td><input	type="text" id="txtStdmount" class="txt num c1"/></td>
							</tr>
							<tr>
								<td><a id='lblStyle' class="lbl"> </a></td>
								<td><input	type="text" id="txtStyle" class="txt c1"/></td>
								<td><a id='lblDays' class="lbl"> </a></td>
								<td><input	type="text" id="txtDays" class="txt c1 num"/></td>
								<td><a id='lblSafemount' class="lbl"> </a></td>
								<td><input	type="text" id="txtSafemount" class="txt num c1"/></td>
							</tr>
							<tr>
								<td><a id='lblCoin' class="lbl"> </a></td>
								<td><select id="cmbCoin" class="txt c1"> </select></td>
								<td><a id='lblInprice' class="lbl"> </a></td>
								<td><input	type="text" id="txtInprice" class="txt num c1"/></td>
								<td><a id='lblSaleprice' class="lbl"> </a></td>
								<td><input	type="text" id="txtSaleprice"	class="txt num c1"/></td>
							</tr>
							<tr>
								<td><a id='lblArea' class="lbl"> </a></td>
								<td><input	type="text" id="txtArea"	class="txt c1"/></td>
								<td><a id='lblTrantype' class="lbl"> </a></td>
								<td><select id="cmbTrantype" class="txt c1"> </select></td>
								
							</tr>
							<tr>
								<td><a id='lblGroupano' class="lbl"> </a></td>
								<td colspan="2"><select id="cmbGroupano" class="txt c1"> </select></td>
								<td><a id='lblGroupbno' class="lbl"> </a></td>
								<td colspan="2"><select id="cmbGroupbno" class="txt c1"> </select></td>
							</tr>
							<tr>
								<td><a id='lblGroupcno' class="lbl"> </a></td>
								<td colspan="2"><select id="cmbGroupcno" class="txt c1"> </select></td>
							</tr>
							<tr>
								<td><a id='lblRc2acc' class="lbl"> </a></td>
								<td><input	type="text" id="txtRc2acc" class="txt c1"/></td>
								<td> </td>
								<td><a id='lblVccacc' class="lbl"> </a></td>
								<td><input	type="text" id="txtVccacc" class="txt c1"/></td>
								<td> </td>
							</tr>
							<tr>
								<td><a id='lblMemo' class="lbl"> </a></td>
								<td colspan='5'> 
									<input type="text" id="txtMemo" class="txt c1"/>
									<input type="hidden" id="txtImages" class="txt c1"/>
								</td>
							</tr>
						</table>
					</div> 
					<div id="based" style="float:left;width:900px;height:300px;overflow-y: scroll;"> </div>
				</td>
				<td valign="top">
					<div id="color" style="float:left;width:200px;height:250px;overflow-y: scroll;"> </div>
					<div id="size" style="float:left;width:200px;height:250px;overflow-y: scroll;"> </div>
					<div id="store" style="float:left;width:200px;height:250px;overflow-y: scroll;"> </div> 
				</td>
			</tr>
		</table>
	</body>
</html>