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
String s_pubdate2="";
String s_price="";
String s_price2="";
String s_quantity="";
String s_quantity2="";
String s_place="";
String s_type="";


String op = request.getParameter("op");
{
if(op!=null&&op.equals("search"))
{
 s_bookid=request.getParameter("bookid");
 s_bookname=request.getParameter("bookname");
 s_author=request.getParameter("author");
 s_publisherid=request.getParameter("publisherid");
 s_pubdate=request.getParameter("pubdate");
 s_pubdate2=request.getParameter("pubdate2");
 s_price=request.getParameter("price");
 s_price2=request.getParameter("price2");
 s_quantity=request.getParameter("quantity");
 s_quantity2=request.getParameter("quantity2");
 s_place=request.getParameter("place");
 s_type=request.getParameter("type");

String s_where="";

if(!s_bookid.equals(""))
s_where+=" and bookid like'%"+s_bookid+"%' ";

if(!s_bookname.equals(""))
s_where+=" and bookname like'%"+s_bookname+"%' ";

if(!s_author.equals(""))
s_where+=" and author like'%"+s_author+"%' ";

if(!s_publisherid.equals(""))
s_where+=" and book.publisherid ='"+s_publisherid+"' ";

if(!s_pubdate.equals(""))
s_where+=" and pubdate >='"+s_pubdate+"' ";
if(!s_pubdate2.equals(""))
s_where+=" and pubdate <='"+s_pubdate2+"' ";

if(!s_price.equals(""))
s_where+=" and price >='"+s_price+"' ";
if(!s_price2.equals(""))
s_where+=" and price <='"+s_price2+"' ";

if(!s_quantity.equals(""))
s_where+=" and quantity >='"+s_quantity+"' ";
if(!s_quantity2.equals(""))
s_where+=" and quantity <='"+s_quantity2+"' ";

if(!s_place.equals(""))
s_where+=" and place like '%"+s_place+"%' ";

if(!s_type.equals(""))
s_where+=" and type ='"+s_type+"' ";

session.setAttribute("s_where",s_where);
response.sendRedirect("booklist.jsp?op=show&currentpage=1");
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
		  <form name="form" action="booksearch.jsp?op=search" method="post" >
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
			  <option value="" >所有出版社</option>
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
              <td><input name="pubdate" type="text" size="12" value="">至<input name="pubdate2" type="text" size="12" value="">
                  (格式:2004-09-01)</td>
            </tr>
            <tr> 
                <td>价格</td>
              <td><input name="price" type="text" size="5" value="0.00">至<input name="price2" type="text" size="5" value="1000.00"></td>
            </tr>
            <tr> 
                <td>库存数量</td>
              <td><input name="quantity" type="text" size="5" value="">至<input name="quantity2" type="text" size="5" value=""></td>
            </tr>
            <tr> 
                <td>存储位置</td>
              <td><input name="place" type="text" size="25" ></td>
            </tr>
            <tr> 
                <td>类别</td>
              <td>
			  <select name="type" >
			  <option value="">所有类别</option>
			  <option value="0">普通</option>
			  <option value="1">新书</option>
			  <option value="2">精品</option>
			  </select>
			  </td>
            </tr>			
            <tr> 
              <td colspan="2"><div align="center">
                  <input type="submit" value=" 查询 ">&nbsp;&nbsp;&nbsp;&nbsp;
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