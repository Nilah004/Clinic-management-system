<%@ page session="true" import="model.User" %>
<%@ page import="dao.DepartmentDAO, dao.DoctorDAO, dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Department, model.Doctor, model.User, model.DoctorAvailability" %>

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
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }
        .container { background: #fff; padding: 20px; border-radius: 10px; max-width: 1100px; margin: auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1, h2 { color: #007BFF; }
        .section { margin-bottom: 30px; }
        label, select, input { display: block; margin: 8px 0; width: 100%; padding: 8px; }
        button { padding: 10px 20px; background-color: #007BFF; color: white; border: none; border-radius: 4px; }
        button:hover { background-color: #0056b3; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #007BFF; color: white; }
        .logout { float: right; font-size: 14px; }
    </style>
</head>
<body>

<div class="container">
    <h1>Welcome, <%= user.getName() %> <a href="<%= request.getContextPath() %>/logout" class="logout">Logout</a></h1>

    <% String msg = (String) session.getAttribute("msg"); if (msg != null) { %>
        <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px; border: 1px solid #c3e6cb;">
            <%= msg %>
        </div>
    <% session.removeAttribute("msg"); } %>

    <div class="section">
        <h2>Clinic Overview</h2>
        <ul>
            <li>Total Doctors: <%= doctors.size() %></li>
            <li>Total Departments: <%= departments.size() %></li>
            <li>Total Patients: <%= patients.size() %></li>
        </ul>
    </div>

    <div class="section">
        <h2>Registered Patients</h2>
        <table>
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Email</th>
                <th>Update</th>
                <th>Delete</th>
            </tr>
            <%
                int p = 1;
                for (User patient : patients) {
            %>
            <tr>
                <form action="<%= request.getContextPath() %>/updatePatient" method="post">
                    <td><%= p++ %></td>
                    <td><input type="text" name="name" value="<%= patient.getName() %>" required></td>
                    <td><input type="email" name="email" value="<%= patient.getEmail() %>" required></td>
                    <td>
                        <input type="hidden" name="id" value="<%= patient.getId() %>">
                        <button type="submit">Update</button>
                    </td>
                </form>
                <td>
                    <form action="<%= request.getContextPath() %>/deletePatient" method="post" onsubmit="return confirm('Delete this patient?');">
                        <input type="hidden" name="id" value="<%= patient.getId() %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <div class="section">
        <h2>Add Department</h2>
        <form action="<%= request.getContextPath() %>/addDepartment" method="post">
            <label>Department Name</label>
            <input type="text" name="department" required>
            <button type="submit">Add Department</button>
        </form>
    </div>

    <div class="section">
    <h2>Add Doctor with Multiple Availability</h2>
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

        <div id="availability-section">
            <div class="availability-group">
                <label>Day of Week</label>
                <select name="dayOfWeek" required>
                    <option>Monday</option>
                    <option>Tuesday</option>
                    <option>Wednesday</option>
                    <option>Thursday</option>
                    <option>Friday</option>
                    <option>Saturday</option>
                    <option>Sunday</option>
                </select>

                <label>Start Time</label>
                <input type="time" name="startTime" required>

                <label>End Time</label>
                <input type="time" name="endTime" required>
            </div>
        </div>

        <button type="button" onclick="addAvailability()">+ Add More Availability</button><br><br>
        <button type="submit">Add Doctor</button>
    </form>
</div>

    <div class="section">
        <h2>Doctors & Availability</h2>
        <table>
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Email</th>
                <th>Department</th>
                <th>Update</th>
                <th>Delete</th>
            </tr>
            <%
                int i = 1;
                for (Doctor d : doctors) {
            %>
            <tr>
                <td><%= i++ %></td>
                <form action="<%= request.getContextPath() %>/updateDoctor" method="post">
                    <td><input type="text" name="name" value="<%= d.getName() %>" required></td>
                    <td><input type="email" name="email" value="<%= d.getEmail() %>" required></td>
                    <td>
                        <select name="departmentId">
                            <% for (Department dept : departments) { %>
                                <option value="<%= dept.getId() %>" <%= dept.getName().equals(d.getDepartmentName()) ? "selected" : "" %>>
                                    <%= dept.getName() %>
                                </option>
                            <% } %>
                        </select>
                    </td>
                    <td>
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <button type="submit">Update</button>
                    </td>
                </form>
                <td>
                    <form action="<%= request.getContextPath() %>/deleteDoctor" method="get" onsubmit="return confirm('Delete doctor and all their availability?');">
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>

            <% if (d.getAvailabilityList() != null && !d.getAvailabilityList().isEmpty()) { %>
                <tr>
                    <td colspan="6">
                        <strong>Availability:</strong>
                        <table style="width:100%; margin-top:10px;">
                            <tr>
                                <th>Day</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Action</th>
                            </tr>
                            <% for (DoctorAvailability av : d.getAvailabilityList()) { %>
                                <tr>
                                    <form action="<%= request.getContextPath() %>/updateAvailability" method="post">
                                        <td><input type="text" name="dayOfWeek" value="<%= av.getDayOfWeek() %>" required></td>
                                        <td><input type="time" name="startTime" value="<%= av.getStartTime() %>" required></td>
                                        <td><input type="time" name="endTime" value="<%= av.getEndTime() %>" required></td>
                                        <td>
                                            <input type="hidden" name="availabilityId" value="<%= av.getId() %>">
                                            <button type="submit">Update</button>
                                            <a href="<%= request.getContextPath() %>/deleteAvailability?id=<%= av.getId() %>" onclick="return confirm('Delete this slot?');">Delete</a>
                                        </td>
                                    </form>
                                </tr>
                            <% } %>
                        </table>
                    </td>
                </tr>
            <% } %>

            <!-- New availability add form -->
            <tr>
                <td colspan="6">
                    <strong>Add New Availability</strong>
                    <form action="<%= request.getContextPath() %>/addAvailability" method="post" style="margin-top:10px;">
                        <input type="hidden" name="doctorId" value="<%= d.getId() %>">
                        <label>Day</label>
                        <select name="dayOfWeek" required>
                            <option>Monday</option>
                            <option>Tuesday</option>
                            <option>Wednesday</option>
                            <option>Thursday</option>
                            <option>Friday</option>
                            <option>Saturday</option>
                            <option>Sunday</option>
                        </select>
                        <label>Start Time</label>
                        <input type="time" name="startTime" required>
                        <label>End Time</label>
                        <input type="time" name="endTime" required>
                        <button type="submit">Add Slot</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <p><a href="<%= request.getContextPath() %>/view/appointments.jsp">View All Appointments</a></p>
</div>

<script>
function addAvailability() {
    const section = document.getElementById("availability-section");
    const group = document.querySelector(".availability-group");
    const clone = group.cloneNode(true);

    // Clear values in cloned inputs
    const inputs = clone.querySelectorAll("input, select");
    inputs.forEach(input => input.value = '');

    section.appendChild(clone);
}
</script>


</body>
</html>
