<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<SCRIPT LANGUAGE="javascript">
function CheckSubmit()
 {
  if( document.orderform.receiver.value == "" )
     { alert("请输入收货人姓名!"); document.orderform.receiver.focus(); return false; } 
  if( document.orderform.address.value == "" )
     { alert("请输入收货人地址!"); document.orderform.address.focus(); return false; } 
  if( document.orderform.phone.value == "" )
     { alert("请输入联系电话!"); document.orderform.phone.focus(); return false; } 
  if( document.orderform.postcode.value == "" )
     { alert("请输入邮编!"); document.orderform.postcode.focus(); return false; } 		 
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
          <td>身份验证:</td>
        </tr>
        <tr>
          <td><hr size="1" noshade width="100%"></td>
        </tr>  
        <tr>
          <td>您还没有登录,您的购书车信息我们会为您保留:<br>
	    1.如果您是我们的会员请您回到<a href="index.jsp">首页登陆</a>;<br>
	    2.如果您是新用户,请您先<a href="register.jsp">注册</a>;<br>
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
          <td colspan="2">为方便我们及时将书送到您手上，请您确保以下信息真实可靠:（带<font color="red">*</font>号的为必填项，其它的可以不填)</td>
        </tr>
        <tr>
          <td colspan="2"><hr size="1" noshade width="100%"></td>
        </tr>     
        <tr>
          <td>收货人:</td>
	  <td><input name="receiver" type="text" size="20" value="<%=rs.getString("username")%>">
	      <input name="userid" type="hidden"  value="<%=s_userid%>"><font color="red">*</font></td>
        </tr>
        <tr>
          <td>收货人地址:</td>
	  <td><input name="address" type="text" size="40" value="<%=rs.getString("address")%>"><font color="red">*</font></td>
        </tr>
        <tr>
          <td>联系电话:</td>
	  <td><input name="phone" type="text" size="20" value="<%=rs.getString("phone")%>"><font color="red">*</font></td>
        </tr>
        <tr>
          <td>邮编:</td>
	  <td><input name="postcode" type="text" size="20" value="<%=rs.getString("postcode")%>"><font color="red">*</font></td>
        </tr>
        <tr>
          <td>付费方式:</td>
	  <td>
	    <select name="payment">
	      <option value="邮局汇款">邮局汇款</option>
	      <option value="银行转账">银行转账</option>
	      <option value="货到付款">货到付款</option>
	    </select>
        </tr>
        <tr>
          <td>送货方式:</td>
	  <td>
	    <select name="deliver">
	      <option value="24小时全国特快专递">24小时全国特快专递</option>
	      <option value="邮局托运">邮局托运</option>
	    </select>
	  </td>
        </tr>
        <tr>
          <td colspan="2"> <div align="center">
            <input type="submit" value=" 我要下订单 " onClick="return CheckSubmit();">&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="reset" value=" 重新填写 ">&nbsp;&nbsp;&nbsp;&nbsp;
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