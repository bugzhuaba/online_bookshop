<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<%
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
String s_where=(String)session.getAttribute("s_where");
if(s_where==null)
s_where="";
%>
<%
int i_totalnum=0;    //总记录数
int i_pagenum=10;    //一页显示的记录数码
int i_totalpage=0;   //总页数 
int i_currentpage=1; //当前页 
%>
<%
String op = request.getParameter("op");
if(op==null)
{
s_where="";
session.setAttribute("s_where",s_where);
}
%>
<%
rs=stmt.executeQuery("select count(*) from notes where id is not null "+s_where);
rs.next();
i_totalnum=rs.getInt(1);

i_totalpage=i_totalnum/i_pagenum;
if(i_totalnum%i_pagenum!=0)
i_totalpage++;

%>

<%
if(op!=null&&op.equals("show"))
{
String s_currentpage = request.getParameter("currentpage");
i_currentpage=Integer.parseInt(s_currentpage);
}
if(op!=null&&op.equals("previous"))
{
String s_currentpage = request.getParameter("currentpage");
i_currentpage=Integer.parseInt(s_currentpage)-1;
}
if(op!=null&&op.equals("next"))
{
String s_currentpage = request.getParameter("currentpage");
i_currentpage=Integer.parseInt(s_currentpage)+1;
}
if(op!=null&&op.equals("firstpage"))
{
i_currentpage=1;
}
if(op!=null&&op.equals("lastpage"))
{
i_currentpage=i_totalpage;
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
   <table width="100%" border="0" cellpadding="1" cellspacing="1" class="td"> 
   <tr>
   <td colspan="9"><div align="right">&nbsp;&nbsp;&nbsp;&nbsp;<a href="notessearch.jsp">查询</a></div></td>
   </tr>
   <tr>
   <td colspan="9"><hr size="1" noshade width="100%"></td>
   </tr>
<%if(i_totalnum>0){%>      
  <tr>
    <td width="10%">留言日期</td>
    <td width="10%">留言人</td>
    <td width="10%">主题</td>	
    <td width="20%">内容</td>
    <td width="10%">处理日期</td>
    <td width="10%">处理人</td>
    <td width="20%">处理意见</td>	
	<td colspan="2"><div align="center">操作</div></td>	
  </tr>
<%
rs=stmt.executeQuery("select * from notes where id is not null "+s_where+" order by date1 desc ");
if(i_currentpage>i_totalpage)
i_currentpage=i_totalpage;

int i_position=(i_currentpage-1)*i_pagenum;
if(i_position==0)
rs.beforeFirst();
else
rs.absolute(i_position);

for(int i=0;i<i_pagenum;i++)
{

if(!rs.isLast()){
rs.next();
String s_id=(rs.getString("id")!=null?rs.getString("id"):"");
String s_userid=(rs.getString("userid")!=null?rs.getString("userid"):"");
String s_subject=(rs.getString("subject")!=null?rs.getString("subject"):"");
String s_date1=(rs.getString("date1")!=null?rs.getString("date1").substring(0,10):"");
String s_context=(rs.getString("context")!=null?rs.getString("context"):"");
String s_employeeid=(rs.getString("employeeid")!=null?rs.getString("employeeid"):""); 
String s_date2=(rs.getString("date2")!=null?rs.getString("date2").substring(0,10):"");
String s_advice=(rs.getString("advice")!=null?rs.getString("advice"):""); 


%>
  <tr>
              <td><a href="notesedit.jsp?op=show&id=<%=s_id%>"><%=s_date1%></a></td>
              <td><%=s_userid%></td>
              <td><%=s_subject%></td>
              <td><%=s_context%></td>
              <td><%=s_date2%></td>
              <td><%=s_employeeid%></td>
              <td><%=s_advice%></td>
			  <td><a href="notesedit.jsp?op=show&id=<%=s_id%>">处理</a></td>
			  <td><a href="notesdelete.jsp?op=delete&id=<%=s_id%>&currentpage=<%=i_currentpage%>">删除</a></td>

  </tr>
  <%
  }//if
  }//for%>
   <tr>
   <td colspan="9"><div align="center">
   共<%=i_totalpage%>页 第<%=i_currentpage%>页&nbsp;
<%if(i_currentpage>1){%>
   <a href="noteslist.jsp?op=firstpage">首页</a>
<%}else{%>首页<%}%>     
   &nbsp;
<%if(i_currentpage>1){%>
   <a href="noteslist.jsp?op=previous&currentpage=<%=i_currentpage%>">上一页</a> 
<%}else{%>上一页<%}%>   
   &nbsp;
<%if(i_currentpage!=i_totalpage){%>
   <a href="noteslist.jsp?op=next&currentpage=<%=i_currentpage%>">下一页</a>
<%}else{%>下一页<%}%>    
   
   &nbsp;
<%if(i_currentpage!=i_totalpage){%>
   <a href="noteslist.jsp?op=lastpage">末页</a>
<%}else{%>末页<%}%>    

   </div></td>
   </tr>
<%}else{%>
   <tr>
   <td colspan="9">没有留言信息.</td>
   </tr>  
<%}%>
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