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
	alert("비밀번호가 다릅니다.");
	history.go(-1);

	</script>
	
<% 	
}


String id=null;

String pass= null;
int modify_num= Integer.parseInt((String)request.getParameter("modify_num"));

String modify_pass = null;


memoDao m_dao= memoDao.getInstance();
//MemberDAO() 클래스를 이용하여 m_dao 객체 생성
ArrayList <memoDto> dtos = null;
String str = Integer.toString(modify_num);
dto.setNum(modify_num);
int ris = m_dao.updateMember(dto);


if (ris == 1){
	%>
	<script language="javascript">
	alert("수정완료");
	//document.location.href="memoTime.jsp";

	</script>
	  <a href="memoTime.jsp">리스트로 돌아가기 </a>
	
	
<% 
}
else {
	
	%>
		<script language="javascript">
	alert("수정 실패");
	//document.location.href="memoTime.jsp";

	</script>
	    <a href="memoTime.jsp">리스트로 돌아가기</a>
	<% 
}



%> 