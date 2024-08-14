<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETILE"></c:set>
<%@ include file="../common/head.jspf"%>
	<div>
		작성자 : ${article.nickname}</div>
	<div>
		날짜 :
		${article.regDate}</div>
	<div>
		제목 :
		${article.title}</div>
	<div>
		내용 :
		${article.title}</div>
<%@ include file="../common/foot.jspf"%>