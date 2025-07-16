// src/dao/DoctorDAO.java
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Doctor;
import util.DBConnection;

public class DoctorDAO {
    private Connection conn;

    public DoctorDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinic_db", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Doctor> getAllDoctors() {
        List<Doctor> list = new ArrayList<>();
        try {
            String query = "SELECT d.id, d.name, d.email, dept.name AS departmentName " +
                           "FROM doctors d JOIN departments dept ON d.department_id = dept.id";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Doctor doc = new Doctor();
                doc.setId(rs.getInt("id"));
                doc.setName(rs.getString("name"));
                doc.setEmail(rs.getString("email"));
                doc.setDepartmentName(rs.getString("departmentName"));
                list.add(doc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertDoctor(String name, String email, int departmentId) {
        Connection con = null;
        PreparedStatement psDoctor = null;
        PreparedStatement psUser = null;
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinic_db", "root", "");
            con.setAutoCommit(false);  // Start transaction

            // Insert into doctors table
            String doctorQuery = "INSERT INTO doctors (name, email, department_id) VALUES (?, ?, ?)";
            psDoctor = con.prepareStatement(doctorQuery);
            psDoctor.setString(1, name);
            psDoctor.setString(2, email);
            psDoctor.setInt(3, departmentId);
            psDoctor.executeUpdate();

            // Insert into users table with NULL password
            String userQuery = "INSERT INTO users (name, email, password, role) VALUES (?, ?, NULL, 'doctor')";
            psUser = con.prepareStatement(userQuery);
            psUser.setString(1, name);
            psUser.setString(2, email);
            psUser.executeUpdate();

            con.commit();  // Success
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try { if (con != null) con.rollback(); } catch (SQLException ignored) {}
            return false;
        } finally {
            try { if (psDoctor != null) psDoctor.close(); } catch (SQLException ignored) {}
            try { if (psUser != null) psUser.close(); } catch (SQLException ignored) {}
            try { if (con != null) con.close(); } catch (SQLException ignored) {}
        }
    }
    
    public boolean updateDoctor(int id, String name, String email, int deptId) {
        try {
            Connection conn = DBConnection.getConnection();
            String query = "UPDATE doctors SET name = ?, email = ?, department_id = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setInt(3, deptId);
            ps.setInt(4, id);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteDoctor(int id) {
        try {
            String sql = "DELETE FROM doctors WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }




}
