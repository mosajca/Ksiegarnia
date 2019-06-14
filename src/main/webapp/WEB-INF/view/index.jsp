<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <title>Księgarnia</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-light bg-light border">
    <div class="container">
        <sec:authorize access="hasRole('ADMIN')">
            <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/authors/list">Autorzy</a>
            <a class="text-dark font-weight-bold"
               href="${pageContext.request.contextPath}/categories/list">Kategorie</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/books/list">Książki</a>
            <sec:authorize access="hasRole('USER')">
                <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/cart">Koszyk</a>
            </sec:authorize>
            <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/orders">Zamówienia</a>
            <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/logout">Wyloguj</a>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/login">Zaloguj</a>
            <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/register">Zarejestruj</a>
        </sec:authorize>
    </div>
</nav>
<h2 class="text-center font-weight-bold mt-2">Księgarnia</h2>
<sec:authorize access="isAuthenticated()">
    <p class="h3">Użytkownik: <c:out value="${pageContext.request.remoteUser}"/></p>
</sec:authorize>
<p class="h3">Witaj na stronie księgarni.</p>
</body>
</html>
