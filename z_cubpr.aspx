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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
         
         $(document).ready(function() {
			  _q_boxClose();
              q_getId();
              q_gf('','z_cubpr');
         });
          $('#q_report').click(function(e) {
					if(isinvosystem=='1'){//沒有發票系統
	                	$('#Xshowenda').hide();
	                }
				});
         function q_gfPost() {
             $('#q_report').q_report({
                 fileName : 'z_cubpr',
                 options : [
				    {/*1[1][2] */
                        type : '1',
                        name : 'date'
                    },{/*2[3][4]*/
  						type : '2',
                        name : 'custno',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    },{/*3[5][6]*/
  						type : '2',
                        name : 'product',
                        dbf : 'ucx',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    },{/*4[7][8]*/
  						type : '1',
                        name : 'noq',
                    },{/*5[9][10]*/
						type : '2', 
                        name : 'tggno',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    },{/*6[11]*/
                        type : '8', //完工顯示//
                        name : 'xshowenda',
                        value : "1@顯示完工".split(',')
                    }, {/*7 [12]*/
                        type : '5',//篩選完工未完工//
                        name : 'xtype',
                        value : [' @全部','0@未完工','1@完工']
                    }, {/*8 [13]*/
                        type : '6',
                        name : 'xnoa'
                    }]
          });
          
                $('#Xshowenda').css('width', '300px').css('height', '30px');
                $('#Xshowenda .label').css('width','0px');
                $('#chkXshowenda').css('width', '220px').css('margin-top', '5px');
                $('#chkXshowenda span').css('width','180px')

                $('.q_report .report').css('width', '420px');
                $('.q_report .report div').css('width', '200px');

          q_popAssign();
          q_getFormat();
          q_langShow();
          $('#txtDate1').mask(r_picd);
          $('#txtDate2').mask(r_picd);

           var t_key = q_getHref();
           if(t_key[1] != undefined){
           $('#txtXnoa').val(t_key[1]);}
            
          if(r_len==3){//西元年
				$('#txtDate1').datepicker();
				$('#txtDate2').datepicker();
          }

		  $('#txtDate1').val(q_cdn(q_date().substr(0,r_lenm)+'/01',-61));
          $('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',30).substr(0,r_lenm)+'/01',-1));
           
          $("input[type='checkbox'][value!='']").attr('checked', true);
          
          }
          
          

          function q_boxClose(s2) {
          }
			
          function q_gtPost(s2) {
          }

	</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report" ></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
                <!--#include file="../inc/print_ctrl.inc"-->
            </div>
		</div>
	</body>
</html>