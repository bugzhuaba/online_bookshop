<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<%
  request.setCharacterEncoding("GB2312");
  Jdbc jdbc=new Jdbc();
  Connection conn = jdbc.getCon();
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  ResultSet rs=null;
  String s_admin=(String)session.getAttribute("admin");
  if(s_admin==null){
    response.sendRedirect("checklogin.jsp");
  }
  String s_orderid="";
  String s_orderdate="";
  String s_orderdate2="";
  String s_userid="";
  String s_totalnum="";
  String s_totalnum2="";
  String s_totalamount="";
  String s_totalamount2="";
  String s_state="";
  String op = request.getParameter("op");
{
  if(op!=null&&op.equals("search")){
    s_orderid=request.getParameter("orderid");
    s_orderdate=request.getParameter("orderdate");
    s_orderdate2=request.getParameter("orderdate2"); 
    s_userid=request.getParameter("userid");
    s_totalnum=request.getParameter("totalnum");
    s_totalnum2=request.getParameter("totalnum2");
    s_totalamount=request.getParameter("totalamount");
    s_totalamount2=request.getParameter("totalamount2"); 
    s_state=request.getParameter("state");
    String s_where="";
    if(!s_orderid.equals(""))
      s_where+=" and orderid ='"+s_orderid+"' "; 
    if(!s_orderdate.equals(""))
      s_where+=" and orderdate >='"+s_orderdate+"' "; 
    if(!s_orderdate2.equals(""))
      s_where+=" and orderdate <='"+s_orderdate2+"' "; 
    if(!s_userid.equals(""))
      s_where+=" and userid like '%"+s_userid+"%' "; 
    if(!s_totalnum.equals(""))
      s_where+=" and totalnum >='"+s_totalnum+"' "; 
    if(!s_totalnum2.equals(""))
      s_where+=" and totalnum <='"+s_totalnum2+"' ";
    if(!s_totalamount.equals(""))
      s_where+=" and totalamount >='"+s_totalamount+"' "; 
    if(!s_totalamount2.equals(""))
      s_where+=" and totalamount <='"+s_totalamount2+"' ";
    if(!s_state.equals(""))
      s_where+=" and state ='"+s_state+"' "; 
    session.setAttribute("s_where",s_where);
    response.sendRedirect("orderlist.jsp?op=show&currentpage=1");
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
      <form name="form" action="ordersearch.jsp?op=search" method="post" >
        <tr> 
          <td width="20%">订单号</td>
          <td><input name="orderid" type="text" size="20" value=""></td>
        </tr>		  
        <tr> 
          <td width="20%">订单日期</td>
          <td><input name="orderdate" type="text" size="12" value="">至<input name="orderdate2" type="text" size="12" value="">(格式:2004-09-01)</td>
        </tr>
        <tr> 
          <td width="20%">下单人</td>
          <td><input name="userid" type="text" size="20" value=""></td>
        </tr>
        <tr> 
          <td>图书总数</td>
          <td><input name="totalnum" type="text" size="8" value="1">至<input name="totalnum2" type="text" size="8" value="10"></td>
        </tr>
        <tr> 
          <td>总价</td>
          <td><input name="totalamount" type="text" size="8" value="0.00">至<input name="totalamount2" type="text" size="8" value="1000.00"></td>
        </tr>			
	<tr> 
          <td>状态</td>
          <td>
	    <select name="state" >
	      <option value="" >所有</option>
	      <option value="0" >未处理</option>
	      <option value="1" >发货</option>
	      <option value="2" >完成</option>
	    </select></td>
        </tr>			
        <tr> 
          <td colspan="2"><div align="center">
            <input type="submit" value=" 查询 ">&nbsp;&nbsp;&nbsp;&nbsp;
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