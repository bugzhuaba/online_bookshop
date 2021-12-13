<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="bean.Jdbc" %>
<SCRIPT LANGUAGE="javascript">

function CheckSubmit()
 {
  if( document.form.subject.value == "" )
     { alert("请输入主题!"); document.form.subject.focus(); return false; } 
  if( document.form.context.value == "" )
     { alert("请输入内容!"); document.form.context.focus(); return false; } 	 	 
  if( document.form.context.value.length >=100 )
     { alert("留言内容不能大于100字!"); document.form.context.focus(); return false; } 		 
  return true;                                                                                          
 } 
</SCRIPT>
<%
  request.setCharacterEncoding("GB2312");
  Jdbc jdbc=new Jdbc();
  Connection conn = jdbc.getCon();
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  ResultSet rs=null;
  String s_userid=(String)session.getAttribute("userid");
  int i_totalnum=0;    //总记录数
  int i_pagenum=5;    //一页显示的记录数码
  int i_totalpage=0;   //总页数 
  int i_currentpage=1; //当前页 
  String s_createid="";
  String s_subject="";
  String s_date1="";
  String s_context="";
  String s_employeeid="";
  String s_date2="";
  String s_advice="";
  rs=stmt.executeQuery("select count(*) from notes  "); 
  rs.next();
  i_totalnum=rs.getInt(1);
  i_totalpage=i_totalnum/i_pagenum;
  if(i_totalnum%i_pagenum!=0)
    i_totalpage++;
  String op = request.getParameter("op");
  if(op!=null&&op.equals("show")){
    String s_currentpage = request.getParameter("currentpage");
    i_currentpage=Integer.parseInt(s_currentpage);
  }
  if(op!=null&&op.equals("previous")){
    String s_currentpage = request.getParameter("currentpage");
    i_currentpage=Integer.parseInt(s_currentpage)-1;
  }
  if(op!=null&&op.equals("next")){
    String s_currentpage = request.getParameter("currentpage");
    i_currentpage=Integer.parseInt(s_currentpage)+1;
  }
  if(op!=null&&op.equals("firstpage")){
    i_currentpage=1;
  }
  if(op!=null&&op.equals("lastpage")){
    i_currentpage=i_totalpage;
  }
%>
<link href="maincss.css" rel="stylesheet" type="text/css">
<div align="center">
<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr> 
    <td ><div align="center"><%@include file="top.jsp" %></div></td>
  </tr>
  <tr> 
    <td ><div align="center">
      <table width="100%" border="0" cellpadding="1" cellspacing="1" class="td">
        <tr> 
          <td colspan="6">读者留言</td>
        </tr>
        <tr> 
          <td colspan="6"><hr size="1" noshade width="100%"></td>
        </tr>
<%if(i_totalnum!=0){%>
        <tr> 
          <td colspan="3">最近的留言共<%=i_totalnum%>条,分<%=i_totalpage%>页显示,每页显示<%=i_pagenum%>条</td>
          <td colspan="3"><div align="right">
            第<%=i_currentpage%>页&nbsp;
<%          if(i_currentpage>1){%>
              <a href="leaveword.jsp?op=firstpage">首页</a>
<%          }else{%>首页<%}%>&nbsp;
<%          if(i_currentpage>1){%>
              <a href="leaveword.jsp?op=previous&currentpage=<%=i_currentpage%>">上一页</a> 
<%          }else{%>上一页<%}%>&nbsp;
<%          if(i_currentpage!=i_totalpage){%>
              <a href="leaveword.jsp?op=next&currentpage=<%=i_currentpage%>">下一页</a>
<%          }else{%>下一页<%}%>&nbsp;
<%          if(i_currentpage!=i_totalpage){%>
              <a href="leaveword.jsp?op=lastpage">末页</a>
<%          }else{%>末页<%}%>
			 </div></td>
        </tr>
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>						
	<tr>
	  <td width="10%">留言日期</td>
	  <td width="10%">留言人</td>
	  <td width="15%">主题</td>			
	  <td width="25%">内容</td>
	  <td width="10%">处理日期</td>
	  <td width="30%">处理意见</td>
	</tr>
<%
  rs=stmt.executeQuery("select * from notes  order by id desc  ");
  if(i_currentpage>i_totalpage)
  i_currentpage=i_totalpage;
  int i_position=(i_currentpage-1)*i_pagenum;
  if(i_position==0)
    rs.beforeFirst();
  else
    rs.absolute(i_position);
  for(int i=0;i<i_pagenum;i++){
    if(!rs.isLast()){
      rs.next();
      s_createid=(rs.getString("userid")!=null?rs.getString("userid"):"");
      s_subject=(rs.getString("subject")!=null?rs.getString("subject"):"");
      s_date1=(rs.getString("date1")!=null?rs.getString("date1").substring(0,10):"");
      s_context=(rs.getString("context")!=null?rs.getString("context"):""); 
      s_employeeid=(rs.getString("employeeid")!=null?rs.getString("employeeid"):""); 
      s_date2=(rs.getString("date2")!=null?rs.getString("date2").substring(0,10):"");
      s_advice=(rs.getString("advice")!=null?rs.getString("advice"):"[请等待工作人员处理]");
%>				
        <tr>
	  <td ><%=s_date1%></td>
	  <td ><%=s_createid%></td>
	  <td ><%=s_subject%></td>			
	  <td ><%=s_context%></td>
	  <td ><%=s_date2%></td>
	  <td ><%=s_advice%></td>
	</tr>
<%
    }//if
  }//for
%>
<%}else{%>
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>
<%}%>			
<%
  if(s_userid!=null){
%>	
<form name="form" action="leaveword2.jsp" method="post">
        <tr> 
          <td width="9%" >主题</td>
          <td colspan="5"><input name="subject" type="text" size="25"></td>
        </tr>								
        <tr> 
          <td width="9%" >留言</td>
          <td colspan="5"><textarea name="context" cols="70" rows="10"></textarea></td>
        </tr>
        <tr> 
          <td colspan="6"><div align="center"><input name="userid" type="hidden" value="<%=s_userid%>">
            <input name="submit" type="submit" value=" 留言 " onClick="return CheckSubmit();">
              </div></td>
        </tr>
</form>
<%}else{%>
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="6">您还没有登录,登录用户可以发表留言!</td>
        </tr>
<%}%>						
      </table></div></td>
  </tr>  
  <tr> 
    <td ><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div>   