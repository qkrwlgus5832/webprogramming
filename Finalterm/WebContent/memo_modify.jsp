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
int modify_num=Integer.parseInt(request.getParameter("num"));
memoDao m_dao= memoDao.getInstance();
//MemberDAO() Ŭ������ �̿��Ͽ� m_dao ��ü ����
ArrayList <memoDto> dtos = null;
String str = Integer.toString(modify_num);
dtos = m_dao.getSearchList("num",str);

memoDto dto = dtos.get(0);
String pass = dto.getPass();

if (request.getParameter("pass") !=null){

	
	if(pass.equals(request.getParameter("pass"))){
		%>
	<form action= "memo_modify_ok.jsp" method="post">  
 <table border="1" >
<tr><td colspan = "5"> <center> <b>�� �� �޸���  </b></center> </td>  </tr>
<tr><td width="100">�ۼ��� </td>
     <td width="170"> <input type="text" name="name" size = "15"> </td>  
<td width="100">��й�ȣ �ٽ� ���� </td>
     <td width="170"> <input type="text" name="pass" size = "15"> </td>
<td width="100">��й�ȣ Ȯ�� </td>
     <td width="170"> <input type="text" name="pass_check" size = "15"> </td>
      <td rowspan = "2">  <input type="submit" value="�����ϱ� " >  </td>  </tr>
   <tr><td>�� &nbsp;��  </td>
     <td colspan="3"> <input type="text" name="title" size = "50"> </td> </tr>
     <input type="hidden" name="modify_num" value="<%=modify_num %>">

     
</table>
		<% 
	}
	else {
		%>
		<script language="javascript">
		alert("��й�ȣ�� �ٸ��ϴ�.  ");
		document.location.href="memoTime.jsp";

		</script>
		<% 
	}

}

// String delete_id= URLDecoder.decode(id); 
 

else {
	int count =Integer.parseInt(request.getParameter("count"));

String name = dto.getName();
 %>
 
  <br><br>
<h3>
<form name="memo_modify" action="memo_modify.jsp" method="post">
<table border= "1">
 <tr> <td colspan ="2" >  <%=count %> �� ���� �����Ͻ÷��� ��й�ȣ�� �Է����ּ��� &nbsp; </td> <tr> 
 <tr> <td> ����� �̸� </td>  <td>  <%=name%>   </td> </tr>
 <tr> <td> ��й�ȣ �Է� </td> <td> <input type="password" name="pass" size= 20> </td> </tr>
 <input type="hidden" name="num" value="<%=modify_num%>">
 <tr>  <td colspan = "2"> <center>  <input type="submit" value="Ȯ�� " > </center>  </td> </tr>
  
</h3>
</table>
<% 
}

%>

</body>
</html> 

