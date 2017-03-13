<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src="../script/qbox.js" type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "salary";
        var q_readonly = ['txtNoa','txtWorker','txtMoney','txtBo_admin','txtBo_traffic','txtBo_special','txtBo_oth','txtTax_other','txtMi_total','txtMtotal','txtBo_full','txtAddmoney','txtPlus','txtMinus','txtCh_health','txtCh_labor','txtCh_labor_self','txtTotal3','txtTotal4','txtTotal5','txtBorrow','txtDate2','txtChangedata'];//,'txtWelfare'
        var q_readonlys = [];
        var bbmNum = [['txtMoney', 15, 0, 1],['txtDaymoney', 15, 0, 1],['txtBo_admin', 15, 0, 1],['txtBo_traffic', 15, 0, 1],['txtBo_special', 15, 0, 1],['txtBo_oth', 15, 0, 1],['txtTax_other', 15, 0, 1],['txtMi_total', 15, 0, 1],['txtMtotal', 15, 0, 1],['txtBo_full', 15, 0, 1],['txtAddmoney', 15, 0, 1],['txtBorrow', 15, 0, 1],['txtCh_labor', 15, 0, 1],['txtCh_health', 15, 0, 1],['txtCh_labor_comp', 15, 0, 1],['txtCh_labor_self', 15, 0, 1],['txtTotal3', 15, 0, 1],['txtTotal4', 15, 0, 1],['txtTotal5', 15, 0, 1],['txtPlus', 15, 0, 1],['txtMinus', 15, 0, 1]];//,['txtWelfare', 15, 0, 1]  
        var bbsNum = [
        	['txtMoney', 15, 0, 1],['txtDaymoney', 15, 0, 1],['txtBo_admin', 15, 0, 1],['txtBo_traffic', 15, 0, 1],['txtBo_special', 15, 0, 1],['txtBo_oth', 15, 0, 1],['txtTotal1', 15, 0, 1],
        	['txtCh_labor1', 15, 0, 1],['txtCh_labor2', 15, 0, 1],['txtCh_health_insure', 15, 0, 1],['txtDay', 15, 1, 1],['txtMtotal', 15, 0, 1],//,['txtBo_born', 15, 0, 1],['txtBo_night', 15, 0, 1],['txtBo_duty', 15, 0, 1],['txtTax_other2', 15, 0, 1],
        	['txtBo_full', 15, 0, 1],['txtTax_other', 15, 0, 1],['txtTotal2', 15, 0, 1],['txtOstand', 15, 2, 1],['txtAddh2_1', 15, 1, 1],['txtAddh2_2', 15, 1, 1],['txtAddmoney', 15, 0, 1],
        	['txtAddh100', 15, 1, 1],['txtAddh46_1', 15, 1, 1],['txtAddh46_2', 15, 1, 1],['txtMeals', 15, 0, 1],['txtTotal3', 15, 0, 1],['txtBorrow', 15, 0, 1],['txtCh_labor', 15, 0, 1],
        	//['txtChgcash', 15, 0, 1],['txtStay_tax', 15, 0, 1],['txtLodging_power_fee', 15, 0, 1],['txtWelfare', 15, 0, 1],['txtStay_money', 15, 0, 1],
        	['txtTax6', 15, 0, 1],['txtTax12', 15, 0, 1],['txtTax18', 15, 0, 1],['txtCh_labor_comp', 15, 0, 1],['txtCh_labor_self', 15, 0, 1],
        	['txtTax', 15, 0, 1],['txtTax5', 15, 0, 1],['txtRaise_num', 15, 0, 1],['txtCh_health', 15, 0, 1],['txtHplus2', 15, 0, 1],['txtTotal4', 15, 0, 1],
        	['txtTotal5', 15, 0, 1],['txtLate', 15, 0, 1],['txtHr_sick', 15, 1, 1],['txtMi_sick', 15, 0, 1],['txtHr_person', 15, 1, 1],['txtMi_person', 15, 0, 1],['txtHr_nosalary', 15, 1, 1],['txtMi_nosalary', 15, 0, 1],
        	['txtHr_leave', 15, 1, 1],['txtMi_leave', 15, 0, 1],['txtPlus', 15, 0, 1],['txtMinus', 15, 0, 1],
        	['txtMoney1', 15, 0, 1],['txtMoney2', 15, 0, 1],['txtMoney3', 15, 0, 1],['txtMoney4', 15, 0, 1],['txtMoney5', 15, 0, 1],['txtMoney6', 15, 0, 1],['txtMoney7', 15, 0, 1],['txtCh_health2', 15, 0, 1],
        	['txtCh_retire2', 15, 0, 1],['txtCh_retire', 15, 0, 1],['txtSa_health', 15, 0, 1],['txtSa_labor', 15, 0, 1],['txtSa_retire', 15, 0, 1]
        	];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        aPop = new Array(
        	['txtSno_', 'lblSno', 'sss', 'noa,namea', 'txtSno_,txtNamea_', 'sss_b.aspx'],
        	['txtPartno_', 'btnPartno_', 'part', 'noa,part', 'txtPartno_,txtPart_', "part_b.aspx"]
        );
        
		q_desc=1;
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  
            q_gt(q_name, q_content, q_sqlCount, 1)
        });
        
        //////////////////   end Ready
        function main() {
            if (dataErr) 
            {
                dataErr = false;
                return;
            }

            mainForm(1); 
        }  
        
		//紀錄工作開始日期、結束日期和工作天數(上期、下期、本月)
		var date_1='',date_2='',date_3='',date_4='',dtmp=0;
		
        function mainPost() {
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];
            q_mask(bbmMask);
            
            q_cmbParse("cmbPerson", q_getPara('person.typea'));
            q_cmbParse("cmbMonkind", ('').concat(new Array( '本月','上期', '下期')));
            q_cmbParse("cmbTypea", ('').concat(new Array('薪資')));
			
			$('#txtDatea').focusout(function () {
				q_cd( $(this).val() ,$(this));
			});
            
            $('#cmbPerson').change(function () {
            	 table_change();
            	 check_insed();
            });
            
            $('#cmbMonkind').change(function () {
            	getdtmp();
            	check_insed();
            });
            
            $('#txtMon').blur(function () {
            	if($('#txtMon').val().length!=6||$('#txtMon').val().indexOf('/')!=3){
            		if($('#txtMon').val().length==5&&$('#txtMon').val().indexOf('/')==-1)
            			$('#txtMon').val($('#txtMon').val().substr(0,3)+'/'+$('#txtMon').val().substr(3,2));
            		else{
            			alert('月份欄位錯誤請，重新輸入!!!');
            			$('#txtMon').focus();
            			return;
            		}
            	}
            	
            	getdtmp();
            	check_insed();
            });
            
            $('#btnInput').click(function () {
            	//抓取全勤判斷
            	if(q_cur==1 ||q_cur==2){
            		q_func('qtxt.query.bofull_dj', 'saladd.txt,bofull_dj,' + encodeURI($('#txtMon').val()));
		        }
            });
            
            $('#btnBank').click(function() {
            	q_func('banktran.gen', $('#txtNoa').val()+',4');
            });
            
            //隱藏控制
            $('#btnHidesalary').click(function() {
            	if($('#btnHidesalary').val().indexOf("隱藏")>-1){
            		$('.btn1').hide();
	            	 $('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-700)+"px");
	            	scroll("tbbs","box",1);
					$("#btnHidesalary").val("薪資顯示");
				}else{
					$('.btn1').show();
					if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
						$('.person1.btn1').hide();$('.person2.btn1').hide();$('.person3.btn1').hide();$('.person4.btn1').show();
					}else if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
						$('.person1.btn1').hide();$('.person3.btn1').hide();$('.person4.btn1').hide();$('.person2.btn1').show();
					}else if($('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
						$('.person1.btn1').hide();$('.person2.btn1').hide();$('.person4.btn1').hide();$('.person3.btn1').show();
					}else{
						$('.person2.btn1').hide();$('.person3.btn1').hide();$('.person4.btn1').hide();$('.person1.btn1').show();
					}

	            	 $('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+700)+"px");
	            	 scroll("tbbs","box",1);
					$("#btnHidesalary").val("薪資隱藏");
				}
            });
            
            $('#btnHideday').click(function() {
            	if($('#btnHideday').val().indexOf("隱藏")>-1){
            		$('.btn2').hide();
					if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1)
	            		$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-1149)+"px");
	            	else
	            		$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-1249)+"px");
	            	scroll("tbbs","box",1);
					$("#btnHideday").val("出勤顯示");
				}else{
					$('.btn2').show();
					if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
						$('.person1.btn2').hide();$('.person2.btn2').hide();$('.person3.btn2').hide();$('.person4.btn2').show();
					}else if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
						$('.person1.btn2').hide();$('.person3.btn2').hide();$('.person4.btn2').hide();$('.person2.btn2').show();
					}else if($('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
						$('.person1.btn2').hide();$('.person2.btn2').hide();$('.person4.btn2').hide();$('.person3.btn2').show();
					}else{
						$('.person2.btn2').hide();$('.person3.btn2').hide();$('.person4.btn2').hide();$('.person1.btn2').show();
					}
					
	            	if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1)
	            		$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+1149)+"px");
	            	else
	            		$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+1249)+"px");
	            	 scroll("tbbs","box",1);
					$("#btnHideday").val("出勤隱藏");
				}
            });
            
            $('#btnHideaddmoney').click(function() {
            	if($('#btnHideaddmoney').val().indexOf("隱藏")>-1){
					$('.btn3').hide();
	            	$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-1400)+"px");
	            	scroll("tbbs","box",1);
					$("#btnHideaddmoney").val("加班費顯示");
				}else{
					$('.btn3').show();
					if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
						$('.person1.btn3').hide();$('.person2.btn3').hide();$('.person3.btn3').hide();$('.person4.btn3').show();
					}else if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
						$('.person1.btn3').hide();$('.person3.btn3').hide();$('.person4.btn3').hide();$('.person2.btn3').show();
					}else if($('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
						$('.person1.btn3').hide();$('.person2.btn3').hide();$('.person4.btn3').hide();$('.person3.btn3').show();
					}else{
						$('.person2.btn3').hide();$('.person3.btn3').hide();$('.person4.btn3').hide();$('.person1.btn3').show();
					}
	            	 $('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+1400)+"px");
	            	 scroll("tbbs","box",1);
					$("#btnHideaddmoney").val("加班費隱藏");
				}
            });
            
            $('#btnHidetotal4').click(function() {
            	if($('#btnHidetotal4').val().indexOf("隱藏")>-1){
					$('.btn4').hide();
	            	 if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1)
	            		$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-1300)+"px");
	            	else
	            		$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-1100)+"px");
	            	scroll("tbbs","box",1);
					$("#btnHidetotal4").val("應扣詳細顯示");
				}else{
					$('.btn4').show();
					if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
						$('.person1.btn4').hide();$('.person2.btn4').hide();$('.person3.btn4').hide();$('.person4.btn4').show();
					}else if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
						$('.person1.btn4').hide();$('.person3.btn4').hide();$('.person4.btn4').hide();$('.person2.btn4').show();
					}else if($('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
						$('.person1.btn4').hide();$('.person2.btn4').hide();$('.person4.btn4').hide();$('.person3.btn4').show();
					}else{
						$('.person2.btn4').hide();$('.person3.btn4').hide();$('.person4.btn4').hide();$('.person1.btn4').show();
					}
	            	if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1)
	            		$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+1300)+"px");
	            	else
	            		$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+1100)+"px");
	            	 scroll("tbbs","box",1);
					$("#btnHidetotal4").val("應扣詳細隱藏");
				}
            });
            
            $('#btnHidesalaryinsure').click(function() {
            	if($('#btnHidesalaryinsure').val().indexOf("隱藏")>-1){
					$('.btn5').hide();
	            	 $('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-600)+"px");
	            	scroll("tbbs","box",1);
					$("#btnHidesalaryinsure").val("投保薪資顯示");
				}else{
					$('.btn5').show();
					if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
						$('.person1.btn5').hide();$('.person2.btn5').hide();$('.person3.btn5').hide();$('.person4.btn5').show();
					}else if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
						$('.person1.btn5').hide();$('.person3.btn5').hide();$('.person4.btn5').hide();$('.person2.btn5').show();
					}else if($('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
						$('.person1.btn5').hide();$('.person2.btn5').hide();$('.person4.btn5').hide();$('.person3.btn5').show();
					}else{
						$('.person2.btn5').hide();$('.person3.btn5').hide();$('.person4.btn5').hide();$('.person1.btn5').show();
					}
	            	 $('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+600)+"px");
	            	 scroll("tbbs","box",1);
					$("#btnHidesalaryinsure").val("投保薪資隱藏");
				}
            });
            
        }
		var checkenda=false;
		var holiday;//存放holiday的資料
		var sssr;//存放sssr的資料
		function endacheck(x_datea,x_day) {
			//102/06/21 7月份開始資料3日後不能在處理
			var t_date=x_datea,t_day=1;
                
			while(t_day<x_day){
				var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
				nextdate.setDate(nextdate.getDate() +1)
				t_date=''+(nextdate.getFullYear()-1911)+'/';
				//月份
				t_date=t_date+((nextdate.getMonth()+1)<10?('0'+(nextdate.getMonth()+1)+'/'):((nextdate.getMonth()+1)+'/'));
				//日期
				t_date=t_date+(nextdate.getDate()<10?('0'+(nextdate.getDate())):(nextdate.getDate()));
	                	
				//六日跳過
				if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0 //日
				||new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6 //六
				){continue;}
	                	
				//假日跳過
				if(holiday){
					var isholiday=false;
					for(var i=0;i<holiday.length;i++){
						if(holiday[i].noa==t_date){
							isholiday=true;
							break;
						}
					}
					if(isholiday) continue;
				}
	                	
				t_day++;
			}
                
			if (t_date<q_date()){
				checkenda=true;
			}else{
				checkenda=false;
			}
		}
		
		var bofullas=[];
		function q_funcPost(t_func, result) {
			if(t_func=='qtxt.query.bofull_dj'){
				bofullas = _q_appendData("tmp0", "", true, true);
				//抓取停職資料
				q_gt('sssr',"where=^^ '"+$('#txtMon').val()+"' between left(stopdate,6) and left(dbo.q_cdn(reindate,-1),6) ^^", 0, 0, 0, "sssr", r_accy);
			}else{
		        var s1 = location.href;
		        var t_path = (s1.substr(7, 5) == 'local' ? xlsPath : s1.substr(0, s1.indexOf('/', 10)) + '/htm/');
		        if (t_func == 'banktran.gen') {
		            window.open(t_path + 'obtdta.txt', "_blank", 'directories=no,location=no,menubar=no,resizable=1,scrollbars=1,status=0,toolbar=1');
		            return;
		        }

		        if (result.length > 0) {
		            var s2 = result.split(';');
		            for (var i = 0; i < s2.length; i++) {
		                switch (i) {
		                    case 0:
		                        $('#txtAccno1').val(s2[i]);
		                        break;
		                    case 1:
		                        $('#txtAccno2').val(s2[i]);
		                        break;
		                    case 2:
		                        $('#txtAccno3').val(s2[i]);
		                        break;
		                    case 3:
		                        $('#txtChkeno').val(s2[i]);
		                        break;
		                    case 4:
		                        $('#txtMemo').val(s2[i]);
		                        break;
		                } //end switch
		            } //end for
		        } //end  if
		        alert('功能執行完畢');
			}	
		} //endfunction
		
        function q_boxClose(s2) { 
           var ret; 
            switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }

		var imports=false;
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'holiday':
            		holiday = _q_appendData("holiday", "", true);
            		endacheck($('#txtDatea').val(),q_getPara('sys.modiday'));//單據日期,幾天後關帳
            		break;
            	case 'sssr':
            		sssr = _q_appendData("sssr", "", true);
            		
            		var t_where = "where=^^ a.person='"+$('#cmbPerson').find("option:selected").text()+"' and a.noa!='Z001'^^";
            		var t_where1 = "where[1]=^^ noa=a.noa and sysgen='1' and mon='"+$('#txtMon').val()+"' ^^";
            		var t_where2 = "where[2]=^^ sssno=a.noa and mon='"+$('#txtMon').val()+"' ^^";
            		var t_where3 = "where[3]=^^ sssno=a.noa and noa between '"+date_1+"' and '"+date_2+"' and noa>=a.indate ^^";
            		var t_where4 = "where[4]=^^ sssno=a.noa and noa between '"+date_3+"' and '"+date_4+"' and noa>=a.indate ^^";
	            	var t_where5 = "where[5]=^^ sssno=a.noa and bdate between '"+date_1+"' and '"+date_2+"' and bdate>=a.indate ^^";
	            	var t_where6 = "where[6]=^^ noa=a.noa and datea<='"+date_2+"' ^^";
					var t_where7 = "where[7]=^^ sssno=a.noa and datea between '"+date_1+"' and '"+date_2+"' and isnull(isapv,0)=1 ^^";
					
			        q_gt('salary_dj_import', t_where+t_where1+t_where2+t_where3+t_where4+t_where5+t_where6+t_where7 , 0, 0, 0, "", r_accy);
			        $('#txtChangedata').val('');
            		break;
                case 'salary_dj_import':  
						var as = _q_appendData("sss", "", true);
						imports=true;
						for (var i = 0; i < as.length; i++) {
							//判斷是否哪些員工要計算薪水 //106/02/15 有離職日當月不會匯入(當天離職會先發，不會等到月底才匯入),除復職日有打
		                    if ((!emp(as[i].outdate) && as[i].outdate<=date_2 && (as[i].reindate=='' || as[i].reindate<date_1)) || as[i].indate > date_2) {
		                        as.splice(i, 1);
		                        i--;
		                    }else{
		                    	//新進員工薪資(不滿一個月)=本俸+主管津貼+交通津貼+工作津貼+其他津貼/30*工作天數(且福利金=0全勤=0) 5/3含六日
		                    	if(as[i].indate>=date_1){//計算工作天數
		                    		var t_date=as[i].indate,inday=0;
		                    		if(!emp(as[i].outdate) && as[i].outdate <= date_2)//當月離職
		                    			inday=dec(as[i].outdate.substr(7,2))-dec(t_date.substr(7,2))+1
		                    		else
		                    			inday=dec(date_2.substr(7,2))-dec(t_date.substr(7,2))+1
		                    		
		                    		if(inday>30)
		                    			inday=30;
		                    		else
		                    			as[i].bo_full=0;
		                    				                    		
		                    		as[i].memo="新進員工(工作日:"+inday+")";
		                    		as[i].iswelfare='false';
		                    	}
		                    	
		                    	//離職員工
		                    	if(as[i].indate < date_1 && !emp(as[i].outdate) && as[i].outdate <= date_2){
		                    		var t_date=as[i].outdate,inday=0;
		                    		inday=dec(t_date.substr(7,2))-dec(date_1.substr(7,2))+1
		                    		
		                    		if(inday>30) inday=30;
		                    		
		                    		as[i].memo="離職員工(工作日:"+inday+")";
		                    		as[i].iswelfare='false';
		                    		
		                    		//滿一個月才有全勤
		                    		if(t_date!=date_2)
		                    			as[i].bo_full=0;
		                    	}
		                    	
			                    //請假扣薪
			                    if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
			                    	as[i].day= dec(as[i].inday);//給薪日數=上班天數
			                    	as[i].mi_saliday=0;
			                    }else if ($('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
			                    	as[i].day= dec(as[i].hrs);//給薪日數=上班天數
			                    	as[i].mi_saliday=0;
			                    }else{
			                    	as[i].day=0;
			                    }
			                    
			                    //伙食費
			                    as[i].meals=q_add(q_mul(dec(as[i].meals),dec(as[i].inday)),q_mul(dec(as[i].meals),dec(as[i].addmealday)));	
			                    	
			                    //全勤獎金
			                    //曠職一律沒有全勤
								//事病假 當日請假2小時內 不扣 (上下期只能各1次否則扣全部) ,半天扣1/2,1天 扣全部
								//遲到 15分內 上下期各3次以上 扣1/2
								//16~30分 扣時薪半小時 上下期各1 第2次以上扣1/2
								//0~30 超過3次 第4次 扣全部
								//因沒有曠職假別所以也要更新
								//遲到30分鐘 轉 事假
								for (var k=0;k<bofullas.length;k++){
									if(bofullas[k].sssno==as[i].sssno){
										as[i].bo_full=round(q_mul(as[i].bo_full,dec(bofullas[k].bofull)),0)
										as[i].hr_leave=bofullas[k].leave;
										as[i].hr_person=q_add(dec(as[i].hr_person),dec(bofullas[k].cb));
										break;
									}
								}
			                    
			                    //只要有請假與遲到一律都沒有全勤獎金
								/*if((dec(as[i].hr_sick)+dec(as[i].hr_person)+dec(as[i].hr_leave)+dec(as[i].hr_nosalary)+dec(as[i].late))>0){
									as[i].bo_full=0;
								}*/
		                    	
		                    	//停職扣薪 寫在無薪(避免扣到全勤 放在處理全勤後面)
			                    for (var j = 0; j < sssr.length; j++) {
			                    	if(as[i].sssno==sssr[j].noa){
			                    		//判斷是否整個月都停職
			                    		if(date_1>=sssr[j].stopdate && date_2<sssr[j].reindate){//整個月都停職
			                    			as[i].hr_nosalary=30*8;//整個月的時數
			                    			as[i].bo_full=0;//整月停職則無全勤
			                    		}else{ //當月停職
			                    			var x_date=date_1,x_count=0;
			                    			while(x_date<=date_2){
			                    				if(x_date>=sssr[j].stopdate && x_date<sssr[j].reindate){
			                    					x_count++;
			                    				}
			                    				x_date=q_cdn(x_date,1);
			                    			}
			                    			as[i].hr_nosalary=dec(as[i].hr_nosalary)+x_count*8;//停職天數的時數
			                    		}
			                    	}
			                    }
		                    	
		                    	
		                    }
						}//end for
						
						
						if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1 || $('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
							/*q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea,txtPartno,txtPart,txtDaymoney,txtBo_admin,txtBo_traffic,txtBo_special,txtBo_oth,txtDay,txtMi_saliday,txtAddh2_1,txtAddh2_2,txtChgcash,txtRaise_num,txtLate,txtHr_sick,txtHr_person,txtHr_nosalary,txtHr_leave,txtMemo,txtPlus,txtMinus,txtBorrow,txtBo_full,txtCh_health,txtCh_labor,txtCh_retire,txtHplus2,txtCh_health2,txtCh_labor2,txtCh_retire2,txtSa_health,txtSa_labor,txtSa_retire,txtTax,txtMoney3'
															, as.length, as
                                                           , 'sssno,namea,partno,part,salary,bo_admin,traffic,bo_special,bo_oth,day,mi_saliday,saddh1,saddh2,chgcash,mount,late,hr_sick,hr_person,hr_nosalary,hr_leave,memo,plus,minus,borrow,bo_full,he_person,la_person,re_person,hplus2,he_comp,la_comp,re_comp,sa_health,sa_labor,sa_retire,tax,bo_money1'
                                                           , '');*/
							q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea,txtPartno,txtPart,txtDaymoney,txtBo_admin,txtBo_traffic,txtBo_special,txtBo_oth,txtDay,txtMi_saliday,txtAddh2_1,txtAddh2_2,txtRaise_num,txtLate,txtHr_sick,txtHr_person,txtHr_nosalary,txtHr_leave,txtMemo,txtPlus,txtMinus,txtBorrow,txtBo_full,txtCh_health,txtCh_labor,txtCh_retire,txtHplus2,txtCh_health2,txtCh_labor2,txtCh_retire2,txtSa_health,txtSa_labor,txtSa_retire,txtTax,txtMoney3'
															, as.length, as
                                                           , 'sssno,namea,partno,part,salary,bo_admin,traffic,bo_special,bo_oth,day,mi_saliday,saddh1,saddh2,mount,late,hr_sick,hr_person,hr_nosalary,hr_leave,memo,plus,minus,borrow,bo_full,he_person,la_person,re_person,hplus2,he_comp,la_comp,re_comp,sa_health,sa_labor,sa_retire,tax,bo_money1'
                                                           , '');
                                                           
						}else{
                         	/*q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea,txtPartno,txtPart,txtMoney,txtBo_admin,txtBo_traffic,txtBo_special,txtBo_oth,txtCh_labor1,txtCh_labor2,txtCh_health_insure,txtDay,txtMi_saliday,txtAddh2_1,txtAddh2_2,txtChgcash,txtRaise_num,txtLate,txtHr_sick,txtHr_person,txtHr_nosalary,txtHr_leave,txtMemo,txtPlus,txtMinus,txtBorrow,txtBo_full,txtMi_sick,txtMi_person,txtMi_nosalary,txtMi_leave,txtBo_born,txtBo_night,txtBo_duty,txtTax_other,txtMeals,txtCh_health,txtCh_labor,txtCh_retire,txtHplus2,txtCh_health2,txtCh_labor2,txtCh_retire2,txtSa_health,txtSa_labor,txtSa_retire,txtTax,txtMoney3'
															, as.length, as
                                                           , 'sssno,namea,partno,part,salary,bo_admin,traffic,bo_special,bo_oth,ch_labor1,ch_labor2,ch_health_insure,day,mi_saliday,saddh1,saddh2,chgcash,mount,late,hr_sick,hr_person,hr_nosalary,hr_leave,memo,plus,minus,borrow,bo_full,mi_sick,mi_person,mi_nosalary,mi_leave,bo_born,bo_night,bo_day,tax_other,meals,he_person,la_person,re_person,hplus2,he_comp,la_comp,re_comp,sa_health,sa_labor,sa_retire,tax,bo_money1'
                                                           , '');*/
                                                          
							q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea,txtPartno,txtPart,txtMoney,txtBo_admin,txtBo_traffic,txtBo_special,txtBo_oth,txtCh_labor1,txtCh_labor2,txtCh_health_insure,txtDay,txtMi_saliday,txtAddh2_1,txtAddh2_2,txtRaise_num,txtLate,txtHr_sick,txtHr_person,txtHr_nosalary,txtHr_leave,txtMemo,txtPlus,txtMinus,txtBorrow,txtBo_full,txtMi_sick,txtMi_person,txtMi_nosalary,txtMi_leave,txtTax_other,txtMeals,txtCh_health,txtCh_labor,txtCh_retire,txtHplus2,txtCh_health2,txtCh_labor2,txtCh_retire2,txtSa_health,txtSa_labor,txtSa_retire,txtTax,txtMoney3'
															, as.length, as
                                                           , 'sssno,namea,partno,part,salary,bo_admin,traffic,bo_special,bo_oth,ch_labor1,ch_labor2,ch_health_insure,day,mi_saliday,saddh1,saddh2,mount,late,hr_sick,hr_person,hr_nosalary,hr_leave,memo,plus,minus,borrow,bo_full,mi_sick,mi_person,mi_nosalary,mi_leave,tax_other,meals,he_person,la_person,re_person,hplus2,he_comp,la_comp,re_comp,sa_health,sa_labor,sa_retire,tax,bo_money1'
                                                           , '');
                        }
                        
                        //福利金	
						/*for (var j = 0; j < q_bbsCount; j++) {
							for (var i = 0; i < as.length; i++) {
								if($('#txtSno_'+j).val()==as[i].sssno){
									if(as[i].iswelfare=='true')
										$('#chkIswelfare_'+j).prop('checked',true);
				                    else
				                    	$('#chkIswelfare_'+j).prop('checked',false);
				                    break;
								}
							}
						}*/
                        
                         sum();
                    break;

                case q_name:
                	var as = _q_appendData("salary", "", true);
                	if(as[0]!=undefined)
                 		insed=true;
                 	else
                 		insed=false;
                 		
                	if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
		
        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtMon', q_getMsg('lblMon')]]); 
           
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            
            if(insed&&q_cur==1){
            	alert($('#txtMon').val()+'薪資作業已新增!!!');
                return;
            }

            $('#txtWorker').val(r_name);
            $('#txtDate2').val(q_date());
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('S' + $('#txtMon').val(), '/', ''));
            else
                wrServer(s1);
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salary_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPay_chg() {  
        }

        function bbsAssign() {  
        	for(var j = 0; j < q_bbsCount; j++) {
           		if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           			$('#checkSel_' + j).click(function () {
	                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
	                    q_bodyId($(this).attr('id'));
	                    b_seq = t_IdSeq;
						 if($('#checkSel_' +b_seq).prop('checked')){	//判斷是否被選取
		                	$('#trSel_'+ b_seq).addClass('chksel');//變色
		                }else{
		                	$('#trSel_'+b_seq).removeClass('chksel');//取消變色
		                }
	                });
            	}
            }
            $(".tbbs [type='text']").change(function() {
				sum()
			});
            _bbsAssign();
            table_change();
            $('#lblMoney').text('底薪');
            $('#lblBo_admin').text('主管加給');
            $('#lblBo_special').text('技術加給');
            $('#lblBo_full').text('全勤獎金');
            $('#lblBo_oth').text('特別加給');
            
            $('#lblMoneys').text('底薪');
            $('#lblBo_admins').text('主管加給');
            $('#lblBo_specials').text('技術加給');
            $('#lblMeals').text('伙食津貼');
            $('#lblBo_fulls').text('全勤獎金');
            $('#lblBo_oths').text('特別責任加給');
            
            $('#lblMoney1s').text('周六加班費(全天)');
            $('#lblMoney2s').text('周六加班費(半天)');
            $('#lblMoney3s').text('敬業獎金');
            $('#lblMoney4s').text('久任獎金');
            $('#lblMoney5s').text('考績獎金');
            $('#lblMoney6s').text('業務達成獎金');
            $('#lblMoney7s').text('申報實領總薪資');
            
            $('#lblCh_retires').text('個人勞退提繳');
            $('#lblCh_health2s').text('公司負擔健保');
            $('#lblCh_labor2s').text('公司負擔勞保');
            $('#lblCh_retire2s').text('公司負擔勞退');
            $('#lblSa_labors').text('勞保薪資');
            $('#lblSa_retires').text('勞退薪資');
            $('#lblSa_healths').text('健保薪資');
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtMon').val(q_date().substr( 0,6));
            $('#txtMon').focus();
            $('#cmbPerson').val("本國");
            $('#cmbMonkind').val("本月");
            $('#cmbTypea').val("薪資");
            table_change();
            check_insed();
        }
        
        var insed=false;
        function check_insed() {
        	if(q_cur==1){
        	 //判斷是否已新增過
           		var t_where = "where=^^ mon='"+$('#txtMon').val()+"' and person='"+$('#cmbPerson').find("option:selected").text()+"' and monkind='"+$('#cmbMonkind').find("option:selected").text()+"' ^^";
		    	q_gt('salary', t_where , 0, 0, 0, "", r_accy);
		    }
        }
        
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
             if (checkenda){
                alert('超過'+q_getPara('sys.modiday')+'天'+'已關帳!!');
                return;
	    		}
            _btnModi();
            $('#txtMon').focus();
            $('#txtMon').attr('disabled', 'disabled');
            $('#cmbPerson').attr('disabled', 'disabled');
            $('#cmbMonkind').attr('disabled', 'disabled');
            table_change();
        }
        function btnPrint() {
			q_box('z_salaryp_dj.aspx', '', "95%", "95%", q_getMsg("popPrint"));
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   
            if (!as['sno']) {  
                as[bbsKey[1]] = '';  
                return;
            }

            q_nowf();
            as['mon'] = abbm2['mon'];
            
            return true;
        }

        function sum() {
        	//bbs計算
        	getdtmp();
        	for (var j = 0; j < q_bbsCount; j++) {
        		var inday=0;
        		if(($('#txtMemo_'+j).val().indexOf('新進員工')>-1 || $('#txtMemo_'+j).val().indexOf('離職員工')>-1)){
        			inday=dec($('#txtMemo_'+j).val().substr($('#txtMemo_'+j).val().indexOf(':')+1,$('#txtMemo_'+j).val().indexOf(')')-$('#txtMemo_'+j).val().indexOf(':')-1));
        		}
        		if(($('#txtMemo_'+j).val().indexOf('新進員工')>-1 || $('#txtMemo_'+j).val().indexOf('離職員工')>-1 )&&imports){
        			inday=dec($('#txtMemo_'+j).val().substr($('#txtMemo_'+j).val().indexOf(':')+1,$('#txtMemo_'+j).val().indexOf(')')-$('#txtMemo_'+j).val().indexOf(':')-1));
        			q_tr('txtMoney_'+j,round((dec($('#txtMoney_'+j).val()))/30*inday,0));
        			q_tr('txtBo_admin_'+j,round((dec($('#txtBo_admin_'+j).val()))/30*inday,0));
        			//q_tr('txtBo_traffic_'+j,round((dec($('#txtBo_traffic_'+j).val()))/30*inday,0)); // 交通津貼 會根據當月申請的費用
        			q_tr('txtBo_special_'+j,round((dec($('#txtBo_special_'+j).val()))/30*inday,0));
        			q_tr('txtBo_oth_'+j,round((dec($('#txtBo_oth_'+j).val()))/30*inday,0));
        		}
        		
        		q_tr('txtTotal1_'+j,dec($('#txtMoney_'+j).val())+dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_traffic_'+j).val())+dec($('#txtBo_special_'+j).val())+dec($('#txtBo_oth_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtMeals_'+j).val()));
        		
        		if($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1 || $('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
        			q_tr('txtTotal1_'+j,dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_traffic_'+j).val())+dec($('#txtBo_special_'+j).val())+dec($('#txtBo_oth_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtMeals_'+j).val()));
        			q_tr('txtMtotal_'+j,Math.round(dec($('#txtDaymoney_'+j).val())*dec($('#txtDay_'+j).val())));//給薪金額
        			q_tr('txtTotal2_'+j,Math.round((dec($('#txtTotal1_'+j).val())+dec($('#txtMtotal_'+j).val())+dec($('#txtTax_other_'+j).val()))));//給付總額
        			
        			if($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
	        			//勞基法加班費基數=日薪+主管津貼+工作津貼+其他津貼+全勤+伙食津貼+交通津貼
	        			q_tr('txtOstand_'+j,Math.round(((dec($('#txtDaymoney_'+j).val())+dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_special_'+j).val())
	        			//+dec($('#txtBo_oth_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtMeals_'+j).val())+dec($('#txtBo_traffic_'+j).val()) 
	        			)/8)*100)/100);//加班費基數(取小數點兩位並四捨五入)
        			}
        			if($('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
	        			//勞基法加班費基數=日薪+主管津貼+工作津貼+其他津貼+全勤
	        			q_tr('txtOstand_'+j,Math.round(((dec($('#txtDaymoney_'+j).val())+dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_special_'+j).val())
	        			//+dec($('#txtBo_oth_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtMeals_'+j).val())+dec($('#txtBo_traffic_'+j).val()) 
	        			))*100)/100);//加班費基數(取小數點兩位並四捨五入)
        			}
        			
        			//當有核取時加班費金額可以直接修改
        			if(!$('#chkIsmanual_'+j).prop('checked'))
        				q_tr('txtAddmoney_'+j,Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh2_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.66*dec($('#txtAddh2_2_'+j).val())));//加班費
        			//應領總額=給付總額+加班費+免稅其他
        			q_tr('txtTotal3_'+j,Math.round(dec($('#txtTotal2_'+j).val())+dec($('#txtAddmoney_'+j).val())//+dec($('#txtTax_other2_'+j).val())
        			+dec($('#txtMoney1_'+j).val())+dec($('#txtMoney2_'+j).val())+dec($('#txtMoney3_'+j).val())+dec($('#txtMoney4_'+j).val())+dec($('#txtMoney5_'+j).val())+dec($('#txtMoney6_'+j).val())+dec($('#txtPlus_'+j).val())));
		        		
        		}else if(($('#cmbMonkind').find("option:selected").text().indexOf('上期')>-1)||($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1)){
        			//勞基法加班費基數=本俸+主管津貼+工作津貼+其他津貼+全勤
        			if(inday>0)
        				q_tr('txtOstand_'+j,Math.round(((dec($('#txtMoney_'+j).val())+dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_special_'+j).val())
        				//+dec($('#txtBo_oth_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtMeals_'+j).val())+dec($('#txtBo_traffic_'+j).val())
        				 )/inday/8)*100)/100);//加班費基數(取小數點兩位並四捨五入)
        			else
	        			q_tr('txtOstand_'+j,Math.round(((dec($('#txtMoney_'+j).val())+dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_special_'+j).val())
	        			//+dec($('#txtBo_oth_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtMeals_'+j).val())+dec($('#txtBo_traffic_'+j).val()) 
	        			)/15/8)*100)/100);//加班費基數(取小數點兩位並四捨五入)
        			
        			//當有核取時扣薪時數和扣薪金額可以直接修改 //暫定用加班費基數扣
        			if(!$('#chkIsmanual_'+j).prop('checked')){
		        		q_tr('txtMi_sick_'+j,round(q_float('txtOstand_'+j)*q_float('txtHr_sick_'+j)/2,0));
			            q_tr('txtMi_person_'+j,round(q_float('txtOstand_'+j)*q_float('txtHr_person_'+j),0));
			            q_tr('txtMi_nosalary_'+j,round(q_float('txtOstand_'+j)*q_float('txtHr_nosalary_'+j),0));
			            q_tr('txtMi_leave_'+j,round(q_float('txtOstand_'+j)*q_float('txtHr_leave_'+j),0));
			            
			            q_tr('txtMi_saliday_'+j,Math.round(dec($('#txtHr_sick_'+j).val())+dec($('#txtHr_person_'+j).val())+dec($('#txtHr_nosalary_'+j).val())+dec($('#txtHr_leave_'+j).val())));//扣薪時數=病假+事假+事假+曠工金額
	        			q_tr('txtMi_total_'+j,Math.round(dec($('#txtMi_sick_'+j).val())+dec($('#txtMi_person_'+j).val())+dec($('#txtMi_nosalary_'+j).val())+dec($('#txtMi_leave_'+j).val())));//扣薪金額=病假+事假+事假+曠工金額
        			}
        			
        			//q_tr('txtTotal2_'+j,Math.round(dec($('#txtTotal1_'+j).val())-dec($('#txtMi_total_'+j).val())+dec($('#txtBo_born_'+j).val())+dec($('#txtBo_night_'+j).val())+dec($('#txtBo_duty_'+j).val())+dec($('#txtTax_other_'+j).val())));//給付總額
        			q_tr('txtTotal2_'+j,Math.round(dec($('#txtTotal1_'+j).val())-dec($('#txtMi_total_'+j).val())+dec($('#txtTax_other_'+j).val())));//給付總額
        			
        			//當有核取時加班費金額可以直接修改
        			if(!$('#chkIsmanual_'+j).prop('checked'))
        				q_tr('txtAddmoney_'+j,Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh2_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.66*dec($('#txtAddh2_2_'+j).val()))
        				+Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh46_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.66*dec($('#txtAddh46_2_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1*dec($('#txtAddh100_'+j).val()))
        				);//加班費
        				
        			q_tr('txtTotal3_'+j,Math.round(dec($('#txtTotal2_'+j).val())+dec($('#txtAddmoney_'+j).val())//+dec($('#txtTax_other2_'+j).val())
        			+dec($('#txtMoney1_'+j).val())+dec($('#txtMoney2_'+j).val())+dec($('#txtMoney3_'+j).val())+dec($('#txtMoney4_'+j).val())+dec($('#txtMoney5_'+j).val())+dec($('#txtMoney6_'+j).val())+dec($('#txtPlus_'+j).val())));
        			
        		}else {//本月
        			//勞基法加班費基數=本俸+主管津貼+工作津貼+其他津貼+全勤
        			if(inday>0)
	        			q_tr('txtOstand_'+j,Math.round(((dec($('#txtMoney_'+j).val())+dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_special_'+j).val())
	        			//+dec($('#txtBo_oth_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtMeals_'+j).val())+dec($('#txtBo_traffic_'+j).val()) 
	        			)/inday/8)*100)/100);//加班費基數(取小數點兩位並四捨五入)
	        		else
	        			q_tr('txtOstand_'+j,Math.round(((dec($('#txtMoney_'+j).val())+dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_special_'+j).val())
	        			//+dec($('#txtBo_oth_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtMeals_'+j).val())+dec($('#txtBo_traffic_'+j).val()) 
	        			)/30/8)*100)/100);//加班費基數(取小數點兩位並四捨五入)
        			
        			//當有核取時扣薪時數和扣薪金額可以直接修改
        			if(!$('#chkIsmanual_'+j).prop('checked')){
		                q_tr('txtMi_sick_'+j,round(q_float('txtOstand_'+j)*q_float('txtHr_sick_'+j)/2,0));
			            q_tr('txtMi_person_'+j,round(q_float('txtOstand_'+j)*q_float('txtHr_person_'+j),0));
			            q_tr('txtMi_nosalary_'+j,round(q_float('txtOstand_'+j)*q_float('txtHr_nosalary_'+j),0));
			            q_tr('txtMi_leave_'+j,round(q_float('txtOstand_'+j)*q_float('txtHr_leave_'+j),0));
		                
		                q_tr('txtMi_saliday_'+j,Math.round(dec($('#txtHr_sick_'+j).val())+dec($('#txtHr_person_'+j).val())+dec($('#txtHr_nosalary_'+j).val())+dec($('#txtHr_leave_'+j).val())));//扣薪時數=病假+事假+事假+曠工金額
	        			q_tr('txtMi_total_'+j,Math.round(dec($('#txtMi_sick_'+j).val())+dec($('#txtMi_person_'+j).val())+dec($('#txtMi_nosalary_'+j).val())+dec($('#txtMi_leave_'+j).val())));//扣薪金額=病假+事假+事假+曠工金額	
        			}
        			//q_tr('txtTotal2_'+j,Math.round(dec($('#txtTotal1_'+j).val())-dec($('#txtMi_total_'+j).val())+dec($('#txtBo_born_'+j).val())+dec($('#txtBo_night_'+j).val())+dec($('#txtBo_duty_'+j).val())+dec($('#txtTax_other_'+j).val())));//給付總額
        			q_tr('txtTotal2_'+j,Math.round(dec($('#txtTotal1_'+j).val())-dec($('#txtMi_total_'+j).val())+dec($('#txtTax_other_'+j).val())));//給付總額
        			
        			//當有核取時加班費金額可以直接修改
        			if(!$('#chkIsmanual_'+j).prop('checked'))
        				q_tr('txtAddmoney_'+j,Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh2_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.66*dec($('#txtAddh2_2_'+j).val()))
        				+Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh46_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.66*dec($('#txtAddh46_2_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1*dec($('#txtAddh100_'+j).val()))
        				);//加班費
        			
        			q_tr('txtTotal3_'+j,Math.round(dec($('#txtTotal2_'+j).val())+dec($('#txtAddmoney_'+j).val())//+dec($('#txtTax_other2_'+j).val())
        			+dec($('#txtMoney1_'+j).val())+dec($('#txtMoney2_'+j).val())+dec($('#txtMoney3_'+j).val())+dec($('#txtMoney4_'+j).val())+dec($('#txtMoney5_'+j).val())+dec($('#txtMoney6_'+j).val())+dec($('#txtPlus_'+j).val())));//應領總額
        		}
        		
        		//福利金
        		//if(!($('#chkIswelfare_'+j).prop('checked')))
		        //	q_tr('txtWelfare_'+j,0);
        		
        		//應扣總額 //+dec($('#txtChgcash_'+j).val())+dec($('#txtStay_tax_'+j).val())+dec($('#txtLodging_power_fee_'+j).val())+dec($('#txtWelfare_'+j).val())+dec($('#txtStay_money_'+j).val())
				q_tr('txtTotal4_'+j,Math.round(dec($('#txtBorrow_'+j).val())+dec($('#txtTax6_'+j).val())+dec($('#txtTax12_'+j).val())+dec($('#txtTax18_'+j).val())
				+dec($('#txtCh_health_'+j).val())+dec($('#txtCh_labor_'+j).val())+dec($('#txtCh_retire_'+j).val())+dec($('#txtHplus2_'+j).val())
				+dec($('#txtTax_'+j).val())+dec($('#txtTax5_'+j).val())+dec($('#txtMinus_'+j).val())));
				//實發金額=應領總額-應扣總額
        		q_tr('txtTotal5_'+j,Math.round(dec($('#txtTotal3_'+j).val())-dec($('#txtTotal4_'+j).val())));
        		
        		//申報實領總薪資
        		q_tr('txtMoney7_'+j,q_float('txtTotal5_'+j)-q_float('txtAddmoney_'+j)-q_float('txtMoney1_'+j)-q_float('txtMoney2_'+j)-q_float('txtMoney3_'+j)-q_float('txtMoney4_'+j)-q_float('txtMoney5_'+j)-q_float('txtMoney6_'+j))
        	}
        	imports=false;
        	//bbm計算
            var monkind=0,t_money=0,t_daymoney=0,t_bo_admin=0,t_bo_traffic=0,t_bo_special=0,t_bo_oth=0,t_bo_full=0,t_tax_other=0
            ,t_mtotal=0,t_mitotal=0,t_addmoney=0,t_borrow=0,t_ch_labor=0,t_ch_health=0,t_ch_labor_comp=0,t_ch_labor_self=0
            ,t_welfare=0,t_total3=0,t_total4=0,t_total5=0,t_minus=0,t_plus=0;
            
            for (var j = 0; j < q_bbsCount; j++) {
				t_money+=dec($('#txtMoney_'+j).val());//本俸
				t_daymoney+=dec($('#txtDaymoney_'+j).val());//日薪
				t_bo_admin+=dec($('#txtBo_admin_'+j).val());//主管津貼
				t_bo_traffic+=dec($('#txtBo_traffic_'+j).val());//交通津貼
				t_bo_full+=dec($('#txtBo_full_'+j).val());//全勤
				t_bo_special+=dec($('#txtBo_special_'+j).val());//特別津貼
				t_bo_oth+=dec($('#txtBo_oth_'+j).val());//其他津貼
				t_tax_other+=dec($('#txtTax_other_'+j).val());//應稅其他
				t_mtotal+=dec($('#txtMtotal_'+j).val());//給薪金額
				t_mitotal+=dec($('#txtMi_total_'+j).val());//扣薪金額
				t_addmoney+=dec($('#txtAddmoney_'+j).val());//加班費
				t_borrow+=dec($('#txtBorrow_'+j).val());//借支
				t_ch_labor+=dec($('#txtCh_labor_'+j).val());//勞保費
				t_ch_health+=dec($('#txtCh_health_'+j).val());//健保費
				t_ch_labor_comp+=dec($('#txtCh_labor_comp_'+j).val());//勞退提繳
				t_ch_labor_self+=dec($('#txtCh_labor_self_'+j).val());//勞退個人
				//t_welfare+=dec($('#txtWelfare_'+j).val());//福利金
				t_total3+=dec($('#txtTotal3_'+j).val());//應領總額
				t_total4+=dec($('#txtTotal4_'+j).val());//應扣總額
				t_total5+=dec($('#txtTotal5_'+j).val());//實發金額
				t_minus+=dec($('#txtMinus_'+j).val());//其他扣款
				t_plus+=dec($('#txtPlus_'+j).val());//其他加項
            } 
            
            q_tr('txtMoney',t_money);//本俸
            q_tr('txtDaymoney',t_daymoney);//日薪
            q_tr('txtBo_admin',t_bo_admin);//主管津貼
            q_tr('txtBo_traffic',t_bo_traffic);//交通津貼
            q_tr('txtBo_full',t_bo_full);//全勤
            q_tr('txtBo_special',t_bo_special);//特別津貼
            q_tr('txtBo_oth',t_bo_oth);//其他津貼
            q_tr('txtTax_other',t_tax_other);//應稅其他         
            q_tr('txtMtotal',Math.round(t_mtotal));//給薪金額
            q_tr('txtMi_total',Math.round(t_mitotal));//扣薪金額
            q_tr('txtAddmoney',t_addmoney);//加班費
            q_tr('txtBorrow',t_borrow);//借支
            q_tr('txtCh_labor',t_ch_labor);//勞保費
            q_tr('txtCh_health',t_ch_health);//健保費
            q_tr('txtCh_labor_comp',t_ch_labor_comp);//勞退提繳
            q_tr('txtCh_labor_self',t_ch_labor_self);//勞退個人
            //q_tr('txtWelfare',Math.round(t_welfare));//福利金
            q_tr('txtTotal3',Math.round(t_total3));//應領總額
            q_tr('txtTotal4',Math.round(t_total4));//應扣總額
            q_tr('txtTotal5',Math.round(t_total5));//實發金額
            q_tr('txtMinus',Math.round(t_minus));//其他扣款
            q_tr('txtPlus',Math.round(t_plus));//其他加項
        }
        
        function refresh(recno) {
            _refresh(recno);
             if(r_rank<=7)
            	q_gt('holiday', "where=^^ noa>='"+$('#txtDatea').val()+"'^^" , 0, 0, 0, "", r_accy);//單據日期之後的假日
            else
            	checkenda=false;
            table_change();
            $('#txtNoa').focus();
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            if (t_para) {
		            $('#btnBank').removeAttr('disabled');
		        }
		        else {
		            $('#btnBank').attr('disabled', 'disabled');
		        }
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield); 
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
        	 if (checkenda){
                alert('超過'+q_getPara('sys.modiday')+'天'+'已關帳!!');
                return;
	    }
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
        
        function getdtmp() {
        	var myDate = new Date(dec($('#txtMon').val().substr( 0,3))+1911,dec($('#txtMon').val().substr( 4,5)),0);
        	var lastday=myDate.getDate();	//取當月最後一天
        	if($('#cmbMonkind').find("option:selected").text().indexOf('上期')>-1){
        		date_1=$('#txtMon').val()+'/01';
        		date_2=$('#txtMon').val()+'/15';
        		dtmp=15;
        	}else if($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1){
        		date_1=$('#txtMon').val()+'/16';
        		date_2=$('#txtMon').val()+'/'+lastday;
        		dtmp=lastday-16+1;
        	}else{
        		date_1=$('#txtMon').val()+'/01';
        		date_2=$('#txtMon').val()+'/'+lastday;
        		if($('#txtMon').val().substr( 4,5)=="02")
        			dtmp=lastday;
        		else
        			dtmp=30;
        	}
        	date_3=$('#txtMon').val()+'/01';
        	date_4=$('#txtMon').val()+'/15';
        	
        	if (q_getPara('sys.project').toUpperCase()=='RB'){
        		var t_premon=q_cdn($('#txtMon').val()+'/01',-1).substr(0,6);//上月
        		var t_prelastday=q_cdn($('#txtMon').val()+'/01',-1).substr(-2);//上月最後一天
        		//薪資結算為上月21~本月20
        		if($('#cmbMonkind').find("option:selected").text().indexOf('上期')>-1){
	        		date_1=t_premon+'/21';
	        		date_2=$('#txtMon').val()+'/05';
	        		dtmp=q_add(q_sub(dec(t_prelastday),20),5);
	        	}else if($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1){
	        		date_1=$('#txtMon').val()+'/06';
	        		date_2=$('#txtMon').val()+'/20';
	        		dtmp=15;
	        	}else{
	        		date_1=t_premon+'/21';
	        		date_2=$('#txtMon').val()+'/20';
	        		if($('#txtMon').val().substr( 4,5)=="02")
	        			dtmp=q_add(q_sub(dec(t_prelastday),20),20);
	        		else
	        			dtmp=30;
	        	}
	        	date_3=t_premon+'/21';
	        	date_4=$('#txtMon').val()+'/05';
        	}
        }
        
        function table_change() {
        	getdtmp();
        	$('.btn1').show();$('.btn2').show();$('.btn3').show();$('.btn4').show();$('.btn5').show();
             if ($('#cmbPerson').find("option:selected").text().indexOf('本國')>-1){
             	$('#tbbs').css("width","6200px");
             	$('.person2').hide();
             	$('.person3').hide();
             	$('.person4').hide();
             	$('.person1').show();
            }else if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
            	$('#tbbs').css("width","6200px");
            	$('.person1').hide();
             	$('.person3').hide();
             	$('.person4').hide();
             	$('.person2').show();
            }else if ($('#cmbPerson').find("option:selected").text().indexOf('時薪')>-1){
            	$('#tbbs').css("width","6200px");
            	$('.person1').hide();
             	$('.person2').hide();
             	$('.person4').hide();
             	$('.person3').show();
            }else{//外勞
            	$('#tbbs').css("width", "6400px");
				$('.person1').hide();
             	$('.person2').hide();
             	$('.person3').hide();
             	$('.person4').show();
            }
            
			$('#btnHidesalary').val("薪資隱藏");
			$('#btnHideday').val("出勤隱藏");
	        $('#btnHidetotal4').val("應扣詳細隱藏");
	        $('#btnHidesalaryinsure').val("投保薪資隱藏");
	        $('#btnHideaddmoney').val("加班費隱藏");
	        
            scroll("tbbs","box",1);
        }
        
		var scrollcount=1;
		//第一個參數指向要產生浮動表頭的table,第二個指向要放置浮動表頭的位置,第三個指要複製的行數(1表示只要複製表頭)
        function scroll(viewid,scrollid,size){
        	//判斷目前有幾個scroll,//主要是隱藏欄位時要重新產生浮動表頭,導致浮動表頭重疊,要刪除重疊的浮動表格,salary_dc才有用到
        	if(scrollcount>1)
        		$('#box_'+(scrollcount-1)).remove();//刪除之前產生的浮動表頭
        	
			var scroll = document.getElementById(scrollid);//取的放置浮動表頭的位置
			var tb2 = document.getElementById(viewid).cloneNode(true);//拷貝要複製表頭的table一份
			var len = tb2.rows.length;//取的table的長度
			for(var i=tb2.rows.length;i>size;i--){//刪除到只需要複製的行數,取得要表頭
		                tb2.deleteRow(size);
			}
			//tb2.rows[0].deleteCell(0);
			//由於btnPlus會複製成兩個所以將複製的btnPlus命名為scrollplus
			tb2.rows[0].cells[0].children[0].id="scrollplus"
			var bak = document.createElement("div");//新增一個div
			bak.id="box_"+scrollcount//設置div的id,提供刪除使用
			scrollcount++;
			scroll.appendChild(bak);//將新建的div加入到放置浮動表頭的位置
			bak.appendChild(tb2);//將浮動表頭加入到新建的div內
			//以下設定新建div的屬性
			bak.style.position = "absolute";
			bak.style.backgroundColor = "#fff";
		    bak.style.display = "block";
			bak.style.left = 0;
			bak.style.top = "0px";
			scroll.onscroll = function(){
				bak.style.top = this.scrollTop+"px";//設定滾動條移動時浮動表頭與div的距離
			}
			$('#scrollplus').click(function () {//讓scrollplus按下時執行btnPlus
	            	$('#btnPlus').click();
	       		});
		}
    </script>
    <style type="text/css">
       
       #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
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
                width: 70%;
                float: right;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:98% ;  
        } 
        .tbbs tr.chksel { background:#FA0300;} 
        
        #box{
		height:500px;
		width: 100%;
		overflow-y:auto;
		position:relative;
		}
    </style>
</head>
<body ondragstart="return false" draggable="false"
        ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
        ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:20%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewMon'> </a></td>
            </tr>
             <tr>   
                  <td><input id="chkBrow.*" type="checkbox" style=' '/></td>                
                  <td align="center" id='mon'>~mon</td>                                     
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width:78%;float:left">
        <table class="tbbm"  id="tbbm"  border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td><span> </span><a id="lblMon" class="lbl"> </a></td>
            <td><input id="txtMon"  type="text" class="txt c1"/></td>
            <td><span> </span><a id="lblPerson" class="lbl"> </a></td>
            <td><select id="cmbPerson" class="txt c1"> </select></td>
            <td><span> </span><a id="lblMonkind" class="lbl"> </a></td>
            <td><select id="cmbMonkind" class="txt c1"> </select></td>
            <td><span> </span><a id="lblType" class="lbl"> </a></td>
            <td><select id="cmbTypea" class="txt c1"> </select></td>
            <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class="td11"><input id="btnInput" type="button" style="width: auto;font-size: medium;"/></td>
        </tr>
        <tr>
        	<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td><input id="txtDatea"  type="text" class="txt c1"/></td>
            <td><span> </span><a id="lblMoney" class="lbl person1 person4"> </a><a id="lblDaymoney" class="lbl person2"> </a><a id="lblHrmoney" class="lbl person3"> </a></td>
            <td><input id="txtMoney"  type="text" class="txt num c1 person1 person4" /><input id="txtDaymoney"  type="text" class="txt num c1 person2 person3" /></td>            
            <td><span> </span><a id="lblBo_admin" class="lbl"> </a></td>
            <td><input id="txtBo_admin"  type="text" class="txt num c1" /></td>
            <td><span> </span><a id="lblBo_traffic" class="lbl"> </a></td>
            <td><input id="txtBo_traffic"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td><span> </span><a id="lblBo_special" class="lbl"> </a></td>
            <td><input id="txtBo_special"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblBo_oth" class="lbl"> </a></td>
            <td><input id="txtBo_oth"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblTax_other" class="lbl"> </a></td>
            <td><input id="txtTax_other"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblMi_total" class="lbl person1 person4"> </a><a id="lblMtotal" class="lbl person2 person3"> </a></td>
            <td><input id="txtMi_total"  type="text" class="txt num c1 person1 person4"/><input id="txtMtotal"  type="text" class="txt num c1 person2 person3"/></td>
            <td colspan="2"><input id="btnBank" type="button" style="float: right;"/></td>
        </tr>
        <tr>
        	<td><span> </span><a id="lblBo_full" class="lbl"> </a></td>
            <td><input id="txtBo_full"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblAddmoney" class="lbl"> </a></td>
            <td><input id="txtAddmoney"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblPlus" class="lbl"> </a></td>
            <td><input id="txtPlus"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblMinus" class="lbl"> </a></td>
            <td><input id="txtMinus"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblDate2" class="lbl"> </a></td>
            <td><input id="txtDate2" type="text" class="txt c1"/></td>
        </tr>
        <tr>
           	<td><span> </span><a id="lblCh_health" class="lbl"> </a></td>
            <td><input id="txtCh_health"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblCh_labor" class="lbl"> </a></td>
            <td><input id="txtCh_labor"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblCh_labor_self" class="lbl"> </a></td>
            <td><input id="txtCh_labor_self"  type="text" class="txt num c1"/>
            	<input id="txtCh_labor_comp"  type="hidden" class="txt num c1"/>
            </td>
            <!--<td><span> </span><a id="lblWelfare" class="lbl"> </a></td>
            <td><input id="txtWelfare"  type="text" class="txt num c1"/></td>-->
            <td><span> </span><a id="lblChangedata" class="lbl" style="color: red;"> </a></td>
            <td colspan="3"><input id="txtChangedata" type="text" class="txt c1"/></td>
        </tr>
        <tr>
        	<td><span> </span><a id="lblTotal3" class="lbl"> </a></td>
            <td><input id="txtTotal3"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblTotal4" class="lbl"> </a></td>
            <td><input id="txtTotal4"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblTotal5" class="lbl"> </a></td>
            <td><input id="txtTotal5"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblBorrow" class="lbl"> </a></td>
            <td><input id="txtBorrow"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblWorker" class="lbl"> </a></td>
            <td><input id="txtWorker" type="text" class="txt c1"/></td>
        </tr>
        </table>
        </div>
        </div>
        <div id="box">
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 6300px;background:#cad3ff;">
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width: 35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;font-size: 16px;"  /> </td>
                <td align="center" style="width: 26px;"><a id='vewChks'>選</a></td>
                <td align="center" style="width: 26px;"><a id='vewIsmanuals'>調</a></td>
                <td align="center" style="width: 100px;"><a id='lblSno'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblNamea'> </a></td>
                <td align="center" style="width: 130px;"><a id='lblPart'> </a></td>
                <td class="person1 person4 btn1" align="center" style="width: 100px;"><a id='lblMoneys'> </a></td>
                <td class="person2 person3 btn1" align="center" style="width: 100px;"><a id='lblDaymoneys' class="person2"> </a><a id='lblHrmoneys' class="person3"> </a></td>
                <td class="btn1" align="center" style="width: 100px;"><a id='lblBo_admins'> </a></td>
                <td class="btn1" align="center" style="width: 100px;"><a id='lblBo_specials'> </a></td>
                <td class="btn1" align="center" style="width: 100px;"><a id='lblBo_fulls'> </a></td>
                <td class="btn1" align="center" style="width: 100px;"><a id='lblMeals'> </a></td>
                <td class="btn1" align="center" style="width: 100px;"><a id='lblBo_traffics'> </a></td>
                <td class="btn1" align="center" style="width: 100px;"><a id='lblBo_oths'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblTotal1s'> </a></td>
                <td class="person2 person3 btn2" align="center" style="width: 100px;"><a id='lblDays' class="person2"> </a><a id='lblHrs' class="person3"> </a></td>
                <td class="person2 person3 btn2" align="center" style="width: 100px;"><a id='lblMtotals'> </a></td>
                <td class="person1 person4 btn2" align="center" style="width: 100px;"><a id='lblMi_salidays'> </a></td>
                <td class="person1 person4 btn2" align="center" style="width: 100px;"><a id='lblMi_totals'> </a></td>
                <td class="btn2" align="center" style="width: 85px;"><a id='lblLate'> </a></td>
                <td class="btn2" align="center" colspan="2" style="width: 216px;"><a id='lblHr_sick'> </a></td>
                <td class="btn2" align="center" colspan="2"  style="width: 216px;"><a id='lblHr_person'> </a></td>
                <td class="btn2" align="center" colspan="2"  style="width: 216px;"><a id='lblHr_nosalary'> </a></td>
                <td class="btn2" align="center" colspan="2" style="width: 216px;"><a id='lblHr_leave'> </a></td>
                <!--<td class="person4 btn2" align="center" style="width: 100px;"><a id='lblBo_borns'> </a></td>
                <td class="person4 btn2" align="center" style="width: 100px;"><a id='lblBo_nights'> </a></td>
                <td class="person4 btn2" align="center" style="width: 100px;"><a id='lblBo_dutys'> </a></td>-->
                <td class="btn2" align="center" style="width: 100px;"><a id='lblTax_others'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblTotal2s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblOstands'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblAddh2_1s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblAddh2_2s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblAddh46_1s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblAddh46_2s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblAddh100s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblAddmoneys'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblMoney1s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblMoney2s'> </a></td>
                <!--<td class="btn3" align="center" style="width: 100px;"><a id='lblTax_other2s'> </a></td>-->
                <td class="btn3" align="center" style="width: 100px;"><a id='lblMoney3s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblMoney4s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblMoney5s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblMoney6s'> </a></td>
                <td class="btn3" align="center" style="width: 100px;"><a id='lblPluss'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblTotal3s'> </a></td>
                <td class="btn4" align="center" style="width: 100px;"><a id='lblBorrows'> </a></td>
                <!--<td class="person4 btn4" align="center" style="width: 100px;"><a id='lblChgcashs'> </a></td>-->
                <td class="person4 btn4" align="center" style="width: 100px;"><a id='lblTax6s'> </a></td>
                <!--<td class="person4 btn4" align="center" style="width: 100px;"><a id='lblStay_taxs'> </a></td>-->
                <td class="person4 btn4" align="center" style="width: 100px;"><a id='lblTax12s'> </a></td>
                <td class="person4 btn4" align="center" style="width: 100px;"><a id='lblTax18s'> </a></td>
                <td class="btn4" align="center" style="width: 100px;"><a id='lblCh_healths'> </a></td>
                <td class="btn4" align="center" style="width: 100px;"><a id='lblCh_labors'> </a></td>
                <td class="btn4" align="center" style="width: 100px;"><a id='lblCh_retires'> </a></td>
                <td class="btn4" align="center" style="width: 100px;"><a id='lblHplus2s'> </a></td>
                <!--<td class="person4 btn4" align="center" style="width: 100px;"><a id='lblLodging_power_fees'> </a></td>-->
                <td class="person1 person2 person3 btn4" align="center" style="width: 100px;"><a id='lblTaxs'> </a></td>
                <td class="person1 person2 person3 btn4" align="center" style="width: 100px;"><a id='lblTax5s'> </a></td>
                <!--<td class="btn4" align="center" style="width: 100px;"><a id='lblWelfares'> </a></td>
                <td class="btn4" align="center" style="width: 26px;"><a id='vewIswelfare'> </a></td>-->
                <!--<td class="person4 btn4" align="center" style="width: 100px;"><a id='lblStay_moneys'> </a></td>-->
                <td class="btn4" align="center" style="width: 100px;"><a id='lblRaise_nums'> </a></td>
                <td class="btn4" align="center" style="width: 100px;"><a id='lblMinuss'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblTotal4s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblTotal5s'> </a></td>
                <td align="center" style="width: 120px;"><a id='lblMoney7s'> </a></td>
                <td class="btn5" align="center" style="width: 100px;"><a id='lblCh_health2s'> </a></td>
                <td class="btn5" align="center" style="width: 100px;"><a id='lblCh_labor2s'> </a></td>
                <td class="btn5" align="center" style="width: 100px;"><a id='lblCh_retire2s'> </a></td>
                <td class="btn5" align="center" style="width: 100px;"><a id='lblSa_healths'> </a></td>
                <td class="btn5" align="center" style="width: 100px;"><a id='lblSa_labors'> </a></td>
                <td class="btn5" align="center" style="width: 100px;"><a id='lblSa_retires'> </a></td>
                <td align="center" style="width: 150px;"><a id='lblMemo'> </a></td>
            </tr>
            <tr  id="trSel.*">
                <td align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;font-size: 16px;float: center;" /></td>
                <td><input id="checkSel.*" type="checkbox"/></td>
                <td><input id="chkIsmanual.*" type="checkbox"/></td>
                <td><input class="txt c1" id="txtSno.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
                <td><input class="txt c1" id="txtNamea.*" type="text" /></td>
                <td>
					<input type="button" id="btnPartno.*" style="width:1%;float:left;" value=".">
					<input class="txt c4" id="txtPartno.*" type="text" />
					<input class="txt c3" id="txtPart.*" type="text" />
				</td>
                <td class="person1 person4 btn1"><input class="txt num c1" id="txtMoney.*" type="text" /></td>
                <td class="person2 person3 btn1"><input class="txt num c1" id="txtDaymoney.*" type="text" /></td>
                <td class="btn1"><input class="txt num c1" id="txtBo_admin.*" type="text" /></td>
                <td class="btn1"><input class="txt num c1" id="txtBo_special.*" type="text"/></td>
                <td class="btn1"><input class="txt num c1" id="txtBo_full.*" type="text"/></td>
                <td class="btn1"><input class="txt num c1" id="txtMeals.*" type="text"/></td>
                <td class="btn1"><input class="txt num c1" id="txtBo_traffic.*" type="text" /></td>
                <td class="btn1"><input class="txt num c1" id="txtBo_oth.*" type="text" /></td>
                <td><input class="txt num c1" id="txtTotal1.*" type="text" /></td>
                <td class="person2 person3 btn2"><input class="txt num c1" id="txtDay.*" type="text" /></td>
                <td class="person2 person3 btn2"><input class="txt num c1" id="txtMtotal.*" type="text" /></td>
                <td class="person1 person4 btn2"><input class="txt num c1" id="txtMi_saliday.*" type="text" /></td>
                <td class="person1 person4 btn2"><input class="txt num c1" id="txtMi_total.*" type="text" /></td>
                <td class="btn2"><input class="txt num c1" id="txtLate.*" type="text" /></td>
                <td class="btn2"><input class="txt num c3" id="txtHr_sick.*" type="text" />HR</td> 
                <td class="btn2">&#36; <input class="txt num c2" id="txtMi_sick.*" type="text" /></td>
                <td class="btn2"><input class="txt num c3" id="txtHr_person.*" type="text" />HR</td>
                <td class="btn2">&#36; <input class="txt num c2" id="txtMi_person.*" type="text"/></td>
                <td class="btn2"><input class="txt num c3" id="txtHr_nosalary.*" type="text" />HR</td>
                <td class="btn2">&#36;<input class="txt num c2" id="txtMi_nosalary.*" type="text" /></td>
                <td class="btn2"><input class="txt num c3" id="txtHr_leave.*" type="text" />HR</td>
                <td class="btn2">&#36;<input class="txt c2" id="txtMi_leave.*" type="text" /></td>
                <!--<td class="person4 btn2"><input class="txt num c1" id="txtBo_born.*" type="text" /></td>
                <td class="person4 btn2"><input class="txt num c1" id="txtBo_night.*" type="text" /></td>
                <td class="person4 btn2"><input class="txt num c1" id="txtBo_duty.*" type="text" /></td>-->
                <td class="btn2"><input class="txt num c1" id="txtTax_other.*" type="text"/></td>
                <td><input class="txt num c1" id="txtTotal2.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtOstand.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtAddh2_1.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtAddh2_2.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtAddh46_1.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtAddh46_2.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtAddh100.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtAddmoney.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtMoney1.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtMoney2.*" type="text" /></td>
                <!--<td class="btn3"><input class="txt num c1" id="txtTax_other2.*" type="text"/></td>-->
                <td class="btn3"><input class="txt num c1" id="txtMoney3.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtMoney4.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtMoney5.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtMoney6.*" type="text" /></td>
                <td class="btn3"><input class="txt num c1" id="txtPlus.*" type="text" /></td>
                <td><input class="txt num c1" id="txtTotal3.*" type="text" /></td>
                <td class="btn4"><input class="txt num c1" id="txtBorrow.*" type="text" /></td>
                <!--<td class="person4 btn4"><input class="txt num c1" id="txtChgcash.*" type="text" /></td>-->
                <td class="person4 btn4"><input class="txt num c1" id="txtTax6.*" type="text" /></td>
                <!--<td class="person4 btn4"><input class="txt num c1" id="txtStay_tax.*" type="text" /></td>-->
                <td class="person4 btn4"><input class="txt num c1" id="txtTax12.*" type="text" /></td>
                <td class="person4 btn4"><input class="txt num c1" id="txtTax18.*" type="text" /></td>
                <td class="btn4"><input class="txt num c1" id="txtCh_health.*" type="text" /></td>
                <td class="btn4"><input class="txt num c1" id="txtCh_labor.*" type="text" /></td>
                <td class="btn4"><input class="txt num c1" id="txtCh_retire.*" type="text" /></td>
                <td class="btn4"><input class="txt num c1" id="txtHplus2.*" type="text" /></td>
                <!--<td class="person4 btn4"><input class="txt num c1" id="txtLodging_power_fee.*" type="text" /></td>-->
                <td class="person1 person2 person3 btn4"><input class="txt num c1" id="txtTax.*" type="text" /></td>
                <td class="person1 person2 person3 btn4"><input class="txt num c1" id="txtTax5.*" type="text" /></td>
                <!--<td class="btn4"><input class="txt num c1" id="txtWelfare.*" type="text" /></td>
                <td class="btn4"><input id="chkIswelfare.*" type="checkbox"/></td>-->
                <!--<td  class="person4 btn4"><input class="txt num c1" id="txtStay_money.*" type="text" /></td>-->
                <td class="btn4"><input class="txt num c1" id="txtRaise_num.*" type="text" /></td>
                <td class="btn4"><input class="txt num c1" id="txtMinus.*" type="text" /></td>
                <td><input class="txt num c1" id="txtTotal4.*" type="text" /></td>
                <td><input class="txt num c1" id="txtTotal5.*" type="text" /></td>
                <td><input class="txt num c1" id="txtMoney7.*" type="text" /></td>
                <td class="btn5"><input class="txt num c1" id="txtCh_health2.*" type="text" /></td>
                <td class="btn5"><input class="txt num c1" id="txtCh_labor2.*" type="text" /></td>
                <td class="btn5"><input class="txt num c1" id="txtCh_retire2.*" type="text" /></td>
                <td class="btn5"><input class="txt num c1" id="txtSa_health.*" type="text" /></td>
                <td class="btn5"><input class="txt num c1" id="txtSa_labor.*" type="text" /></td>
                <td class="btn5"><input class="txt num c1" id="txtSa_retire.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
           </tr>
        </table>
        </div>
        </div>
        <input id="btnHidesalary" type="button" style="width: auto;font-size: medium;"/>
        <input id="btnHideday" type="button" style="width: auto;font-size: medium;"/>
        <input id="btnHideaddmoney" type="button" style="width: auto;font-size: medium;"/>
        <input id="btnHidetotal4" type="button" style="width: auto;font-size: medium;"/>
        <input id="btnHidesalaryinsure" type="button" style="width: auto;font-size: medium;"/>
        <input id="q_sys" type="hidden" />
</body>
</html>