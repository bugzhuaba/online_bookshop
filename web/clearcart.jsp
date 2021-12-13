<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="bean.*,java.util.*"%>
<%
  Collection c_cart=(Collection)session.getAttribute("cart");
  if(c_cart!=null)
    c_cart.clear();
  else{
    c_cart=new Vector();
    session.setAttribute("cart",c_cart);
  }
  response.sendRedirect("shoppingcart.jsp");
%>