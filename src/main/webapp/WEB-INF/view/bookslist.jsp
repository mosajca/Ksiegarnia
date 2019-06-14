<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <title>Książki</title>
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
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/books/list">Książki</a>
        <sec:authorize access="hasRole('USER')">
            <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/cart">Koszyk</a>
        </sec:authorize>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/logout">Wyloguj</a>
    </div>
</nav>
<h3 class="text-center font-weight-bold mt-2">Książki:</h3>
<div>
    <form:form method="get" modelAttribute="search">
        <label for="title">Tytuł:</label>
        <form:input path="title" id="title"/>
        <label for="publisher">Wydawnictwo:</label>
        <form:input path="publisher" id="publisher"/>
        <label for="price">Cena:</label>
        <form:input path="price" id="price"/>
        <label for="category">Kategoria:</label>
        <form:input path="category" id="category"/>
        <label for="author">Autor:</label>
        <form:input path="author" id="author"/>
        <button type="submit" class="btn btn-dark">Szukaj</button>
    </form:form>
</div>
<div>
    <p>sortuj:
        <c:url var="sortUrl" value="/books/list">
            <c:forEach var="p" items="${param}">
                <c:if test="${p.key ne 'sort'}">
                    <c:param name="${p.key}" value="${p.value}"/>
                </c:if>
            </c:forEach>
            <c:param name="sort" value="name"/>
        </c:url>
        <a href="${sortUrl}">tytuł</a>
        <a href="${sortUrl.toString().replaceAll("sort=name", "sort=price")}">cena</a>
    </p>
</div>
<div>
    <table class="table table-striped table-bordered table-hover">
        <thead class="thead-dark">
        <tr>
            <th>Tytuł</th>
            <th>Wydawnictwo</th>
            <th>Cena</th>
            <th>Kategoria</th>
            <th>Autorzy</th>
            <sec:authorize access="hasRole('ADMIN')">
                <th>Edytuj</th>
                <th>Usuń</th>
            </sec:authorize>
            <sec:authorize access="hasRole('USER')">
                <th>Do koszyka</th>
            </sec:authorize>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="book" items="${books}">
            <c:url var="update" value="/books/updateBookForm">
                <c:param name="bookId" value="${book.id}"/>
            </c:url>
            <c:url var="delete" value="/books/deleteBookForm">
                <c:param name="bookId" value="${book.id}"/>
            </c:url>
            <tr>
                <td>${book.name}</td>
                <td>${book.publisher}</td>
                <td>${book.price}</td>
                <td>${book.category.name}</td>
                <td>${book.authors.toString().replaceAll("^\\[", "").replaceAll("]$", "")}</td>
                <sec:authorize access="hasRole('ADMIN')">
                    <td><a href="${update}">edytuj</a></td>
                    <td><a href="${delete}">usuń</a></td>
                </sec:authorize>
                <sec:authorize access="hasRole('USER')">
                    <td>
                        <form:form action="${pageContext.request.contextPath}/cart/add">
                            <input type="hidden" id="bookId" name="bookId" value="${book.id}"/>
                            <button type="submit" class="btn btn-dark">Do koszyka</button>
                        </form:form>
                    </td>
                </sec:authorize>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<sec:authorize access="hasRole('ADMIN')">
    <div>
        <a href="${pageContext.request.contextPath}/books/formadd" class="btn btn-dark">Dodaj książkę</a>
    </div>
</sec:authorize>
</body>
</html>
