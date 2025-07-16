package controller;

import dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Appointment;
import java.time.LocalTime;
import model.User;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/bookAppointment")
public class BookAppointmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User patient = (User) session.getAttribute("user");

        if (patient == null || !"patient".equals(patient.getRole())) {
            res.sendRedirect("login.jsp");
            return;
        }

        try {
            int doctorId = Integer.parseInt(req.getParameter("doctorId"));
            Date date = Date.valueOf(req.getParameter("date"));

            // ✅ Convert HH:mm to HH:mm:ss properly
            LocalTime lt = LocalTime.parse(req.getParameter("time")); // parses HH:mm
            Time time = Time.valueOf(lt); // converts to HH:mm:ss

            Appointment app = new Appointment();
            app.setPatientId(patient.getId());
            app.setDoctorId(doctorId);
            app.setAppointmentDate(date);
            app.setAppointmentTime(time);

            AppointmentDAO dao = new AppointmentDAO();
            boolean success = dao.bookAppointment(app);

            if (success) {
                session.setAttribute("msg", "Appointment booked successfully.");
            } else {
                session.setAttribute("msg", "Failed to book appointment.");
            }

            res.sendRedirect("view/patientDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Something went wrong: " + e.getMessage());
            res.sendRedirect("view/patientDashboard.jsp");
        }
    }
}



