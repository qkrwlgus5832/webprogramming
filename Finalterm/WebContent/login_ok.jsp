<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("EUC-KR");

String id = null;
id = request.getParameter("id");
String pass= null;
pass = request.getParameter("pw");

if (id.equals("")){
	%>
	<script language="javascript">
	alert("아이디를 입력해 주십시오");
	history.go(-1);
	</script>
	
	
<%

}


 if (pass.equals("")){
	%>
	<script language="javascript">
	alert("비밀번호를 입력해 주십시오");
	history.go(-1);
	</script>
	
	
<%
}
else {
session.setAttribute("id", id);
out.println("<script>");
  out.println("location.href='memoTime.jsp'");
  out.println("</script>");
} 


	
%>

</body>
</html>