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
<caption> ȸ�� ��� ���� </caption>
<tr><td width="70">NO</td>	<td width="70">�̸�</td>
	<td width="70">content</td>		<td width="140">�ۼ� ��¥</td> 	</tr></table>
<%
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	memoDao m_dao= memoDao.getInstance();
// MemberDAO() Ŭ������ �̿��Ͽ� m_dao ��ü ����
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
	 d1 = df.format(indate);// dto�� id �����Ͽ� ����
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


for(int i=0; i<dtos.size(); i++) {  // dtos �� size ��ŭ for �� ����
memoDto dto=dtos.get(i);  // dtos �� i ���� ������ ������ dto �� ����
 name = dto.getName();  // dto�� name �����Ͽ� ����
 title = dto.getTitle();
 indate = dto.getIndate();  
 d1 = df.format(indate);// dto�� id �����Ͽ� ����
 pass = dto.getPass();    
 count = dtos.size()-i;// dto�� email �����Ͽ� ����

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
	alert("select_text�� �Է����ּ��� ");
	document.location.href="memoTime.jsp";

	</script>
<% 	
}



%>


<% if(searchtf!=null){ 
if (search.equals("num")){
	%>
	<h4><%=request.getParameter("search") %> �� 
			<%=request.getParameter("search_text") %>�� �˻��� ���
			 <%=memoDao.COUNT %>���� �˻��Ǿ����ϴ�.</h4>
<% 
}


else { %> 
<h4><%=request.getParameter("search") %> �� 
<%=request.getParameter("search_text") %>�� �˻��� ���
 <%=memoDao.COUNT %>���� �˻��Ǿ����ϴ�.</h4>

<%
}

} %>

<a href="memoTime.jsp">����Ʈ�� ���ư���</a>
</body>
</html>