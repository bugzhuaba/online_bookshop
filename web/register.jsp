<%@ page contentType="text/html; charset=GB2312" errorPage="error.jsp"%>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<SCRIPT LANGUAGE="javascript">

function CheckSubmit()
 {
  if( document.registerform.userid.value == "" )
     { alert("�������û���!"); document.registerform.userid.focus(); return false; } 
  if( document.registerform.password.value == "" )
     { alert("����������!"); document.registerform.password.focus(); return false; } 	 
  if( document.registerform.password2.value == "" )
     { alert("����֤����!"); document.registerform.password2.focus(); return false; } 
  if( document.registerform.password2.value != document.registerform.password.value  )
     { alert("������֤����!"); document.registerform.password.focus(); return false; }
  if( document.registerform.username.value == "" )
     { alert("��������ʵ����!"); document.registerform.username.focus(); return false; }	 
  if( document.registerform.address.value == "" )
     { alert("������סַ!"); document.registerform.address.focus(); return false; }	
  if( document.registerform.postcode.value == "" )
     { alert("�������ʱ�!"); document.registerform.postcode.focus(); return false; }	
  if( document.registerform.phone.value == "" )
     { alert("��������ϵ�绰!"); document.registerform.phone.focus(); return false; }	 		 
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
  String op = request.getParameter("op");
  if(op!=null&&op.equals("register")){
    String s_userid=request.getParameter("userid");
    String s_password=request.getParameter("password");
    String s_username=request.getParameter("username");
    String s_gender=request.getParameter("gender");
    String s_address=request.getParameter("address");
    String s_phone=request.getParameter("phone");
    String s_postcode=request.getParameter("postcode");
    String s_email=request.getParameter("email");
    String s_sql="insert into userinfo(userid,password,username,gender,address,phone,postcode,email,state) "+
             "values('"+s_userid+"','"+s_password+"','"+s_username+"','"+s_gender+"','"+s_address+"','"+s_phone+"','"+s_postcode+"','"+s_email+"','0')" ;
    try{
      stmt.executeUpdate(s_sql);
    }catch(Exception e){
      response.sendRedirect("error.jsp?error=ע��ʧ��,"+e.getMessage());
     }
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
<form name="registerform" action="register.jsp?op=register" method="post">
    <tr> 
      <td colspan="2">&nbsp;&nbsp;������������ʵ��д���Ա�֤��ȷ��������Щ����δ���ͻ�����ֻ���ڴ���ͻ��Ķ�����Ϣ�������ϸ��ܡ����� 
       <font color="red">*</font>�ŵ�Ϊ����������Ŀ��Բ��</td>
    </tr>
    <tr> 
      <td width="15%"><div align="right">�û���</div></td>
      <td><div align="left"><input name="userid" type="text" size="20"><font color="red">*</font>(Ϊ����ʹ����ͬ���û���,��<a href="#">���</a>����û����Ƿ���Ч)</div></td>
    </tr>
    <tr> 
      <td><div align="right">����</div></td>
      <td><div align="left"><input name="password" type="password" size="20"><font color="red">*</font></div></td>
    </tr>
    <tr> 
      <td><div align="right">��֤����</div></td>
      <td><div align="left"><input name="password2" type="password" size="20"><font color="red">*</font></div></td>
    </tr>
    <tr> 
      <td><div align="right">��ʵ����</div></td>
      <td><div align="left"><input name="username" type="text" size="20"><font color="red">*</font></div></td>
    </tr>
    <tr> 
      <td><div align="right">�Ա�</div></td>
      <td><div align="left">
         <select name="gender">
	   <option value="��">��</option>
	   <option value="Ů">Ů</option>
	 </select>
	  </div></td>
    </tr>		  
    <tr> 
      <td><div align="right">סַ</div></td>
      <td><div align="left"><input name="address" type="text" size="20"><font color="red">*</font>(�����ṩ��������ϸ�ĵ�ַ)</div></td>
    </tr>
    <tr> 
      <td><div align="right">�ʱ�</div></td>
      <td><div align="left"><input name="postcode" type="text" size="20"><font color="red">*</font></div></td>
    </tr>		  
    <tr> 
      <td><div align="right">��ϵ�绰</div></td>
      <td><div align="left"><input name="phone" type="text" size="20"><font color="red">*</font></div></td>
    </tr>
    <tr> 
      <td><div align="right">E-mail</div></td>
      <td><div align="left"><input name="email" type="text" size="20"></div></td>
    </tr>
    <tr> 
      <td><div align="right">&nbsp;</div></td>
      <td><div align="left"> 
        <input name="submit" type="submit" value=" ע�����û� " onClick="return CheckSubmit();">&nbsp;&nbsp;
        <input name="reset" type="reset" value=" ������д ">
         </div></td>
    </tr>		  
</form>
<%}else{%>
    <tr> 
       <td colspan="2">&nbsp;&nbsp;��ϲ,ע��ɹ�,���ס�����û���������!���ھ�ȥ<a href="index.jsp">��ҳ��½</a>.</td>
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