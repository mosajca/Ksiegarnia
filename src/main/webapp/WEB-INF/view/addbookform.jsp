<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <title>Książka</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style> span { padding-right: 10px; } </style>
</head>
<body>
<nav class="navbar navbar-light bg-light border">
    <div class="container">
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/authors/list">Autorzy</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/categories/list">Kategorie</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/books/list">Książki</a>
        <a class="text-dark font-weight-bold" href="${pageContext.request.contextPath}/logout">Wyloguj</a>
    </div>
</nav>
<h3 class="text-center font-weight-bold mt-2">Dodaj / edytuj książkę</h3>
<form:form action="saveBook" modelAttribute="book" method="POST">
    <table>
        <tbody>
        <tr>
            <td><label for="name">nazwa:</label></td>
            <td><form:input path="name" class="form-control" id="name"/></td>
        </tr>
        <tr>
            <td><label for="publisher">wydawnictwo:</label></td>
            <td><form:input path="publisher" class="form-control" id="publisher"/></td>
        </tr>
        <tr>
            <td><label for="price">cena:</label></td>
            <td><form:input path="price" class="form-control" id="price"/></td>
        </tr>
        <tr>
            <td><label for="categories">kategoria:</label></td>
            <td>
                <form:select path="category" class="form-control" id="categories">
                    <form:options items="${categories}" itemValue="id" itemLabel="name"/>
                </form:select>
            </td>
        </tr>
        <tr>
            <td><label for="authors">autorzy:</label></td>
            <td><form:checkboxes path="authors" items="${authors}" itemValue="id" id="authors"/></td>
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
