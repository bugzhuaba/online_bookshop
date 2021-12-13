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
String s_userid="";
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
if(op!=null&&op.equals("add"))
{
 s_userid=request.getParameter("userid");
 s_username=request.getParameter("username");
 s_password=request.getParameter("password");
 s_gender=request.getParameter("gender");
 s_address=request.getParameter("address");
 s_email=request.getParameter("email");
 s_phone=request.getParameter("phone");
 s_postcode=request.getParameter("postcode");
 s_state=request.getParameter("state");
 
String s_sql="insert into  userinfo(userid,username,password,gender,address,email,phone,postcode,state) "+
             "values('"+s_userid+"','"+s_username+"','"+s_password+"','"+s_gender+"','"+s_address+"','"+s_email+"','"+s_phone+"','"+s_postcode+"','"+s_state+"')";
try{			 			 			 
stmt.executeUpdate(s_sql);
}catch(Exception e){
response.sendRedirect("../error.jsp?error=新建用户出错:"+e.getMessage());
}
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
		  <form name="form" action="userinfoadd.jsp?op=add" method="post" >
            <tr> 
              <td width="20%">用户名</td>
              <td><input name="userid" type="text"  size="25" ></td>
            </tr>
            <tr> 
              <td>姓名</td>
              <td><input name="username" type="text" size="25" ></td>
            </tr>
            <tr> 
              <td>密码</td>
              <td><input name="password" type="text" size="25" ></td>
            </tr>
            <tr> 
              <td>性别</td>
              <td>              
			  <select name="gender" >
			  <option value="男" >男</option>
			  <option value="女" >女</option>
			  </select></td>
            </tr>
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
              <td>邮编</td>
              <td><input name="postcode" type="text" size="25" ></td>
            </tr>
            <tr> 
              <td>状态</td>
              <td>
			  <select name="state" >
			  <option value="0">未激活</option>
			  <option value="1">激活</option>
			  </select>
			  </td>
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