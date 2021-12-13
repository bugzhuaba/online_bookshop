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
   <td colspan="9"><div align="right">&nbsp;&nbsp;&nbsp;&nbsp;<a href="notessearch.jsp">��ѯ</a></div></td>
   </tr>
   <tr>
   <td colspan="9"><hr size="1" noshade width="100%"></td>
   </tr>
<%if(i_totalnum>0){%>      
  <tr>
    <td width="10%">��������</td>
    <td width="10%">������</td>
    <td width="10%">����</td>	
    <td width="20%">����</td>
    <td width="10%">��������</td>
    <td width="10%">������</td>
    <td width="20%">�������</td>	
	<td colspan="2"><div align="center">����</div></td>	
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
			  <td><a href="notesedit.jsp?op=show&id=<%=s_id%>">����</a></td>
			  <td><a href="notesdelete.jsp?op=delete&id=<%=s_id%>&currentpage=<%=i_currentpage%>">ɾ��</a></td>

  </tr>
  <%
  }//if
  }//for%>
   <tr>
   <td colspan="9"><div align="center">
   ��<%=i_totalpage%>ҳ ��<%=i_currentpage%>ҳ&nbsp;
<%if(i_currentpage>1){%>
   <a href="noteslist.jsp?op=firstpage">��ҳ</a>
<%}else{%>��ҳ<%}%>     
   &nbsp;
<%if(i_currentpage>1){%>
   <a href="noteslist.jsp?op=previous&currentpage=<%=i_currentpage%>">��һҳ</a> 
<%}else{%>��һҳ<%}%>   
   &nbsp;
<%if(i_currentpage!=i_totalpage){%>
   <a href="noteslist.jsp?op=next&currentpage=<%=i_currentpage%>">��һҳ</a>
<%}else{%>��һҳ<%}%>    
   
   &nbsp;
<%if(i_currentpage!=i_totalpage){%>
   <a href="noteslist.jsp?op=lastpage">ĩҳ</a>
<%}else{%>ĩҳ<%}%>    

   </div></td>
   </tr>
<%}else{%>
   <tr>
   <td colspan="9">û��������Ϣ.</td>
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