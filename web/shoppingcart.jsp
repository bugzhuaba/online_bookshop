<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="bean.*,java.util.*"%>
<script language="JavaScript" type="text/JavaScript">

  function MM_goToURL() { //v3.0
    var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
    for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->
</script>
<link href="maincss.css" rel="stylesheet" type="text/css">
<div align="center">
<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr> 
    <td ><div align="center"><%@include file="top.jsp" %></div></td>
  </tr>
  <tr> 
    <td ><div align="center">
      <table width="100%" border="0" cellpadding="1" cellspacing="1" class="td">
        <tr> 
          <td colspan="7">���鳵</td>
        </tr>
        <tr> 
          <td colspan="7"><hr size="1" noshade width="100%"></td>
        </tr>
<%
  int i_totalnum=0;
  double d_totalamount=0.0;
  Collection c_cart=(Collection)session.getAttribute("cart");
  Iterator it=null;
  if(c_cart!=null&&c_cart.size()>0){%>
        <tr> 
          <td>���</td>
          <td>����</td>
          <td>������</td>
          <td>����</td>
          <td>����(��)</td>
          <td>�ϼ�</td>
	  <td>����</td>
        </tr>
<%
    it=c_cart.iterator();
    while(it.hasNext()){
      cartBean cbean=(cartBean)(it.next());
      i_totalnum+=cbean.ordernum;
      d_totalamount+=cbean.subtotal;
%>
        <tr> 
          <td height="19"><a href="bookdetail.jsp?bookid=<%=cbean.bookid%>" target="_blank"><%=cbean.bookid%></a></td>
          <td><%=cbean.bookname%></td>
          <td><%=cbean.publish%></td>
          <td>��<%=cbean.unitprice%></td>
          <td><input type="text" class="formtext" value="<%=cbean.ordernum%>" size="5" readonly>&nbsp;
	      <input type="button" onClick="MM_goToURL('parent','increaseCart.jsp?bookid=<%=cbean.bookid%>');return document.MM_returnValue" value="+">&nbsp;
	      <input type="button" onClick="MM_goToURL('parent','decreaseCart.jsp?bookid=<%=cbean.bookid%>');return document.MM_returnValue" value="-"></td>
          <td>��<%=cbean.subtotal%></td>
	  <td><a href="delfromcart.jsp?bookid=<%=cbean.bookid%>">ȡ��</a></td>
        </tr>	
<%  }//while%>			  
        <tr> 
          <td colspan="4"><div align="right">�ϼ�</div></td>
          <td ><%=i_totalnum%>(��)</td>
<%
    d_totalamount=Math.round(d_totalamount*100)/100.00;
%>					
          <td colspan="2">��<%=d_totalamount%></td>
        </tr>   
        <tr> 
          <td colspan="7"> <div align="center">
            <input type="button" onClick="MM_goToURL('parent','clearcart.jsp');return document.MM_returnValue" value=" ��չ��鳵 "> &nbsp;&nbsp;
            <input type="button" onClick="MM_goToURL('parent','index.jsp');return document.MM_returnValue" value=" �������� ">&nbsp;&nbsp;
            <input type="button" onClick="MM_goToURL('parent','order1.jsp');return document.MM_returnValue" value=" ȥ����̨ ">
             </div></td>
        </tr>
<%}else{%>	
        <tr> 
          <td colspan="7"> <div align="center">���Ĺ��鳵Ϊ��!</div></td>
        </tr>
<% }//else%>			          															
      </table>
    </div></td>
  </tr>  
  <tr> 
    <td ><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div>   