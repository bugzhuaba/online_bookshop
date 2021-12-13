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
String s_userid=request.getParameter("userid");
String s_username="";
String s_password="";
String s_gender="";
String s_address="";
String s_email="";
String s_phone="";
String s_postcode="";
String s_state="";

String op = request.getParameter("op");
{
if(op!=null&&op.equals("show"))
{
rs=stmt.executeQuery("select * from userinfo where userid='"+s_userid+"'");
rs.next();
 s_username=(rs.getString("username")!=null?rs.getString("username"):"");
 s_password=(rs.getString("password")!=null?rs.getString("password"):"");
 s_gender=(rs.getString("gender")!=null?rs.getString("gender"):"");
 s_address=(rs.getString("address")!=null?rs.getString("address"):"");
 s_email=(rs.getString("email")!=null?rs.getString("email"):"");
 s_phone=(rs.getString("phone")!=null?rs.getString("phone"):"");
 s_postcode=(rs.getString("postcode")!=null?rs.getString("postcode"):"");
 s_state=(rs.getString("state")!=null?rs.getString("state"):"");

}
if(op!=null&&op.equals("edit"))
{
 s_username=request.getParameter("username");
 s_password=request.getParameter("password");
 s_gender=request.getParameter("gender");
 s_address=request.getParameter("address");
 s_email=request.getParameter("email");
 s_phone=request.getParameter("phone");
 s_postcode=request.getParameter("postcode");
 s_state=request.getParameter("state");
 
String s_sql="update userinfo set "+
             "username='"+s_username+"' "+
			 ",password='"+s_password+"' "+
			 ",gender='"+s_gender+"' "+
			 ",address='"+s_address+"' "+
			 ",email='"+s_email+"' "+
			 ",phone='"+s_phone+"' "+
			 ",postcode='"+s_postcode+"' "+
			 ",state='"+s_state+"' "+
			 "where userid='"+s_userid+"' ";
			 			 			 
stmt.executeUpdate(s_sql);
response.sendRedirect("userinfolist.jsp");
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
		  <form name="form" action="userinfoedit.jsp?op=edit" method="post" >
            <tr> 
              <td width="20%">用户名</td>
              <td><%=s_userid%><input name="userid" type="hidden"  value="<%=s_userid%>"></td>
            </tr>
            <tr> 
              <td>姓名</td>
              <td><input name="username" type="text" size="25" value="<%=s_username%>"></td>
            </tr>
            <tr> 
              <td>密码</td>
              <td><input name="password" type="text" size="25" value="<%=s_password%>"></td>
            </tr>
            <tr> 
              <td>性别</td>
              <td>
              <select name="gender" >
			  <option value="男" <%=(s_gender.equals("男")?" selected ":"")%>>男</option>
			  <option value="女" <%=(s_gender.equals("女")?" selected ":"")%>>女</option>
			  </select>			  
			  </td>
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
              <td>邮编</td>
              <td><input name="postcode" type="text" size="25" value="<%=s_postcode%>"></td>
            </tr>
            <tr> 
              <td>状态</td>
              <td>
			  <select name="state" >
			  <option value="0" <%=(s_state.equals("0")?" selected ":"")%>>未激活</option>
			  <option value="1" <%=(s_state.equals("1")?" selected ":"")%>>激活</option>
			  </select></td>
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