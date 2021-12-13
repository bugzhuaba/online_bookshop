<%@ page contentType="text/html; charset=GB2312" %>
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
String s_publisherid=request.getParameter("publisherid");
String s_name="";
String s_linkman="";
String s_address="";
String s_email="";
String s_phone="";
String s_website="";

String op = request.getParameter("op");
{
if(op!=null&&op.equals("show"))
{
rs=stmt.executeQuery("select * from publisher where publisherid='"+s_publisherid+"'");
rs.next();
 s_name=(rs.getString("name")!=null?rs.getString("name"):"");
 s_linkman=(rs.getString("linkman")!=null?rs.getString("linkman"):"");
 s_address=(rs.getString("address")!=null?rs.getString("address"):"");
 s_email=(rs.getString("email")!=null?rs.getString("email"):"");
 s_phone=(rs.getString("phone")!=null?rs.getString("phone"):"");
 s_website=(rs.getString("website")!=null?rs.getString("website"):"");

}
if(op!=null&&op.equals("edit"))
{
 s_name=request.getParameter("name");
 s_linkman=request.getParameter("linkman");
 s_address=request.getParameter("address");
 s_email=request.getParameter("email");
 s_phone=request.getParameter("phone");
 s_website=request.getParameter("website");
 
String s_sql="update publisher set "+
             "name='"+s_name+"' "+
			 ",linkman='"+s_linkman+"' "+
			 ",address='"+s_address+"' "+
			 ",email='"+s_email+"' "+
			 ",phone='"+s_phone+"' "+
			 ",website='"+s_website+"' "+
			 "where publisherid='"+s_publisherid+"' ";
			 			 			 
stmt.executeUpdate(s_sql);
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
		  <form name="form" action="publisheredit.jsp?op=edit" method="post" >
            <tr> 
              <td>出版社名</td>
              <td><input name="name" type="text" size="25" value="<%=s_name%>"><input name="publisherid" type="hidden"  value="<%=s_publisherid%>"></td>
            </tr>
            <tr> 
              <td>联系人</td>
              <td><input name="linkman" type="text" size="25" value="<%=s_linkman%>"></td>
            </tr>
            <tr> 
              <td>联系地址</td>
              <td><input name="address" type="text" size="25" value="<%=s_address%>"></td>
            </tr>
            <tr> 
              <td>E-mail</td>
              <td><input name="email" type="text" size="25" value="<%=s_email%>"></td>
            </tr>
            <tr> 
              <td>电话</td>
              <td><input name="phone" type="text" size="25" value="<%=s_phone%>"></td>
            </tr>
            <tr> 
              <td>网址</td>
              <td><input name="website" type="text" size="25" value="<%=s_website%>"></td>
            </tr>
            <tr> 
              <td colspan="2"><div align="center">
                  <input type="submit" value=" 修改 ">&nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="reset" value=" 重置 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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