<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		    var q_name = 'view_ordcs', t_bbsTag = 'tbbs', t_content = " field=productno,product,spec,size,dime,width,lengthb,radius,mount,weight,noa,no2,price,total,theory,memo,notv,uno,class,style,unit,unit2,scolor,ucolor  order=odate ", afilter = [], bbsKey = ['noa', 'no2'], t_count = 0, as;
		    var t_sqlname = 'ordcs_load2'; t_postname = q_name;
		    var isBott = false;  /// 是否已按過 最後一頁
		    var txtfield = [], afield, t_data, t_htm;
		    var i, s1;
			var bbsNum = [['txtCnt', 2, 0, 1]];
			var q_readonlys = ['txtProductno', 'txtProduct', 'txtSpec','txtRadius','txtWidth','txtDime','txtLengthb','txtMount','txtWeight','txtPrice','txtNoa','txtNo2','txtMemo'];
		    brwCount=-1;
			brwCount2 = 0;
			
			function Spec() {};
            Spec.prototype = {};
			t_spec = new Spec();
			
		    $(document).ready(function () {
		        main();
		        setTimeout('parent.$.fn.colorbox.resize({innerHeight : "750px"})', 300);
		    });
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
		    		
		    function main() {
		        if (dataErr)  /// 載入資料錯誤
		        {
		            dataErr = false;
		            return;
		        }
		        
				q_gt('spec', '', 0, 0, 0,'');
    			
		        mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
		        
		    			
				var w = window.parent;
				w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color','red').css('font-size','initial');
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				if(q_getPara('sys.project').toUpperCase()=='PK'){
					$('.pk').show();
				}
		    }

		    function bbsAssign() { 
		    	/*for(var i=0;i<Object.keys(t_spec).length;i++){
		    		console.log(Object.keys(t_spec)[i]+':'+t_spec[Object.keys(t_spec)[i]]);
				}*/
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					$('.txtSpec').hide();
		        	$('.combSpec').show();
		        }
				for (var j = 0; j < q_bbsCount; j++) {
					//console.log(Object.keys(t_spec).length);
					for(var i=0;i<Object.keys(t_spec).length;i++){
						console.log('#combSpec_'+j);
						console.log('<option value="'+Object.keys(t_spec)[i]+'">'+t_spec[Object.keys(t_spec)[i]]+'</option>');
						$('#combSpec_'+j).append('<option value="'+Object.keys(t_spec)[i]+'">'+t_spec[Object.keys(t_spec)[i]]+'</option>');
					}
					$('#combSpec_'+j).val($('#txtSpec_'+j).val());
					$('#txtCnt_'+j).change(function(){
						var n = $(this).attr('id').replace(/.*_([0-9]+)/,'$1');
						var thisVal = dec($(this).val());
						if(thisVal > 0){
							$('#chkSel_'+n).attr('checked',true);
						}else{
							$('#chkSel_'+n).attr('checked',false);
						}
					});
				}
				_bbsAssign();
				if(q_getPara('sys.project').toUpperCase()=='PK'){
					$('.pk').show();
				}
		    }
		
		    function q_gtPost(t_name) { 
		    	switch(t_name){
		    		case 'spec':
						var as = _q_appendData("spec", "", true);
						for ( i = 0; i < as.length; i++) {
							t_spec[as[i].noa]=as[i].product;
						}
		        		break;
		    		case 'view_rc2s':
		    			var as = _q_appendData("view_rc2s", "", true);
		    			for(var k=0;k<as.length;k++){
		    				for(var i = 0;i<abbs.length;i++){
		    					if(as[k].ordeno==abbs[i].noa && as[k].no2==abbs[i].no2){
		    						abbs[i].mount = dec(abbs[i].mount)-dec(as[k].mount);
		    						abbs[i].weight = dec(abbs[i].weight)-dec(as[k].weight);
		    					}
		    				}
		    			}
				        for(var i = 0;i<abbs.length;i++){
				        	if(q_getPara('sys.project').toUpperCase()=='RK'  || q_getPara('sys.project').toUpperCase()=='PK' ){
				        		if (abbs[i].mount <= 0 && abbs[i].weight <= 0) {
									abbs.splice(i, 1);
									i--;
								}	
				        	}else{
				        		if (abbs[i].mount <= 0 || abbs[i].weight <= 0) {
									abbs.splice(i, 1);
									i--;
								}
				        	}
				        }
				        _refresh();
						$('#checkAllCheckbox').click(function(){
							$('input[type=checkbox][id^=chkSel]').each(function(){
								var t_id = $(this).attr('id').split('_')[1];
								if(!emp($('#txtProductno_' + t_id).val()))
									$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
							});
						});
						q_bbsCount = abbs.length;
						if (q_bbsCount == 0) q_bbsCount = 1;
		   				for(var i=0;i<q_bbsCount;i++){
		   					if($.trim($('#txtNoa_'+i).val()).length > 0)
								$('#txtCnt_'+i).val(1).removeAttr('readonly').css('color','black').css('background','white');
						}
				        size_change();
		    			break;
		    	}
		    }
			var maxAbbsCount = 0;
		    function refresh() {
				var distinctArray = new Array;
				var inStr = '';
				for(var i=0;i<abbs.length;i++){distinctArray.push(abbs[i].noa);}
				distinctArray = distinct(distinctArray);
				for(var i=0;i<distinctArray.length;i++){
					inStr += "'"+distinctArray[i]+"',";
				}
				var t_where = '';
				inStr = inStr.substring(0,inStr.length-1);
				if(trim(inStr)!=''){
					t_where = "where=^^ ordeno in("+inStr+") ^^";
					q_gt('view_rc2s', t_where , 0, 0, 0, "",r_accy);
				}else{
					_refresh();
					size_change();
				}
		    }
		    
		    function size_change () {
		    	var w = window.parent;
		    	var t_kind = (w.$('#cmbKind')?trim(w.$('#cmbKind').val()):'');
		    	t_kind = t_kind.substring(0,1);
				if(t_kind == 'B'){
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					for (var j = 0; j < q_bbsCount ; j++) {
						$('#txtSize4_'+j).removeAttr('hidden');
						$('#x3_'+j).removeAttr('hidden');
						$('*[id="FixedSize"').css('width','297px');
						q_tr('txtSize1_'+ j ,q_float('txtRadius_'+j));
						q_tr('txtSize2_'+ j ,q_float('txtWidth_'+j));
						q_tr('txtSize3_'+ j ,q_float('txtDime_'+j));
						q_tr('txtSize4_'+ j ,q_float('txtLengthb_'+j));
					}
				}else{
					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					for (var j = 0; j < q_bbsCount ; j++) {
						$('#txtSize4_'+j).attr('hidden', 'true');
						$('#x3_'+j).attr('hidden', 'true');
						$('*[id="FixedSize"').css('width','222px');
						q_tr('txtSize1_'+ j ,q_float('txtDime_'+j));
						q_tr('txtSize2_'+ j ,q_float('txtWidth_'+j));
						q_tr('txtSize3_'+ j ,q_float('txtLengthb_'+j));
						$('#txtSize4_'+j).val(0);
						$('#txtRadius_'+j).val(0);
					}
				}
			}
		</script>
		<style type="text/css">
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c8 {
				float:left;
				width: 65px;
			}
			.txt.num {
				text-align: right;
			}
			input[type="text"],input[type="button"] {     
				font-size: medium;
			}
			.dbbs .tbbs{
				margin:0;
				padding:2px;
				border:2px lightgrey double;
				border-spacing:1px;
				border-collapse:collapse;
				font-size:medium;
				color:blue;
				background:#cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr{
				height:35px;
			}
			.dbbs .tbbs tr td{
				text-align:center;
				border:2px lightgrey double;
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
					<td align="center" style="width:6%;"><a id='lblProductno_st'></a></td>
					<td align="center" style="width:8%;"><a id='lblProduct'></a></td>
					<td align="center" style="width:4%;display:none;" class="pk">規範<BR>國別</td>
					<td align="center" style="width:8%;"><a id='lblSpec'></a></td>
					<td align="center" id='FixedSize'><a id='lblSize_help'> </a><BR><a id='lblSize'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMount'></a></td>
					<td align="center" class="pk" style="width:4%;display:none;"><a>數量單位</a></td>
					<td align="center" style="width:7%;"><a id='lblWeight'></a></td>
					<td align="center" style="width:4%;"><a>單位</a></td>
					<td align="center" style="width:7%;display:none;"><a id='lblPrice'></a></td>
					<td align="center" style="width:8%;"><a id='lblInmount_text'></a></td>
					<td align="center" style="width:15%;"><a id='lblNoa'></a><br><a id='lblMemo'></a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:550px;" >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'>
				<tr style='color:White; background:#003366;display:none;' >
					<td align="center" style="width:1%;"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:6%;"><a id='lblProductno_st'></a></td>
					<td align="center" style="width:8%;"><a id='lblProduct'></a></td>
					<td align="center" style="width:4%;display:none;" class="pk">規範<BR>國別</td>
					<td align="center" style="width:8%;"><a id='lblSpec'></a></td>
					<td align="center" id='Size'><a id='lblSize_help'> </a><BR><a id='lblSize'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMount'></a></td>
					<td align="center" class="pk" style="width:4%;display:none;"><a>數量單位</a></td>
					<td align="center" style="width:7%;"><a id='lblWeight'></a></td>
					<td align="center" style="width:4%;"><a>單位</a></td>
					<td align="center" style="width:7%;display:none;" class="pk"><a id='lblPrice'></a></td>
					<td align="center" style="width:8%;"><a id='lblInmount_text'></a></td>
					<td align="center" style="width:15%;"><a id='lblNoa'></a><br><a id='lblMemo'></a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:1%;" align="center"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:6%;"><input class="txt c1"  id="txtProductno.*" type="text" /></td>
					<td style="width:8%;"><input class="txt c1" id="txtProduct.*" type="text"/></td>
					<td style="width:4%;display:none;" class="pk">
                        <input id="txtUcolor.*" type="text" style="width:95%;"/>
                        <input id="txtScolor.*" type="text" style="width:95%;"/>
                    </td>
					<td style="width:8%;">
						<input class="txt c1 txtSpec" id="txtSpec.*" type="text" />
						<select id="combSpec.*" class="txt c1 combSpec" style="display:none;"> </select>
					</td>
					<td id="FixedSize">
						<input class="txt num c8" id="txtSize1.*" type="text"/><div id="x1" style="float: left"> x</div>
						<input class="txt num c8" id="txtSize2.*" type="text"/><div id="x2" style="float: left"> x</div>
						<input class="txt num c8" id="txtSize3.*" type="text"/><div id="x3.*" style="float: left"> x</div>
						<input class="txt num c8" id="txtSize4.*" type="text"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="hidden"/>
						<input  id="txtWidth.*" type="hidden"/>
						<input  id="txtDime.*" type="hidden"/>
						<input id="txtLengthb.*" type="hidden"/>
						<input id="txtSize.*" type="text" style="width:95%;"/>
					</td>
					<td style="width:7%;"><input class="txt num c1" id="txtMount.*" type="text"/></td>
					<td class="pk" style="width:4%;display:none;"><input class="txt c1" id="txtUnit2.*" type="text"/></td>
					<td style="width:7%;"><input class="txt num c1" id="txtWeight.*" type="text" /></td>
					<td style="width:4%;"><input class="txt c1" id="txtUnit.*" type="text"/></td>
					<td style="width:7%;display:none;" class="pk"><input class="txt num c1" id="txtPrice.*" type="text"/></td>
					<td style="width:8%;"><input class="txt num c1" id="txtCnt.*" type="text"/></td>
					<td style="width:15%;">
						<input class="txt" id="txtNoa.*" type="text" style="width:75%;"/>
						<input class="txt" id="txtNo2.*" type="text" style="width:20%;"/>
						<input class="txt c1" id="txtMemo.*" type="text"/>
						<input id="txtKind.*" style="display:none;" />
						<input id="recno.*" style="display:none;" />
					</td>
				</tr>
			</table>
		</div>
			<!--#include file="../inc/pop_ctrl.inc"--> 
	</body>
</html>