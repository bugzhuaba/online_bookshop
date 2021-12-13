<%@ page contentType="text/html; charset=GB2312" %>
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
String s_userid="";
String s_date1="";
String s_date1end="";
String s_date2="";

String op = request.getParameter("op");
{

if(op!=null&&op.equals("search"))
{
 s_userid=request.getParameter("userid");
 s_date1=request.getParameter("date1");
 s_date1end=request.getParameter("date1end");
 s_date2=request.getParameter("date2");
 
 String s_where="";

if(!s_userid.equals(""))
s_where+=" and userid like'%"+s_userid+"%' "; 

if(!s_date1.equals(""))
s_where+=" and date1 >='"+s_date1+"' "; 
if(!s_date1end.equals(""))
s_where+=" and date1 <='"+s_date1end+"' "; 

if(!s_date2.equals("")&&s_date2.equals("已处理"))
s_where+=" and date2 is not null "; 
if(!s_date2.equals("")&&s_date2.equals("未处理"))
s_where+=" and date2 is null "; 

session.setAttribute("s_where",s_where);
response.sendRedirect("noteslist.jsp?op=show&currentpage=1");
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
		  <form name="form" action="notessearch.jsp?op=search" method="post" >
            <tr> 
              <td width="20%">留言日期</td>
              <td><input name="date1" type="text" size="12" value="">至<input name="date1end" type="text" size="12" value="">(格式:2004-09-01)</td>
            </tr>
            <tr> 
              <td width="20%">留言人</td>
              <td><input name="userid" type="text" size="20" value=""></td>
            </tr>
            <tr> 
              <td>类型</td>
              <td>
			  <select name="date2" >
			  <option value="" >所有</option>
			  <option value="已处理" >已处理</option>
			  <option value="未处理" >未处理</option>
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