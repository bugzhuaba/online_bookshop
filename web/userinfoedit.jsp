<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<SCRIPT LANGUAGE="javascript">

function CheckSubmit()
 {
  if( document.editform.username.value == "" )
     { alert("请输入真实姓名!"); document.editform.username.focus(); return false; }	 
  if( document.editform.address.value == "" )
     { alert("请输入住址!"); document.editform.address.focus(); return false; }	
  if( document.editform.postcode.value == "" )
     { alert("请输入邮编!"); document.editform.postcode.focus(); return false; }	
  if( document.editform.phone.value == "" )
     { alert("请输入联系电话!"); document.editform.phone.focus(); return false; }	 		 
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
String s_username="";
String s_gender="";
String s_address="";
String s_phone="";
String s_postcode="";
String s_email="";
%>
<%
String s_userid=(String)session.getAttribute("userid");
if(s_userid==null){
response.sendRedirect("checklogin.jsp");
}
%>
<%
String op = request.getParameter("op");
if(op==null)
{
rs=stmt.executeQuery("select * from userinfo where userid='"+s_userid+"'"); 
rs.next();
s_username=rs.getString("username");
s_gender=rs.getString("gender");
s_address=rs.getString("address");
s_email=rs.getString("email");
s_phone=rs.getString("phone");
s_postcode=rs.getString("postcode");

}

if(op!=null&&op.equals("edit")){

 s_username=request.getParameter("username");
 s_gender=request.getParameter("gender");
 s_address=request.getParameter("address");
 s_phone=request.getParameter("phone");
 s_postcode=request.getParameter("postcode");
 s_email=request.getParameter("email");

String s_sql="update userinfo set username='"+s_username+"',gender='"+s_gender+"',address='"+s_address+"',phone='"+s_phone+"',postcode='"+s_postcode+"',email='"+s_email+"'  where userid='"+s_userid+"'";
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
<form name="editform" action="userinfoedit.jsp?op=edit" method="post">
          <tr> 
            <td colspan="2">&nbsp;&nbsp;以下资料请如实填写，以保证正确发货。这些资料未经客户允许将只用于处理客户的订货信息，对外严格保密。（带 
              <font color="red">*</font>号的为必填项，其它的可以不填）</td>
          </tr>
          <tr> 
            <td width="15%"><div align="right">用户名</div></td>
            <td><div align="left"><%=s_userid%></div></td>
          </tr>
          <tr> 
            <td><div align="right">真实姓名</div></td>
            <td><div align="left"><input name="username" type="text" size="20" value="<%=s_username%>"><font color="red">*</font></div></td>
          </tr>
          <tr> 
            <td><div align="right">性别</div></td>
            <td><div align="left">
			<select name="gender">
			<option value="男" <%=(s_gender.equals("男")?" selected ":"")%>>男</option>
			<option value="女" <%=(s_gender.equals("女")?" selected ":"")%>>女</option>
			</select>
			</div></td>
          </tr>		  
          <tr> 
            <td><div align="right">住址</div></td>
            <td><div align="left"><input name="address" type="text" size="20" value="<%=s_address%>">
                    <font color="red">*</font>（请您提供尽可能详细的地址）</div></td>
          </tr>
          <tr> 
            <td><div align="right">邮编</div></td>
            <td><div align="left"><input name="postcode" type="text" size="20" value="<%=s_postcode%>"><font color="red">*</font></div></td>
          </tr>		  
          <tr> 
            <td><div align="right">联系电话</div></td>
            <td><div align="left"><input name="phone" type="text" size="20" value="<%=s_phone%>"><font color="red">*</font></div></td>
          </tr>
          <tr> 
            <td><div align="right">E-mail</div></td>
            <td><div align="left"><input name="email" type="text" size="20" value="<%=s_email%>"></div></td>
          </tr>
          <tr> 
            <td><div align="right">&nbsp;</div></td>
            <td><div align="left"> 
                <input name="submit" type="submit" value=" 修改个人信息 " onClick="return CheckSubmit();">&nbsp;&nbsp;
                <input name="reset" type="reset" value=" 重新填写 ">
              </div></td>
          </tr>		  
</form>
<%}else{%>
          <tr> 
              <td colspan="2">&nbsp;&nbsp;恭喜,个人信息成功修改.<a href="index.jsp">返回首页</a></td>
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