package EstorePackage;

import java.sql.Timestamp;

public class InquiryModel {
    private int id;
    private int customerId;
    private String subject;
    private String message;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String response;
    private Timestamp responseDate;
    
    public InquiryModel(int id, int customerId, String subject, String message, String status, 
                       Timestamp createdAt, Timestamp updatedAt, String response, Timestamp responseDate) {
        this.id = id;
        this.customerId = customerId;
        this.subject = subject;
        this.message = message;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.response = response;
        this.responseDate = responseDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public Timestamp getResponseDate() {
        return responseDate;
    }

    public void setResponseDate(Timestamp responseDate) {
        this.responseDate = responseDate;
    }
    
    

}