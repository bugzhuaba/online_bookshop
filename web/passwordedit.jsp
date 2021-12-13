<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<SCRIPT LANGUAGE="javascript">

function CheckSubmit()
 {
  if( document.passwordform.password.value == "" )
     { alert("请输入新密码!"); document.passwordform.password.focus(); return false; } 	 
  if( document.passwordform.password2.value == "" )
     { alert("请验证新密码!"); document.passwordform.password2.focus(); return false; } 
  if( document.passwordform.password2.value != document.passwordform.password.value  )
     { alert("新密码验证出错!"); document.passwordform.password.focus(); return false; }		 
  return true;                                                                                          
 } 
</SCRIPT>
<%
request.setCharacterEncoding("GB2312");
    Jdbc jdbc=new Jdbc();
    Connection conn = jdbc.getCon();
    Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    ResultSet rs=null;
%>
<%
String s_password="";
%>
<%
String s_userid=(String)session.getAttribute("userid");
if(s_userid==null){
response.sendRedirect("checklogin.jsp");
}
%>
<%
String op = request.getParameter("op");
if(op!=null&&op.equals("edit")){

 s_password=request.getParameter("password");

String s_sql="update userinfo set password='"+s_password+"'  where userid='"+s_userid+"'";
stmt.executeUpdate(s_sql);
}
%>
<link href="maincss.css" rel="stylesheet" type="text/css">

<div align="center">
<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr> 
    <td ><div align="center"><%@include file="top.jsp" %></div></td>
  </tr>
  <tr> 
    <td ><div align="center">
<table width="80%" border="0" cellpadding="1" cellspacing="1" class="td">
<%
if(op==null){
%>
<form name="passwordform" action="passwordedit.jsp?op=edit" method="post">

          <tr> 
            <td width="15%"><div align="right">用户名</div></td>
            <td><div align="left"><%=s_userid%></div></td>
          </tr>
          <tr> 
            <td><div align="right">新密码</div></td>
            <td><div align="left"><input name="password" type="password" size="20"><font color="red">*</font></div></td>
          </tr>
          <tr> 
            <td><div align="right">验证新密码</div></td>
            <td><div align="left"><input name="password2" type="password" size="20"><font color="red">*</font></div></td>
          </tr>

          <tr> 
            <td><div align="right">&nbsp;</div></td>
            <td><div align="left"> 
                <input name="submit" type="submit" value=" 修改密码 " onClick="return CheckSubmit();">&nbsp;&nbsp;
                <input name="reset" type="reset" value=" 重新填写 ">
              </div></td>
          </tr>		  
</form>
<%}else{%>
          <tr> 
              <td colspan="2">&nbsp;&nbsp;密码已修改,请您记住新密码.<a href="index.jsp">返回首页</a></td>
          </tr>
<%}%>		  		  
        </table>

	</div> 
	</td>
  </tr> 
  <tr> 
    <td ><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div>  