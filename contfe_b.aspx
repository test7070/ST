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
    var q_name = 'cont_workj', t_content = 'contno,contnoq,productno,product,unit,lengthb,mount,weight,price,total,xmount,xweight', bbsKey = ['contno'], as; 
    var isBott = false;  
    var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
    var i,s1;
        $(document).ready(function () {
            main();
        });         /// end ready

        function main() {
            if (dataErr)  
            {
                dataErr = false;
                return;
            }
            mainBrow(0,t_content);
         }

        function q_gtPost() {  
        }

        function refresh() {
            _refresh();
        }
    </script>
    <style type="text/css">
    </style>
</head>

<body> 
<div  id="dbbs"  >
       <table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
            <tr>
                <th align="center" > </th>
                <th align="center" style='color:blue;' ><a id='lblContno'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblContnoq'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblProductno'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblProduct'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblUnit'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblLengthb'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblMount'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblWeight'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblPrice'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblTotal'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblXmount'> </a></th>
                <th align="center" style='color:blue;' ><a id='lblXweight'> </a></th>
            </tr>
            <tr>
                <td style="width:2%;"><input name="sel"  id="radSel.*" type="radio" /></td>
                <td style="width:7%;"><input class="txt" id="txtContno.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:2%;"><input class="txt" id="txtContnoq.*" type="text" style="width:98%;"  readonly="readonly" /></td> 
           		<td style="width:5%;"><input class="txt" id="txtProductno.*" type="text" style="width:98%;"  readonly="readonly" /></td> 
           		<td style="width:7%;"><input class="txt" id="txtProduct.*" type="text" style="width:98%;"  readonly="readonly" /></td> 
           		<td style="width:3%;"><input class="txt" id="txtUnit.*" type="text" style="width:98%;"  readonly="readonly" /></td> 
            	<td style="width:3%;"><input class="txt" id="txtLengthb.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            	<td style="width:3%;"><input class="txt" id="txtMount.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            	<td style="width:3%;"><input class="txt" id="txtWeight.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            	<td style="width:3%;"><input class="txt" id="txtPrice.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            	<td style="width:3%;"><input class="txt" id="txtTotal.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            	<td style="width:3%;"><input class="txt" id="txtXmount.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            	<td style="width:3%;"><input class="txt" id="txtXweight.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            </tr>
        </table>
  <!--#include file="../inc/brow_ctrl.inc"--> 
</div>

</body>
</html> 

