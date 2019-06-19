<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <title>Zamówienia</title>
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
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/orders">Zamówienia</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/logout">Wyloguj</a>
    </div>
</nav>
<h3 class="text-center font-weight-bold mt-2">Zamówienia:</h3>
<div class="container-fluid">
<c:if test="${not empty orders}">
    <div>
        <table class="table table-striped table-bordered table-hover">
            <thead class="thead-dark">
            <tr>
                <th>Data</th>
                <th>Książki</th>
                <th>Cena</th>
                <th>Status</th>
                <sec:authorize access="hasRole('ADMIN')">
                    <th>Użytkownik</th>
                    <th>Zmień status</th>
                </sec:authorize>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td><c:out value="${order.timestampToString()}"/></td>
                    <td><c:out value="${order.booksToString()}"/></td>
                    <td><c:out value="${order.price}"/></td>
                    <td><c:out value="${order.status}"/></td>
                    <sec:authorize access="hasRole('ADMIN')">
                        <td><c:out value="${order.user.username}"/></td>
                        <td>
                            <form:form action="${pageContext.request.contextPath}/orders/complete">
                                <input type="hidden" id="orderId" name="orderId" value="${order.id}"/>
                                <button type="submit" class="btn btn-dark">Zrealizowane</button>
                            </form:form>
                        </td>
                    </sec:authorize>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>
</div>
</body>
</html>
