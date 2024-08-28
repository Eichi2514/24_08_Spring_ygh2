<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}')
	console.log(params);
	console.log(params.memberId);
	
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
		if(isNaN(params.memberId) == true){
			if(confirm('로그인 창으로 이동하시겠습니까?')){
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri;
			}
			return;
		}	
		
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
		if(isNaN(params.memberId) == true){
			if(confirm('로그인 창으로 이동하시겠습니까?')){
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri;
			}
			return;
		}	
		
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
			<span class="likeCount">${article.goodReactionPoint}</span>
			)
		</button>
		<br />
		<button class="bad_btn cursor-pointer inline-block" onclick="doBad(${param.id})" style="text-align: center;">
			Bad ▼(
			<span class="badCount">${article.badReactionPoint} </span>
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
<section class="mt-24 text-xl px-4">
	<hr />
	<br />
	<!-- 	댓글 리스트 -->
	<div class="mx-auto">
		<table border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
			<thead>
				<tr>
					<th style="text-align: center;">Registration Date</th>
					<th style="text-align: center;">Writer</th>
					<th style="text-align: center;">Body</th>
					<th style="text-align: center;">Like</th>
					<th style="text-align: center;">Dislike</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="reply" items="${replies}">
					<tr class="hover">
						<td style="text-align: center;">${reply.regDate.substring(0,10)}</td>
						<td style="text-align: center;">${reply.extra__writer}</td>
						<td style="text-align: center;">${reply.body}</td>
						<td style="text-align: center;">${reply.goodReactionPoint}</td>
						<td style="text-align: center;">${reply.badReactionPoint}</td>
					</tr>
				</c:forEach>
				<c:if test="${empty replies}">
					<tr>
						<td colspan="4" style="text-align: center;">댓글이 없습니다</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<!-- 댓글 -->
	<br />
	<hr />
	<div class="flex justify-center p-10">
		<c:if test="${rq.isLogined() }">
			<form action="../reply/doWrite" method="POST" onsubmit="ReplyWrite__submit(this); return false;" )>
				<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
					<input type="hidden" name="relTypeCode" value="article" />
					<input type="hidden" name="relId" value="${article.id }" />
					<tbody>
						<tr>
							<th>댓글 내용 입력</th>
							<td style="text-align: center;">
								<input style="background-color: transparent;" name="body" autocomplete="off" type="text" placeholder="내용을 입력해"></input>
								<button class="btn btn-outline">작성</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</c:if>
		<c:if test="${!rq.isLogined() }">
		댓글 작성을 위해 <a href="../member/login">로그인</a>이 필요합니다
	</c:if>
	</div>
</section>
<br />
<%@ include file="../common/foot.jspf"%>