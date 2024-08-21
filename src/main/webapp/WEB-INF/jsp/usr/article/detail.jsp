<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<%-- <iframe src="http://localhost:8080/usr/article/doincreaseHitCount?id=${article.id} }" frameborder="0"></iframe> --%>
<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function ArticleDetail__doIncreaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyOnView';
		
		if (localStorage.getItem(localStorageKey)){
			return;
		}
		localStorage.setItem(localStorageKey, true);
		
		$.get('../article/doincreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			console.log(data);
			console.log(data.data1);
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json')
	}

	$(function() {
		ArticleDetail__doIncreaseHitCount();
	})
</script>

<section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<table border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
			<tbody>
				<tr>
					<th style="text-align: center;">Writer</th>
					<td style="text-align: center;">${article.extra__writer}</td>
				</tr>
				<tr>
					<th style="text-align: center;">Registration Date</th>
					<td style="text-align: center;">${article.regDate.substring(0,10)}</td>
				</tr>
				<tr>
					<th style="text-align: center;">Title</th>
					<td style="text-align: center;">${article.title}</td>
				</tr>
				<tr>
					<th style="text-align: center;">Body</th>
					<td style="text-align: center;">${article.body}</td>
				</tr>
				<tr>
					<th style="text-align: center;">Views</th>
					<td style="text-align: center;">
					     <span class="article-detail__hit-count">${article.hitCount}</span>
					</td>
				</tr>
				<%-- <tr>
					<th style="text-align: center;">Like</th>
					<td style="text-align: center;">
					     <span class="article-detail__Like">${article.Like}</span>
					</td>
				</tr> --%>				
			</tbody>
		</table>
		<div class="btns">
			<button type="button" onclick="history.back()">뒤로가기</button>
			<c:if test="${article.userCanModify }">
				<a href="../article/modify?id=${article.id }">수정</a>
			</c:if>
			<c:if test="${article.userCanDelete }">
				<a href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>