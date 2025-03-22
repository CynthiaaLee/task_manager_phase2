# API Testing Documentation

This document provides step-by-step testing procedures for the Task Manager API using **cURL** commands and expected responses.

---

## **1. User Signup Test**
### **📌 Test Case: Successful Signup**
**Request:**
```bash
curl -X POST http://localhost:3000/api/users \
     -H "Content-Type: application/json" \
     -d '{
           "user": {
             "email": "test_signup@gmail.com",
             "password": "password",
             "password_confirmation": "password"
           }
         }'
```
#### **Expected Response (201 Created)**
```json
{
    "user": {
        "id": 4,
        "name": null,
        "email": "test_signup@gmail.com",
        "authentication_token": "54666b55978ed93ac5f7120ea57185ca2c62d1a4",
        "created_at": "2025-03-22T02:37:46.854Z",
        "updated_at": "2025-03-22T02:37:46.854Z"
    },
    "token": "54666b55978ed93ac5f7120ea57185ca2c62d1a4"
}
```

### **📌 Test Case: Duplicate Email Signup**
**Request:** (Same as above)

#### **Expected Response (422 Unprocessable Entity)**
```json
{
    "errors": [
        "Email has already been taken"
    ]
}
```

---

## **2. User Login Test**
### **📌 Test Case: Successful Login**
**Request:**
```bash
curl -X POST http://localhost:3000/api/users/sign_in \
     -H "Content-Type: application/json" \
     -d '{
           "user": {
             "email": "test_signup@gmail.com",
             "password": "password"
           }
         }'
```
#### **Expected Response (200 OK)**
```json
{
  "user": {
    "id": 4,
    "email": "test_signup@gmail.com",
    "authentication_token": "54666b55978ed93ac5f7120ea57185ca2c62d1a4"
  }
}
```

---

## **3. User Logout Test**
### **📌 Test Case: Successful Logout**
**Request:**
```bash
curl -X DELETE http://localhost:3000/api/users/sign_out \
     -H "Authorization: Bearer 54666b55978ed93ac5f7120ea57185ca2c62d1a4"
```
#### **Expected Response (200 OK)**
```json
{
  "message": "User logged out successfully"
}
```

### **📌 Test Case: Logout Again (Invalid Token)**
**Request:**
```bash
curl -X DELETE http://localhost:3000/api/users/sign_out \
     -H "Authorization: Bearer 54666b55978ed93ac5f7120ea57185ca2c62d1a4"
```
#### **Expected Response (401 Unauthorized)**
```json
{
  "error": "Unauthorized - Invalid Token"
}
```
---

## **4. Update User Name Test**
### **📌 Test Case: Successfully Update Name**
**Request:**
```bash
curl -X POST http://localhost:3000/api/users/update_name \
     -H "Authorization: Bearer 18105267f335e9765dd29ec0e66c0616d23dce79" \
     -H "Content-Type: application/json" \
     -d '{"name": "New Username"}'
```
#### **Expected Response (200 OK)**
```json
{
    "user": {
        "name": "New Username",
        "email": "test_signup@gmail.com",
        "id": 4,
        "authentication_token": "18105267f335e9765dd29ec0e66c0616d23dce79",
        "created_at": "2025-03-22T02:37:46.854Z",
        "updated_at": "2025-03-22T02:50:34.903Z"
    },
    "message": "Name updated successfully"
}
```


---
## **5. Get All Tasks Test**
### **📌 Test Case: Retrieve Tasks (Authenticated User)**
**Request:**
```bash
curl -X GET http://localhost:3000/api/tasks \
     -H "Authorization: Bearer 18105267f335e9765dd29ec0e66c0616d23dce79"
```
#### **Expected Response (200 OK)**
```json
[
    {
        "id": 3,
        "title": "Complete Phase 1",
        "description": "Finish all Phase 1 requirements",
        "due_date": "2025-03-26",
        "status": "In Progress",
        "user_id": 3,
        "created_at": "2025-03-22T02:34:39.049Z",
        "updated_at": "2025-03-22T02:34:39.049Z"
    },
    {
        "id": 2,
        "title": "Submit Project",
        "description": "Upload the final project files",
        "due_date": "2025-03-20",
        "status": "Completed",
        "user_id": 2,
        "created_at": "2025-03-22T02:34:39.042Z",
        "updated_at": "2025-03-22T02:34:39.042Z"
    },
    {
        "id": 1,
        "title": "Prepare for Meeting",
        "description": "Review notes for the team meeting",
        "due_date": "2025-03-23",
        "status": "Not Started",
        "user_id": 1,
        "created_at": "2025-03-22T02:34:39.025Z",
        "updated_at": "2025-03-22T02:34:39.025Z"
    }
]
```

### **📌 Test Case: Retrieve Tasks (Unauthorized)**
**Request:**
```bash
curl -X GET http://localhost:3000/api/tasks
```
#### **Expected Response (401 Unauthorized)**
```json
{
  "error": "Unauthorized - Invalid Token"
}
```

---

## **6. Create Task Test**
### **📌 Test Case: Successfully Create a Task**
**Request:**
```bash
curl -X POST http://localhost:3000/api/tasks \
     -H "Authorization: Bearer 18105267f335e9765dd29ec0e66c0616d23dce79" \
     -H "Content-Type: application/json" \
     -d '{
           "task": {
             "title": "New Task",
             "description": "This is a new task",
             "status": "Not Started",
             "due_date": "2025-03-30"
           }
         }'
```
#### **Expected Response (201 Created)**
```json
{
    "id": 4,
    "title": "New Task",
    "description": "This is a new task",
    "due_date": "2025-03-30",
    "status": "Not Started",
    "user_id": 4,
    "created_at": "2025-03-22T02:58:33.391Z",
    "updated_at": "2025-03-22T02:58:33.391Z"
}
```

### **📌 Test Case: Create Task Without Authentication**
**Request:**
```bash
curl -X POST http://localhost:3000/api/tasks \
     -H "Content-Type: application/json" \
     -d '{
           "task": {
             "title": "New Task",
             "description": "This is a new task",
             "status": "Not Started",
             "due_date": "2025-03-30"
           }
         }'
```
#### **Expected Response (401 Unauthorized)**
```json
{
  "error": "Unauthorized - Invalid Token"
}
```

---

## **7. Delete Task Test**
### **📌 Test Case: Successfully Delete a Task**
**Request:**
```bash
curl -X DELETE http://localhost:3000/api/tasks/4 \
     -H "Authorization: Bearer 18105267f335e9765dd29ec0e66c0616d23dce79"
```
#### **Expected Response (200 OK)**
```json
{
  "message": "Task deleted successfully"
}
```

### **📌 Test Case: Attempt to Delete a Task That Belongs to Another Usern**
**Request:**
```bash
curl -X DELETE http://localhost:3000/api/tasks/3 \
     -H "Authorization: Bearer 18105267f335e9765dd29ec0e66c0616d23dce79"
```
#### **Expected Response (403 Forbidden)**
```json
{
  "error": "You do not have permission to delete this task"
}
```
### **📌 Test Case: Delete Task With Wrong Token**
**Request:**
```bash
curl -X DELETE http://localhost:3000/api/tasks/3 \
     -H "Authorization: Bearer Token123"
```
#### **Expected Response (403 Forbidden)**
```json
{
    "error": "Unauthorized - Invalid Token"
}
```
### **📌 Test Case: Delete a Non-Existing Task**
**Request:**
```bash
curl -X DELETE http://localhost:3000/api/tasks/999 \
     -H "Authorization: Bearer 18105267f335e9765dd29ec0e66c0616d23dce79"
```
#### **Expected Response (404 Not Found)**
```json
{
  "error": "Task not found"
}
```
---
## **✅ Summary of Tests**

| **Test Case**                          | **Method** | **Endpoint**         | **Expected Response**        |
|-----------------------------------------|-----------|----------------------|------------------------------|
| **User Signup (Success)**               | POST      | `/users`             | 201 Created                  |
| **User Signup (Duplicate Email)**       | POST      | `/users`             | 422 Unprocessable Entity     |
| **User Login (Success)**                | POST      | `/users/sign_in`     | 200 OK                        |
| **User Logout (Success)**               | DELETE    | `/users/sign_out`    | 200 OK                        |
| **User Logout (Invalid Token)**         | DELETE    | `/users/sign_out`    | 401 Unauthorized              |
| **Update User Name (Success)**          | PATCH     | `/users/update_name` | 200 OK                        |
| **Get Tasks (Authenticated)**           | GET       | `/tasks`             | 200 OK                        |
| **Get Tasks (Unauthorized)**            | GET       | `/tasks`             | 401 Unauthorized              |
| **Create Task (Success)**               | POST      | `/tasks`             | 201 Created                   |
| **Create Task (Unauthorized)**          | POST      | `/tasks`             | 401 Unauthorized              |
| **Delete Task (Success)**               | DELETE    | `/tasks/:id`         | 200 OK                        |
| **Delete Task (Unauthorized)**          | DELETE    | `/tasks/:id`         | 403 Forbidden                 |
| **Delete Task (Wrong Token)**           | DELETE    | `/tasks/:id`         | 403 Forbidden                 |
| **Delete Task (Non-Existing)**          | DELETE    | `/tasks/999`         | 404 Not Found                 |
| **Delete Task (Belongs to Another User)** | DELETE  | `/tasks/:id`         | 403 Forbidden                 |

