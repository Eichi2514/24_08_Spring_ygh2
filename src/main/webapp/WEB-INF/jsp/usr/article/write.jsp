<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="WRITE"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<script type="text/javascript">
	function ArticleWrite__submit(form) {
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목 써');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		if (markdown.length == 0) {
			alert('내용 써');
			return;
		}
		form.body.value = markdown;
		form.submit();
	}
</script>
<form onsubmit="ArticleWrite__submit(this); return false;" action="../article/doWrite" method="POST" enctype="multipart/form-data">
<input type="hidden" name="body" />
	<tr>
		<th>게시판</th>
		<td class="text-black" style="text-align: center;">
			<select class="text-black" name="boardId">
				<option class="text-black" value="2" selected disabled>게시판을 선택해주세요.</option>
				<option class="text-black" value="1">공지사항</option>
				<option class="text-black" value="2">자유</option>
				<option class="text-black" value="3">질의응답</option>
			</select>
		</td>
	</tr>
	<input type="hidden" value="${article.id}" name="id" />
	<div>
		제목 :
		<input type="text" placeholder="제목 입력" name="title" style="background-color: transparent;" />
	</div>
	<div>
		내용
		<div class="toast-ui-editor">
			<script type="text/x-template"></script>
		</div>
	</div>
	<button type="submit">작성</button>
	<button type="button" onclick="history.back()">취소</button>
</form>
<%@ include file="../common/foot.jspf"%>