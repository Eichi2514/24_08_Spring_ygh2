<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	var isAlreadyAddBadRp = ${isAlreadyAddBadRp};
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
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json')
	};

	$(function() {
		ArticleDetail__doIncreaseHitCount();
	});
</script>
<!-- 좋아요 싫어요  -->
<script>
<!-- 좋아요 싫어요 버튼	-->
	function checkRP() {
		if (isAlreadyAddGoodRp == true) {
			$('.like_btn').toggleClass('text-red-500');
		} else if (isAlreadyAddBadRp == true) {
			$('.bad_btn').toggleClass('text-blue-500');
		} else {
			return;
		}
	}

	function doGood(articleId) {
		$.ajax({
			url : '/usr/reactionPoint/doGood',
			type : 'POST',
			data : {
				relTypeCode : 'article',
				relId : articleId
			},
			dataType : 'json',
			success : function(data) {
				if (data.resultCode.startsWith('S-')) {
					var likeButton = $('.like_btn');
					var DislikeButton = $('.bad_btn');
					var likeCount = $('.likeCount');
					var DislikeCount = $('.badCount');
					
					if (data.resultCode == 'S-1') {
						likeButton.toggleClass('text-red-500');
						likeCount.text(parseInt(likeCount.text()) + 1);
					} else if (data.resultCode == 'S-2') {
						DislikeButton.toggleClass('text-blue-500');
						DislikeCount.text(parseInt(DislikeCount.text()) - 1);
						likeButton.toggleClass('text-red-500');
						likeCount.text(parseInt(likeCount.text()) + 1);
					} else {
						likeButton.toggleClass('text-red-500');
						likeCount.text(parseInt(likeCount.text()) - 1);
					}
				} else {
					alert(data.msg);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert('좋아요 오류 발생 : ' + textStatus);
			}

		});
	}

	function doBad(articleId) {
		$.ajax({
			url : '/usr/reactionPoint/doBad',
			type : 'POST',
			data : {
				relTypeCode : 'article',
				relId : articleId
			},
			dataType : 'json',
			success : function(data) {
				if (data.resultCode.startsWith('S-')) {
					var likeButton = $('.like_btn');
					var DislikeButton = $('.bad_btn');
					var likeCount = $('.likeCount');
					var DislikeCount = $('.badCount');

					if (data.resultCode == 'S-1') {
						DislikeButton.toggleClass('text-blue-500');
						DislikeCount.text(parseInt(DislikeCount.text()) + 1);
					} else if (data.resultCode == 'S-2') {
						likeButton.toggleClass('text-red-500');
						likeCount.text(parseInt(likeCount.text()) - 1);
						DislikeButton.toggleClass('text-blue-500');
						DislikeCount.text(parseInt(DislikeCount.text()) + 1);
					} else {
						DislikeButton.toggleClass('text-blue-500');
						DislikeCount.text(parseInt(DislikeCount.text()) - 1);
					}
				} else {
					alert(data.msg);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert('싫어요 오류 발생 : ' + textStatus);
			}

		});
	}

	$(function() {
		checkRP();
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
					<td style="text-align: center;">
						<span class="article-detail__hit-count">${article.hitCount}</span>
					</td>
				</tr>
			</tbody>
		</table>
		<a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.currentUri}"
			class="cursor-pointer ${isAlreadyAddGoodRp ? 'text-red-500' : '' } inline-block" style="text-align: center;">Like
			▲(${article.goodReactionPoint})</a>
		<br />
		<a href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.currentUri}"
			class="cursor-pointer ${isAlreadyAddBadRp ? 'text-blue-500' : '' } inline-block" style="text-align: center;"> Bad
			▼(${article.badReactionPoint})</a>
		<br />
		<br />
		<div>▼ ajax 방식 ▼</div>
		<button class="like_btn cursor-pointer inline-block" onclick="doGood(${param.id})" style="text-align: center;">
			Like ▲(
			<span class = "likeCount">${article.goodReactionPoint}</span>
			)
		</button>
		<br />
		<button class="bad_btn cursor-pointer inline-block" onclick="doBad(${param.id})" style="text-align: center;">
			Bad ▼(
			<span class = "badCount">${article.badReactionPoint} </span>
			)
		</button>
		<div class="btns">
			<br />
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