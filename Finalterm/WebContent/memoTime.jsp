<%@ page import="memoPackage.*"%>
<%@ page import="java.util.ArrayList"  %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%> 

<%@ page import="javax.sql.*" %>

<%@ page import="javax.naming.*" %>
<%@page import="java.net.URLEncoder"%> 
<%@page import="java.net.URLDecoder"%> 
<%@ page import="java.text.SimpleDateFormat" %>
 <%  request.setCharacterEncoding("euc-kr");  %>

<html><head>

<form action= "memoTime_ok.jsp" method="post">  
 <table border="1" >
<tr><td colspan = "5"> <center> <b>한 줄 메모장  </b></center> </td>  </tr>
<tr><td width="100">작성자 </td>
     <td width="170"> <input type="text" name="name" size = "15"> </td>  
<td width="100">비밀번호  </td>
     <td width="170"> <input type="text" name="pass" size = "15"> </td>
      <td rowspan = "2">  <input type="submit" value="저장하기 " >  </td>  </tr>
   <tr><td>내 &nbsp;용  </td>
     <td colspan="3"> <input type="text" name="title" size = "50"> </td> </tr>
</table></form></body></html> 

 
<%
String id = (String) session.getAttribute("id");
memoDao m_dao = memoDao.getInstance();
ArrayList<memoDto> dtos=null;
dtos=m_dao.getList();

SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");


%>
<body> <center>
<table width="600" cellpadding="0" cellspacing="0" border="1">
<tr><td width = "30">NO</td>	<td width = "100">이름</td>
	<td width = "260">content</td>		<td width="100">작성 날짜</td> 	<td width="60"> </td></tr>
</table>
<%

    // 6단계: 모든 행  반복 처리
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

<table width="600" cellpadding="0" cellspacing="0" border="1">

<tr> <td width= "30"> <%=count %> </td><td width="100"><%=name %></td><td width = "260"><%=title %></td> 
	<td width="100"><%=d1 %></td>
<% 
	if (id.equals("admin")){
	%>
	  <td width = "30"><a href="memoTime_Delete.jsp?num=<%=num%>&count=<%=count%>">삭제</a> </td>
	 
<%
}	
%>
<td width = "30"><a href="memo_modify.jsp?num=<%=num%>&count=<%=count%>">수정</a> </td> </tr>
</table>
<% 
}

%>



 </table>
 <form action="memoTimeSelect.jsp" method="post">
<select name="search">

<option value="num">num</option>
<option value="name">name</option>
<option value="title"> content </option>
</select>
&nbsp;&nbsp;
<input type="text" name="search_text" size="20"/>&nbsp;
<input type="hidden" name="search_tf" value="true">
<input type="submit" value="조 회">

 </center>
 </body> 

</html>


 
