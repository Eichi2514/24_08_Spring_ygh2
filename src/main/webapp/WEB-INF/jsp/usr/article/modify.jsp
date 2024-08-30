<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MODIFY"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<script type="text/javascript">
	function ArticleModify__submit(form) {
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		if (markdown.length == 0) {
			alert('내용 써');
			editor.focus();
			return;
		}
		form.body.value = markdown;
		form.submit();
	}
</script>
<form onsubmit="ArticleModify__submit(this); return false;" action=" ../article/doModify" method="POST">
	<input type="hidden" value="${article.id}" name="id" />
	<div>작성자 : ${article.extra__writer}</div>
	<div>날짜 : ${article.regDate}</div>
	<div>
		새 제목 :
		<input type="text" placeholder="제목 입력" name="title" style="background-color: transparent;" />
	</div>
	<div>
		새 내용 :
		<div class="toast-ui-editor">
			<script type="text/x-template">${article.body }</script>
		</div>
	</div>
	<button type="submit">수정</button>
	<button type="button" onclick="history.back()">취소</button>
</form>
<%@ include file="../common/foot.jspf"%>