<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.code}"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<div>게시글 수 : ${totalCnt}개</div>
<a href="list?boardId=${boardId}&page=${lpage}">이전</a>
<a href="list?boardId=${boardId}&page=${rpage}">다음</a>
<section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<table border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
			<thead>
				<tr>
					<th style="text-align: center;">ID</th>
					<th style="text-align: center;">Registration Date</th>
					<th style="text-align: center;">Title</th>
					<th style="text-align: center;">Writer</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="article" items="${articles}">
					<tr>
						<td style="text-align: center;">${article.id}</td>
						<td style="text-align: center;">${article.regDate.substring(0,10)}</td>
						<td style="text-align: center;"><a class="hover:underline" href="detail?id=${article.id}">${article.title}</a></td>
						<td style="text-align: center;">${article.extra__writer}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="flex justify-center p-10">
		<form method="POST" action="list">
			<input type="hidden" value="${boardId}" name="boardId" />
			<input type="text" placeholder="검색어를 입력해주세요" name="str" style="background-color: transparent;" />
			<button type="submit">검색</button>
		</form>
	</div>
</section>
<%@ include file="../common/foot.jspf"%>