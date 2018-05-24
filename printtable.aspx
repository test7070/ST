<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script src='../script/clipboard.min.js' type="text/javascript"> </script>
		<script type="text/javascript">
			var q_name = "printtable";
            $(document).ready(function() {
            	_q_boxClose();
            	q_getId();
            	q_gf('', q_name);
            });
            
            var t_field='';
            var pq_name=window.parent.q_name;
            var pq_db=window.parent.q_db;
            function q_gfPost() {
                q_getFormat();
                q_langShow();
                q_popAssign();
                
                $('#txtBmon').mask(r_picm);
                $('#txtEmon').mask(r_picm);
                
                if(window.parent.q_getMsg('lblNoa')=='..')
                	$('#lblNoa').text(window.parent.$('#lblNoa').text());
                else
                	$('#lblNoa').text(window.parent.q_getMsg('lblNoa')+'　');
                	
                if(window.parent.q_getMsg('lblMon')=='..')
                	$('#lblMon').text(window.parent.$('#lblMon').text());
                else
                	$('#lblMon').text(window.parent.q_getMsg('lblMon')+'　');
                	
                if(pq_name=='salchg'){
                	$('.mon').show();
                }
                
                $('#btnPrint').click(function() {
                	var value = $('#print_div')[0].innerHTML;
				     var printPage = window.open("", "Printing...", "");
				     printPage.document.open();
				     printPage.document.write("<HTML><head></head><BODY style='text-align: center;' onload='window.print();window.close()'>");
				     printPage.document.write("<PRE>");
				     printPage.document.write(value);
				     printPage.document.write("</PRE>");
				     printPage.document.close("</BODY></HTML>");
                });
                
                $('#btnSeek').click(function() {
                	initprint($('#txtBnoa').val(),$('#txtEnoa').val(),$('#txtBmon').val(),$('#txtEmon').val())
				});
				
				$('#btnCopy').click(function(e) {
					var clipboard = new Clipboard('#btnCopy');
				});
				
				initprint('','','','');
            }
            
            function initprint(bnoa,enoa,bmon,emon) {
            	if(pq_name=='' || pq_name==q_name){
            		return;
            	}
            	var tdate=q_date()+' '+padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
                var phtm="<a style='font-size:26px;'>"+window.parent.r_comp+"</a><BR>";
                phtm+="<a style='font-size:20px;'>"+window.parent.q_getMsg('qTitle')+"</a><BR>";
                phtm+="<a style='float:left;'>列印日期："+tdate+"</a><BR>";
                var pinput=window.parent.$('.tbbm input[type=text],.tbbm select,.tbbm a,.tbbm textarea,.tbbm input[type=checkbox]');
                
                phtm+="<table id='printtable' border='1' style='word-break:break-all;text-align:initial;position:absolute;'><tr id='head' style='background-color: cornsilk;'><td style='display:none;'>";
                var cmbtext="";
                var table_col=1;
                var col_with=[];
                var t_chk=false;
                var t_plblname='';
                if(window.parent.q_xchg==1){
                	window.parent.$('#btnXchg').click();
                }
                
                pinput.each(function(index) {
                	if(!$(this).is(':hidden') && $(this).attr('id')!=undefined){
                		if($(this).attr('id')!='lblCopy' && $(this).attr('id')!='Copy' && $(this).attr('id').substr(0,4)!='text' //複製不用
                		//排除特殊
                		&& !(pq_name=='gqb' && $(this).attr('id')=='lblGqb')
                		&& !(pq_name=='gqb' && $(this).attr('id')=='lblGqbs')
                		){
	                		if($(this).attr('id').substr(0,3)=='lbl' || $(this).attr('id').substr(0,3)=='vew'){
	                			var plbl=$(this).attr('id');
	                			if(window.parent.q_getMsg(plbl)=='..'){
	                				phtm+="</td><td id='head_"+table_col+"' style='width:110px;text-align:center;'>"+window.parent.$('#'+plbl).text();
	                			}else{
	                				phtm+="</td><td id='head_"+table_col+"' style='width:110px;text-align:center;'>"+window.parent.q_getMsg(plbl);
	                			}
	                			t_plblname=plbl;
	                			if(!t_chk)
	                				t_field+="#";
	                			else
	                				t_chk=false;
	                			table_col++;
	                		}else{
	                			if($(this).attr('id').substr(0,4)!='comb'&& $(this).attr('id').substr(0,5)!='check'){
		                			var ptxt=$(this).attr('id');
		                			//phtm+="<br><a style='display:none;'>"+ptxt+"</a>";
		                			if(ptxt.substr(0,3)=='chk'){
		                				//if(($(this).attr('id')=='chkLok' && pq_name=='accc') || ($(this).attr('id')=='chkNet' && pq_name=='tel')){
		                				if(ptxt.indexOf(replaceAll(t_plblname,'lbl',''))>-1){
		                					t_field+='@'+replaceAll(replaceAll(replaceAll(ptxt,'txt',''),'cmb',''),'chk','')+'^^';
		                				}else{
		                					t_field+='#@'+replaceAll(replaceAll(replaceAll(ptxt,'txt',''),'cmb',''),'chk','')+'^^';
			                				t_chk=true;
		                				}
		                			}else{
		                				t_field+='@'+replaceAll(replaceAll(replaceAll(ptxt,'txt',''),'cmb',''),'chk','');
		                			}
		                			
		                			if($(this).hasClass('num')){
		                				t_field+="**";
		                			}
		                			var t_ptxt=replaceAll(replaceAll(replaceAll(ptxt,'txt',''),'cmb',''),'chk','');
		                			if(ptxt.substr(0,3)=='cmb'){
		                				var cmbobjet=window.parent.$('#'+ptxt);
		                				for(var i=0;i<cmbobjet[0].options.length;i++){
		                					if(window.parent.$('#'+ptxt)[0].options[i]!=undefined)
		                						cmbtext+='#'+t_ptxt+"^^"+window.parent.$('#'+ptxt)[0].options[i].value+'@'+window.parent.$('#'+ptxt)[0].options[i].text;
		                				}
		                			}
	                			}
	                		}
                		}
                	}
                });
                phtm+="</td></tr>";
                
                t_field=t_field.split('#');
                cmbtext=cmbtext.split('#');
                
                //傳票
                var t_r_accy=r_accy;
                if(pq_name.substr(0,2)=='ac'){
                	t_r_accy=r_accy+'_'+r_cno;
                }
                
                
                //107/05/21 目前只有salchg才有mon查詢 NV
                if(pq_name=='salchg' && (bnoa.length>0 || enoa.length>0 || bmon.length>0 || emon.length>0)){
                	var t_where="";
                	if(enoa.length>0){
                		t_where="noa between '"+bnoa+"' and '"+enoa+"' "
                	}else{
                		t_where="noa between '"+bnoa+"' and char(255) "
                	}
                	
                	if(emon.length>0){
                		t_where+="and mon between '"+bmon+"' and '"+emon+"' "
                	}else{
                		t_where+="and mon between '"+bmon+"' and char(255) "
                	}
                	
                	t_where="where=^^ "+t_where+" ^^";
                	
                	q_gt(pq_name, t_where, 0, 0, 0, "getdb",t_r_accy,1);
                }else if(bnoa.length>0 || enoa.length>0){
                	var t_where="";
                	if(enoa.length>0){
                		t_where="where=^^noa between '"+bnoa+"' and '"+enoa+"' ^^"
                	}else{
                		t_where="where=^^noa between '"+bnoa+"' and char(255) ^^"
                	}
                	q_gt(pq_name, t_where, 0, 0, 0, "getdb",t_r_accy,1);
                }else{
                	q_gt(pq_name, 'where=^^1=1^^ stop=1000', 0, 0, 0, "getdb",t_r_accy,1);
                }
                
                var as = _q_appendData(pq_name, "", true);
                if(as.length==1000){
                	alert('資料筆數超出1000筆，系統預設先顯示1000筆。\n若需要查詢更多資料，請再按【查詢】顯示。');
                }
                
                for(var i=0;i<as.length;i++){
                	phtm+="<tr><td style='display:none;'>";
                	
                	for(var j=1;j<t_field.length;j++){
                		var tt_field=t_field[j].split('@')
                		if(t_field[j].indexOf('**')>-1)
                			phtm+="</td><td style='text-align:right;'>";
                		else if(t_field[j].indexOf('^^')>-1)
                			phtm+="</td><td style='text-align:center;'>";
                		else
                			phtm+="</td><td>";
                		for(var k=1;k<tt_field.length;k++){
                			var fieldname=replaceAll(replaceAll(tt_field[k].toLowerCase(),'**',''),'^^','');
                			
                			//判斷是否是cmb
                			var iscmb=false;
                			for(var n=1;n<cmbtext.length;n++){
                				var t_cmbname=cmbtext[n].split('^^')[0].toLowerCase();
                				var t_cmbvalue=cmbtext[n].split('^^')[1].split('@')[0];
                				var t_cmbtext=cmbtext[n].split('^^')[1].split('@')[1];
                				if(t_cmbname==fieldname && t_cmbvalue==as[i][fieldname]){//判斷是否等於選項值
                					phtm+=t_cmbtext;
                					iscmb=true;
                					
                					//寫入字串長度
                					var bytelen=encodeURIComponent(t_cmbtext).replace(/%[A-F\d]{2}/g, 'X').length;
                					var t_iscw=false;
                					for(var m=0;m<col_with.length;m++){
                						if(col_with[m].col==j){
                							t_iscw=true;
                							if(bytelen>col_with[m].num)
                								col_with[m].num=bytelen;
                						}
                					}
                					if(!t_iscw){
                						col_with.push({
                							col : j,
                							num : bytelen
                						});
                					}
                				}
                			}
                			if(!iscmb){
                				var ttdata='';
                				if(pq_name=='accc' && (fieldname=='tyear' || fieldname=='accc1')){
                					if(fieldname=='tyear'){
	                					phtm+=r_accy;
	                					ttdata=r_accy;
                					}
                					if(fieldname=='accc1'){
                						if(as[i][fieldname]=='1'){
                							phtm+='現金收入傳票';
	                						ttdata='現金收入傳票';
                						}else if(as[i][fieldname]=='2'){
                							phtm+='現金支出傳票';
	                						ttdata='現金支出傳票';
                						}else{
                							phtm+='轉帳傳票';
	                						ttdata='轉帳傳票';
                						}
                					}
                				}else if(as[i][fieldname]==undefined){
                					phtm+='';
                					ttdata=''
                				}else if(tt_field[k].indexOf('**')>-1){
                					phtm+=FormatNumber(as[i][fieldname]);
                					ttdata=FormatNumber(as[i][fieldname]);
                				}else if(tt_field[k].indexOf('^^')>-1){
                					if(as[i][fieldname]=='true'){
                						phtm+='V';
                						ttdata='V'
                					}else{
                						phtm+='';
                						ttdata=''
                					}
                				}else{
                					phtm+=as[i][fieldname];
                					ttdata=as[i][fieldname];
                				}
                				
                				//寫入字串長度
                				var bytelen=encodeURIComponent(ttdata).replace(/%[A-F\d]{2}/g, 'X').length;
                				var t_iscw=false;
                				for(var m=0;m<col_with.length;m++){
                					if(col_with[m].col==j){
                						t_iscw=true;
                						if(bytelen>col_with[m].num)
                							col_with[m].num=bytelen;
                					}
                				}
                				if(!t_iscw){
                					col_with.push({
                						col : j,
                						num : bytelen
                					});
                				}
                			}
                			
                			if(ttdata!=undefined){
	                			if(ttdata.length>2)
	                				phtm+="<br>";
	                		}
                		}
                	}
                	
                	phtm+="</tr>";
                }
                
                phtm+="</table>";
                $('#print_div').html(phtm);
                
                var table_width=0;
                for(var m=0;m<col_with.length;m++){
                	var t_with=110;
                	if(col_with[m].num>24){
                		t_with=t_with*col_with[m].num/24
                	}
                	
                	$('#head_'+col_with[m].col).css('width',t_with+'px');
                	
                	table_width+=t_with;
                }
                
                if(table_width>1260){
	                $('#printtable').css('width',table_width+'px');
	                $('#print_div').css('width',table_width+'px');
                }else{
                	$('#printtable').css('width',((t_field.length-1)*110)+'px');
	                $('#print_div').css('width','1260px');
                }
            }
            
            function q_gtPost(t_name) {
                switch (t_name) {
                }
            }

            function q_boxClose(s2) {
            }
            
            function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}

		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
        </style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id='q_menu'> </div>
		<div id='q_acDiv'> </div>
		<BR><BR>
		<a id='lblNoa'> </a>
		<input id="txtBnoa" type="text" class="txt c1" style="width: 150px;"> ~ 
		<input id="txtEnoa" type="text" class="txt c1" style="width: 150px;">
		
		<BR class="mon" style="display: none;"><BR class="mon" style="display: none;">
		<a id='lblMon' class="mon" style="display: none;"> </a>
		<input id="txtBmon" type="text" class="txt c1 mon" style="width: 150px;display: none;"> <a style="display: none;">~</a> 
		<input id="txtEmon" type="text" class="txt c1 mon" style="width: 150px;display: none;">
		
		<input id="btnSeek" type="button" value="查詢"><BR>
		<input id="btnPrint" type="button" value="列印">
		<input id="btnCopy" type="button" value="複製到剪貼簿" data-clipboard-target="#print_div"><BR>
		<div id='print_div' style="text-align: center;"> </div>
	</body>
</html>
          