<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf"%>

<form method="POST" action="doJoin">
	
	<div>
		아이디 : <input type="text" placeholder="아이디 입력" name="loginId"  style="background-color:transparent;"/>
	</div>
	<div>
		비밀번호 :	<input type="text" placeholder="비밀번호 입력" name="loginPw" style="background-color:transparent;"></textarea>
	</div>
	<div>
		비밀번호 확인 :	<input type="text" placeholder="비밀번호 입력" name="loginPw2" style="background-color:transparent;"></textarea>
	</div>
	<div>
		이름 :	<input type="text" placeholder="이름 입력" name="name" style="background-color:transparent;"></textarea>
	</div>
	<div>
		닉네임 :	<input type="text" placeholder="닉네임 입력" name="nickname" style="background-color:transparent;"></textarea>
	</div>
	<div>
		전화번호 :	<input type="text" placeholder="전화번호 입력" name="cellphoneNum" style="background-color:transparent;"></textarea>
	</div>
	<div>
		이메일 :	<input type="text" placeholder="이메일 입력" name="email" style="background-color:transparent;"></textarea>
	</div>
	
	<button type="submit">회원가입</button>
	<button type="button" onclick="history.back()">취소</button>
	
</form>

<%@ include file="../common/foot.jspf"%>