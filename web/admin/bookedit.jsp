<%@ page contentType="text/html; charset=GB2312" errorPage="../error.jsp"%>
<%@ page import="java.util.*,java.sql.*,org.apache.commons.fileupload.*,java.io.*,javax.servlet.http.*"%>
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
String s_bookid=request.getParameter("bookid");
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

String op = request.getParameter("op");
{
if(op!=null&&op.equals("show"))
{
rs=stmt.executeQuery("select * from book where bookid='"+s_bookid+"'");
rs.next();
 
 s_bookname=(rs.getString("bookname")!=null?rs.getString("bookname"):"");
 s_author=(rs.getString("author")!=null?rs.getString("author"):"");
 s_publisherid=(rs.getString("publisherid")!=null?rs.getString("publisherid"):"");
 s_pubdate=(rs.getString("pubdate")!=null?rs.getString("pubdate").substring(0,10):"");
 s_price=(rs.getString("price")!=null?rs.getString("price"):"");
 s_type=(rs.getString("type")!=null?rs.getString("type"):"");
 s_quantity=(rs.getString("quantity")!=null?rs.getString("quantity"):"");
 s_place=(rs.getString("place")!=null?rs.getString("place"):"");
 s_content=(rs.getString("content")!=null?rs.getString("content"):"");
 s_content=s_content.replaceAll("<br>","");
 s_content=s_content.replaceAll("&nbsp;"," ");
 s_picture=(rs.getString("picture")!=null?rs.getString("picture"):""); 

}
if(op!=null&&op.equals("edit"))
{
 s_bookid=request.getParameter("bookid");
 s_bookname=request.getParameter("bookname");
 s_author=request.getParameter("author");
 s_publisherid=request.getParameter("publisherid");
 s_pubdate=request.getParameter("pubdate");
 s_price=request.getParameter("price");
 s_type=request.getParameter("type");
 s_quantity=request.getParameter("quantity");
 s_place=request.getParameter("place");
 s_content=request.getParameter("content");
 s_content=s_content.replaceAll("\n","<br>");
 s_content=s_content.replaceAll(" ","&nbsp;");
 
String s_sql="update book set "+
             "bookname='"+s_bookname+"' "+
			 ",author='"+s_author+"' "+
			 ",publisherid='"+s_publisherid+"' "+
			 ",pubdate='"+s_pubdate+"' "+
			 ",price='"+s_price+"' "+
			 ",type='"+s_type+"' "+
			 ",quantity='"+s_quantity+"' "+
			 ",place='"+s_place+"' "+
			 ",content='"+s_content+"' "+
			 "where bookid='"+s_bookid+"' ";
try{			 			 			 
stmt.executeUpdate(s_sql);
}catch(Exception e){
response.sendRedirect("../error.jsp?error=新建图书出错:"+e.getMessage());
}
response.sendRedirect("booklist.jsp");
}
if(op!=null&&op.equals("upload"))
{ 
      DiskFileUpload upload = new DiskFileUpload();
      upload.setSizeMax(10*1024*1024);
      upload.setSizeThreshold(100*1024);
      upload.setRepositoryPath("c:/");
	  List items = upload.parseRequest(request);
	
	  Iterator iter = items.iterator();

            while (iter.hasNext()) {
               FileItem item = (FileItem) iter.next();
              if (!item.isFormField()) {	
               String name = item.getName();
               long size = item.getSize();
				
                if((name==null||name.equals("")) && size==0)
                 continue;
			    name=name.replace('\\','/');					
                File fullFile = new File(name); 
				
                File savedFile = new File(application.getRealPath("/")+"/images/",fullFile.getName());
				s_picture=fullFile.getName();					
				item.write(savedFile);
				}//if			   	 
			   } 	  
	  
stmt.executeUpdate("update book set picture='"+s_picture+"' where bookid='"+s_bookid+"'");	  
	  
	  response.sendRedirect("bookedit.jsp?op=show&bookid="+s_bookid);
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
		  <form name="form1" action="bookedit.jsp?op=edit" method="post" >
            <tr> 
                <td width="20%">书号</td>
              <td><%=s_bookid%><input name="bookid" type="hidden"  value="<%=s_bookid%>" ></td>
            </tr>
            <tr> 
                <td>书名</td>
              <td><input name="bookname" type="text" size="25" value="<%=s_bookname%>"></td>
            </tr>
            <tr> 
                <td>作者</td>
              <td><input name="author" type="text" size="25" value="<%=s_author%>"></td>
            </tr>
            <tr> 
                <td>出版社</td>
              <td>              
			  <select name="publisherid" >
			  <%
			  ResultSet rs2=stmt.executeQuery("select * from publisher ");
			  while(rs2.next()){
			  %>
			  <option value="<%=rs2.getString("publisherid")%>" <%=(s_publisherid.equals(rs2.getString("publisherid"))?" selected ":"")%>><%=rs2.getString("name")%></option>
			  <%}%>
			  </select></td>
            </tr>
            <tr> 
                <td>出版日期</td>
              <td><input name="pubdate" type="text" size="25" value="<%=s_pubdate%>"></td>
            </tr>
            <tr> 
                <td>价格</td>
              <td><input name="price" type="text" size="25" value="<%=s_price%>"></td>
            </tr>
            <tr> 
                <td>库存数量</td>
              <td><input name="quantity" type="text" size="25" value="<%=s_quantity%>"></td>
            </tr>
            <tr> 
                <td>存储位置</td>
              <td><input name="place" type="text" size="25" value="<%=s_place%>"></td>
            </tr>
            <tr> 
                <td>类别</td>
              <td>
			  <select name="type" >
			  <option value="0" <%=(s_type.equals("0")?" selected ":"")%>>普通</option>
			  <option value="1" <%=(s_type.equals("1")?" selected ":"")%>>新书</option>
			  <option value="2" <%=(s_type.equals("2")?" selected ":"")%>>精品</option>
			  </select>
			  </td>
            </tr>
            <tr> 
                <td>内容简介</td>
              <td><textarea name="content" cols="70" rows="10"><%=s_content%></textarea></td>
            </tr>			
            <tr> 
              <td colspan="2"><div align="center">
                  <input type="submit" value=" 修改 ">&nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="reset" value=" 重置 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </div></td>
            </tr>
			</form>
            <tr> 
              <td colspan="2"><hr size="1" noshade width="100%"></td>
            </tr>			
            <tr> 
              <td colspan="2"><div align="center">
			      <table width="100%" border="0" cellpadding="1" cellspacing="1" class="td">
				  <form name="form2" action="bookedit.jsp?op=upload&bookid=<%=s_bookid%>" method="post" enctype="multipart/form-data">
                    <tr> 
                      <td width="20%" ><img src="../images/<%=s_picture%>" height="120" width="85" ></td>
                      <td width="80%">封面图片<br>
                          <input type="file" name="picture" size="25">
                          &nbsp;&nbsp;&nbsp;&nbsp; 
                          <input type="submit" value=" 上传图片 "></td>
                    </tr>
					</form>
                  </table>

                </div></td>
            </tr>
			
			
			
			
						
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