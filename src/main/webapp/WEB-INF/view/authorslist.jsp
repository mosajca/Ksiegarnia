<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <title>Autorzy</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-light bg-light border">
    <div class="container">
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/authors/list">Autorzy</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/categories/list">Kategorie</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/books/list">Książki</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/orders">Zamówienia</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/logout">Wyloguj</a>
    </div>
</nav>
<h3 class="text-center font-weight-bold mt-2">Autorzy:</h3>
<div>
    <table class="table table-striped table-bordered table-hover">
        <thead class="thead-dark">
        <tr>
            <th>Imię</th>
            <th>Nazwisko</th>
            <th>Edytuj</th>
            <th>Usuń</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="author" items="${authors}">
            <c:url var="update" value="/authors/updateAuthorForm">
                <c:param name="authorId" value="${author.id}"/>
            </c:url>
            <c:url var="delete" value="/authors/deleteAuthorForm">
                <c:param name="authorId" value="${author.id}"/>
            </c:url>
            <tr>
                <td>${author.firstName}</td>
                <td>${author.lastName}</td>
                <td><a href="${update}">edytuj</a></td>
                <td><a href="${delete}">usuń</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div>
    <a href="${pageContext.request.contextPath}/authors/formadd" class="btn btn-dark">Dodaj autora</a>
</div>
</body>
</html>
