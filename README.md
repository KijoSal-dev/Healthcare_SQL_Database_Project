# Healthcare_SQL_Database_Project

# Healthcare SQL Database Project

A comprehensive SQL mini project demonstrating database queries and analytics for a healthcare management system. This project includes analysis of patient data, appointments, medications, billing, and doctor information.

## 📋 Project Overview

This project contains SQL queries that solve real-world healthcare analytics problems such as:
- Patient location and demographic queries
- Appointment scheduling and completion analysis
- Doctor performance metrics and revenue tracking
- Medication and diagnosis management
- Billing and financial reporting

## 🚀 Approach Summary
1. Designed a relational healthcare database structure (patients, doctors, appointments, billing, etc.).
2. Wrote SQL queries to solve real-world healthcare analytics problems.
3. Used JOINs to connect multiple tables for comprehensive insights.
4. Applied aggregate functions (COUNT, SUM) and GROUP BY for reporting.
5. Implemented filtering, ranking, and date-based analysis for performance tracking.
6. Focused on practical, decision-support insights like revenue, diagnosis trends, and appointment efficiency.  

## 📊 Database Tables

The project works with the following main tables:
- `healthcare_patients` - Patient demographic information
- `healthcare_doctors` - Doctor profiles and clinic locations
- `healthcare_appointments` - Appointment records and status
- `healthcare_medications` - Medication inventory with dosages
- `healthcare_diagnoses` - Diagnosis codes and records
- `healthcare_billing` - Billing and payment information

## 🔍 Key Queries

The project includes 10 analytical queries:

1. **List patients by location** - Find all patients in a specific city
2. **Filter medications by dosage** - Find high-dosage medications
3. **Completed appointments** - Query appointments by status and date range
4. **Doctor appointment statistics** - Count completed appointments per doctor
5. **Common diagnoses** - Identify the most frequent diagnosis in the database
6. **Patient billing summary** - Calculate total billing amounts per patient
7. **Clinic performance** - Find the clinic with the highest appointment volume
8. **Multi-diagnosis patients** - Identify patients with multiple diagnoses
9. **Doctor revenue ranking** - Rank doctors by total revenue generated
10. **Recent appointments** - Display each patient's most recent appointment

## 🛠️ Technologies

- **SQL** - Database querying and analysis
- **Database** - Compatible with MySQL, SQL Server, or similar relational databases

## 📝 Usage

1. Load the SQL file into your database management tool
2. Execute individual queries to analyze specific healthcare metrics
3. Modify WHERE clauses and parameters as needed for your specific data

## 📈 Use Cases

- **Healthcare Analytics** - Analyze patient visits and trends
- **Revenue Analysis** - Track doctor performance and billing metrics
- **Quality Assurance** - Monitor appointment completion rates and diagnosis patterns
- **Resource Planning** - Identify clinic utilization and staffing needs

## 💡 Learning Outcomes

This project demonstrates:
- JOIN operations across multiple tables
- Aggregate functions (COUNT, SUM)
- GROUP BY and HAVING clauses
- Date range filtering
- Window functions and ranking
- Data aggregation and reporting

## 📌 Notes

- All dates should be in the format specified by your database system
- Ensure proper indexes are created for optimal query performance
- Some queries use LEFT JOIN to include records with null values
- Modify LIMIT clauses as needed for your dataset size

## 👨‍💻 Author

Healthcare SQL Mini Project

## 📄 License

This project is provided as-is for educational purposes.
