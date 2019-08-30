<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%> 

<%@ page import="javax.sql.*" %>

<%@ page import="javax.naming.*" %>
<%@page import = "java.sql.Timestamp" %>
<%@page import = "memoPackage.*" %>



<%  request.setCharacterEncoding("euc-kr");  %>

 <jsp:useBean id="dto" class="memoPackage.memoDto"/>
 <jsp:setProperty name="dto" property="*"/>
 <%
//dto.setIndate(new Timestamp(System.currentTimeMillis()));

memoDao dao = memoDao.getInstance();


int ri = dao.insertMember(dto);
if (ri == memoDao.memo_JOIN_SUCCESS){
	%>
	<script language="javascript">
	alert("글 작성 완료 ");
	document.location.href="memoTime.jsp";

	</script>
	<% 

}
else {
	
	out.println("등록 실패");
}

%>

