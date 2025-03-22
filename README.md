# Task Manager API

## **📌 Overview**
This project is a **task management API** that allows users to **sign up, log in, create, view, update, and delete tasks**. The API is protected with **token-based authentication** using Devise.

## **📽️ API Testing Video**
Watch the API testing in action: [Click here to view the video](https://drive.google.com/file/d/15iLngr31YXQj4Cpb5P-C766vZHEV3DO-/view?usp=sharing)

## **📑 Documentation**
- **API Testing Documentation**: [API_Testing_Documentation.md](API_Testing_Documentation.md)
- **Completion Report**: [Completion_Report.md](Completion_Report.md)

## **📝 Test Accounts**
| **Role** | **Email** | **Password** |
|----------|----------|--------------|
| **Alice** | `alice@example.com` | `password` |
| **Bob** | `bob@example.com` | `password` |
| **Cassy** | `cassy@example.com` | `password` |

## **🛠️ Installation Guide**
### **🔹 Prerequisites**
Ensure you have the following installed:
- **Ruby (3.x)**
- **Rails (7.x)**
- **PostgreSQL**
- **Heroku CLI**

---

### **🔹 1. Clone the Repository**
```sh
git clone https://github.com/CynthiaaLee/task_manager_phase2.git
cd task_manager_phase2
```

### **🔹 2. Install Dependencies**
```sh
bundle install
```

### **🔹 3. Set Up the Database**
```sh
rails db:create
rails db:migrate
rails db:seed
```

### **🔹 4. Start the Server**
```sh
rails server
```
Visit **http://localhost:3000** in your browser.

