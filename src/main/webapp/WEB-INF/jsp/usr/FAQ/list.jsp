<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="FAQ"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<div>FAQ : ${totalCnt}개</div>
<div class="pagination flex justify-center">
	<c:set var="paginationLen" value="3" />
	<c:set var="startPage"
		value="${page -  paginationLen  >= 1 ? page - paginationLen : 1}" />
	<c:set var="endPage"
		value="${page +  paginationLen  <= totalPage ? page + paginationLen : totalPage}" />
	<c:set var="baseUri" value="?boardId=${boardId}" />
	<c:set var="baseUri" value="${baseUri}&search=${search}" />
	<c:set var="baseUri" value="${baseUri}&str=${str}" />
	<a href="list${baseUri}&page=${lpage}">이전</a>
	<c:if test="${startPage > 1 }">
		<a href="?page=1&${baseUri}">1</a>
	</c:if>
	<c:if test="${startPage > 2 }">
		<button>...</button>
	</c:if>
	<c:forEach begin="${startPage }" end="${endPage }" var="i">
		<a class="${page == i ? 'text-red-500' : '' }"
			href="${baseUri}&page=${i }">${i }</a>
	</c:forEach>
	<c:if test="${endPage < totalPage - 1 }">
		<button>...</button>
	</c:if>
	<c:if test="${endPage < totalPage }">
		<a href="${baseUri}&page=${totalPage }">${totalPage }</a>
	</c:if>
	<a href="list${baseUri}&page=${rpage}">다음</a>
</div>
<section class="mt-8 text-xl px-4">
	<div class="flex justify-center p-10">
		<form method="POST" action="list">
			<select class="text-black p-1" name="search" data-value="${search}">
				<option class="text-black" value="title">질문</option>
				<option class="text-black" value="body">답변</option>
			</select> <input type="text" placeholder="검색어를 입력해주세요" name="str"
				style="background-color: transparent;" value="${str}" />
			<button type="submit">검색</button>
		</form>
	</div>
	<div class="mx-auto">
		<table border="1" cellspacing="0" cellpadding="5"
			style="width: 100%; border-collapse: collapse;">
			<thead>
				<tr>
					<th style="text-align: center;">ID</th>
					<th style="text-align: center;">Title</th>
					<th style="text-align: center;">Writer</th>
					<th style="text-align: center;">Registration Date</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="FAQ" items="${FAQs}">
					<tr>
						<td style="text-align: center;">${FAQ.id}</td>
						<td class="FAQ_title cursor-pointer">
						${FAQ.title}
							<div class="FAQ_body">${FAQ.body}</div>
						</td>
						<td style="text-align: center;">${FAQ.extra__writer}</td>
						<td style="text-align: center;">${FAQ.regDate.substring(0,10)}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${empty FAQs}">
			<div class="p-10" style="text-align: center;">해당 게시글이 없습니다.</div>
		</c:if>
	</div>
</section>
<%@ include file="../common/foot.jspf"%>