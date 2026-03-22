<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Redirect to the HomeServlet mapped to /home
    response.sendRedirect(request.getContextPath() + "/home");
%>
