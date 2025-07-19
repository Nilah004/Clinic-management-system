package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/addDoctor")
public class AddDoctorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));

        Connection conn = null;
        PreparedStatement userStmt = null;
        PreparedStatement doctorStmt = null;
        ResultSet rs = null;

        try {
            // Load JDBC driver and connect to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinic_db", "root", "");

            // Step 1: Insert into 'users' table with a default password
            String insertUserSQL = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, 'doctor')";
            userStmt = conn.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS);
            userStmt.setString(1, name);
            userStmt.setString(2, email);
            userStmt.setString(3, "default123"); // <-- Default dummy password
            userStmt.executeUpdate();

            rs = userStmt.getGeneratedKeys();
            int userId = -1;
            if (rs.next()) {
                userId = rs.getInt(1);
            }

            // Step 2: Insert into 'doctors' table
            if (userId != -1) {
                String insertDoctorSQL = "INSERT INTO doctors (name, email, department_id, user_id) VALUES (?, ?, ?, ?)";
                doctorStmt = conn.prepareStatement(insertDoctorSQL);
                doctorStmt.setString(1, name);
                doctorStmt.setString(2, email);
                doctorStmt.setInt(3, departmentId);
                doctorStmt.setInt(4, userId);
                doctorStmt.executeUpdate();

                request.getSession().setAttribute("msg", "Doctor added successfully!");
            } else {
                request.getSession().setAttribute("msg", "Error: Unable to get user ID.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (userStmt != null) userStmt.close(); } catch (Exception ignored) {}
            try { if (doctorStmt != null) doctorStmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }

        // Redirect to admin dashboard after operation
        response.sendRedirect("view/adminDashboard.jsp");
    }
}
