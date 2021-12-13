<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="bean.*,java.util.*,java.sql.*"%>
<%
  request.setCharacterEncoding("GB2312");
  Jdbc jdbc=new Jdbc();
  Connection conn = jdbc.getCon();
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  ResultSet rs=null;
  String s_admin=(String)session.getAttribute("admin");
  if(s_admin==null){
    response.sendRedirect("checklogin.jsp");
  }
  String s_where=(String)session.getAttribute("s_where");
  if(s_where==null)
    s_where="";
  int i_totalnum=0;    //�ܼ�¼��
  int i_pagenum=10;    //һҳ��ʾ�ļ�¼����
  int i_totalpage=0;   //��ҳ�� 
  int i_currentpage=1; //��ǰҳ 
  String op = request.getParameter("op");
  if(op==null){
    s_where="";
    session.setAttribute("s_where",s_where);
  }
  rs=stmt.executeQuery("select count(*) from orderform where orderid is not null "+s_where);
  rs.next();
  i_totalnum=rs.getInt(1);
  i_totalpage=i_totalnum/i_pagenum;
  if(i_totalnum%i_pagenum!=0)
    i_totalpage++;
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
  String s_orderid="";
  String s_userid="";

  String s_payment="";
  String s_deliver="";
  String s_receiver="";
  String s_address="";
  String s_phone="";
  String s_postcode="";
  String s_totalnum="";
  String s_totalamount="";
  String s_orderdate="";
  String s_state="";
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
          <td colspan="8"><div align="right">&nbsp;&nbsp;&nbsp;&nbsp;<a href="ordersearch.jsp">��ѯ</a></div></td>
        </tr>
        <tr> 
          <td colspan="8"><hr size="1" noshade width="100%"></td>
        </tr>
<%
if(i_totalnum!=0){
%>
        <tr> 
          <td>������</td>
          <td>����</td>
          <td>�ջ���</td>
          <td>��ַ</td>
	  <td><div align="center">ͼ������</div></td>
	  <td>�ܼ�</td>
          <td>״̬</td>
	  <td>����״̬</td>
        </tr>
<%
  rs=stmt.executeQuery("select * from orderform  where orderid is not null "+s_where+" order by orderdate desc ");
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
      s_orderid=rs.getString("orderid");
      s_orderdate=rs.getString("orderdate").substring(0,10);
      s_totalnum=rs.getString("totalnum");
      s_totalamount=rs.getString("totalamount");
      s_receiver=rs.getString("receiver");
      s_address=rs.getString("address");
      s_state=rs.getString("state");
      if(s_state.equals("0")) s_state="δ����";
      if(s_state.equals("1")) s_state="�ѷ���";
      if(s_state.equals("2")) s_state="���";

Statement stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
ResultSet rs2=stmt2.executeQuery("select state from userinfo where userid='"+s_userid+"' and state=0 ");
if(rs2.next())
{
s_state="�û�δ����";
}
%>
        <tr> 
          <td><a href="orderlist.jsp?op=show&detailid=<%=s_orderid%>&currentpage=<%=i_currentpage%>"><%=s_orderid%></a></td>  
          <td><%=s_orderdate%></td >
          <td><%=s_receiver%></td >
          <td><%=s_address%></td>
	  <td><div align="center"><%=s_totalnum%></div></td>
	  <td>��<%=s_totalamount%></td>
          <td><%=s_state%></td>
	  <td>
            <%if(s_state.equals("δ����")){%>
	       <a href="orderedit.jsp?orderid=<%=s_orderid%>&state=1&currentpage=<%=i_currentpage%>">����</a>
	    <%}%>
	    <%if(s_state.equals("�ѷ���")){%>
	       <a href="orderedit.jsp?orderid=<%=s_orderid%>&state=2&currentpage=<%=i_currentpage%>">���</a>
	    <%}%>
			  <%if(s_state.equals("�û�δ����")){%>
			  �û�δ����
			  <%}%>
	  </td>
        </tr>
<%
    }//if
  }//for
%>												
        <tr> 
          <td colspan="8">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="8"><div align="center">
            ��<%=i_totalpage%>ҳ ��<%=i_currentpage%>ҳ&nbsp;
           <%if(i_currentpage>1){%>
             <a href="orderlist.jsp?op=firstpage">��ҳ</a>
           <%}else{%>��ҳ<%}%>&nbsp;
           <%if(i_currentpage>1){%>
              <a href="orderlist.jsp?op=previous&currentpage=<%=i_currentpage%>">��һҳ</a> 
           <%}else{%>��һҳ<%}%>&nbsp;
           <%if(i_currentpage!=i_totalpage){%>
             <a href="orderlist.jsp?op=next&currentpage=<%=i_currentpage%>">��һҳ</a>
           <%}else{%>��һҳ<%}%>&nbsp;
           <%if(i_currentpage!=i_totalpage){%>
             <a href="orderlist.jsp?op=lastpage">ĩҳ</a>
           <%}else{%>ĩҳ<%}%>
         </div></td>
        </tr>			
<%
  String s_detailid=request.getParameter("detailid");
  if(s_detailid==null){
    rs=stmt.executeQuery("select * from orderform where orderid is not null "+s_where+" order by orderdate desc ");
    if(i_currentpage>i_totalpage)
      i_currentpage=i_totalpage;
    i_position=(i_currentpage-1)*i_pagenum;
    if(i_position==0)
      rs.beforeFirst();
    else
      rs.absolute(i_position);
    rs.next();
    s_detailid=rs.getString("orderid");
  }
%>			
        <tr> 
          <td colspan="8">
	    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="td">
              <tr> 
                <td colspan="6">����<%=s_detailid%>����ϸ</td>
              </tr>
              <tr> 
                <td>���</td>
                <td>����</td>
                <td>������</td>
                <td>����</td>
                <td>����(��)</td>
                <td>�ϼ�</td>
              </tr>
<%
  rs=stmt.executeQuery("select * from orderdetail where orderid='"+s_detailid+"' ");
  int i_total=0;
  double d_totalamount=0.0;
  while(rs.next()){
    String s_bookid=rs.getString("bookid");
    String s_bookname=rs.getString("bookname");
    String s_publisher=rs.getString("publisher");
    double d_unitprice=rs.getDouble("unitprice");
    int i_ordernum=rs.getInt("ordernum");
    i_total+=i_ordernum;
    d_totalamount+=d_unitprice*i_ordernum;
%>				  
              <tr> 
                <td><%=s_bookid%></td>
                <td><%=s_bookname%></td>
                <td><%=s_publisher%></td>
                <td>��<%=d_unitprice%></td>
                <td><%=i_ordernum%></td>
                <td>��<%=d_unitprice*i_ordernum%></td>
              </tr>
<%}%>
              <tr> 
                <td colspan="4"><div align="right">�ϼ�</div></td>
                <td ><%=i_total%></td>
		<td >��<%=d_totalamount%></td>
              </tr>
            </table>
          </td>
        </tr>
<%}else{%>
        <tr> 
          <td colspan="8">û�ж�����Ϣ.</td>
        </tr>			
     <%}%>			
      </table>
    </div></td>
  </tr>  
  <tr> 
    <td ><div align="center"><%@include file="../bottom.jsp" %></div></td>
  </tr>
</table>
</div>   