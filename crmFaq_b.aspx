﻿<html xmlns="http://www.w3.org/1999/xhtml">
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
    var q_name = 'crmFaq', t_content = ' ', bbsKey = ['noa'], as; 
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
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:100% ;  
        }      
        .txt.c1
        {
            width: 99%;
        }
    </style>
</head>

<body> 
<div  id="dbbs"  >
       <table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
            <tr>
                <th align="center" > </th>
                <th align="center" style='color:Blue;' ><a id='lblNoa'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblFgroup'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblQuestion'></a></th>
            </tr>
            <tr>
                <td style="width:2%;"><input name="sel"  id="radSel.*" type="radio" /></td>
                <td style="width: 25%;"><input class="txt c1" id="txtNoa.*" type="text"   readonly="readonly" /></td>
                <td style="width: 25%;"><input class="txt c1" id="txtFgroup.*" type="text"   readonly="readonly" /></td>
                <td style="width: 50%;"><input class="txt c1" id="txtQuestion.*" type="text"   readonly="readonly" /></td>
            </tr>
        </table>
  <!--#include file="../inc/brow_ctrl.inc"--> 
</div>
</body>
</html> 

