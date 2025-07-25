package model;

public class User {
    private int id;
    private String name, email, password, role;
    private String gender;
    private String contact;
    private int age;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    

public String getGender() {
    return gender;
}

public void setGender(String gender) {
    this.gender = gender;
}
public String getContact() {
    return contact;
}
public void setContact(String contact) {
    this.contact = contact;
}

// Getter and Setter for age
public int getAge() {
    return age;
}
public void setAge(int age) {
    this.age = age;
}
}
