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
int i_totalnum=0;    //�ܼ�¼��
int i_pagenum=10;    //һҳ��ʾ�ļ�¼����
int i_totalpage=0;   //��ҳ�� 
int i_currentpage=1; //��ǰҳ 
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
rs=stmt.executeQuery("select count(*) from employee where employeeid is not null "+s_where);
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
   <td colspan="8"><div align="right"><a href="employeeadd.jsp">�½�</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="employeesearch.jsp">��ѯ</a></div></td>
   </tr>
   <tr>
   <td colspan="8"><hr size="1" noshade width="100%"></td>
   </tr>  
<%if(i_totalnum>0){%>   
  <tr>
    <td>ְ���ʺ�</td>
    <td>����</td>
    <td>�Ա�</td>	
    <td>��ϵ��ַ</td>
    <td>E-mail </td>
    <td>�绰</td>
    <td>��������</td>	
	<td>����</td>	
  </tr>
<%
rs=stmt.executeQuery("select * from employee where employeeid is not null "+s_where+" order by employeeid ");
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
String s_employeeid=(rs.getString("employeeid")!=null?rs.getString("employeeid"):"");
String s_name=(rs.getString("name")!=null?rs.getString("name"):"");
String s_gender=(rs.getString("gender")!=null?rs.getString("gender"):"");
String s_address=(rs.getString("address")!=null?rs.getString("address"):"");
String s_email=(rs.getString("email")!=null?rs.getString("email"):"");
String s_phone=(rs.getString("phone")!=null?rs.getString("phone"):"");
String s_task=(rs.getString("task")!=null?rs.getString("task"):"");


%>
  <tr>
              <td><a href="employeeedit.jsp?op=show&employeeid=<%=s_employeeid%>"><%=s_employeeid%></a></td>
              <td><%=s_name%></td>
              <td><%=s_gender%></td>
              <td><%=s_address%></td>
              <td><%=s_email%></td>
              <td><%=s_phone%></td>
			  <td><%=s_task%></td>
			  <td><a href="employeedelete.jsp?op=delete&employeeid=<%=s_employeeid%>&currentpage=<%=i_currentpage%>">ɾ��</a></td>

  </tr>
  <%
  }//if
  }//for%>
   <tr>
   <td colspan="8"><div align="center">
   ��<%=i_totalpage%>ҳ ��<%=i_currentpage%>ҳ&nbsp;
<%if(i_currentpage>1){%>
   <a href="employeelist.jsp?op=firstpage">��ҳ</a>
<%}else{%>��ҳ<%}%>     
   &nbsp;
<%if(i_currentpage>1){%>
   <a href="employeelist.jsp?op=previous&currentpage=<%=i_currentpage%>">��һҳ</a> 
<%}else{%>��һҳ<%}%>   
   &nbsp;
<%if(i_currentpage!=i_totalpage){%>
   <a href="employeelist.jsp?op=next&currentpage=<%=i_currentpage%>">��һҳ</a>
<%}else{%>��һҳ<%}%>    
   
   &nbsp;
<%if(i_currentpage!=i_totalpage){%>
   <a href="employeelist.jsp?op=lastpage">ĩҳ</a>
<%}else{%>ĩҳ<%}%>    

   </div></td>
   </tr>
<%}else{%>
   <tr>
   <td colspan="8">û��ְ����Ϣ.</td>
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