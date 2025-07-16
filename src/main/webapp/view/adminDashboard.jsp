<%@ page session="true" import="model.User" %>
<%@ page import="dao.DepartmentDAO, dao.DoctorDAO, dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Department, model.Doctor" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    DepartmentDAO deptDao = new DepartmentDAO();
    DoctorDAO docDao = new DoctorDAO();
    UserDAO userDao = new UserDAO();
    List<Department> departments = deptDao.getAllDepartments();
    List<Doctor> doctors = docDao.getAllDoctors();
    List<User> patients = userDao.getAllPatients();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial; background: #f4f4f4; padding: 20px; }
        .container { background: #fff; padding: 20px; border-radius: 10px; max-width: 1000px; margin: auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1, h2 { color: #007BFF; }
        .section { margin-bottom: 30px; }
        label, select, input { display: block; margin: 8px 0; width: 100%; padding: 8px; }
        button { padding: 8px 16px; background: #007BFF; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #0056b3; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #007BFF; color: white; }
        .logout { float: right; font-size: 14px; }
        form.inline { display: inline; }
    </style>
</head>
<body>

<div class="container">
    <h1>Welcome, <%= user.getName() %> <a href="<%= request.getContextPath() %>/logout" class="logout">Logout</a></h1>

    <% String msg = (String) session.getAttribute("msg");
       if (msg != null) { %>
    <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
        <%= msg %>
    </div>
    <% session.removeAttribute("msg"); } %>

    <!-- Summary Section -->
    <div class="section">
        <h2>Clinic Overview</h2>
        <ul>
            <li>Total Doctors: <%= doctors.size() %></li>
            <li>Total Departments: <%= departments.size() %></li>
            <li>Total Patients: <%= patients.size() %></li>
        </ul>
    </div>

    <!-- Patients List -->
    <div class="section">
        <h2>Registered Patients</h2>
        <table>
            <tr><th>#</th><th>Name</th><th>Email</th></tr>
            <%
                int p = 1;
                for (User patient : patients) {
            %>
            <tr>
                <td><%= p++ %></td>
                <td><%= patient.getName() %></td>
                <td><%= patient.getEmail() %></td>
            </tr>
            <% } %>
        </table>
    </div>

    <!-- Add Department -->
    <div class="section">
        <h2>Add Department</h2>
        <form action="<%= request.getContextPath() %>/addDepartment" method="post">
            <label>Department Name</label>
            <input type="text" name="department" required>
            <button type="submit" onclick="return confirm('Add this department?');">Add Department</button>
        </form>
    </div>

    <!-- Department List -->
    <div class="section">
        <h2>Departments</h2>
        <table>
            <tr><th>ID</th><th>Name</th><th>Update</th><th>Delete</th></tr>
            <% for (Department d : departments) { %>
            <tr>
                <form action="<%= request.getContextPath() %>/updateDepartment" method="post" class="inline">
                    <td><%= d.getId() %></td>
                    <td><input type="text" name="name" value="<%= d.getName() %>" required></td>
                    <td>
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <button type="submit" onclick="return confirm('Update this department?');">Update</button>
                    </td>
                </form>
                <td>
                    <a href="<%= request.getContextPath() %>/deleteDepartment?id=<%= d.getId() %>"
                       onclick="return confirm('Are you sure you want to delete this department?');">
                       <button>Delete</button>
                    </a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <!-- Add Doctor -->
    <div class="section">
        <h2>Add Doctor</h2>
        <form action="<%= request.getContextPath() %>/addDoctor" method="post">
            <label>Name</label>
            <input type="text" name="name" required>
            <label>Email</label>
            <input type="email" name="email" required>
            <label>Department</label>
            <select name="departmentId" required>
                <% for (Department d : departments) { %>
                    <option value="<%= d.getId() %>"><%= d.getName() %></option>
                <% } %>
            </select>
            <button type="submit" onclick="return confirm('Add this doctor?');">Add Doctor</button>
        </form>
    </div>

    <!-- Doctor List -->
    <div class="section">
        <h2>List of Doctors</h2>
        <table>
            <tr><th>#</th><th>Name</th><th>Email</th><th>Department</th><th>Update</th><th>Delete</th></tr>
            <%
                int i = 1;
                for (Doctor d : doctors) {
            %>
            <tr>
                <form action="<%= request.getContextPath() %>/updateDoctor" method="post" class="inline">
                    <td><%= i++ %></td>
                    <td><input type="text" name="name" value="<%= d.getName() %>" required></td>
                    <td><input type="email" name="email" value="<%= d.getEmail() %>" required></td>
                    <td>
                        <select name="departmentId" required>
                            <% for (Department dept : departments) { %>
                                <option value="<%= dept.getId() %>" <%= dept.getName().equals(d.getDepartmentName()) ? "selected" : "" %>><%= dept.getName() %></option>
                            <% } %>
                        </select>
                    </td>
                    <td>
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <button type="submit" onclick="return confirm('Update this doctor?');">Update</button>
                    </td>
                </form>
                <td>
                    <a href="<%= request.getContextPath() %>/deleteDoctor?id=<%= d.getId() %>"
                       onclick="return confirm('Are you sure you want to delete this doctor?');">
                       <button>Delete</button>
                    </a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <p><a href="<%= request.getContextPath() %>/view/appointments.jsp">View Appointments</a></p>
</div>

</body>
</html>
