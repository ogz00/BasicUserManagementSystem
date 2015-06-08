<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="net.tanesha.recaptcha.ReCaptcha"%>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="http://localhost:8080/UserManagementApplication-0/resources/css/jquery-ui.css">
<script
	src="http://localhost:8080/UserManagementApplication-0/resources/js/jquery-2.1.0.js"></script>
<script
	src="http://localhost:8080/UserManagementApplication-0/resources/js/jquery-ui.js"></script>
<script
	src="http://localhost:8080/UserManagementApplication-0/resources/js/jqueyMask.js"></script>
<script
	src="http://localhost:8080/UserManagementApplication-0/resources/js/mainScript.js"></script>


<title>INFONAL SYSTEMS</title>

</head>
<body>

	<div id="dialog-confirm" title="Are you sure you want to delete this? &#13;&#10;There is no return on this transaction"></div>


	<div id="dialog" title="Update Screen">
	<h3>Update User</h3>
		<p>
			Name: <input id="editName" type="text" placeholder="" /> </br> Surname: <input
				id="editSurname" type="text" placeholder="" /> </br> Phone Number: <input
				id="editPhoneNo" type="text" placeholder="" />
			<button id="dialogEditButton">Edit</button>
			<button id="dialogCloseButton">Cancel</button>
			</br> </br> </br>
		</p>
	</div>

	<h3>Add User</h3>
	<form:form id="myUserForm" modelAttribute="userForm"
		action="submitedform">



		<fieldset>
			<div class="form-row">
				<label for="userName">Name:</label> <span class="input"><form:input
						path="userName" /></span>
			</div>
			<div class="form-row">
				<label for="userSurname">Surname:</label> <span class="input"><form:input
						path="userSurname" /></span>
			</div>
			<div class="form-row">
				<label for="phoneNo">Phone Number:</label> <span class="input"><form:input
						id="phoneNo" path="phoneNo" /></span>
			</div>
			<%
				ReCaptcha c = ReCaptchaFactory.newReCaptcha(
							"6LdryPASAAAAAJ7_wNiG-XKE1GU16pAjrgUnnIrT",
							"6LdryPASAAAAAK-sSiErRVQDSkl7NYyc9v18FKGO", false);
					out.print(c.createRecaptchaHtml(null, null));
			%>

			<div class="form-buttons">
				<div class="button">
					<input type="submit" id="save" value="Save" />
				</div>
			</div>
		</fieldset>
	</form:form>


	<div style="color: red;">${wrongCaptcha}</div>


	<h1>Users List</h1>

	<c:forEach items="${myUserList}" var="i">
		<table id="${i.userId}table" border="1px" cellpadding="0"
			cellspacing="0">
			<thead>
				<tr>
					<th width="15%">Name</th>
					<th width="10%">Surname</th>
					<th width="10%">Phone Number</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td id="${i.userId}tablename">${i.userName}</td>
					<td id="${i.userId}tablesurname">${i.userSurname}</td>
					<td id="${i.userId}tablephoneno">${i.phoneNo}</td>
					<td><button class="opener" id="${i.userId}opener">Edit</button>
						<br>
						<button class="remover" id="${i.userId}remover">Delete</button> <br></td>
				</tr>

			</tbody>
		</table>
	</c:forEach>

</body>
</html>