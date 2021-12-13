<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<%
    Jdbc jdbc=new Jdbc();
    Connection conn = jdbc.getCon();
    Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    ResultSet rs=null;
%>
<link href="maincss.css" rel="stylesheet" type="text/css">

<div align="center">
<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr> 
    <td colspan="2"><div align="center"><%@include file="top.jsp" %></div></td>
  </tr>
  <tr> 
    <td width="25%" valign="top"><%@include file="declare.jsp" %> <br><%@include file="login.jsp" %> <br><br><%@include file="search.jsp" %></td>
      <td width="75%" valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr bgcolor="#999999"></tr>
          <tr> 
            <td width="1" nowrap bgcolor="#999999"></td>
            <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="td">
                <tr> 
                  <td colspan="2"><img src="images/lanmu_r1.jpg" width="85" height="29"></td>
                </tr>
                <%
rs=stmt.executeQuery("select * from book left join publisher on book.publisherid=publisher.publisherid  where type=2 "); 
while(rs.next()){
%>
                <tr class="td"> 
                  <%
String s_bookid=rs.getString("bookid");
String s_bookname=rs.getString("bookname");
String s_author=rs.getString("author");
String s_pubdate=rs.getString("pubdate").substring(0,10);
String s_price=rs.getString("price");
String s_content=rs.getString("content");
String s_picture=rs.getString("picture");
String s_publisherid=rs.getString("name");
%>
                  <td width="50%"> <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
                      <tr> 
                        <td width="30%" rowspan="5"><a href="bookdetail.jsp?bookid=<%=s_bookid%>"><img src="images/<%=s_picture%>" width="65" height="90" border="0" ></a></td>
                        <td width="25%"><div align="left">书名</div></td>
                        <td><%=s_bookname%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">作者</div></td>
                        <td><%=s_author%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">出版社</div></td>
                        <td><%=s_publisherid%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">出版日期</div></td>
                        <td><%=s_pubdate%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">定价</div></td>
                        <td>￥<%=s_price%></td>
                      </tr>
                      <tr> 
                        <td colspan="2"><div align="center"><a href="addtocart.jsp?bookid=<%=s_bookid%>">放入购书车</a>&nbsp;&nbsp;
                            <a href="bookdetail.jsp?bookid=<%=s_bookid%>">查看详情</a>
                          </div></td>
                      </tr>
                    </table></td>
                  <%
if(!rs.isLast()){
rs.next();
s_bookid=rs.getString("bookid");
s_bookname=rs.getString("bookname");
s_author=rs.getString("author");
s_pubdate=rs.getString("pubdate").substring(0,10);
s_price=rs.getString("price");
s_content=rs.getString("content");
s_picture=rs.getString("picture");
s_publisherid=rs.getString("name");
%>
                  <td> <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
                      <tr> 
                        <td width="30%" rowspan="5"><a href="bookdetail.jsp?bookid=<%=s_bookid%>"><img src="images/<%=s_picture%>" width="65" height="90" border="0" ></a></td>
                        <td width="25%">书名</td>
                        <td><%=s_bookname%></td>
                      </tr>
                      <tr> 
                        <td width="25%">作者</td>
                        <td><%=s_author%></td>
                      </tr>
                      <tr> 
                        <td width="25%">出版社</td>
                        <td><%=s_publisherid%></td>
                      </tr>
                      <tr> 
                        <td width="25%">出版社</td>
                        <td><%=s_pubdate%></td>
                      </tr>
                      <tr> 
                        <td width="25%">定价</td>
                        <td>￥<%=s_price%></td>
                      </tr>
                      <tr> 
                        <td colspan="2"><div align="center"><a href="addtocart.jsp?bookid=<%=s_bookid%>">放入购书车</a>&nbsp;&nbsp;
                            <a href="bookdetail.jsp?bookid=<%=s_bookid%>">查看详情</a>
                          </div></td>
                      </tr>
                    </table></td>
                  <%}else{%>
                  <td >&nbsp;</td>
                  <%}%>
                </tr>
                <%}//while%>
              </table></td>
            <td width="1" bgcolor="#999999"></td>
          </tr>
          <tr bgcolor="#999999">
            <td height="1" colspan="3" nowrap></td>
          </tr>
        </table></td>
  </tr>
  <tr> 
    <td colspan="2"><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div>


