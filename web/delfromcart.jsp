<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="bean.*,java.util.*"%>
<%
  String s_bookid=request.getParameter("bookid");
  Collection c_cart=(Collection)session.getAttribute("cart");
  Iterator it=null;
%>
<%
  if(c_cart==null){
    c_cart= new Vector();
    session.setAttribute("cart",c_cart);
  }else{
    it=c_cart.iterator();
    while(it.hasNext()){
      cartBean cb=(cartBean)(it.next());
      if(cb.bookid.equals(s_bookid)){
        c_cart.remove(cb); 
        break;
      }//if end	
   }//while end
  }//else end
  response.sendRedirect("shoppingcart.jsp");
%>
