<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			aPop = new Array(['txtXpart', '', 'part', 'noa,part', 'txtXpart', "part_b.aspx"]);
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			t_isinit = false;
			var custtypeItem = '';
			$(document).ready(function() {
				q_getId();
				if(custtypeItem.length == 0){
					q_gt('custtype', '', 0, 0, 0, "custtype");
				}
				//q_gf('', 'z_umm');
				
				$('#q_report').click(function(e) {
					//客戶請款單與應收對帳簡要表>>正常隱藏業務選項>>>不然會造成金額問題
					if(!(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1 || q_getPara('sys.comp').indexOf('永勝')>-1 || q_getPara('sys.project').toUpperCase()=='RB')){
						if($('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_umm13' || $('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_umm10' || $('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_umm16'){
							$('#Sales').hide();
						}
						//月結客戶刪除業務應收帳款總表>>>月結會不知道帳要沖到哪一個業務
						if(q_getPara('sys.project').toUpperCase()!='XY'){
							var delete_report=999;
							for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
								if($('#q_report').data().info.reportData[i].report=='z_umm12')
									delete_report=i;
							}
							if($('#q_report div div').text().indexOf('業務應收帳款總表')>-1)
								$('#q_report div div').eq(delete_report).hide()
						}else{
							$('#Paytype').hide();
						}
					}
					if($('#q_report').data().info.reportData[$('#q_report').data().info.radioIndex].report=='z_umm10'){
						if(q_getPara('sys.project').toUpperCase()!='YC')
							$('#Xcno').hide();
					}
					
					if(q_getPara('sys.isAcccUs')!='1')
						$('#Xcoin').hide();
					
					if(q_getPara('sys.project').toUpperCase()!='YC'){
						var delete_report=999;
						for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
							if($('#q_report').data().info.reportData[i].report=='z_umm15')
								delete_report=i;
						}
						if($('#q_report div div').text().indexOf('客戶收款簽收報表')>-1)
							$('#q_report div div').eq(delete_report).hide();
					}
					
					if(!(q_getPara('sys.project').toUpperCase()=='YC' || q_getPara('sys.project').toUpperCase()=='FE' || q_getPara('sys.project')=='1')){
						var delete_report=999;
						for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
							if($('#q_report').data().info.reportData[i].report=='z_umm16')
								delete_report=i;
						}
						if($('#q_report div div').text().indexOf('客戶請款單(重量)')>-1)
							$('#q_report div div').eq(delete_report).hide();
					}
					
					if(q_getPara('sys.project').toUpperCase()!='XY'){
						$('#Acckey').hide();
					}
						
				});
			});
			
			function q_gfPost() {
				q_gt('flors_coin', '', 0, 0, 0, "");
			}

			function q_boxClose(s2) {
				var ret;
                switch (b_pop) {
                	case 'cust':
                        ret = getb_ret();
                        if(ret==null)
                        	return;
                        var xcust='';
                        if(ret[0]!=undefined){
                        	for (var i = 0; i < ret.length; i++) {
                        		xcust+=ret[i].noa+'.'
                        	}
                        }
                        xcust=xcust.substr(0,xcust.length-1);
                        $('#txtMultcust').val(xcust);
                        break;	
                }	
			}

			var z_coin='';
			function q_gtPost(t_name) {
                switch (t_name) {
                	case 'sss_issales_xy':
                		var as = _q_appendData("sss", "", true);
                		if (as[0] != undefined) {
                			if(as[0].issales=="true"){
                				$('#txtSales1a').val(r_userno).attr('disabled', 'disabled');
                				$('#txtSales2a').val(r_userno).attr('disabled', 'disabled');
                				$('#txtSales1b').val(r_name).attr('disabled', 'disabled');
                				$('#txtSales2b').val(r_name).attr('disabled', 'disabled');
                				$('#btnSales1').hide();
                				$('#btnSales2').hide();
                			}
                		}
                		break;
                	case 'flors_coin':
                		z_coin='#non@本幣';
                		var as = _q_appendData("flors", "", true);
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin!='#non@本幣')//有外幣
							z_coin+=',ALL@全部';
                	break;
                	case 'custtype':
                        var as = _q_appendData("custtype", "", true);
                        custtypeItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            custtypeItem = custtypeItem + (custtypeItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
                        }
						q_gf('', 'z_umm');
						break;
                }
                if(!t_isinit && z_coin.length>0){
                	t_isinit=true;
                	$('#q_report').q_report({
						fileName : 'z_umm',
						options : [{
							type : '6', //[1]
							name : 'xcno'
						}, {
							type : '6', //[2]
							name : 'xpart'
						}, {
							type : '1', //[3][4]
							name : 'date'
						}, {
							type : '2', //[5][6]
							name : 'xcust',
							dbf : 'cust',
							index : 'noa,comp',
							src : 'cust_b.aspx'
						}, {
							type : '1', //[7][8]
							name : 'xdate'
						}, {
							type : '0',
							name : 'accy', //[9]
							value : r_accy + "_" + r_cno
						}, {
							type : '0', //[10]
							name : 'xaccy',
							value : r_accy
						}, {
							type : '2', //[11][12]
							name : 'scno',
							dbf : 'acomp',
							index : 'noa,acomp',
							src : 'acomp_b.aspx'
						}, {
							type : '1', //[13][14]
							name : 'smon'
						}, {
							type : '2', //[15][16]
							name : 'sales',
							dbf : 'sss',
							index : 'noa,namea',
							src : 'sss_b.aspx'
						}, {
							type : '2', //[17][18]
							name : 'product',
							dbf : 'ucaucc',
							index : 'noa,product',
							src : 'ucaucc_b.aspx'
						}, {
							type : '6', //[19]
							name : 'xmemo'
						}, {
							type : '6', //[20]
							name : 'paytype'
						}, {
							type : '0', //[21] //判斷vcc是內含或應稅 內含不抓vcca
							name : 'vcctax',
							value : q_getPara('sys.d4taxtype')
						}, {
							type : '8', //[22]
							name : 'showunpay', //只顯示未收
							value : "1@只顯示未收,2@顯示貨單備註".split(',')
						}, {
							type : '2', //[23][24]
							name : 'xctype',
							dbf : 'custtype',
							index : 'noa,namea',
							src : 'custtype_b.aspx'
						}, {
							type : '0', //[25] 
							name : 'xacomp',
							value : q_getPara('sys.comp')
						}, {
							type : '0', //[26] 
							name : 'xproject',
							value : q_getPara('sys.project').toUpperCase()
						}, {
							type : '5', //[27]
							name : 'xcoin', //幣別
							value : z_coin.split(',')
						}, {
							type : '8', //[28]
							name : 'showordetotal', //顯示單據小計
							value : "1@顯示單據小計".split(',')
						},{
                        	type : '6', //[29] //4-4
                      	  	name : 'multcust'
                    	},{
                        	type : '6', //[30] 
                      	  	name : 'acckey'
                    	}, {
							type : '5', //[31]
							name : 'custtype', 
							value : custtypeItem.split(',')
						}]
					});
					q_popAssign();
					q_getFormat();
                	q_langShow();
                	
					if(r_len==4){                	
	                	$.datepicker.r_len=4;
						//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
	                }
					
					$('#txtDate1').mask(r_picd);
					$('#txtDate1').datepicker();
					$('#txtDate2').mask(r_picd);
					$('#txtDate2').datepicker();
					$('#txtXdate1').mask('99/99');
					$('#txtXdate2').mask('99/99');
					$('#txtSmon1').mask(r_picm);
					$('#txtSmon2').mask(r_picm);
					$('#Xmemo').removeClass('a2').addClass('a1');
					$('#txtXmemo').css('width', '85%');
					$('.q_report .report').css('width', '460px');
					$('.q_report .report div').css('width', '220px');
					
					$('#Showordetotal').css('width','300px');
					$('#chkShowordetotal').css('width','220px');
					$('#chkShowordetotal span').css('width','180px');
					
					$('#txtDate1').val(q_date().substr(0,r_lenm)+'/01')
					$('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',35).substr(0,r_lenm)+'/01',-1))
					$('#txtSmon1').val(q_date().substr(0,r_lenm))
					$('#txtSmon2').val(q_date().substr(0,r_lenm))
					$('#txtXdate1').val($('#txtDate1').val().slice(-5));
					$('#txtXdate2').val($('#txtDate2').val().slice(-5));
					
					var tmp = document.getElementById("txtPaytype");
					var selectbox = document.createElement("select");
					selectbox.id = "combPay";
					selectbox.style.cssText = "width:15px;font-size: medium;";
					//selectbox.attachEvent('onchange',combPay_chg);
					//selectbox.onchange="combPay_chg";
					tmp.parentNode.appendChild(selectbox, tmp);
					q_cmbParse("combPay", '@全部,' + q_getPara('vcc.paytype').substr(1));
					$('#txtPaytype').val('');
	
					$('#combPay').change(function() {
						var cmb = document.getElementById("combPay")
						$('#txtPaytype').val(cmb.value);
					});
					
					if(q_getPara('sys.isAcccUs')!='1')
						$('#Xcoin').hide();
						
					//鎖住業務
					if(q_getPara('sys.project').toUpperCase()=='XY'){
						q_gt('sss', "where=^^ noa='"+r_userno+"' ^^", 0, 0, 0, "sss_issales_xy");
					}
					
					if(q_getPara('sys.project').toUpperCase()=='RB'){
						$('#chkShowordetotal input').prop('checked',true);
						$('#chkShowunpay input').prop('checked',true);
					}
					
					$('#Multcust').css("width","605px");
					$('#txtMultcust').css("width","515px");
					$('#lblMultcust').css("color","#0000ff");
					$('#lblMultcust').click(function(e) {
	                	q_box("cust_b2.aspx?;;;;", 'cust', "600px", "90%", q_getMsg("popCust"));
	                });
	                
	                $('#Acckey').css("width","605px");
					$('#txtAcckey').css("width","515px");
					$('#txtAcckey').click(function(e) {
	                	q_msg($(this),'多關鍵字請用,隔開');
	                });
                }
	         }

		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>