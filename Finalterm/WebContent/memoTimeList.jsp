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
for(int i=0; i<dtos.size(); i++) {  // dtos 를 size 만큼 for 문 돌림
memoDto dto=dtos.get(i);  // dtos 의 i 번재 정보를 가져와 dto 에 저장
String name = dto.getName();  // dto의 name 추출하여 저장
String title=dto.getTitle();
int num = dto.getNum();
Timestamp indate= dto.getIndate();   
// dto의 id 추출하여 저장
String d1 = df.format(indate);
String pass = dto.getPass();      // dto의 email 추출하여 저장
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
<input type="submit" value="조 회">


