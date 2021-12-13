<%@ page contentType="text/html; charset=GB2312" %>
<%
  String op = request.getParameter("op");
  if(op!=null&&op.equals("search")){
    String s_BookName=request.getParameter("bookname");
    String s_Author=request.getParameter("author");
    String s_Publisher=request.getParameter("publisher");
    String s_where="";
    if(!s_BookName.equals(""))
      s_where+=" and bookname like'%"+s_BookName+"%' ";
    if(!s_Author.equals(""))
      s_where+=" and author like'%"+s_Author+"%' ";
    if(!s_Publisher.equals(""))
      s_where+=" and name like'%"+s_Publisher+"%' ";
    session.setAttribute("s_where",s_where);
    response.sendRedirect("booklist.jsp");
  }
%>
<link href="maincss.css" rel="stylesheet" type="text/css">
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#f6f6f6" class="td">
  <form name="searchform" action="index.jsp?op=search" method="post">
    <tr> 
      <td colspan="3"><div align="left">
      <img src="images/search_r1.jpg" width="158" height="43"></div></td>
    </tr>
    <tr> 
      <td width="8">&nbsp;</td>
      <td width="25%">书名</td>
      <td width="75%"><input name="bookname" type="text" class="formtext" size="15"></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>作者</td>
      <td><input name="author" type="text" class="formtext" size="15"></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>出版社</td>
      <td><input name="publisher" type="text" class="formtext" size="15"></td>
    </tr>
    <tr> 
      <td>&nbsp; </td>
      <td colspan="2"> <input name="submit" type="submit" value=" 查找 "> <a href="booksearch.jsp">高级搜索</a> 
      </td>
    </tr>
  </form>
</table>
