<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<%
    Jdbc jdbc=new Jdbc();
    Connection conn = jdbc.getCon();
    Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    ResultSet rs=null;
%>
<%
String s_admin=(String)session.getAttribute("admin");
if(s_admin==null){
response.sendRedirect("checklogin.jsp");
}
%>
<%
String s_currentpage=request.getParameter("currentpage");
String s_employeeid = request.getParameter("employeeid");
stmt.executeUpdate("delete from employee where employeeid='"+s_employeeid+"'");
response.sendRedirect("employeelist.jsp?op=show&currentpage="+s_currentpage);
%>