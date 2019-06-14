<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <title>Kategoria</title>
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
<h3 class="text-center font-weight-bold mt-2">Dodaj / edytuj kategorię</h3>
<form:form action="saveCategory" modelAttribute="category" method="POST">
    <table>
        <tbody>
        <tr>
            <td><label for="name">nazwa:</label></td>
            <td><form:input path="name" class="form-control" id="name"/></td>
        </tr>
        <tr>
            <td><form:hidden path="id"/></td>
        </tr>
        <tr>
            <td>
                <button type="submit" class="btn btn-dark">Zapisz</button>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>
</body>
</html>
