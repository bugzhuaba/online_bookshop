<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<SCRIPT LANGUAGE="javascript">
function CheckSubmit()
 {
  if( document.orderform.receiver.value == "" )
     { alert("�������ջ�������!"); document.orderform.receiver.focus(); return false; } 
  if( document.orderform.address.value == "" )
     { alert("�������ջ��˵�ַ!"); document.orderform.address.focus(); return false; } 
  if( document.orderform.phone.value == "" )
     { alert("��������ϵ�绰!"); document.orderform.phone.focus(); return false; } 
  if( document.orderform.postcode.value == "" )
     { alert("�������ʱ�!"); document.orderform.postcode.focus(); return false; } 		 
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
<link href="maincss.css" rel="stylesheet" type="text/css">
<div align="center">
<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr> 
    <td ><div align="center"><%@include file="top.jsp" %></div></td>
  </tr>
<%
  String s_userid=(String)session.getAttribute("userid");
  if(s_userid==null){
%>
  <tr> 
    <td ><div align="center">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
        <tr>
          <td>�����֤:</td>
        </tr>
        <tr>
          <td><hr size="1" noshade width="100%"></td>
        </tr>  
        <tr>
          <td>����û�е�¼,���Ĺ��鳵��Ϣ���ǻ�Ϊ������:<br>
	    1.����������ǵĻ�Ա�����ص�<a href="index.jsp">��ҳ��½</a>;<br>
	    2.����������û�,������<a href="register.jsp">ע��</a>;<br>
	  </td>
        </tr>
      </table></div></td>
  </tr>
<%
  }else{
    rs=stmt.executeQuery("select username,address,phone,postcode from userinfo where userid='"+s_userid+"'"); 
    rs.next();
%>
  <tr> 
    <td ><div align="center">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
      <form name="orderform" action="order2.jsp" method="post">
        <tr>
          <td colspan="2">Ϊ�������Ǽ�ʱ�����͵������ϣ�����ȷ��������Ϣ��ʵ�ɿ�:����<font color="red">*</font>�ŵ�Ϊ����������Ŀ��Բ���)</td>
        </tr>
        <tr>
          <td colspan="2"><hr size="1" noshade width="100%"></td>
        </tr>     
        <tr>
          <td>�ջ���:</td>
	  <td><input name="receiver" type="text" size="20" value="<%=rs.getString("username")%>">
	      <input name="userid" type="hidden"  value="<%=s_userid%>"><font color="red">*</font></td>
        </tr>
        <tr>
          <td>�ջ��˵�ַ:</td>
	  <td><input name="address" type="text" size="40" value="<%=rs.getString("address")%>"><font color="red">*</font></td>
        </tr>
        <tr>
          <td>��ϵ�绰:</td>
	  <td><input name="phone" type="text" size="20" value="<%=rs.getString("phone")%>"><font color="red">*</font></td>
        </tr>
        <tr>
          <td>�ʱ�:</td>
	  <td><input name="postcode" type="text" size="20" value="<%=rs.getString("postcode")%>"><font color="red">*</font></td>
        </tr>
        <tr>
          <td>���ѷ�ʽ:</td>
	  <td>
	    <select name="payment">
	      <option value="�ʾֻ��">�ʾֻ��</option>
	      <option value="����ת��">����ת��</option>
	      <option value="��������">��������</option>
	    </select>
        </tr>
        <tr>
          <td>�ͻ���ʽ:</td>
	  <td>
	    <select name="deliver">
	      <option value="24Сʱȫ���ؿ�ר��">24Сʱȫ���ؿ�ר��</option>
	      <option value="�ʾ�����">�ʾ�����</option>
	    </select>
	  </td>
        </tr>
        <tr>
          <td colspan="2"> <div align="center">
            <input type="submit" value=" ��Ҫ�¶��� " onClick="return CheckSubmit();">&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="reset" value=" ������д ">&nbsp;&nbsp;&nbsp;&nbsp;
                </div></td>
        </tr>  
  </form>
</table>	
	</div></td>
  </tr> 
<%}%>
  <tr> 
    <td ><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div>