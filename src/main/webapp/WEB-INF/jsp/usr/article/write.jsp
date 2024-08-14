<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="WRITE"></c:set>
<%@ include file="../common/head.jspf"%>
<form method="POST" action="doWrite">
	<input type="hidden" value="${article.id}" name="id" />
	<div>
		제목 : <input type="text" placeholder="제목 입력" name="title"  style="background-color:transparent;" />
	</div>
	<div>
		내용 :
		<textarea type="text" placeholder="내용 입력" name="body"  style="background-color:transparent;" /></textarea>
	</div>
	<button type="submit">작성</button>
	<button type="button" onclick="history.back()">취소</button>
</form>
<%@ include file="../common/foot.jspf"%>