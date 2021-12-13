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
<script language=javascript>
<!-- Begin-->
  function setVariables() {
    imgwidth=50; 
    imgheight=50;  
    if (navigator.appName == "Netscape") {
      horz=".left";
      vert=".top";
      docStyle="document.";
      styleDoc="";
      innerW="window.innerWidth";
      innerH="window.innerHeight";
      offsetX="window.pageXOffset";
      offsetY="window.pageYOffset";
    }
    else {
      horz=".pixelLeft";
      vert=".pixelTop";
      docStyle="";
      styleDoc=".style";
      innerW="document.body.clientWidth";
      innerH="document.body.clientHeight";
      offsetX="document.body.scrollLeft";
      offsetY="document.body.scrollTop";
    }
  }
  function checkLocation() {
    objectXY="branding";
    var availableX=eval(innerW);
    var availableY=eval(innerH);
    var currentX=eval(offsetX);
    var currentY=eval(offsetY);
    x=availableX-(imgwidth+60)+currentX;
    y=availableY-(imgheight+40)+currentY-300;
    evalMove();
    setTimeout("checkLocation()",10);
  }
  function evalMove() {
    eval(docStyle + objectXY + styleDoc + horz + "=" + x);
    eval(docStyle + objectXY + styleDoc + vert + "=" + y);
  }
// End -->
</script>

<link href="maincss.css" rel="stylesheet" type="text/css">
<body onload="setVariables(); checkLocation();">
<div align="center"> 
      <div id="branding" style="position:absolute; visibility:collapse; left: 685px; top: 181px;">
        <table width="10" bgcolor="#ffffff">
          <tr> 
            <td> 
              <p align="center">
	      <a href="booksearch.jsp">
              <img src="images/angle.gif" alt="服务员" border="0"></a>
            </td>
          </tr>
        </table>
      </div>
  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td colspan="2"> 
        <div align="center"> 
          <%@include file="top.jsp" %>
        </div></td>
    </tr>
    <tr> 
      <td width="25%" rowspan="3" valign="top">
         <%@include file="declare.jsp" %> <br>
          <%@include file="login.jsp" %> <br>
<%--         <%@include file="user/top.jsp" %> <br>--%>
         <%@include file="search.jsp" %></td>
      <td width="75%" height="15" valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td height="1" nowrap bgcolor="#CCCCCC"></td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr bgcolor="#999999"></tr>
          <tr> 
            <td width="1" nowrap bgcolor="#999999"></td>
            <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="td">
                <tr> 
                  <td colspan="2"><div align="left"><img src="images/lanmu_r1.jpg" width="85" height="29"></div>
                  </td>
                </tr>
                <%
                   int i_num=2;
                   rs=stmt.executeQuery("select * from book left join publisher on book.publisherid=publisher.publisherid where type=2 ");  
                   while(rs.next()&&i_num>0){
                   i_num--; 
                %>
                <tr> 
                  <%
                    String s_bookid=rs.getString("bookid");
                    String s_bookname=rs.getString("bookname");
                    String s_author=rs.getString("author");
                    String s_pubdate=rs.getString("pubdate").substring(0,10);
                    String s_price=rs.getString("price");
                    String s_content=rs.getString("content");
                    String s_picture=rs.getString("picture");
                    String s_publisherid=rs.getString("name");
                  %>
                  <td width="50%"> <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
                      <tr> 
                        <td width="30%" rowspan="5"><a href="bookdetail.jsp?bookid=<%=s_bookid%>">
                                                    <img src="images/<%=s_picture%>" width="65" height="90" border="0" ></a>
                        </td>
                        <td width="25%"><div align="left">书名</div></td>
                        <td><%=s_bookname%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">作者</div></td>
                        <td><%=s_author%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">出版社</div></td>
                        <td><%=s_publisherid%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">出版日期</div></td>
                        <td><%=s_pubdate%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">定价</div></td>
                        <td>￥<%=s_price%></td>
                      </tr>
                      <tr> 
                        <td colspan="2"><div align="center">
                            <a href="addtocart.jsp?bookid=<%=s_bookid%>">放入购书车</a>&nbsp;&nbsp;
                            <a href="bookdetail.jsp?bookid=<%=s_bookid%>">查看详情</a>
                          </div></td>
                      </tr>
                    </table></td>
                  <%
                    if(!rs.isLast()){
                    rs.next();
                    s_bookid=rs.getString("bookid");
                    s_bookname=rs.getString("bookname");
                    s_author=rs.getString("author");
                    s_pubdate=rs.getString("pubdate").substring(0,10);
                    s_price=rs.getString("price");
                    s_content=rs.getString("content");
                    s_picture=rs.getString("picture");
                    s_publisherid=rs.getString("name");
                  %>
                  <td> <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
                      <tr> 
                        <td width="30%" rowspan="5"><a href="bookdetail.jsp?bookid=<%=s_bookid%>">
                                                    <img src="images/<%=s_picture%>" width="65" height="90" border="0" ></a></td>
                        <td width="25%">书名</td>
                        <td><%=s_bookname%></td>
                      </tr>
                      <tr> 
                        <td width="25%">作者</td>
                        <td><%=s_author%></td>
                      </tr>
                      <tr> 
                        <td width="25%">出版社</td>
                        <td><%=s_publisherid%></td>
                      </tr>
                      <tr> 
                        <td width="25%">出版社</td>
                        <td><%=s_pubdate%></td>
                      </tr>
                      <tr> 
                        <td width="25%">定价</td>
                        <td>￥<%=s_price%></td>
                      </tr>
                      <tr> 
                        <td colspan="2"><div align="center"><a href="addtocart.jsp?bookid=<%=s_bookid%>">放入购书车</a>&nbsp;&nbsp;
                            <a href="bookdetail.jsp?bookid=<%=s_bookid%>">查看详情</a>
                          </div></td>
                      </tr>
                    </table></td>
                  <%}else{%>
                  <td >&nbsp;</td>
                  <%}%>
                </tr>
                <%}//while%>
                <tr> 
                  <td colspan="2"><div align="right"><a href="excellent.jsp">更多精品</a></div></td>
                </tr></table></td>
            <td width="1" bgcolor="#999999"></td>
          </tr><tr bgcolor="#999999"><td height="1" colspan="3" nowrap></td>
          </tr>
        </table>
        <table width="100%" height="116" border="0" cellpadding="0" cellspacing="0">
          <tr bgcolor="#999999"></tr>
          <tr> 
            <td width="1" nowrap bgcolor="#999999"></td>
            <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="td">
                <tr> 
                  <td colspan="2"><img src="images/lanmu_r2.jpg" width="85" height="29"></td>
                </tr>
                <%
                  i_num=2;
                  rs=stmt.executeQuery("select * from book left join publisher on book.publisherid=publisher.publisherid where type=1 "); 
                  while(rs.next()&&i_num>0){
                  i_num--;
                %>
                <tr> 
                  <%
                    String s_bookid=rs.getString("bookid");
                    String s_bookname=rs.getString("bookname");
                    String s_author=rs.getString("author");
                    String s_pubdate=rs.getString("pubdate").substring(0,10);
                    String s_price=rs.getString("price");
                    String s_content=rs.getString("content");
                    String s_picture=rs.getString("picture");
                    String s_publisherid=rs.getString("name");
                  %>
                  <td width="50%"> <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
                      <tr> 
                        <td width="30%" rowspan="5"><a href="bookdetail.jsp?bookid=<%=s_bookid%>">
                                                    <img src="images/<%=s_picture%>" width="65" height="90" border="0" ></a></td>
                        <td width="25%"><div align="left">书名</div></td>
                        <td><%=s_bookname%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">作者</div></td>
                        <td><%=s_author%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">出版社</div></td>
                        <td><%=s_publisherid%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">出版日期</div></td>
                        <td><%=s_pubdate%></td>
                      </tr>
                      <tr> 
                        <td width="25%"><div align="left">定价</div></td>
                        <td>￥<%=s_price%></td>
                      </tr>
                      <tr> 
                        <td colspan="2"><div align="center"><a href="addtocart.jsp?bookid=<%=s_bookid%>">放入购书车</a>&nbsp;&nbsp;
                            <a href="bookdetail.jsp?bookid=<%=s_bookid%>">查看详情</a>
                          </div></td>
                      </tr>
                    </table></td>
                  <%
                    if(!rs.isLast()){
                    rs.next();
                    s_bookid=rs.getString("bookid");
                    s_bookname=rs.getString("bookname");
                    s_author=rs.getString("author");
                    s_pubdate=rs.getString("pubdate").substring(0,10);
                    s_price=rs.getString("price");
                    s_content=rs.getString("content");
                    s_picture=rs.getString("picture");
                    s_publisherid=rs.getString("name");
                  %>
                  <td> <table width="100%" border="0" cellpadding="0" cellspacing="0" class="td">
                      <tr> 
                        <td width="30%" rowspan="5"><a href="bookdetail.jsp?bookid=<%=s_bookid%>"><img src="images/<%=s_picture%>" width="65" height="90" border="0" ></a></td>
                        <td width="25%">书名</td>
                        <td><%=s_bookname%></td>
                      </tr>
                      <tr> 
                        <td width="25%">作者</td>
                        <td><%=s_author%></td>
                      </tr>
                      <tr> 
                        <td width="25%">出版社</td>
                        <td><%=s_publisherid%></td>
                      </tr>
                      <tr> 
                        <td width="25%">出版社</td>
                        <td><%=s_pubdate%></td>
                      </tr>
                      <tr> 
                        <td width="25%">定价</td>
                        <td>￥<%=s_price%></td>
                      </tr>
                      <tr> 
                        <td colspan="2"><div align="center"><a href="addtocart.jsp?bookid=<%=s_bookid%>">放入购书车</a>&nbsp;&nbsp;
                            <a href="bookdetail.jsp?bookid=<%=s_bookid%>">查看详情</a>
                          </div></td>
                      </tr>
                    </table></td>
                  <%}else{%>
                  <td >&nbsp;</td>
                  <%}%>
                </tr>
                <%}//while%>
                <tr> 
                  <td colspan="2"><div align="right"><a href="newbook.jsp">更多新书</a></div></td>
                </tr>
              </table></td>
            <td width="1" nowrap bgcolor="#999999"></td>
          </tr>
          <tr bgcolor="#999999"> 
            <td height="1" colspan="3" nowrap></td>
          </tr>
        </table> </td>
    </tr>
    <tr>
      <td valign="top">&nbsp;</td>
    </tr>
    <tr> 
      <td valign="top">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2"><div align="center"> 
          <%@include file="bottom.jsp" %>
        </div></td>
    </tr>
  </table>
</div>
</body>