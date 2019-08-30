<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@page import="java.net.URLDecoder"%> 
<%@ page import="memoPackage.*"%>
<%@ page import="java.util.ArrayList"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

 <%  request.setCharacterEncoding("euc-kr"); %>

<%

 int delete_num=Integer.parseInt(request.getParameter("num"));




 int count =Integer.parseInt(request.getParameter("count"));
// String delete_id= URLDecoder.decode(id); 
 


 memoDao m_dao= memoDao.getInstance();
//MemberDAO() 클래스를 이용하여 m_dao 객체 생성
ArrayList <memoDto> dtos = null;
String str = Integer.toString(delete_num);
dtos = m_dao.getSearchList("num",str);

memoDto dto = dtos.get(0);
String name = dto.getName();
 %>
 
  <br><br>
<h3>
<form name="memoTime_Delete" action="memo_Delete_ok.jsp" method="post">
<table border= "1">
 <tr> <td colspan ="2" >  정말 <%=count %> 번 글 삭제 하시겠습니까 ? &nbsp; </td> <tr> 
 <tr> <td> 사용자 이름 </td>  <td>  <%=name%>   </td> </tr>
 <tr> <td> 비밀번호 입력 </td> <td> <input type="password" name="pass" size= 20> </td> </tr>
 <input type="hidden" name="delete_num" value="<%=delete_num%>">
 
 <tr>  <td colspan = "2"> <center>  <input type="submit" value="확인 " > </center>  </td> </tr>
  
</h3>
</table>
<% 

%>

</body>
</html> 

