<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="bean.*,java.util.*,java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
  Date b=new Date();
%>
<%
  request.setCharacterEncoding("GB2312");
  Jdbc jdbc=new Jdbc();
  Connection conn = jdbc.getCon();
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  ResultSet rs=null;
  rs=stmt.executeQuery("select MAX(CAST(orderid AS UNSIGNED INTEGER)) from orderform");
  rs.next();
  String s_orderid=rs.getInt(1)+1+"";
  String s_userid=request.getParameter("userid");
  String s_payment=request.getParameter("payment");
  String s_deliver=request.getParameter("deliver");
  String s_receiver=request.getParameter("receiver");
  String s_address=request.getParameter("address");
  String s_phone=request.getParameter("phone");
  String s_postcode=request.getParameter("postcode");
  SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd hh-mm-ss");
  String a=simpleDateFormat.format(b);
  int i_totalnum=0;
  double d_totalamount=0.0;
  Iterator it=null;
  Collection c_cart=(Collection)session.getAttribute("cart");

if(c_cart==null)
{
out.println("不能重复下订单!");
return;
}
  it=c_cart.iterator();
  while(it.hasNext()){
    cartBean cbean=(cartBean)(it.next());
    i_totalnum+=cbean.ordernum;
    d_totalamount+=cbean.subtotal;	
    stmt.executeUpdate("insert into orderdetail(orderid,bookid,bookname,publisher,unitprice,ordernum) values('"+s_orderid+"','"+cbean.bookid+"','"+cbean.bookname+"','"+cbean.publish+"','"+cbean.unitprice+"','"+cbean.ordernum+"')");
  }
  String s_sql="insert into orderform(orderid,orderdate,userid,totalnum,totalamount,payment,deliver,receiver,address,phone,postcode,state) "+
             "values('"+s_orderid+"','"+a+"','"+s_userid+"','"+i_totalnum+"','"+d_totalamount+"','"+s_payment+"','"+s_deliver+"','"+s_receiver+"','"+s_address+"','"+s_phone+"','"+s_postcode+"','0')" ;
  stmt.executeUpdate(s_sql);	
%>
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
          <td colspan="6">您已经成功下单,下面是您这次订单的购书信息,请记住您订单号,我们的工作人员会及时与您联系.</td>
        </tr>
        <tr> 
          <td colspan="6"><hr size="1" noshade width="100%"></td>
        </tr>
        <tr> 
          <td colspan="6"> 订单号:<%=s_orderid%></td>
        </tr>
        <tr> 
          <td colspan="2"> 收货人:<%=s_receiver%></td>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="2"> 地址:<%=s_address%></td>
        </tr>
        <tr> 
          <td colspan="2"> 邮编:<%=s_postcode%></td>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="2"> 联系电话:<%=s_phone%></td>
        </tr>				  
<%
  i_totalnum=0;
  d_totalamount=0.0;
  c_cart=(Collection)session.getAttribute("cart");
  if(c_cart!=null&&c_cart.size()>0){%>
        <tr> 
          <td>书号</td>
          <td>书名</td>
          <td>出版社</td>
          <td>单价</td>
          <td>数量(本)</td>
          <td>合价</td>
        </tr>
<%
    it=c_cart.iterator();
    while(it.hasNext()){
      cartBean cbean=(cartBean)(it.next());
      i_totalnum+=cbean.ordernum;
      d_totalamount+=cbean.subtotal;
%>
        <tr> 
          <td height="19"><%=cbean.bookid%></td>
          <td><%=cbean.bookname%></td>
          <td><%=cbean.publish%></td>
          <td>￥<%=cbean.unitprice%></td>
          <td><%=cbean.ordernum%>&nbsp;
          <td>￥<%=cbean.subtotal%></td>
        </tr>	
<%  }//while
  session.removeAttribute("cart");
%>			  
        <tr> 
          <td colspan="4"><div align="right">合计</div></td>
          <td ><%=i_totalnum%>(本)</td>
	  <td colspan="2">￥<%=d_totalamount%></td>
        </tr>   
        <tr> 
          <td colspan="7"> <div align="left">谢谢您的支持! </div></td>
        </tr>
<%}%>	
    </table></div></td>
  </tr>  
  <tr> 
    <td ><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div> 
  