<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;

            q_tables = 't';
            var q_name = "workj";
            var q_readonly = ['txtNoa','txtOrdeno','txtLengthb','txtMount','txtWeight'];
            var q_readonlys = ['txtContno','txtContnoq','txtStore','txtMech','txtWeight'];
            var q_readonlyt = [];
            var bbmNum = [['txtMount',10,2,1],['txtWeight',10,2,1],['txtLengthb',10,0,1]];
            var bbsNum = [['txtMount',10,2,1],['txtWeight',10,2,1],['txtLengthb',10,0,1]];
            var bbtNum = [['txtMount',10,2,1],['txtWeight',10,2,1]];
            var bbmMask = [['txtOdate','999/99/99'],['txtDatea','999/99/99'],['txtTimea','99:99']];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 6;

            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtPicno_', 'btnPicno_', 'img', 'noa', 'txtPicno_', 'img_b.aspx']
            	,['txtProductno__', 'btnProduct__', 'ucc', 'noa,product', 'txtProductno__,txtProduct__', 'ucc_b.aspx']
            	,['txtUno__', 'btnUno__', 'view_uccc2', 'uno,productno,product,spec,emount,eweight', 'txtUno__,txtProductno__,txtProduct__,,txtMount__,txtWeight__', 'uccc_seek_b2.aspx?;;;1=0', '95%', '60%']
            	,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtCust,txtNick', 'cust_b.aspx']
            	,['txtMechno_', 'btnMech_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx']
            	,['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
            	,['txtStoreno__', 'btnStore__', 'store', 'noa,store', 'txtStoreno__,txtStore__', 'store_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                q_cmbParse("cmbTagcolor", '桃紅色,紫色,天空藍,草綠色,黃色,膚色,白色');
                q_cmbParse("cmbTrantype", '本廠送達,本廠拖運,本廠自運,指送,其它,廠商拖運,廠商送達,廠商自運');
                $('#btnCont').click(function(e){
                	var t_noa = $('#txtNoa').val();
                	var t_custno = $('#txtCustno').val();
                	//q_func('qtxt.query.cont', 'workj.txt,cont,' + encodeURI(t_noa) + ';' + encodeURI(t_custno)); 	
                	
                	var t_where ='';
                	q_box("contfe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({workjno:t_noa,custno:t_custno}), "cont_workj", "95%", "95%", '');
                });
                $('#btnOrde').click(function(e){
                	var t_key = q_getPara('sys.key_orde');
                	var t_noa = $('#txtNoa').val();
                	q_func('qtxt.query.orde', 'workj.txt,orde,' + encodeURI(t_key)+ ';' +encodeURI(t_noa)); 	
                });
                $('#lblOrdeno').click(function(e){
                	var t_noa= $('#txtOrdeno').val();
                	var t_accy = $('#txtOrdeaccy').val();
                	if(t_noa.length>0)
                		q_box("ordefe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + t_noa + "';" + t_accy, 'orde', "95%", "95%", q_getMsg("popOrde"));
                });
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.cont':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtContno,txtContnoq,txtProductno,txtProduct,txtLengthb,txtMount,txtWeight'
                        	, as.length, as, 'contno,contnoq,productno,product,lengthb,xmount,xweight', '','');
                        	sum();
                        } else {
                            alert('無資料!');
                        }
                		break;
            		case 'qtxt.query.orde':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	if(as[0].ordeno != undefined && as[0].ordeno.length>0){
                        		$('#txtOrdeno').val(as[0].ordeno);
                        		$('#txtOrdeaccy').val(as[0].ordeaccy);
                        	}else{
                        		alert(as[0].msg);
                        	}
                        } else {
                            alert('匯出訂單錯誤!');
                        }
                		break;
                    default:
                        break;
                }
            }
			function q_popPost(id) {
                switch (id) {
                	case 'txtProductno_':
                		sum();
                	case 'txtPicno_':
                		var n = b_seq;
                		createImg(n);
                    default:
                        break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'btnModi':
                		var as = _q_appendData("view_vccs", "", true);
                        if (as[0] != undefined) {
                        	alert('已訂單已出貨，禁止修改。');
                        }else{
                        	_btnModi();
                			$('#txtDatea').focus();
                        }
                        Unlock(1);
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                $('#btnOrde').click();
                Unlock(1);
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'cont_workj':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtContno,txtContnoq,txtProductno,txtProduct,txtLengthb,txtMount,txtWeight'
                        	, as.length, as, 'contno,contnoq,productno,product,lengthb,mount,weight', '','');
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('workj_s.aspx', q_name + '_s', "550px", "440px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtOdate').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                var t_ordeno = $('#txtOrdeno').val()
                if(t_ordeno.length>0){
                	Lock(1,{opacity:0});
               		q_gt('view_vccs', "where=^^ ordeno='"+t_ordeno+"' ^^ stop=1", 0, 0, 0, 'btnModi'); 
                }
                else{
                	_btnModi();
                	$('#txtDatea').focus();
                }    
            }

            function btnPrint() {
                q_box("z_workjp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'workj', "95%", "95%", m_print);
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if($.trim($('#txtCustno').val())==0){
                	alert(q_getMsg('lblCust') + '空白。');
                    Unlock(1);
                    return;
                }
                
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workj') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['imgdata']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                for(var n=0;n<q_bbsCount;n++){
                	if($('#canvas_'+n).length>0){

						$('#imgPic_'+n).attr('src', $('#txtImgdata_'+n).val());
						var imgwidth = $('#imgPic_'+n).width();
                        var imgheight = $('#imgPic_'+n).height();
						//$('#canvas_'+i)[0].witdh = $('#canvas_'+i)[0].witdh;
						$("#canvas_"+n)[0].getContext("2d").drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight,0,0,150,150);
                	}
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==1 || q_cur==2){
                	$('#btnOrde').attr('disabled','disabled');
                	$('#btnCont').removeAttr('disabled');
                }else{
                	$('#btnCont').attr('disabled','disabled');
                	$('#btnOrde').removeAttr('disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }
            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }
			function createImg(n){
				if (n ==undefined)
					return;
				var t_picno = $('#txtPicno_'+n).val();
        		var t_para = $('#txtParaa_'+n).val()+'^'+$('#txtParab_'+n).val()+'^'+$('#txtParac_'+n).val()
        			+'^'+$('#txtParad_'+n).val()+'^'+$('#txtParae_'+n).val()+'^'+$('#txtParaf_'+n).val();

        		if(t_picno.length>0 && t_para.replace(/\^/g,'').replace(/0/g,'').length>0){
                	$.ajax({
                		picno : t_picno,
                		n : n,
	                    url: '..\\images\\feorg\\'+t_picno+'.txt',
	                    type: 'GET',
	                    dataType: 'text',
	                    timeout: 5000,
	                    success: function(data){
	                    	var n = this.n;
	                    	//先用原大小
	                    	$('#imgPic_'+n).attr('src','../images/feorg/'+this.picno+'.jpg?'+(new Date()).getTime())
	                       	 	
	                        $('#imgPic_'+n)[0].onload = function(){
	                        	var n = $(this).attr('id').replace('imgPic_','');
	                        	var imgwidth = $('#imgPic_'+n).width();
		                        var imgheight = $('#imgPic_'+n).height();
		                        $('#canvas_'+n).width(imgwidth).height(imgheight);
		                        var c=document.getElementById("canvas_"+n);
								var ctx=c.getContext("2d");		
								c.width = imgwidth;
								c.height = imgheight;
								ctx.drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight);
								
								t_para = data.split('\n');
								for(var i=1;i<t_para.length;i++){
									x_para = t_para[i].split(',');
									if(x_para.length>=4 && x_para[0].toLowerCase()>='a' && x_para[0].toLowerCase()<='z' && $('#txtPara'+x_para[0].toLowerCase()+'_'+n).length>0){
										if(parseInt(x_para[1])!=0 || parseInt(x_para[2])!=0){
											value = q_float('txtPara'+x_para[0].toLowerCase()+'_'+n);
											ctx.font = (parseInt(x_para[3])*2)+"px times new roman";
											ctx.fillStyle = 'red';
											ctx.fillText(value,parseInt(x_para[1])+10,parseInt(x_para[2])+25);
										}
									}
								}
								//縮放為150*150
								$('#imgPic_'+n).attr('src',c.toDataURL());
								$('#canvas_'+n).width(150).height(150);
								c.width = 150;
								c.height = 150;
								$("#canvas_"+n)[0].getContext("2d").drawImage($('#imgPic_'+n)[0],0,0,imgwidth,imgheight,0,0,150,150);
								
								$('#txtImgdata_'+n).val(c.toDataURL());
	                        };
	                        
	                        
	                    },
	                    complete: function(){                    
	                    },
	                    error: function(jqXHR, exception) {
	                        var errmsg = 'Error。\n';
	                        if (jqXHR.status === 0) {
	                            alert(errmsg+'Not connect.\n Verify Network.');
	                        } else if (jqXHR.status == 404) {
	                            alert(errmsg+'Requested page not found. [404]');
	                        } else if (jqXHR.status == 500) {
	                            alert(errmsg+'Internal Server Error [500].');
	                        } else if (exception === 'parsererror') {
	                            alert(errmsg+'Requested JSON parse failed.');
	                        } else if (exception === 'timeout') {
	                            alert(errmsg+'Time out error.');
	                        } else if (exception === 'abort') {
	                            alert(errmsg+'Ajax request aborted.');
	                        } else {
	                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
	                        }
	                    }
	                });
        		}
			};
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                        $('#txtMechno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtMechno_', '');
                            $('#btnMech_'+n).click();
                        });
                        $('#txtStoreno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtStoreno_', '');
                            $('#btnStore_'+n).click();
                        });
                        $('#txtPicno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtPicno_', '');
                            $('#btnPicno_'+n).click();
                        });
                    	$('#txtPicno_'+i).change(function(e){
                    		var n = $(this).attr('id').replace('txtPicno_', '');
                    		createImg(n);
                    	});
                    	$('#txtParaa_'+i).change(function(e){
                    		var n = $(this).attr('id').replace('txtParaa_', '');
                    		createImg(n);
                    	});
                    	$('#txtParab_'+i).change(function(e){
                    		var n = $(this).attr('id').replace('txtParab_', '');
                    		createImg(n);
                    	});
                    	$('#txtParac_'+i).change(function(e){
                    		var n = $(this).attr('id').replace('txtParac_', '');
                    		createImg(n);
                    	});
                    	$('#txtParad_'+i).change(function(e){
                    		var n = $(this).attr('id').replace('txtParad_', '');
                    		createImg(n);
                    	});
                    	$('#txtParae_'+i).change(function(e){
                    		var n = $(this).attr('id').replace('txtParae_', '');
                    		createImg(n);
                    	});
                    	$('#txtParaf_'+i).change(function(e){
                    		var n = $(this).attr('id').replace('txtParaf_', '');
                    		createImg(n);
                    	});
                    	$('#txtContno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var t_noa =  $(this).val();
                            if(t_noa.length>0)
                            	q_box("contfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + t_noa + "';" + r_accy, 'cont', "95%", "95%", q_getMsg("popCont"));
                        });
                        $('#txtProduct_'+i).change(function(e){
                        	sum();
                        });
                        $('#txtLengthb_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount_'+i).change(function(e){
                    		sum();
                    	});
                    }
                }
                _bbsAssign();
            }
			var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
			})();
			function imgDisplay(obj){
				$(obj).hide();
			}
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtProductno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno__', '');
                            $('#btnProduct__'+n).click();
                        });
                        $('#txtStoreno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtStoreno__', '');
                            $('#btnStore__'+n).click();
                        });
                        $('#txtUno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtUno__', '');
                            $('#btnUno__'+n).click();
                        });
                    }
                }
                _bbtAssign();
            }


            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var calc =[{key:'3#',value:0.56}
	                ,{key:'4#',value:0.994}
	                ,{key:'5#',value:1.56}
	                ,{key:'6#',value:2.25}
	                ,{key:'7#',value:3.05}
	                ,{key:'8#',value:3.98}
	                ,{key:'9#',value:5.08}
	                ,{key:'10#',value:6.39}
	                ,{key:'11#',value:7.9}];
	            var t_weight=0,t_mount=0,t_length=0,t_weights;
                for(var i=0;i<q_bbsCount;i++){
                	t_weights = 0;
                	t_product = $('#txtProduct_'+i).val();
                	if(t_product.length>0){
                		for(var j=0;j<calc.length;j++){
							if(t_product.indexOf(calc[j].key)>0){
								t_weights = round(q_mul(q_mul(calc[j].value,q_float('txtLengthb_'+i)/100),q_float('txtMount_'+i)),2);
								break;
							}                			
                		}
                	}
                	$('#txtWeight_'+i).val(t_weights);
                	t_weight = q_add(t_weight,t_weights);
                	t_mount = q_add(t_mount,q_float('txtMount_'+i));
                	t_length = q_add(t_length,q_float('txtLengthb_'+i));
                }
                $('#txtWeight').val(t_weight);
                $('#txtMount').val(t_mount);
                $('#txtLengthb').val(t_length);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
            	
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 300px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 70%;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 1%;
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
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 130%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1200px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 1500px;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 1500px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewCust'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:100px; color:black;"><a id='vewOdate'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='odate' style="text-align: center;">~odate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblOdate" class="lbl"> </a></td>
						<td><input id="txtOdate"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtCustno"  type="text"  class="txt" style="width:45%;float:left;"/>
							<input id="txtCust"  type="text"  class="txt" style="width:55%;float:left;"/>
							<input id="txtNick"  type="text"  class="txt" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblSite" class="lbl"> </a></td>
						<td><input id="txtSite"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblTagcolor" class="lbl"> </a></td>
						<td><select id="cmbTagcolor" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTrantype" class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1"></select></td>
						<td><span> </span><a id="lblChktype" class="lbl"> </a></td>
						<td colspan="2"><input id="txtChktype"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="4" rowspan="2"><textarea id="txtMemo" class="txt c1" rows="3"></textarea></td>
						<td><span> </span><a id="lblLengthb" class="lbl"> </a></td>
						<td><input id="txtLengthb"  type="text"  class="num txt c1"/></td>
					</tr>
					<tr>
						<td></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount"  type="text"  class="num txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtOrdeno"  type="text"  class="txt c1"/>
							<input id="txtOrdeaccy"  type="text"  style="display:none;"/>
						</td>
						<td></td>
						<td></td>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text"  class="num txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td></td>
						<td><input type="button" id="btnCont" value="合約匯入" /></td>
						<td><input type="button" id="btnOrde" value="轉訂單" style="display:none;"/></td>
					</tr>
					
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
					<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"></td>
					<td style="width:180px;" ><a id='lbl_product'>品名</a></td>
					<td style="width:170px;"><a id='lbl_pic'>形狀</a></td>
					<td style="width:80px;"><a id='lbl_picno'>形狀<br>編號</a></td>
					<td style="width:60px;"><a id='lbl_imgparaa'>參數A</a></td>
					<td style="width:60px;"><a id='lbl_imgparab'>參數B</a></td>
					<td style="width:60px;"><a id='lbl_imgparac'>參數C</a></td>
					<td style="width:60px;"><a id='lbl_imgparad'>參數D</a></td>
					<td style="width:60px;"><a id='lbl_imgparae'>參數E</a></td>
					<td style="width:60px;"><a id='lbl_imgparaf'>參數F</a></td>
					<td style="width:80px;"><a id='lbl_lengthb'>單支長</a></td>
					<td style="width:80px;"><a id='lbl_monnt'>數量</a></td>
					<td style="width:80px;"><a id='lbl_weight'>重量</a></td>
					<td style="width:80px;"><a id='lbl_timea'>時間</a></td>
					<td style="width:80px;"><a id='lbl_store'>入庫倉</a></td>
					<td style="width:60px;"><a id='lbl_mech'>機台</a></td>
					<td style="width:60px;"><a id='lbl_place'>儲位</a></td>
					<td style="width:200px;"><a id='lbl_memo'>備註</a></td>
					<td style="width:180px;"><a id='lbl_cont'>合約單號</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
						<input id="txtImgsrc.*"  type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:95%;"/>
						<input class="txt" id="txtProduct.*" type="text" style="width:95%;"/>
						<input id="btnProduct.*" type="button" style="display:none;">
					</td>
					<td>
						<canvas id="canvas.*" width="150"> </canvas>
						<img id="imgPic.*" src="" style="display:none;"/>
						<input id="txtImgdata.*" type="text" style="display:none;">
					</td>
					<td>
						<input class="txt" id="txtPicno.*" type="text" style="width:95%;"/>
						<input id="btnPicno.*" type="button" style="display:none;">
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParaa.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParab.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParac.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParad.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParae.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParaf.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td><input class="txt" id="txtLengthb.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input class="txt" id="txtMount.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input class="txt" id="txtWeight.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input class="txt" id="txtTimea.*" type="text" style="width:95%;"/></td>
					<td>
						<input class="txt" id="txtStoreno.*" type="text" style="width:95%;float:left;"/>
						<input class="txt" id="txtStore.*" type="text" style="width:95%;float:left;"/>
						<input id="btnStore.*" type="button" style="display:none;">
					</td>
					<td>
						<input class="txt" id="txtMechno.*" type="text" style="width:95%;float:left;"/>
						<input class="txt" id="txtMech.*" type="text" style="width:95%;float:left;"/>
						<input id="btnMech.*" type="button" style="display:none;">
					</td>
					<td><input class="txt" id="txtPlace.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtMemo.*" type="text" style="width:95%;"/></td>
					<td>
						<input class="txt" id="txtContno.*" type="text" style="float:left;width:120px;"/>
						<input class="txt" id="txtContnoq.*" type="text" style="float:left;width:35px;"/>
					</td>
				</tr>
			</table>
		</div>
		
		<input id="q_sys" type="hidden" />
		<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"></td>
						<td style="width:200px; text-align: center;">批號</td>
						<td style="width:200px; text-align: center;">品名</td>
						<td style="width:100px; text-align: center;">數量</td>
						<td style="width:100px; text-align: center;">重量</td>
						<td style="width:200px; text-align: center;">餘料批號</td>
						<td style="width:100px; text-align: center;">餘料數量</td>
						<td style="width:100px; text-align: center;">餘料重量</td>
						<td style="width:100px; text-align: center;">餘料倉</td>
						<td style="width:200px; text-align: center;">備註</td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input class="txt" id="txtUno..*" type="text" style="width:95%;"/>
							<input id="btnUno..*" type="button" style="display:none;">
						</td>
						<td>
							<input class="txt" id="txtProductno..*" type="text" style="width:45%;float:left;"/>
							<input class="txt" id="txtProduct..*" type="text" style="width:45%;float:left;"/>
							<input id="btnProduct..*" type="button" style="display:none;">
						</td>
						<td><input class="txt" id="txtMount..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtWeight..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtBno..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtEmount..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtEweight..*" type="text" style="width:95%;text-align: right;"/></td>
						<td>
							<input class="txt" id="txtStoreno..*" type="text" style="width:30%;float:left;"/>
							<input class="txt" id="txtStore..*" type="text" style="width:60%;float:left;"/>
							<input id="btnStore..*" type="button" style="display:none;">
						</td>
						<td><input class="txt" id="txtMemo..*" type="text" style="width:95%;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
