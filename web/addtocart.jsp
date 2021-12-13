<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="bean.*,java.util.*"%>
<%@ page import="java.sql.*"%>
<%
  Jdbc jdbc=new Jdbc();
  Connection conn = jdbc.getCon();
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
  ResultSet rs=null;
%>
<%
  String s_bookid=request.getParameter("bookid");
  rs=stmt.executeQuery("select * from book  left join publisher on book.publisherid=publisher.publisherid  where bookid='"+s_bookid+"'");
  rs.next();
  String s_bookname=rs.getString("bookname");
  String s_author=rs.getString("author");
  String s_price=rs.getString("price");
  String s_publish=rs.getString("name");
  int i_ordernum=1;
  double d_unitprice=Double.parseDouble(s_price);
  double d_subtotal=i_ordernum*d_unitprice;
  d_subtotal=Math.round(d_subtotal*100)/100.00;
  cartBean cbean=new cartBean();
  cbean.bookid=s_bookid;
  cbean.bookname=s_bookname;
  cbean.publish=s_publish;
  cbean.ordernum=i_ordernum;
  cbean.unitprice=d_unitprice;
  cbean.subtotal=d_subtotal;
  Collection c_cart=(Collection)session.getAttribute("cart");
  Iterator it=null;
%>
<%
  if(c_cart==null){
    c_cart= new Vector();
    c_cart.add(cbean);
    session.setAttribute("cart",c_cart);
  }else{
    String s_flag="false";
    it=c_cart.iterator();
    while(it.hasNext()){
      cartBean cb=(cartBean)(it.next());
      if(cb.bookid.equals(s_bookid)){
	cb.ordernum++;
        cb.subtotal+=cb.unitprice;
	s_flag="true";
      }//if end
    }//while end
    if(s_flag.equals("false")){
      c_cart.add(cbean);
    }
  }//else end
  response.sendRedirect("shoppingcart.jsp");
%>
