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
String s_employeeid="";
String s_name="";
String s_gender="";
String s_address="";
String s_email="";
String s_phone="";
String s_task="";

String op = request.getParameter("op");
{
if(op!=null&&op.equals("search"))
{
 s_employeeid=request.getParameter("employeeid");
 s_name=request.getParameter("name");
 s_gender=request.getParameter("gender");
 s_address=request.getParameter("address");
 s_email=request.getParameter("email");
 s_phone=request.getParameter("phone");
 s_task=request.getParameter("task");
 
String s_where="";

if(!s_employeeid.equals(""))
s_where+=" and employeeid like'%"+s_employeeid+"%' ";
if(!s_name.equals(""))
s_where+=" and name like'%"+s_name+"%' ";
if(!s_gender.equals(""))
s_where+=" and gender like'%"+s_gender+"%' ";
if(!s_address.equals(""))
s_where+=" and address like'%"+s_address+"%' ";
if(!s_email.equals(""))
s_where+=" and email like'%"+s_email+"%' ";
if(!s_phone.equals(""))
s_where+=" and phone like'%"+s_phone+"%' ";
if(!s_task.equals(""))
s_where+=" and task like'%"+s_task+"%' ";



session.setAttribute("s_where",s_where);
response.sendRedirect("employeelist.jsp?op=show&currentpage=1");
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
		  <form name="form" action="employeesearch.jsp?op=search" method="post" >
            <tr> 
              <td width="20%">职工帐号</td>
              <td><input name="employeeid" type="text"  size="25" ></td>
            </tr>
            <tr> 
              <td>姓名</td>
              <td><input name="name" type="text" size="25" ></td>
            </tr>
            <tr> 
              <td>性别</td>
              <td>              
			  <select name="gender" >
			  <option value="" >所有</option>
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
              <td>工作任务</td>
              <td><input name="task" type="text" size="25" ></td>
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