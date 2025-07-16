// src/dao/AppointmentDAO.java
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;

public class AppointmentDAO {
    private Connection conn;

    public AppointmentDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinic_db", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean bookAppointment(Appointment app) {
        try {
            String query = "INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, app.getPatientId());
            ps.setInt(2, app.getDoctorId());
            ps.setDate(3, app.getAppointmentDate());
            ps.setTime(4, app.getAppointmentTime());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🔽 New method to view all appointments
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        try {
            String query = "SELECT a.id, u.name AS patientName, d.name AS doctorName, dept.name AS department, " +
                           "a.appointment_date, a.appointment_time, a.status " +
                           "FROM appointments a " +
                           "JOIN users u ON a.patient_id = u.id " +
                           "JOIN doctors d ON a.doctor_id = d.id " +
                           "JOIN departments dept ON d.department_id = dept.id";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment app = new Appointment();
                app.setId(rs.getInt("id"));
                app.setPatientName(rs.getString("patientName"));
                app.setDoctorName(rs.getString("doctorName"));
                app.setDepartment(rs.getString("department"));
                app.setAppointmentDate(rs.getDate("appointment_date"));
                app.setAppointmentTime(rs.getTime("appointment_time"));
                app.setStatus(rs.getString("status"));
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
