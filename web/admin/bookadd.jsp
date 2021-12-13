<%@ page contentType="text/html; charset=GB2312" errorPage="../error.jsp"%>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<%
request.setCharacterEncoding("GB2312");
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
String s_bookid="";
String s_bookname="";
String s_author="";
String s_publisherid="";
String s_pubdate="";
String s_price="";
String s_quantity="";
String s_place="";
String s_type="";
String s_content="";

String op = request.getParameter("op");
{
if(op!=null&&op.equals("add"))
{
 s_bookid=request.getParameter("bookid");
 s_bookname=request.getParameter("bookname");
 s_author=request.getParameter("author");
 s_publisherid=request.getParameter("publisherid");
 s_pubdate=request.getParameter("pubdate");
 s_price=request.getParameter("price");
 s_quantity=request.getParameter("quantity");
 s_place=request.getParameter("place");
 s_type=request.getParameter("type");
 s_content=request.getParameter("content");
 s_content=s_content.replaceAll("\n","<br>");
 s_content=s_content.replaceAll(" ","&nbsp;");
String s_sql="insert into  book(bookid,bookname,author,publisherid,pubdate,price,quantity,place,type,content) "+
             "values('"+s_bookid+"','"+s_bookname+"','"+s_author+"','"+s_publisherid+"','"+s_pubdate+"','"+s_price+"','"+s_quantity+"','"+s_place+"','"+s_type+"','"+s_content+"')";
try{			 			 			 
stmt.executeUpdate(s_sql);
}catch(Exception e){
response.sendRedirect("../error.jsp?error=新建图书出错:"+e.getMessage());
}
response.sendRedirect("booklist.jsp");
}

}
%>
<link href="../maincss.css" rel="stylesheet" type="text/css">

<div align="center">
<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr> 
    <td ><div align="center"><%@include file="top.jsp" %></div></td>
  </tr>
  <tr> 
    <td ><div align="center">
	      <table width="80%" border="0" cellpadding="1" cellspacing="1" class="td">
		  <form name="form" action="bookadd.jsp?op=add" method="post" >
            <tr> 
                <td width="20%">书号</td>
              <td><input name="bookid" type="text"  size="25" ></td>
            </tr>
            <tr> 
                <td>书名</td>
              <td><input name="bookname" type="text" size="25" ></td>
            </tr>
            <tr> 
                <td>作者</td>
              <td><input name="author" type="text" size="25" ></td>
            </tr>
            <tr> 
                <td>出版社</td>
              <td>              
			  <select name="publisherid" >
			  <%
			  ResultSet rs2=stmt.executeQuery("select * from publisher ");
			  while(rs2.next()){
			  %>
			  <option value="<%=rs2.getString("publisherid")%>" ><%=rs2.getString("name")%></option>
			  <%}%>
			  </select></td>
            </tr>
            <tr> 
                <td>出版日期</td>
              <td><input name="pubdate" type="text" size="25" value="2004-07-27"></td>
            </tr>
            <tr> 
                <td>价格</td>
              <td><input name="price" type="text" size="25" value="0.00"></td>
            </tr>
            <tr> 
                <td>库存数量</td>
              <td><input name="quantity" type="text" size="25" value="0"></td>
            </tr>
            <tr> 
                <td>存储位置</td>
              <td><input name="place" type="text" size="25" ></td>
            </tr>
            <tr> 
                <td>类别</td>
              <td>
			  <select name="type" >
			  <option value="0">普通</option>
			  <option value="1">新书</option>
			  <option value="2">精品</option>
			  </select>
			  </td>
            </tr>
            <tr> 
                <td>内容简介</td>
              <td><textarea name="content" cols="70" rows="10"></textarea></td>
            </tr>			
            <tr> 
              <td colspan="2"><div align="center">
                  <input type="submit" value=" 新建 ">&nbsp;&nbsp;&nbsp;&nbsp;
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </div></td>
            </tr>
			</form>
          </table>
	
	</div></td>
  </tr>  
  <tr> 
    <td ><div align="center">
          <%@include file="../bottom.jsp" %>
        </div></td>
  </tr>
</table>
</div> 	