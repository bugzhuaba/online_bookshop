<%@ page contentType="text/html; charset=GB2312" %>
<SCRIPT LANGUAGE="javascript">

function CheckSubmit()
 { //focus()����������궨λ�������Ŀ
  if( document.loginform.userid.value == "" )
     { alert("�������û���!"); document.loginform.userid.focus(); return false; }   
  if( document.loginform.password.value == "" )
     { alert("����������!"); document.loginform.password.focus(); return false; } 	 
  if(document.loginform.userid.value.indexOf("'") != -1)
     { alert("�û������ܰ���������,�ո���ַ�!"); document.loginform.userid.focus(); return false; }   	 
  return true;                                                                                          
 } 
</SCRIPT>
<%@ page import="java.util.*,java.sql.*"%>
<%
  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection connn=DriverManager.getConnection("jdbc:mysql://localhost:3306/web_bookshop?useUnicode=true&characterEncooding=utf8&useSSL=true","root","123456");
%>
<%
  String opp = request.getParameter("op");
  if(opp!=null&&opp.equals("login")){
    String s_userid=request.getParameter("userid");
    String s_password=request.getParameter("password");
    Statement stmtt=connn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
    ResultSet rss=stmtt.executeQuery("select * from userinfo where userid='"+s_userid+"' and password='"+s_password+"'");

    if(rss.next()){
      session.setAttribute("userid",s_userid);
      response.sendRedirect("index.jsp");
    }
    else
    {
      response.sendRedirect("error.jsp?error="+"�û��������벻��ȷ!");
    }
  }
  if(opp!=null&&opp.equals("exit")){
    session.removeAttribute("userid");
    session.removeAttribute("cart");
    response.sendRedirect("index.jsp");
  }
  String s_userid=(String)session.getAttribute("userid");
%>
<%
  if(s_userid==null){
%>
<link href="maincss.css" rel="stylesheet" type="text/css">
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#f6f6f6" class="td">
  <form name="loginform" action="index.jsp?op=login" method="post" >
    <tr> 
      <td colspan="3"><div align="left"><img src="images/login_r1.jpg" width="158" height="43"></div></td>
    </tr>
    <tr> 
      <td width="8">&nbsp;</td>
      <td width="25%">�û���</td>
      <td width="75%"><input name="userid" type="text" class="formtext" size="12"></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>����</td>
      <td><input name="password" type="password" class="formtext" size="12"></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td colspan="2"> <input name="loginbutton" type="submit" value=" ��¼ " onClick="return CheckSubmit();">
        ���û�<a href="register.jsp">ע��</a> </td>
    </tr>
  </form>
</table>
<%}else{%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#f6f6f6" class="td">
  <tr> 
    <td width="8" > <div align="left"></div></td>
    <td width="737" ><%=s_userid%>,����!<br>
      ��ӭ�����������...</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>������:</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td><a href="passwordedit.jsp">�޸ĵ�¼����</a></td>
  </tr>
  <tr> 
    <td >&nbsp;</td>
    <td ><a href="userinfoedit.jsp">ά��������Ϣ</a></td>
  </tr>
  <tr> 
    <td >&nbsp;</td>
    <td ><a href="myorder.jsp">�鿴��ʷ����</a></td>
  </tr>
  <tr> 
    <td >&nbsp;</td>
    <td ><a href="shoppingcart.jsp">�鿴���鳵</a></td>
  </tr>
  <tr> 
    <td >&nbsp;</td>
    <td ><a href="leaveword.jsp">������Ա����</a></td>
  </tr>
  <tr> 
    <td >&nbsp;</td>
    <td ><a href="index.jsp?op=exit">ע���˳�</a></td>
  </tr>
</table>
<%}%>

