<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<SCRIPT LANGUAGE="javascript">

function CheckSubmit()
 {
  if( document.editform.username.value == "" )
     { alert("��������ʵ����!"); document.editform.username.focus(); return false; }	 
  if( document.editform.address.value == "" )
     { alert("������סַ!"); document.editform.address.focus(); return false; }	
  if( document.editform.postcode.value == "" )
     { alert("�������ʱ�!"); document.editform.postcode.focus(); return false; }	
  if( document.editform.phone.value == "" )
     { alert("��������ϵ�绰!"); document.editform.phone.focus(); return false; }	 		 
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
            <td colspan="2">&nbsp;&nbsp;������������ʵ��д���Ա�֤��ȷ��������Щ����δ���ͻ�����ֻ���ڴ���ͻ��Ķ�����Ϣ�������ϸ��ܡ����� 
              <font color="red">*</font>�ŵ�Ϊ����������Ŀ��Բ��</td>
          </tr>
          <tr> 
            <td width="15%"><div align="right">�û���</div></td>
            <td><div align="left"><%=s_userid%></div></td>
          </tr>
          <tr> 
            <td><div align="right">��ʵ����</div></td>
            <td><div align="left"><input name="username" type="text" size="20" value="<%=s_username%>"><font color="red">*</font></div></td>
          </tr>
          <tr> 
            <td><div align="right">�Ա�</div></td>
            <td><div align="left">
			<select name="gender">
			<option value="��" <%=(s_gender.equals("��")?" selected ":"")%>>��</option>
			<option value="Ů" <%=(s_gender.equals("Ů")?" selected ":"")%>>Ů</option>
			</select>
			</div></td>
          </tr>		  
          <tr> 
            <td><div align="right">סַ</div></td>
            <td><div align="left"><input name="address" type="text" size="20" value="<%=s_address%>">
                    <font color="red">*</font>�������ṩ��������ϸ�ĵ�ַ��</div></td>
          </tr>
          <tr> 
            <td><div align="right">�ʱ�</div></td>
            <td><div align="left"><input name="postcode" type="text" size="20" value="<%=s_postcode%>"><font color="red">*</font></div></td>
          </tr>		  
          <tr> 
            <td><div align="right">��ϵ�绰</div></td>
            <td><div align="left"><input name="phone" type="text" size="20" value="<%=s_phone%>"><font color="red">*</font></div></td>
          </tr>
          <tr> 
            <td><div align="right">E-mail</div></td>
            <td><div align="left"><input name="email" type="text" size="20" value="<%=s_email%>"></div></td>
          </tr>
          <tr> 
            <td><div align="right">&nbsp;</div></td>
            <td><div align="left"> 
                <input name="submit" type="submit" value=" �޸ĸ�����Ϣ " onClick="return CheckSubmit();">&nbsp;&nbsp;
                <input name="reset" type="reset" value=" ������д ">
              </div></td>
          </tr>		  
</form>
<%}else{%>
          <tr> 
              <td colspan="2">&nbsp;&nbsp;��ϲ,������Ϣ�ɹ��޸�.<a href="index.jsp">������ҳ</a></td>
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