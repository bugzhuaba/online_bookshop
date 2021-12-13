<%@ page contentType="text/html; charset=GB2312" errorPage="../error.jsp" %>
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
String s_publisherid="";
String s_name="";
String s_linkman="";
String s_address="";
String s_email="";
String s_phone="";
String s_website="";

String op = request.getParameter("op");
{
if(op!=null&&op.equals("add"))
{
 s_publisherid=request.getParameter("publisherid");
 s_name=request.getParameter("name");
 s_linkman=request.getParameter("linkman");
 s_address=request.getParameter("address");
 s_email=request.getParameter("email");
 s_phone=request.getParameter("phone");
 s_website=request.getParameter("website");
 
String s_sql="insert into  publisher(name,linkman,address,email,phone,website) "+
             "values('"+s_name+"','"+s_linkman+"','"+s_address+"','"+s_email+"','"+s_phone+"','"+s_website+"')";
try{			 			 			 
stmt.executeUpdate(s_sql);
}catch(Exception e){
response.sendRedirect("../error.jsp?error=新建出版社出错:"+e.getMessage());
}
response.sendRedirect("publisherlist.jsp");
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
		  <form name="form" action="publisheradd.jsp?op=add" method="post" >
            <tr> 
              <td>出版社名</td>
              <td><input name="name" type="text" size="25" ></td>
            </tr>
            <tr> 
              <td>联系人</td>
              <td><input name="linkman" type="text" size="25" ></td>
            </tr>
            <tr> 
            <tr> 
              <td>联系地址</td>
              <td><input name="address" type="text" size="25" ></td>
            </tr>
            <tr> 
              <td>E-mail</td>
              <td><input name="email" type="text" size="25" ></td>
            </tr>
            <tr> 
              <td>电话</td>
              <td><input name="phone" type="text" size="25" ></td>
            </tr>
            <tr> 
              <td>网址</td>
              <td><input name="website" type="text" size="25" ></td>
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