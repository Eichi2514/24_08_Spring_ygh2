<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resource/common.css" />
<title>게시물 상세페이지</title>
</head>
<body>

	<button type="button"><a href="../home/main">메인</a></button>

	<h2>게시물 상세페이지</h2>

	<div>
		작성자 : ${article.memberId}</div>
	<div>
		날짜 :
		${article.regDate}</div>
	<div>
		제목 :
		${article.title}</div>
	<div>
		내용 :
		${article.title}</div>

	<button type="button">
		<a href="list">리스트</a>
	</button>
	
	
	<style type="text/css">
a {
	color: red;
	text-decoration: none;
}
</style>

</body>
</html>