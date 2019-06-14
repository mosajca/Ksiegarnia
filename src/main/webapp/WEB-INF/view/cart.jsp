<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <title>Koszyk</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-light bg-light border">
    <div class="container">
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/books/list">Książki</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/cart">Koszyk</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/orders">Zamówienia</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/logout">Wyloguj</a>
    </div>
</nav>
<h3 class="text-center font-weight-bold mt-2">Koszyk:</h3>
<c:if test="${not empty books}">
    <div>
        <table class="table table-striped table-bordered table-hover">
            <thead class="thead-dark">
            <tr>
                <th>Tytuł</th>
                <th>Wydawnictwo</th>
                <th>Cena</th>
                <th>Kategoria</th>
                <th>Autorzy</th>
                <th>Usuń</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.name}</td>
                    <td>${book.publisher}</td>
                    <td>${book.price}</td>
                    <td>${book.category.name}</td>
                    <td>${book.authors.toString().replaceAll("^\\[", "").replaceAll("]$", "")}</td>
                    <td>
                        <form:form action="${pageContext.request.contextPath}/cart/delete">
                            <input type="hidden" id="bookId" name="bookId" value="${book.id}"/>
                            <button type="submit" class="btn btn-dark">Usuń</button>
                        </form:form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <form:form method="post" action="${pageContext.request.contextPath}/orders">
            <button type="submit" class="btn btn-dark">Zamów</button>
        </form:form>
    </div>
</c:if>
</body>
</html>
