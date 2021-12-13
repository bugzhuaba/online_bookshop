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
  String s_where=(String)session.getAttribute("s_where");
  if(s_where==null)
    s_where="";
  int i_totalnum=0;    //�ܼ�¼��
  int i_pagenum=10;    //һҳ��ʾ�ļ�¼����
  int i_totalpage=0;   //��ҳ�� 
  int i_currentpage=1; //��ǰҳ 
  String s_bookid="";
  String s_bookname="";
  String s_author="";
  String s_publisherid="";
  String s_pubdate="";
  String s_price="";
  String s_quantity="";
  String s_place="";
  String s_type="";
  String s_content="";
  String s_picture="";
%>
<%
  rs=stmt.executeQuery("select count(*) from book left join publisher on book.publisherid=publisher.publisherid  where bookid is not null  "+s_where); 
  rs.next();
  i_totalnum=rs.getInt(1);
  i_totalpage=i_totalnum/i_pagenum;
  if(i_totalnum%i_pagenum!=0)
    i_totalpage++;
%>
<%
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
          <td colspan="6">��Ŀ�������</td>
        </tr>
        <tr> 
          <td colspan="6"><hr size="1" noshade width="100%"></td>
        </tr>
            <%if(i_totalnum!=0){%>
        <tr> 
          <td colspan="3">��Ҫ�ҵ�ͼ�鹲<%=i_totalnum%>��,��<%=i_totalpage%>ҳ��ʾ,ÿҳ��ʾ<%=i_pagenum%>��</td>
          <td colspan="3"><div align="right">
            ��<%=i_currentpage%>ҳ&nbsp;
            <%if(i_currentpage>1){%>
              <a href="booklist.jsp?op=firstpage">��ҳ</a>
            <%}else{%>��ҳ<%}%>&nbsp;
              <%if(i_currentpage>1){%>
                <a href="booklist.jsp?op=previous&currentpage=<%=i_currentpage%>">��һҳ</a> 
              <%}else{%>��һҳ<%}%>&nbsp;
                <%if(i_currentpage!=i_totalpage){%>
                  <a href="booklist.jsp?op=next&currentpage=<%=i_currentpage%>">��һҳ</a>
                <%}else{%>��һҳ<%}%>&nbsp;
                  <%if(i_currentpage!=i_totalpage){%>
                    <a href="booklist.jsp?op=lastpage">ĩҳ</a>
                  <%}else{%>ĩҳ<%}%></div>
          </td>
        </tr>
        <tr> 
          <td>���</td>
          <td>���</td>
          <td>����</td>
          <td>����</td>
          <td>����</td>
          <td>��ϸ��Ϣ</td>
        </tr>
<%
  rs=stmt.executeQuery("select * from book  left join publisher on book.publisherid=publisher.publisherid  where bookid is not null "+s_where+" order by bookid ");
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
      s_bookid=(rs.getString("bookid")!=null?rs.getString("bookid"):"");
      s_bookname=(rs.getString("bookname")!=null?rs.getString("bookname"):"");
      s_author=(rs.getString("author")!=null?rs.getString("author"):"");
      s_price=(rs.getString("price")!=null?rs.getString("price"):"");
      s_type=(rs.getString("type")!=null?rs.getString("type"):"");
      s_quantity=(rs.getString("quantity")!=null?rs.getString("quantity"):"");
      s_place=(rs.getString("place")!=null?rs.getString("place"):"");
      s_publisherid=(rs.getString("name")!=null?rs.getString("name"):"");
      if(s_type.equals("1"))
        s_type="����";
      if(s_type.equals("2"))
        s_type="��Ʒ";
%>			
        <tr> 
          <td><%=i+1+(i_currentpage-1)*i_pagenum%></td>
          <td><%=s_bookid%></td>
          <td><%=s_bookname%></td>
          <td>��<%=s_price%></td>
          <td><a href="addtocart.jsp?bookid=<%=s_bookid%>">���빺�鳵</a></td>
          <td><a href="booklist.jsp?op=show&detailid=<%=s_bookid%>&currentpage=<%=i_currentpage%>">�鿴</a></td>
        </tr>
<%
    }//if
  }//for
%>			
        <tr> 
          <td colspan="6">&nbsp;</td>
        </tr>
<%
  String s_detailid=request.getParameter("detailid");
  if(s_detailid==null){
    rs=stmt.executeQuery("select * from book left join publisher on book.publisherid=publisher.publisherid  where bookid is not null "+s_where+" order by bookid ");
    if(i_currentpage>i_totalpage)
      i_currentpage=i_totalpage;
    i_position=(i_currentpage-1)*i_pagenum;
    if(i_position==0)
      rs.beforeFirst();
    else
      rs.absolute(i_position);
  }else{
    rs=stmt.executeQuery("select * from book left join publisher on book.publisherid=publisher.publisherid  where bookid= '"+s_detailid+"'");
  }
  rs.next();
  s_bookid=(rs.getString("bookid")!=null?rs.getString("bookid"):"");
  s_bookname=(rs.getString("bookname")!=null?rs.getString("bookname"):"");
  s_author=(rs.getString("author")!=null?rs.getString("author"):"");
  s_pubdate=(rs.getString("pubdate")!=null?rs.getString("pubdate").substring(0,10):"");
  s_price=(rs.getString("price")!=null?rs.getString("price"):"");
  s_content=(rs.getString("content")!=null?rs.getString("content"):""); 
  s_type=(rs.getString("type")!=null?rs.getString("type"):"");
  s_quantity=(rs.getString("quantity")!=null?rs.getString("quantity"):"");
  s_place=(rs.getString("place")!=null?rs.getString("place"):"");
  s_picture=(rs.getString("picture")!=null?rs.getString("picture"):"");
  s_publisherid=(rs.getString("name")!=null?rs.getString("name"):""); 
%>			
        <tr> 
          <td colspan="6">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
              <tr> 
                <td width="30%" rowspan="8"><img src="images/<%=s_picture%>" height="212" width="150" ></td>
                <td colspan="2"><%=s_bookname%></td>
              </tr>
              <tr> 
                <td colspan="2"><%=s_author%>&nbsp;&nbsp;��</td>
              </tr>
              <tr> 
                <td colspan="2">ͼ����</td>
              </tr>
              <tr> 
                <td colspan="2"><%=s_publisherid%></td>
              </tr>
              <tr> 
                <td colspan="2"><%=s_pubdate%>&nbsp;&nbsp;����</td>
              </tr>
              <tr> 
                <td colspan="2">���: <%=s_bookid%></td>
              </tr>
              <tr> 
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="3">�� ��:��<%=s_price%>&nbsp;&nbsp;<a href="addtocart.jsp?bookid=<%=s_bookid%>">���빺�鳵</a></td>
              </tr>
              <tr> 
                <td colspan="3">���ݼ��</td>
              </tr>
              <tr> 
                <td colspan="3"><%=s_content%></td>
              </tr>
            </table>			  
          </td>
        </tr>
<%}else{%>
        <tr> 
          <td colspan="6">û���ҵ���Ҫ����,��<a href="booksearch.jsp">��������</a>!</td>
        </tr>			
<%}%>			
            </table>
	</div></td>
  </tr>  
  <tr> 
    <td ><div align="center"><%@include file="bottom.jsp" %></div></td>
  </tr>
</table>
</div>   