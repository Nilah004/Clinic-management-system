package controller;

import dao.DoctorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/addDoctor")
public class AddDoctorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String deptIdStr = req.getParameter("departmentId");

        HttpSession session = req.getSession();

        try {
            if (name != null && email != null && deptIdStr != null) {
                int departmentId = Integer.parseInt(deptIdStr);

                DoctorDAO dao = new DoctorDAO();
                boolean inserted = dao.insertDoctor(name, email, departmentId);

                if (inserted) {
                    session.setAttribute("msg", "Doctor added successfully!");
                } else {
                    session.setAttribute("msg", "Failed to add doctor. Check email/DB.");
                }
            } else {
                session.setAttribute("msg", "❗ Missing form data.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "❗ Server error: " + e.getMessage());
        }

        res.sendRedirect("view/adminDashboard.jsp");
    }
}
