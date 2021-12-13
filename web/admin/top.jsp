<%@ page contentType="text/html; charset=GB2312" %>
<link href="../maincss.css" rel="stylesheet" type="text/css"> <table width="749" border="0" cellpadding="0" cellspacing="0" class="td">
<%
java.util.Date today=new java.util.Date(); 
String s_today=(today.getYear()+1900)+"年"+(today.getMonth()+1)+"月"+today.getDate()+"日";
%>

  <tr> 
    <td colspan="14"><table width="748" height="43" border="0" cellpadding="0" cellspacing="0" class="td">
        <tr> 
          <td width="31%"><img src="../images/top_r1.jpg" width="229" height="59"></td>
          <td width="4%"><img src="../images/top_r3.jpg" width="30" height="59"></td>
          <td width="4%"><img src="../images/top_r4.jpg" width="31" height="59"></td>
          <td width="8%"><img src="../images/top_r5.jpg" width="57" height="59"></td>
          <td width="5%"><img src="../images/top_r6.jpg" width="40" height="59"></td>
          <td width="6%"><img src="../images/top_r7.jpg" width="48" height="59"></td>
          <td width="6%"><img src="../images/top_r8.jpg" width="45" height="59"></td>
          <td width="10%"><img src="../images/top_r9.jpg" width="73" height="59"></td>
          <td width="10%"><img src="../images/top_r10.jpg" width="76" height="59"></td>
          <td width="8%"><img src="../images/top_r11.jpg" width="61" height="59"></td>
          <td width="8%"><img src="../images/top_r12.jpg" width="60" height="59"></td>
        </tr>
        <tr> 
          <td><img src="../images/top_r2.jpg" width="229" height="17"></td>
          <td colspan="10" bgcolor="#f1f1f1"><div align="right">日期:<%=s_today%>&nbsp;&nbsp;</div></td>
        </tr>
        <tr bgcolor="#666666"> 
          <td height="1" colspan="11" nowrap></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td width="109" height="25" valign="bottom"><div align="right"><a href="booklist.jsp"><img src="../images/adin_r1.gif" width="87" height="19" border="0" align="absbottom"></a> 
      </div></td>
    <td width="11" valign="bottom"> <div align="center"></div></td>
    <td width="85" valign="bottom"><a href="userinfolist.jsp"><img src="../images/adin_r2.gif" width="87" height="19" border="0" align="absbottom"></a></td>
    <td width="11"> <div align="center"></div></td>
    <td width="77" valign="bottom"><a href="orderlist.jsp"><img src="../images/adin_r3.gif" width="87" height="19" border="0" align="absbottom"></a></td>
    <td width="11"> <div align="center"></div></td>
    <td width="81" valign="bottom"><a href="noteslist.jsp"><img src="../images/adin_r4.gif" width="87" height="19" border="0" align="absbottom"></a></td>
    <td width="11"> <div align="center"></div></td>
    <td width="82" valign="bottom"><a href="employeelist.jsp"><img src="../images/adin_r5.gif" width="87" height="19" border="0" align="absbottom"></a></td>
    <td width="11" valign="bottom"> <div align="center"></div></td>
    <td width="52" valign="bottom"><a href="publisherlist.jsp"><img src="../images/adin_r6.gif" width="97" height="19" border="0" align="absbottom"></a></td>
    <td width="11" valign="bottom"> <div align="center"></div></td>
    <td width="86" valign="bottom">&nbsp;</td>
    <td width="172" valign="bottom">&nbsp;</td>
  </tr>
  <tr bgcolor="#676767"> 
    <td height="3" colspan="14"></td>
  </tr>
  <tr bgcolor="#343434"> 
    <td height="3" colspan="14"></td>
  </tr>
  <tr bgcolor="#fc7500"> 
    <td height="14" colspan="14" nowrap>&nbsp;</td>
  </tr>
</table>
