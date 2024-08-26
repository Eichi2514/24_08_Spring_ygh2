<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAP"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />
<script>
$(window).keydown(function (e) {
	if (e.keyCode === 37) { 
		Left(${charac}, ${characXCood}, ${characYCood});
	} else if (e.keyCode === 38) { 
		Up(${charac}, ${characXCood}, ${characYCood});
	} else if (e.keyCode === 39) { 
		Right(${charac}, ${characXCood}, ${characYCood});
	} else if (e.keyCode === 40) { 
		Down(${charac}, ${characXCood}, ${characYCood});
	}
});

function Up(something, xCood, yCood) {
	fetch('/usr/maze/keyUp', {
		method: 'POST',
		body: JSON.stringify({
			something2: something,
			xCood2: xCood,
			yCood2: yCood
		}),
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.text())
	.then(result => {
		if (result === "success") {
			window.location.reload();
		}else {
			alert("You " + result);
			window.history.back();
		}
	})
	.catch(error => console.error('Error:', error));
}

function Down(something, xCood, yCood) {
	fetch('/usr/maze/keyDown', {
		method: 'POST',
		body: JSON.stringify({
			something2: something,
			xCood2: xCood,
			yCood2: yCood
		}),
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.text())
	.then(result => {
		if (result === "success") {
			window.location.reload();
			
		}else {
			alert("You " + result);
			window.history.back();
		}
	})
	.catch(error => console.error('Error:', error));
}

function Left(something, xCood, yCood) {
	fetch('/usr/maze/keyLeft', {
		method: 'POST',
		body: JSON.stringify({
			something2: something,
			xCood2: xCood,
			yCood2: yCood
		}),
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.text())
	.then(result => {
		if (result === "success") {
			window.location.reload();
		}else {
			alert("You " + result);
			window.history.back();
		}
	})
	.catch(error => console.error('Error:', error));
}

function Right(something, xCood, yCood) {
	fetch('/usr/maze/keyRight', {
		method: 'POST',
		body: JSON.stringify({
			something2: something,
			xCood2: xCood,
			yCood2: yCood
		}),
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.text())
	.then(result => {
		if (result === "success") {
			window.location.reload();
		} else {
			alert("You " + result);
			window.history.back();
		}
	})
	.catch(error => console.error('Error:', error));
}
</script>
<c:forEach var="x" begin="0" end="${mapHeight}">
	<c:forEach var="y" begin="0" end="${mapWidth}">
		<c:if test="${map[x][y] == 0}">
			<div class="text-gray-500 inline-block">${map[x][y]}</div>
		</c:if>
		<c:if test="${map[x][y] == 1}">
			<div class="text-yellow-500 inline-block">${map[x][y]}</div>
		</c:if>
		<c:if test="${map[x][y] == 2}">
			<div class="text-red-800 inline-block">${map[x][y]}</div>
		</c:if>
		<c:if test="${map[x][y] == 9}">
			<div class="text-blue-800 inline-block">${map[x][y]}</div>
		</c:if>
	</c:forEach>
	<br />
</c:forEach>
<%@ include file="../common/foot.jspf"%>