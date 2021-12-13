<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<% request.setCharacterEncoding("utf-8"); %>

<SCRIPT LANGUAGE="javascript">

function CheckSubmit()
 {
  if( document.loginform.employeeid.value == "" )
     { alert("请输入用户名!"); document.loginform.employeeid.focus(); return false; }   
  if( document.loginform.password.value == "" )
     { alert("请输入密码!"); document.loginform.password.focus(); return false; } 	 
  if(document.loginform.employeeid.value.indexOf("'") != -1||document.loginform.employeeid.value.indexOf(" ") != -1)
     { alert("用户名不能包含单引号,空格等字符!"); document.loginform.employeeid.focus( ); return false; }
  return true;                                                                                          
 } 
</SCRIPT>
<%
  request.setCharacterEncoding("GB2312");
  Jdbc jdbc=new Jdbc();
  Connection conn = jdbc.getCon();
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  ResultSet rs=null;
  String op = request.getParameter("op");
  if(op!=null&&op.equals("login")){
    String s_employeeid=request.getParameter("employeeid");
    String s_password=request.getParameter("password");
    rs=stmt.executeQuery("select * from employee where employeeid='"+s_employeeid+"' and password='"+s_password+"'");
    if(rs.next()){
      session.setAttribute("admin",s_employeeid);
      response.sendRedirect("booklist.jsp");
    }
    else{
      response.sendRedirect("../error.jsp?error="+"用户名或密码不正确!");
    }
  }
%>
<link href="../maincss.css" rel="stylesheet" type="text/css">
<div align="center">
<br><br><br><br>
  <table width="20%" border="0" cellpadding="0" cellspacing="0" class="td">
  <form name="loginform" action="index.jsp?op=login" method="post">
    <tr> 
      <td colspan="2"><img src="../images/adin_r1.jpg"></td>
    </tr>
    <tr> 
      <td width="25%">用户名</td>
      <td><input name="employeeid" type="text"  size="15"></td>
    </tr>
    <tr> 
      <td>密码</td>
      <td><input name="password" type="password"  size="15" ></td>
    </tr>
    <tr> 
      <td colspan="2"><div align="center">
          <input name="submit" type="submit"  onClick="return CheckSubmit();" value=" 登录 ">
        </div></td>
    </tr>
	</form>
  </table>
</div>  