package model;

import java.util.List;
import model.DoctorAvailability;

public class Doctor {
    private int id;
    private String name;
    private String email;
    private int departmentId;
    private String departmentName;

    private int userId; // 🔹 Add this line
    private List<DoctorAvailability> availabilityList;

    // --- Getters ---
    public int getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public int getDepartmentId() { return departmentId; }
    public String getDepartmentName() { return departmentName; }
    public int getUserId() { return userId; } // 🔹 Add this

    public List<DoctorAvailability> getAvailabilityList() {
        return availabilityList;
    }

    // --- Setters ---
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setDepartmentId(int departmentId) { this.departmentId = departmentId; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
    public void setUserId(int userId) { this.userId = userId; } // 🔹 Add this

    public void setAvailabilityList(List<DoctorAvailability> availabilityList) {
        this.availabilityList = availabilityList;
    }
}
