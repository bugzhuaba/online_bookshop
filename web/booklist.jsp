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
  int i_totalnum=0;    //总记录数
  int i_pagenum=10;    //一页显示的记录数码
  int i_totalpage=0;   //总页数 
  int i_currentpage=1; //当前页 
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
          <td colspan="6">书目搜索结果</td>
        </tr>
        <tr> 
          <td colspan="6"><hr size="1" noshade width="100%"></td>
        </tr>
            <%if(i_totalnum!=0){%>
        <tr> 
          <td colspan="3">您要找的图书共<%=i_totalnum%>本,分<%=i_totalpage%>页显示,每页显示<%=i_pagenum%>本</td>
          <td colspan="3"><div align="right">
            第<%=i_currentpage%>页&nbsp;
            <%if(i_currentpage>1){%>
              <a href="booklist.jsp?op=firstpage">首页</a>
            <%}else{%>首页<%}%>&nbsp;
              <%if(i_currentpage>1){%>
                <a href="booklist.jsp?op=previous&currentpage=<%=i_currentpage%>">上一页</a> 
              <%}else{%>上一页<%}%>&nbsp;
                <%if(i_currentpage!=i_totalpage){%>
                  <a href="booklist.jsp?op=next&currentpage=<%=i_currentpage%>">下一页</a>
                <%}else{%>下一页<%}%>&nbsp;
                  <%if(i_currentpage!=i_totalpage){%>
                    <a href="booklist.jsp?op=lastpage">末页</a>
                  <%}else{%>末页<%}%></div>
          </td>
        </tr>
        <tr> 
          <td>序号</td>
          <td>书号</td>
          <td>书名</td>
          <td>单价</td>
          <td>购买</td>
          <td>详细信息</td>
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
        s_type="新书";
      if(s_type.equals("2"))
        s_type="精品";
%>			
        <tr> 
          <td><%=i+1+(i_currentpage-1)*i_pagenum%></td>
          <td><%=s_bookid%></td>
          <td><%=s_bookname%></td>
          <td>￥<%=s_price%></td>
          <td><a href="addtocart.jsp?bookid=<%=s_bookid%>">放入购书车</a></td>
          <td><a href="booklist.jsp?op=show&detailid=<%=s_bookid%>&currentpage=<%=i_currentpage%>">查看</a></td>
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
                <td colspan="2"><%=s_author%>&nbsp;&nbsp;著</td>
              </tr>
              <tr> 
                <td colspan="2">图书规格</td>
              </tr>
              <tr> 
                <td colspan="2"><%=s_publisherid%></td>
              </tr>
              <tr> 
                <td colspan="2"><%=s_pubdate%>&nbsp;&nbsp;出版</td>
              </tr>
              <tr> 
                <td colspan="2">书号: <%=s_bookid%></td>
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
                <td colspan="3">定 价:￥<%=s_price%>&nbsp;&nbsp;<a href="addtocart.jsp?bookid=<%=s_bookid%>">放入购书车</a></td>
              </tr>
              <tr> 
                <td colspan="3">内容简介</td>
              </tr>
              <tr> 
                <td colspan="3"><%=s_content%></td>
              </tr>
            </table>			  
          </td>
        </tr>
<%}else{%>
        <tr> 
          <td colspan="6">没有找到您要的书,请<a href="booksearch.jsp">重新搜索</a>!</td>
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