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
String s_id=request.getParameter("id");
String s_userid="";
String s_subject="";
String s_date1="";
String s_context="";
String s_employeeid="";
String s_advice="";

String op = request.getParameter("op");
{
if(op!=null&&op.equals("show"))
{
rs=stmt.executeQuery("select * from notes where id='"+s_id+"'");
rs.next();
 s_userid=(rs.getString("userid")!=null?rs.getString("userid"):"");
 s_subject=(rs.getString("subject")!=null?rs.getString("subject"):"");
 s_date1=(rs.getString("date1")!=null?rs.getString("date1").substring(0,10):"");
 s_context=(rs.getString("context")!=null?rs.getString("context"):"");
 s_employeeid=(rs.getString("employeeid")!=null?rs.getString("employeeid"):""); 

 s_advice=(rs.getString("advice")!=null?rs.getString("advice"):""); 
}
if(op!=null&&op.equals("edit"))
{
 s_advice=request.getParameter("advice");
 
String s_sql="update notes set "+
			 " advice='"+s_advice+"' "+
			 ", employeeid='"+s_admin+"' "+
			 ", date2=getdate() "+
			 "where id='"+s_id+"' ";
			 			 			 
stmt.executeUpdate(s_sql);
response.sendRedirect("noteslist.jsp");
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
		  <form name="form" action="notesedit.jsp?op=edit" method="post" >
            <tr> 
              <td width="20%">留言日期</td>
              <td><%=s_date1%><input name="id" type="hidden"  value="<%=s_id%>"></td>
            </tr>
            <tr> 
              <td width="20%">用户名</td>
              <td><%=s_userid%></td>
            </tr>
            <tr> 
              <td>主题</td>
              <td><%=s_subject%></td>
            </tr>
            <tr> 
              <td>内容</td>
              <td><%=s_context%></td>
            </tr>			
            <tr> 
              <td>处理意见</td>
              <td><textarea name="advice" cols="70" rows="10"><%=s_advice%></textarea></td>
            </tr>

            <tr> 
              <td colspan="2"><div align="center">
                  <input type="submit" value=" 修改 ">&nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="reset" value=" 重置 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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