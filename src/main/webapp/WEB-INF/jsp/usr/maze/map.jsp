<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAP"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<script>
$(window).keydown(function (e) {
	if (e.keyCode === 37) { // Left arrow key
		Left();
	} else if (e.keyCode === 38) { // Up arrow key
		Up();
	} else if (e.keyCode === 39) { // Right arrow key
		Right();
	} else if (e.keyCode === 40) { // Down arrow key
		Down();
	}
});

function Up() {
	fetch('/usr/maze/keyUp', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.text())
	.then(result => {
		if (result === "success") {
			window.location.reload();
		} else {
			alert("Error occurred: " + result);
		}
	})
	.catch(error => console.error('Error:', error));
}

function Down() {
	fetch('/usr/maze/keyDown', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.text())
	.then(result => {
		if (result === "success") {
			window.location.reload();
		} else {
			alert("Error occurred: " + result);
		}
	})
	.catch(error => console.error('Error:', error));
}

function Left() {
	fetch('/usr/maze/keyLeft', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.text())
	.then(result => {
		if (result === "success") {
			window.location.reload();
		} else {
			alert("Error occurred: " + result);
		}
	})
	.catch(error => console.error('Error:', error));
}

function Right() {
	fetch('/usr/maze/keyRight', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.text())
	.then(result => {
		if (result === "success") {
			window.location.reload();
		} else {
			alert("Error occurred: " + result);
		}
	})
	.catch(error => console.error('Error:', error));
}
</script>

<c:forEach var="x" begin="0" end="${mapWidth}">
	<c:forEach var="y" begin="0" end="${mapHeight}">
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