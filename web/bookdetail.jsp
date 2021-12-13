<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="bean.Jdbc" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%
    Jdbc jdbc=new Jdbc();
    Connection conn = jdbc.getCon();
Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
ResultSet rs=null;
%>
<%
String s_bookid=request.getParameter("bookid");
rs=stmt.executeQuery("select * from book left join publisher on book.publisherid=publisher.publisherid  where bookid='"+s_bookid+"'"); 
rs.next();

//String s_bookid=rs.getString("bookid");
String s_bookname=rs.getString("bookname");
String s_author=rs.getString("author");
String s_pubdate=rs.getString("pubdate").substring(0,10);
String s_price=rs.getString("price");
String s_content=rs.getString("content");
String s_picture=rs.getString("picture");
String s_publisherid=rs.getString("name");
%>
<link href="maincss.css" rel="stylesheet" type="text/css">

<div align="center">
<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr> 
    <td colspan="2"><div align="center"><%@include file="top.jsp" %></div></td>
  </tr>
  <tr> 
<%--    <td width="25%" valign="top"><%@include file="login.jsp" %><br><%@include file="search.jsp" %></td>--%>
    <td width="75%" valign="top">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
        <tr> 
          <td width="30%" rowspan="8"><img src="images/<%=s_picture%>" height="212" width="150" ></td>
          <td colspan="2"><%=s_bookname%></td>
        </tr>
        <tr> 
          <td colspan="2"><%=s_author%>&nbsp;著</td>
        </tr>

        <tr> 
          <td colspan="2"><%=s_publisherid%></td>
        </tr>		
		 <tr> 
          <td colspan="2"><%=s_pubdate%></td>
        </tr>		
		 <tr> 
          <td colspan="2"><%=s_bookid%></td>
        </tr>
        <tr> 
          <td colspan="2">&nbsp;</td>
        </tr>
		 <tr> 
          <td colspan="2">&nbsp;</td>
        </tr>
		 <tr> 
          <td colspan="2">&nbsp;</td>
        </tr>		
        <tr> 
          <td>定 价:￥<%=s_price%> </td>
          <td><div align="center"><a href="addtocart.jsp?bookid=<%=s_bookid%>">放入购书车</a></div></td>
          <td><a href="javascript:history.go(-1);" >返回</a></td>
        </tr>
        <tr> 
          <td colspan="3">内容简介</td>
        </tr>
        <tr> 
          <td colspan="3"><%=s_content%>		  </td>
        </tr>		
      </table>

	
	
	
	
	</td>
  </tr>
  <tr> 
    <td colspan="2"><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div>