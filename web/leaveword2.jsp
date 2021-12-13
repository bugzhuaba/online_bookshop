<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="bean.Jdbc" %>
<%
  Date today=new Date();
%>
<%
  request.setCharacterEncoding("GB2312");
  Jdbc jdbc=new Jdbc();
  Connection conn = jdbc.getCon();
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  ResultSet rs=null;
  String s_userid=request.getParameter("userid");
  String s_subject=request.getParameter("subject");
  String s_context=request.getParameter("context");
  SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd hh-mm-ss");
  String a=simpleDateFormat.format(today);

  String s_sql="insert into notes(userid,subject,date1,context) "+
             "values('"+s_userid+"','"+s_subject+"','"+a+"','"+s_context+"')" ;
  stmt.executeUpdate(s_sql);
  response.sendRedirect("leaveword.jsp");
%>