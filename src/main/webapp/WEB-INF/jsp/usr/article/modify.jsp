<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="pageTitle" value="${}번글 수정"></c:set> --%>
<%@ include file="../common/head.jspf"%>
<form method="POST" action="doModify">
	<input type="hidden" value="${article.id}" name="id" />
	<div>작성자 : ${article.extra__writer}</div>
	<div>날짜 : ${article.regDate}</div>
	<div>
		새 제목 : <input type="text" placeholder="제목 입력" name="title" />
	</div>
	<div>
		새 내용 :
		<textarea type="text" placeholder="내용 입력" name="body"></textarea>
	</div>
	<button type="submit">수정</button>
	<button type="button">
		<a href="list">취소</a>
	</button>
</form>
<%@ include file="../common/foot.jspf"%>