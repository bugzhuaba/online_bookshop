<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="bean.*,java.util.*,java.sql.*"%>
<%
  request.setCharacterEncoding("GB2312");
    Jdbc jdbc=new Jdbc();
    Connection conn = jdbc.getCon();
    Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    ResultSet rs=null;
%>
<%
  String s_userid=(String)session.getAttribute("userid");
  if(s_userid==null){
   response.sendRedirect("checklogin.jsp");
  }
%>
<%
  String s_orderid="";
  String s_payment="";
  String s_deliver="";
  String s_receiver="";
  String s_address="";
  String s_phone="";
  String s_postcode="";
  String s_totalnum="";
  String s_totalamount="";
  String s_orderdate="";
  String s_state="";
  rs=stmt.executeQuery("select count(*) from orderform where userid='"+s_userid+"'");
  rs.next();
  int i_count=rs.getInt(1);
%>
<link href="maincss.css" rel="stylesheet" type="text/css">
<div align="center">
<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr> 
    <td ><div align="center"><%@include file="top.jsp" %></div></td>
  </tr>
  <tr> 
    <td><div align="center">
       <table width="100%" border="0" cellpadding="1" cellspacing="1" class="td">
          <tr> 
            <td colspan="8">我的订单</td>
          </tr>
          <tr> 
            <td colspan="8"><hr size="1" noshade width="100%"></td>
          </tr>
<%
  if(i_count!=0){
%>
          <tr> 
            <td>序号</td>
            <td>订单号</td>
            <td>日期</td>
            <td>收货人</td>
            <td>地址</td>
	    <td>图书总数</td>
	    <td>总价</td>
            <td>订单状态</td>
          </tr>
<%
  rs=stmt.executeQuery("select * from orderform where userid='"+s_userid+"' order by orderdate desc ");
  int i=0;
  while(rs.next()){
    i++;
    s_orderid=rs.getString("orderid");
    s_orderdate=rs.getString("orderdate").substring(0,10);
    s_totalnum=rs.getString("totalnum");
    s_totalamount=rs.getString("totalamount");
    s_receiver=rs.getString("receiver");
    s_address=rs.getString("address");
    s_state=rs.getString("state");
    if(s_state.equals("0")) s_state="未处理";
    if(s_state.equals("1")) s_state="已发货";
    if(s_state.equals("2")) s_state="完毕";
%>
          <tr> 
            <td><%=i%></td >
            <td><a href="myorder.jsp?detailid=<%=s_orderid%>"><%=s_orderid%></a></td>  
            <td><%=s_orderdate%></td >
            <td><%=s_receiver%></td >
            <td><%=s_address%></td>
	    <td><%=s_totalnum%></td>
	    <td>￥<%=s_totalamount%></td>
            <td><%=s_state%></td>
          </tr>
<%}%>												
          <tr> 
            <td colspan="8">&nbsp;</td>
          </tr>
<%
  String s_detailid=request.getParameter("detailid");
  if(s_detailid==null)
  {
    rs=stmt.executeQuery("select * from orderform where userid='"+s_userid+"' order by orderdate desc ");
    rs.next();
    s_detailid=rs.getString("orderid");
  }
%>			
          <tr> 
            <td colspan="8">
	      <table width="100%" border="0" cellpadding="1" cellspacing="1" class="td">
                <tr> 
                  <td colspan="6">订单<%=s_detailid%>的明细</td>
                </tr>
                <tr> 
                  <td>书号</td>
                  <td>书名</td>
                  <td>出版社</td>
                  <td>单价</td>
                  <td>数量(本)</td>
                  <td>合价</td>
                </tr>
<%
  rs=stmt.executeQuery("select * from orderdetail where orderid='"+s_detailid+"' ");
  int i_totalnum=0;
  double d_totalamount=0.0;
  while(rs.next()){
  String s_bookid=rs.getString("bookid");
  String s_bookname=rs.getString("bookname");
  String s_publisher=rs.getString("publisher");
  double d_unitprice=rs.getDouble("unitprice");
  int i_ordernum=rs.getInt("ordernum");
  i_totalnum+=i_ordernum;
  d_totalamount+=d_unitprice*i_ordernum;
%>				  
                <tr> 
                  <td><a href="bookdetail.jsp?bookid=<%=s_bookid%>"><%=s_bookid%></a></td>
                  <td><%=s_bookname%></td>
                  <td><%=s_publisher%></td>
                  <td>￥<%=d_unitprice%></td>
                  <td><%=i_ordernum%></td>
                  <td>￥<%=d_unitprice*i_ordernum%></td>
                </tr>
<%}%>
                <tr> 
                  <td colspan="4"><div align="right">合计</div></td>
                  <td ><%=i_totalnum%></td>
		  <td >￥<%=d_totalamount%></td>
                </tr>
              </table>
            </td>
          </tr>
<%}else{%>
          <tr> 
            <td colspan="8">您还没有下过订单!</td>
          </tr>			
     <%}%>			
        </table>
	</div></td>
  </tr>  
  <tr> 
    <td ><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div>   