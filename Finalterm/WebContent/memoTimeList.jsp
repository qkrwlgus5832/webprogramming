<%@ page import="memoPackage.memoDto" %>
<%@ page import="memoPackage.memoDao" %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%> 

<%@ page import="javax.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>


</body>
</html>
 <%  request.setCharacterEncoding("euc-kr");  %>
<% 
String id = (String) session.getAttribute("id");
memoDao m_dao = memoDao.getInstance();
ArrayList<memoDto> dtos=null;
dtos=m_dao.getList();

SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
for(int i=0; i<dtos.size(); i++) {  // dtos �� size ��ŭ for �� ����
memoDto dto=dtos.get(i);  // dtos �� i ���� ������ ������ dto �� ����
String name = dto.getName();  // dto�� name �����Ͽ� ����
String title=dto.getTitle();
int num = dto.getNum();
Timestamp indate= dto.getIndate();   
// dto�� id �����Ͽ� ����
String d1 = df.format(indate);
String pass = dto.getPass();      // dto�� email �����Ͽ� ����
int count = dtos.size() - i;

%>

<table width ="600" border = "1">
<tr> <td> <%=count %> </td><td><%=name %></td><td width=60><%=title %></td> 
	<td><%=d1 %></td>

</table>
<% 
}
%>

<form action="memoTimeSelect.jsp" method="post">
<select name="search">

<option value="num">num</option>
<option value="name">name</option>
<option value="title">content</option>
</select>
&nbsp;&nbsp;
<input type="text" name="search_text" size="20"/>&nbsp;
<input type="hidden" name="search_tf" value="true">
<input type="submit" value="�� ȸ">


