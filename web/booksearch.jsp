<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<%
  request.setCharacterEncoding("GB2312");
  Jdbc jdbc=new Jdbc();
  Connection conn = jdbc.getCon();
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  ResultSet rs=null;
%>
<%
  String op = request.getParameter("op");
  if(op!=null&&op.equals("search")){
    String s_bookid=request.getParameter("bookid");
    String s_bookname=request.getParameter("bookname");
    String s_author=request.getParameter("author");
    String s_price=request.getParameter("price");
    String s_price2=request.getParameter("price2");
    String s_publisher=request.getParameter("publisher");
    String s_type=request.getParameter("type"); 
    String s_where="";
    if(!s_bookid.equals(""))
      s_where+=" and bookid like'%"+s_bookid+"%' ";
    if(!s_bookname.equals(""))
      s_where+=" and bookname like'%"+s_bookname+"%' ";
    if(!s_author.equals(""))
      s_where+=" and author like'%"+s_author+"%' ";
    if(!s_price.equals(""))
      s_where+=" and price >='"+s_price+"' ";
    if(!s_price2.equals(""))
      s_where+=" and price <='"+s_price2+"' ";
    if(!s_publisher.equals(""))
      s_where+=" and name like'%"+s_publisher+"%' ";
    if(!s_type.equals(""))
      s_where+=" and type ='"+s_type+"' ";
    session.setAttribute("s_where",s_where);
    response.sendRedirect("booklist.jsp");
  }
%>
<link href="maincss.css" rel="stylesheet" type="text/css">
<div align="center">
<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr> 
    <td colspan="2"><div align="center"><%@include file="top.jsp" %></div></td>
  </tr>
  <tr> 
    <td width="25%" valign="top">
      <table width="100%" border="0" cellpadding="2" cellspacing="2" class="td">
        <tr>
          <td>〖检索说明〗</td>
        </tr>
        <tr>
          <td>1、检索范围为出版并已上网的图书；</td>
        </tr>
        <tr>
          <td>2、选择要检索的图书类别，在相应的“□”处打上勾为选中；</td>
        </tr>
        <tr>
          <td>3、各检索条件之间为逻辑“与”的关系，即选择检索条件越多，条件越苛刻。 </td>
        </tr>
        <tr>
          <td>4、填写的字符中不要包括这些字符：“'”、“%”、“[”、“]”，系统会自动过滤掉！</td>
        </tr>
      </table>
    </td>
    <td width="75%" valign="top">
<form name="search" action="booksearch.jsp?op=search" method="post"> 
      <table width="100%" border="0" cellpadding="2" cellspacing="2" class="td">
        <tr> 
          <td colspan="2"><hr size="1" noshade width="100%"></td>
        </tr>
        <tr> 
          <td width="50%"><div align="center">书号</div></td>
          <td width="50%"><input name="bookid" type="text" size="20" value="ISBN"></td>
        </tr>
        <tr> 
          <td width="50%"><div align="center">书名</div></td>
          <td width="50%"><input name="bookname" type="text" size="20"></td>
        </tr>
        <tr> 
          <td><div align="center">作者</div></td>
          <td><input name="author" type="text" size="20"></td>
        </tr>
        <tr> 
          <td><div align="center">书价</div></td>
          <td><input name="price" type="text" size="8" value="0.00">至<input name="price2" type="text" size="8" value="1000.00"></td>
        </tr>
        <tr> 
          <td><div align="center">出版社</div></td>
          <td><input name="publisher" type="text" size="20"></td>
        </tr> 
        <tr> 
          <td><div align="center">类别</div></td>
          <td><select name="type">
	        <option value="" >所有图书</option>
	        <option value="1" >新书</option>
		<option value="2" >精品图书</option>
	      </select>
	  </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td><div align="right">
                <input type="submit" name="Submit" value=" 搜索 ">&nbsp;&nbsp;
              </div></td>
          <td> <div align="left">
                &nbsp;&nbsp;<input type="reset" name="Reset" value=" 重置 ">
              </div></td>
        </tr>
        </table>
</form>
    </td>
  </tr>
  <tr> 
    <td colspan="2"><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div>