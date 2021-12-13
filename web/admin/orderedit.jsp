<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<%
  Jdbc jdbc=new Jdbc();
  Connection conn = jdbc.getCon();
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  ResultSet rs=null;
  String s_admin=(String)session.getAttribute("admin");
  if(s_admin==null){
    response.sendRedirect("checklogin.jsp");
  }
  String s_currentpage=request.getParameter("currentpage");
  String s_orderid = request.getParameter("orderid");
  String s_state = request.getParameter("state");
  stmt.executeUpdate("update orderform set state='"+s_state+"' where orderid='"+s_orderid+"'");   
  rs=stmt.executeQuery("select * from orderdetail where orderid='"+s_orderid+"' ");
  while(rs.next()){
    String s_bookid=rs.getString("bookid");
    int i_ordernum=rs.getInt("ordernum");
    Statement stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    stmt2.executeUpdate("update book set quantity=quantity-"+i_ordernum+" where bookid='"+s_bookid+"'");
  }
  response.sendRedirect("orderlist.jsp?op=show&currentpage="+s_currentpage);
%>