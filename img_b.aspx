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
            var q_name = 'img', t_content = 'field=noa,namea,data', bbsKey = ['noa'], as ;
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
         
            $(document).ready(function() {
                main();
            });
            // end ready

            function main() {
                if(dataErr)// 載入資料錯誤
                {
                    dataErr = false;
                    return;
                }
                mainBrow(0, t_content);
            }
            
            function mainPost(){
				q_getFormat();				
			}
			
            function refresh() {
                _refresh();
                $('.img').attr('src','');
                $('input:radio').attr('disabled','disabled');
                for(var i=0;i<q_bbsCount;i++){
                	if($('#txtNoa_'+i).val().length>0){
                		$('#imgPic_'+i).attr('src','..\\htm\\htm\\img\\' + $('#txtData_'+i).val()+'?'+(new Date().Format("yyyy-MM-dd hh:mm:ss")));
                		$('#radSel_'+i).removeAttr('disabled');
                	}
                }
            }
            Date.prototype.Format = function (fmt) { 
			    var o = {
			        "M+": this.getMonth() + 1, //月份 
			        "d+": this.getDate(), //日 
			        "h+": this.getHours(), //小时 
			        "m+": this.getMinutes(), //分 
			        "s+": this.getSeconds(), //秒 
			        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
			        "S": this.getMilliseconds() //毫秒 
			    };
			    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
			    for (var k in o)
			    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
			    return fmt;
			};
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" > </th>
					<th align="center" style='color:blue;' ><a id='lblPic'> </a></th>
					<th align="center" style='color:blue;' ><a id='lblNoa'> </a></th>
					<th align="center" style='color:blue;' ><a id='lblNamea'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;">
						<input name="sel"  id="radSel.*" type="radio" />
					</td>
					<td style="width:20%;text-align: center;">
						<img id="imgPic.*" class="img" src="" style="width:150px;height:50px;"/>
						<input class="txt" id="txtData.*" type="text" style="width:98%;display:none;"  readonly="readonly" />
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtNamea.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>
