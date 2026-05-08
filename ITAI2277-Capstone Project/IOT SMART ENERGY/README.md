# ⚡ SmartEnergy – IoT Smart Energy Optimization Platform

An AI-powered IoT platform designed to optimize energy consumption for Airbnb properties, small businesses, and multi-site building environments through real-time monitoring, automation, and predictive analytics.

---

## 📌 Overview

SmartEnergy combines IoT sensors, Machine Learning models, and AWS cloud services to create a complete smart energy ecosystem capable of:

- Monitoring electricity usage in real time
- Detecting abnormal energy behavior
- Predicting occupancy using sensor data
- Optimizing operational costs
- Automating HVAC and lighting decisions
- Providing centralized dashboards and AI-powered analytics

This project was developed as a Capstone Project for ITAI-2277.

---

## 👥 Team Members

- Tien Manh Nguyen
- Virginia Mccoy
- Enrique Quintero
- Ali Shan

---

## 🎯 Project Objective

The goal of SmartEnergy is to build an integrated smart energy platform that uses:

- IoT devices for live environmental monitoring
- AI/ML models for prediction and optimization
- AWS cloud infrastructure for scalable deployment
- Automation systems for energy savings

The system helps reduce:
- Excessive electricity consumption
- Unexpected equipment failures
- Energy waste in unoccupied spaces
- Operational costs

---

# 🏗️ System Architecture

The platform is divided into 3 major layers:

## 1️⃣ IoT Sensing Layer

Real-time sensor collection using:

- Shelly EM / Shelly 2.5
- Presence & Motion Sensors
- Lux (Light) Sensors
- Temperature & Humidity Sensors

Collected metrics:
- Energy usage
- Voltage
- Temperature
- Humidity
- Occupancy
- Light levels

---

## 2️⃣ AI Intelligence Layer

Machine Learning models deployed inside AWS Lambda containers.

### Models Used

### 🔹 Failure / Anomaly Detection Model
Detects:
- Voltage spikes
- Overloads
- Unsafe electrical behavior

Model:
- RandomForestClassifier

Features:
- energy_usage
- temperature
- humidity
- voltage

Performance:
- Accuracy: 0.95
- Precision: 0.95
- Recall: 0.95
- F1-Score: 0.95

---

### 🔹 Occupancy Detection Model

Predicts if a room is occupied using:
- Temperature
- Humidity
- CO₂
- Motion
- Sound
- Light level

Outputs:
- 0 = Empty
- 1 = Occupied

Automation Example:
- Empty room → HVAC/Lights OFF
- Occupied room → HVAC/Lights ON

Performance:
- Accuracy: 1.00

---

### 🔹 Cost Optimization Model

Classifies:
- Normal Consumption
- High / Abnormal Consumption

Purpose:
- Energy-saving recommendations
- Detect inefficiencies
- Reduce electricity costs

Performance:
- Accuracy: 0.96

---

## 3️⃣ Cloud Processing & Automation Layer

AWS services used:

- AWS Lambda
- API Gateway
- Amazon RDS
- Amazon ECR
- AWS CloudWatch
- Docker Containers

Flow:
1. IoT sensors send data
2. API Gateway receives payload
3. Lambda executes ML inference
4. Results stored in database
5. Dashboard displays predictions and metrics
6. Automation actions triggered

---

# ☁️ AWS Infrastructure

## 🔹 AWS Lambda (Container-Based)

This project uses Docker-based Lambda containers instead of ZIP deployments.

Benefits:
- Supports large ML libraries
- Faster inference
- Easier dependency management
- Version-controlled deployments

---

## 🔹 API Gateway

Secure endpoint for receiving IoT sensor data and chatbot requests.

---

## 🔹 Amazon RDS

Stores:
- Sensor readings
- Predictions
- Historical analytics
- Occupancy records
- Cost metrics

---

## 🔹 CloudWatch

Used for:
- Logging
- Monitoring
- Error tracking
- Performance metrics

---

# 🤖 AI SQL Chatbot Dashboard

The dashboard includes an AI-powered SQL chatbot that allows users to query energy data using natural language.

Example:
> "Show yesterday’s energy usage for Property A"

The system:
1. Sends the prompt to OpenAI
2. Generates SQL dynamically
3. Executes validated query
4. Returns results and AI-generated summaries

Security Features:
- Query sanitization
- Schema validation
- 30-second execution timeout

---

# 🧠 Features

✅ Real-time energy monitoring  
✅ Occupancy detection  
✅ Predictive anomaly detection  
✅ Cost optimization  
✅ Automated HVAC/light control  
✅ AI-powered dashboard  
✅ Cloud-based architecture  
✅ Multi-property management  
✅ Machine learning inference in AWS Lambda  
✅ Time-series analytics  

---

# 🛠️ Technology Stack

## Programming & AI
- Python
- Scikit-learn
- Pandas
- NumPy

## Cloud & Infrastructure
- AWS Lambda
- API Gateway
- Amazon RDS
- Amazon ECR
- CloudWatch
- Docker

## IoT Hardware
- Shelly EM
- Shelly 2.5
- PIR Motion Sensors
- Lux Sensors
- Temperature Sensors
- Humidity Sensors

## Frontend
- HTML
- JavaScript
- Dashboard UI

---

# 📊 Process Flow

```text
IoT Sensors
     ↓
API Gateway
     ↓
AWS Lambda
     ↓
ML Prediction
     ↓
Database Storage
     ↓
Dashboard & Automation
