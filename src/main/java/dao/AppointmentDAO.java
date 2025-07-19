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
        String query = "INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, patient_name, contact, age, gender) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, app.getPatientId());
            ps.setInt(2, app.getDoctorId());
            ps.setDate(3, app.getAppointmentDate());
            ps.setTime(4, app.getAppointmentTime());
            ps.setString(5, app.getPatientName());
            ps.setString(6, app.getContact());
            ps.setInt(7, app.getAge());
            ps.setString(8, app.getGender());

            int rows = ps.executeUpdate();

            if (rows == 1) {
                System.out.println("✅ Appointment booked successfully.");
                return true;
            } else {
                System.out.println("⚠️ No rows inserted.");
                return false;
            }

        } catch (SQLException e) {
            System.err.println("❌ Error booking appointment:");
            System.err.println("SQLState: " + e.getSQLState());
            System.err.println("ErrorCode: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }



    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        try {
        	String query = "SELECT a.id, a.patient_id, a.doctor_id, a.appointment_date, a.appointment_time, " +
                    "u.name AS patientName, d.name AS doctorName, dept.name AS department, a.status " +
                    "FROM appointments a " +
                    "JOIN users u ON a.patient_id = u.id " +
                    "JOIN doctors d ON a.doctor_id = d.id " +
                    "JOIN departments dept ON d.department_id = dept.id";

     PreparedStatement ps = conn.prepareStatement(query);
     ResultSet rs = ps.executeQuery();

     while (rs.next()) {
         Appointment app = new Appointment();
         app.setId(rs.getInt("id"));
         app.setPatientId(rs.getInt("patient_id"));
         app.setDoctorId(rs.getInt("doctor_id")); // ← important!
         app.setAppointmentDate(rs.getDate("appointment_date"));
         app.setAppointmentTime(rs.getTime("appointment_time"));
         app.setPatientName(rs.getString("patientName"));
         app.setDoctorName(rs.getString("doctorName"));
         app.setDepartment(rs.getString("department"));
         app.setStatus(rs.getString("status"));
         list.add(app);
     }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int appointmentId, String status) {
        try {
            String query = "UPDATE appointments SET status = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, appointmentId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Appointment> getAppointmentsByDoctorId(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        try {
            String query = "SELECT a.id, a.patient_id, a.doctor_id, a.appointment_date, a.appointment_time, " +
                           "u.name AS patientName, d.name AS doctorName, dept.name AS department, a.status " +
                           "FROM appointments a " +
                           "JOIN users u ON a.patient_id = u.id " +
                           "JOIN doctors d ON a.doctor_id = d.id " +
                           "JOIN departments dept ON d.department_id = dept.id " +
                           "WHERE a.doctor_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, doctorId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment app = new Appointment();
                app.setId(rs.getInt("id"));
                app.setPatientId(rs.getInt("patient_id"));
                app.setDoctorId(rs.getInt("doctor_id"));
                app.setAppointmentDate(rs.getDate("appointment_date"));
                app.setAppointmentTime(rs.getTime("appointment_time"));
                app.setPatientName(rs.getString("patientName"));
                app.setDoctorName(rs.getString("doctorName"));
                app.setDepartment(rs.getString("department"));
                app.setStatus(rs.getString("status"));
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Appointment> getConfirmedAppointmentsByDoctorId(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        try {
            String query = "SELECT a.id, a.patient_id, a.doctor_id, a.appointment_date, a.appointment_time, " +
                    "u.name AS patientName, d.name AS doctorName, dept.name AS department, a.status " +
                    "FROM appointments a " +
                    "JOIN users u ON a.patient_id = u.id " +
                    "JOIN doctors d ON a.doctor_id = d.id " +
                    "JOIN departments dept ON d.department_id = dept.id " +
                    "WHERE a.doctor_id = ? AND a.status = 'Confirmed'";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, doctorId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment app = new Appointment();
                app.setId(rs.getInt("id"));
                app.setPatientId(rs.getInt("patient_id"));
                app.setDoctorId(rs.getInt("doctor_id"));
                app.setAppointmentDate(rs.getDate("appointment_date"));
                app.setAppointmentTime(rs.getTime("appointment_time"));
                app.setPatientName(rs.getString("patientName"));
                app.setDoctorName(rs.getString("doctorName"));
                app.setDepartment(rs.getString("department"));
                app.setStatus(rs.getString("status"));
                list.add(app);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Appointment> getAppointmentsByPatientId(int patientId) {
        List<Appointment> list = new ArrayList<>();
        try {
            String query = "SELECT a.id, a.patient_id, a.doctor_id, a.appointment_date, a.appointment_time, " +
                    "u.name AS patientName, d.name AS doctorName, dept.name AS department, a.status " +
                    "FROM appointments a " +
                    "JOIN users u ON a.patient_id = u.id " +
                    "JOIN doctors d ON a.doctor_id = d.id " +
                    "JOIN departments dept ON d.department_id = dept.id " +
                    "WHERE a.patient_id = ?";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, patientId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment app = new Appointment();
                app.setId(rs.getInt("id"));
                app.setPatientId(rs.getInt("patient_id"));
                app.setDoctorId(rs.getInt("doctor_id"));
                app.setAppointmentDate(rs.getDate("appointment_date"));
                app.setAppointmentTime(rs.getTime("appointment_time"));
                app.setPatientName(rs.getString("patientName"));
                app.setDoctorName(rs.getString("doctorName"));
                app.setDepartment(rs.getString("department"));
                app.setStatus(rs.getString("status"));
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    }




