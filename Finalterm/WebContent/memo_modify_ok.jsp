<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@page import="java.net.URLDecoder"%>
<%@ page import="memoPackage.*"%>
<%@ page import="java.util.ArrayList"  %>

 <%  request.setCharacterEncoding("euc-kr");  %>

 <jsp:useBean id="dto" class="memoPackage.memoDto"/>
 <jsp:setProperty name="dto" property="*"/>
 
 
<%


if(!request.getParameter("pass").equals(request.getParameter("pass_check"))){
%>
	<script language="javascript">
	alert("��й�ȣ�� �ٸ��ϴ�.");
	history.go(-1);

	</script>
	
<% 	
}


String id=null;

String pass= null;
int modify_num= Integer.parseInt((String)request.getParameter("modify_num"));

String modify_pass = null;


memoDao m_dao= memoDao.getInstance();
//MemberDAO() Ŭ������ �̿��Ͽ� m_dao ��ü ����
ArrayList <memoDto> dtos = null;
String str = Integer.toString(modify_num);
dto.setNum(modify_num);
int ris = m_dao.updateMember(dto);


if (ris == 1){
	%>
	<script language="javascript">
	alert("�����Ϸ�");
	//document.location.href="memoTime.jsp";

	</script>
	  <a href="memoTime.jsp">����Ʈ�� ���ư��� </a>
	
	
<% 
}
else {
	
	%>
		<script language="javascript">
	alert("���� ����");
	//document.location.href="memoTime.jsp";

	</script>
	    <a href="memoTime.jsp">����Ʈ�� ���ư���</a>
	<% 
}



%> 