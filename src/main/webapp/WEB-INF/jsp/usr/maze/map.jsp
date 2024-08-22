<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAP"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<script>
document.addEventListener("keydown", checkKey, false);

function checkKey(e) {
	console.clear();
	if (e.keyCode === 37) {
		Left();
	} else if (e.keyCode === 38) {
		Up();
	} else if (e.keyCode === 39) {
		Right();
	} else if (e.keyCode === 40) {
		Down();
	}
}
</script>
<script>
function Up() {
	fetch('/keyUp', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			map: map,
			xCood: xCood,
			yCood: yCood
		})
	})
	.then(response => {
		if (response.ok) {
			window.location.reload(); // 성공 시 페이지 새로고침
		} else {
			alert("서버에서 오류가 발생했습니다.");
		}
	})
	.catch(error => {
		console.error('에러 발생:', error);
	});
}

function Down() {
	fetch('/keyDown', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			map: map,
			xCood: xCood,
			yCood: yCood
		})
	})
	.then(response => {
		if (response.ok) {
			window.location.reload(); // 성공 시 페이지 새로고침
		} else {
			alert("서버에서 오류가 발생했습니다.");
		}
	})
	.catch(error => {
		console.error('에러 발생:', error);
	});
}

function Left() {
	fetch('/keyLeft', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			map: map,
			xCood: xCood,
			yCood: yCood
		})
	})
	.then(response => {
		if (response.ok) {
			window.location.reload(); // 성공 시 페이지 새로고침
		} else {
			alert("서버에서 오류가 발생했습니다.");
		}
	})
	.catch(error => {
		console.error('에러 발생:', error);
	});
}

function Right() {
	fetch('/keyRight', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			map: map,
			xCood: xCood,
			yCood: yCood
		})
	})
	.then(response => {
		if (response.ok) {
			window.location.reload(); // 성공 시 페이지 새로고침
		} else {
			alert("서버에서 오류가 발생했습니다.");
		}
	})
	.catch(error => {
		console.error('에러 발생:', error);
	});
}
</script>
<c:forEach var="x" begin="0" end="99">
	<c:forEach var="y" begin="0" end="99">
		<c:if test="${map[x][y] != 2}">
			<div class="text-gray-500 inline-block">${map[x][y]}</div>
		</c:if>
		<c:if test="${map[x][y] == 2}">
			<div class="text-red-800 inline-block">${map[x][y]}</div>
		</c:if>
	</c:forEach>
	<br />
</c:forEach>
<%@ include file="../common/foot.jspf"%>