<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Registration Status</title>
</head>
<body>

<c:choose>

     <c:when test="${not empty sessionScope.PENDING_TEACHER}">
        <jsp:include page="teacherRegisterCvSuccess.jsp"/>
    </c:when>

     <c:otherwise>
        <jsp:include page="teacherRegisterCv.jsp"/>
    </c:otherwise>

</c:choose>

</body>
</html>
