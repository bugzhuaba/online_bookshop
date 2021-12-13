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
rs=stmt.executeQuery("select count(*) from userinfo where userid is not null "+s_where);
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
   <td colspan="9"><div align="right"><a href="userinfoadd.jsp">新建</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="userinfosearch.jsp">查询</a></div></td>
   </tr>
   <tr>
   <td colspan="9"><hr size="1" noshade width="100%"></td>
   </tr>  
<%if(i_totalnum>0){%>    
  <tr>
    <td>用户名</td>
    <td>姓名</td>
    <td>性别</td>	
    <td>联系地址</td>
    <td>E-mail </td>
    <td>电话</td>
    <td>邮编</td>
    <td>状态</td>	
	<td>操作</td>	
  </tr>
<%
rs=stmt.executeQuery("select * from userinfo where userid is not null "+s_where+" order by userid ");
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
String s_userid=(rs.getString("userid")!=null?rs.getString("userid"):"");
String s_username=(rs.getString("username")!=null?rs.getString("username"):"");
String s_gender=(rs.getString("gender")!=null?rs.getString("gender"):"");
String s_address=(rs.getString("address")!=null?rs.getString("address"):"");
String s_email=(rs.getString("email")!=null?rs.getString("email"):"");
String s_phone=(rs.getString("phone")!=null?rs.getString("phone"):"");
String s_postcode=(rs.getString("postcode")!=null?rs.getString("postcode"):"");
String s_state=(rs.getString("state")!=null?rs.getString("state"):"");

if(s_state.equals("1"))
s_state="激活";
if(s_state.equals("0"))
s_state="未激活";

%>
  <tr>
              <td><a href="userinfoedit.jsp?op=show&userid=<%=s_userid%>"><%=s_userid%></a></td>
              <td><%=s_username%></td>
              <td><%=s_gender%></td>
              <td><%=s_address%></td>
              <td><%=s_email%></td>
              <td><%=s_phone%></td>
              <td><%=s_postcode%></td>
			  <td><%=s_state%></td>
			  <td><a href="userinfodelete.jsp?op=delete&userid=<%=s_userid%>&currentpage=<%=i_currentpage%>">删除</a></td>

  </tr>
  <%
  }//if
  }//for%>
   <tr>
   <td colspan="9"><div align="center">
   共<%=i_totalpage%>页 第<%=i_currentpage%>页&nbsp;
<%if(i_currentpage>1){%>
   <a href="userinfolist.jsp?op=firstpage">首页</a>
<%}else{%>首页<%}%>     
   &nbsp;
<%if(i_currentpage>1){%>
   <a href="userinfolist.jsp?op=previous&currentpage=<%=i_currentpage%>">上一页</a> 
<%}else{%>上一页<%}%>   
   &nbsp;
<%if(i_currentpage!=i_totalpage){%>
   <a href="userinfolist.jsp?op=next&currentpage=<%=i_currentpage%>">下一页</a>
<%}else{%>下一页<%}%>    
   
   &nbsp;
<%if(i_currentpage!=i_totalpage){%>
   <a href="userinfolist.jsp?op=lastpage">末页</a>
<%}else{%>末页<%}%>    

   </div></td>
   </tr>
<%}else{%>
   <tr>
   <td colspan="9">没有用户信息.</td>
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