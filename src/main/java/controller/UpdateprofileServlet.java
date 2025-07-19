package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

@WebServlet("/updateProfile")
public class UpdateprofileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinic_db", "root", "");
             PreparedStatement stmt = conn.prepareStatement("UPDATE users SET name=?, email=? WHERE id=?")) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setInt(3, id);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                // Update session user info too
                User updatedUser = (User) request.getSession().getAttribute("user");
                updatedUser.setName(name);
                updatedUser.setEmail(email);
                request.getSession().setAttribute("user", updatedUser);
                request.getSession().setAttribute("msg", "Profile updated successfully!");
            } else {
                request.getSession().setAttribute("msg", "Update failed!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "Error: " + e.getMessage());
        }

        response.sendRedirect("view/profile.jsp");
    }
}
