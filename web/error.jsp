<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
String s_error=new String(request.getParameter("error").getBytes("iso-8859-1"),"utf-8");
%>

<link href="maincss.css" rel="stylesheet" type="text/css">

<table width="100%" border="0" cellpadding="1" cellspacing="1" class="td">
  <tr>
    <td><font color="#FF0000"><%=s_error%></font>&nbsp;&nbsp;<a href="javascript:history.go(-1);" >返回</a></td>
  </tr>
</table>
