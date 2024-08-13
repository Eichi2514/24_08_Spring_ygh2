<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTICLE LIST</title>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>

	<button>
		<a href="../home/main">처음으로</a>
	</button>

	<h2>${article.id}번 글 수정
	</h2>

	<form method="POST" action="doModify">
		<input type="hidden" value="${article.id}" name="id" />
		<div>
			작성자 :
			${article.memberId}</div>
		<div>
			<div>
				날짜 :
				${article.regDate}
			</div>
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

	<style type="text/css">
a {
	color: black;
	text-decoration: none;
}
</style>
</body>
</html>