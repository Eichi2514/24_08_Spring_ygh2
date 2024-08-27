<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf"%>

<form method="POST" action="doLogin">
	<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
	<div>
		아이디 : <input type="text" placeholder="아이디 입력" name="loginId"  style="background-color:transparent;"/>
	</div>
	<div>
		비밀번호 :	<input type="text" placeholder="비밀번호 입력" name="loginPw" style=" background-color:transparent;"></input>
	</div>


	<button type="submit">로그인</button>
	<button type="button" onclick="history.back()">취소</button>
	
</form>

<%@ include file="../common/foot.jspf"%>