<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@page import="java.net.URLDecoder"%>
<%@ page import="memoPackage.*"%>
<%@ page import="java.util.ArrayList"  %>
<%
String id=null;

String pass= null;
int delete_num= Integer.parseInt((String)request.getParameter("delete_num"));

String delete_pass = null;
if (!request.getParameter("pass").equals("")){
 delete_pass =request.getParameter("pass");
}

memoDao m_dao= memoDao.getInstance();
//MemberDAO() Ŭ������ �̿��Ͽ� m_dao ��ü ����
ArrayList <memoDto> dtos = null;
String str = Integer.toString(delete_num);
dtos = m_dao.getSearchList("num",str);

memoDto dto = dtos.get(0);
pass = dto.getPass();


if (pass.equals(delete_pass)) { 
	m_dao.deleteMember(delete_num);
	%>
	<script language="javascript">
	alert("���� �Ϸ� ");
	document.location.href="memoTime.jsp";

	</script>

<%
}
else {
	%>
	<script language="javascript">
	alert("��й�ȣ�� �ٸ��ϴ� ");
	document.location.href="memoTime.jsp";

	</script>
<% 
}
%> 
