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
String s_name="";
String s_linkman="";
String s_address="";
String s_email="";
String s_phone="";
String s_website="";

String op = request.getParameter("op");
{
if(op!=null&&op.equals("search"))
{
 s_name=request.getParameter("name");
 s_linkman=request.getParameter("linkman");
 s_address=request.getParameter("address");
 s_email=request.getParameter("email");
 s_phone=request.getParameter("phone");
 s_website=request.getParameter("website");
 
 String s_where="";

if(!s_name.equals(""))
s_where+=" and name like'%"+s_name+"%' "; 

if(!s_linkman.equals(""))
s_where+=" and linkman like'%"+s_linkman+"%' "; 

if(!s_address.equals(""))
s_where+=" and address like'%"+s_address+"%' "; 

if(!s_email.equals(""))
s_where+=" and email like'%"+s_email+"%' "; 

if(!s_phone.equals(""))
s_where+=" and phone like'%"+s_phone+"%' "; 

if(!s_website.equals(""))
s_where+=" and website like'%"+s_website+"%' "; 



session.setAttribute("s_where",s_where);
response.sendRedirect("publisherlist.jsp?op=show&currentpage=1");
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
		  <form name="form" action="publishersearch.jsp?op=search" method="post" >
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