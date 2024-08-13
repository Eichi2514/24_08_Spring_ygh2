<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resource/common.css" />
<title>ARTICLE LIST</title>
</head>
<body>
	<h1>LIST</h1>
	<button type="button">
		<a href="../home/main">메인</a>
	</button>
	<hr />
	<table border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
		<thead>
			<tr>
				<th style="text-align: center;">번호</th>
				<th style="text-align: center;">작성날짜</th>
				<th style="text-align: center;">제목</th>
				<th style="text-align: center;">작성자 번호</th>
				<th style="text-align: center;">수정</th>
				<th style="text-align: center;">삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="article" items="${articles}">
				<tr>
					<td style="text-align: center;">${article.id}</td>
					<td style="text-align: center;">${article.regDate.substring(0,10)}</td>
					<td style="text-align: center;"><a href="detail?id=${article.id}">${article.title}</a></td>
					<td style="text-align: center;">${article.memberId}</td>
				
					<td style="text-align: center;"><c:if test="${loginedMemberId eq article.memberId}"><button>
							<a href="doModify?id=${article.id}">수정</a>
						</button></c:if></td>
					<td style="text-align: center;"><c:if test="${loginedMemberId eq article.memberId}"><button>
							<a href="doDelete?id=${article.id}">삭제</a>
						</button></c:if></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>