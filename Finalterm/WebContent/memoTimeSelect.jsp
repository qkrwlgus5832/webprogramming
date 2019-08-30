<%@ page import="memoPackage.*" %>
<%@ page import="java.util.ArrayList"  %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.net.URLDecoder"%> 
<%@ page import="java.sql.*"%> 

<%@ page import="javax.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
 <% request.setCharacterEncoding("euc-kr");
 %>
 
<table width="600" cellpadding="0" cellspacing="0" border="1">
<caption> 회원 목록 보기 </caption>
<tr><td width="70">NO</td>	<td width="70">이름</td>
	<td width="70">content</td>		<td width="140">작성 날짜</td> 	</tr></table>
<%
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	memoDao m_dao= memoDao.getInstance();
// MemberDAO() 클래스를 이용하여 m_dao 객체 생성
String searchtf = null;

searchtf=request.getParameter("search_tf");

ArrayList<memoDto> dtos=null;
String search=request.getParameter("search");
if(!(request.getParameter("search_text").equals("")) && searchtf!=null){
 //String search_op= URLDecoder.decode(search); 
int search_text = 0;
String Search_text = null;
if (search.equals("num")){
 search_text=Integer.parseInt(request.getParameter("search_text"));
}
else {
	Search_text = request.getParameter("search_text");
}
String name = null;
String title = null;
Timestamp indate = null;
String d1= null;
String pass =null;
int count = 0;

if (search.equals("num")){
	dtos = m_dao.getList();
	memoDto dto= dtos.get(dtos.size()-search_text);
	name = dto.getName();
	title = dto.getTitle();
	indate = dto.getIndate();  
	 d1 = df.format(indate);// dto의 id 추출하여 저장
	 pass = dto.getPass();    
	 count =1;
	 
	 %>
	 <table width="600" cellpadding="0" cellspacing="0" border="1">
	 <tr> <td width="70"><%=search_text %></td><td width="70"><%=name %></td> 
	 	<td width="70"><%=title %></td><td width="140"><%=d1 %></td>
	 </tr>	
	 </table>
	 <% 
	}
	


else{
dtos = m_dao.getSearchList(search,Search_text);


for(int i=0; i<dtos.size(); i++) {  // dtos 를 size 만큼 for 문 돌림
memoDto dto=dtos.get(i);  // dtos 의 i 번재 정보를 가져와 dto 에 저장
 name = dto.getName();  // dto의 name 추출하여 저장
 title = dto.getTitle();
 indate = dto.getIndate();  
 d1 = df.format(indate);// dto의 id 추출하여 저장
 pass = dto.getPass();    
 count = dtos.size()-i;// dto의 email 추출하여 저장

%>

<table width="600" cellpadding="0" cellspacing="0" border="1">
<tr> <td width="70"><%=count %></td><td width="70"><%=name %></td> 
	<td width="70"><%=title %></td><td width="140"><%=d1 %></td>
</tr>	
</table>
<% 
}
}
}

else {
	%>
	<script language="javascript">
	alert("select_text를 입력해주세요 ");
	document.location.href="memoTime.jsp";

	</script>
<% 	
}



%>


<% if(searchtf!=null){ 
if (search.equals("num")){
	%>
	<h4><%=request.getParameter("search") %> 로 
			<%=request.getParameter("search_text") %>를 검색한 결과
			 <%=memoDao.COUNT %>건이 검색되었습니다.</h4>
<% 
}


else { %> 
<h4><%=request.getParameter("search") %> 로 
<%=request.getParameter("search_text") %>를 검색한 결과
 <%=memoDao.COUNT %>건이 검색되었습니다.</h4>

<%
}

} %>

<a href="memoTime.jsp">리스트로 돌아가기</a>
</body>
</html>