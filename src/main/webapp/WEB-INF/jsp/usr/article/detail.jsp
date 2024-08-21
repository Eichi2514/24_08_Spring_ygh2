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

		if (localStorage.getItem(localStorageKey)) {
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
	};

	$(function() {
		ArticleDetail__doIncreaseHitCount();
	});
</script>

<script>
/* const localStorageKey2 = 'article__' + params.id + '__Like';
const localStorageKey3 = 'article__' + params.id + '__Hite'; */

$(".ditailLike").click(function () {
	let has = $(".ditailLike").hasClass("text-red-500");

	if (!has) {
		$(".ditailLike").addClass("text-red-500");
	} else {
		$(".ditailLike").removeClass("text-red-500");
	}

/* 	if (localStorage.getItem(localStorageKey3)) {
		localStorage.removeItem(localStorageKey3);
	}

	localStorage.setItem(localStorageKey2, true); */
});

$(".ditailHate").click(function () {

	$(".ditailLike").removeClass("text-red-500");

/* 	if (localStorage.getItem(localStorageKey2)) {
		localStorage.removeItem(localStorageKey2);
	}

	localStorage.setItem(localStorageKey3, true); */

});
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
					<td style="text-align: center;"><span class="article-detail__hit-count">${article.hitCount}</span></td>
				</tr>
			</tbody>
		</table>
		<div class="ditailLike cursor-pointer inline-block z-20" style="text-align: center;">좋아요 ▲</div>
		<br />
		<div class="ditailHate cursor-pointer inline-block z-20" style="text-align: center;">싫어요 ▼</div>
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