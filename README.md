# IAM Operations Toolkit

This repository contains PowerShell automation scripts designed to support common Identity & Access Management (IAM) operational workflows in Active Directory environments.

The goal of this project is to simulate real-world identity lifecycle management processes, including automated user provisioning, secure offboarding, and access auditing.

These scripts were developed within a hybrid identity lab environment using Active Directory and Microsoft Entra ID to demonstrate how IAM teams automate identity operations in enterprise environments.

# IAM Problem

Manual identity administration introduces several risks:
- Inconsistent user provisioning
- Excessive access permissions
- Delayed deprovisioning of accounts
- Lack of audit visibility into group memberships
IAM automation helps reduce these risks by enforcing standardized identity workflows and RBAC-based access control.

# Solution

This toolkit provides Powershell automation scripts that simulate IAM operational tasks:
- Automated user provisioning
- Secure account deactivation
- Group membership auditing
- Enforcement of role-based access control (RBAC)
The scripts demonstrate how IAM teams can automate identity lifecycle processes while improving operational consistency and security visibility.

---

## Repository Structure

scripts/

scripts/

New-IAMUser.ps1
Automates user provisioning in Active Directory.

Disable-IAMUser.ps1
Handles secure offboarding by disabling accounts and removing access.

Get-GroupAudit.ps1
Exports group membership data for access review and auditing.

---

## IAM Workflows Demonstrated

- Joiner process (user provisioning)
- Mover process (role / access changes)
- Leaver process (account deprovisioning)
- RBAC-based group access management
- Identity access auditing

These workflows represent the core identity lifecycle model used in enterprise IAM programs.

---

# Lab Architecture
Example identity provisioning flow:

HR Request
     ↓
PowerShell IAM Provisioning Script
     ↓
Active Directory User Creation
     ↓
Security Group Assignment (RBAC)
     ↓
User Access to Enterprise Resources

---

# Lab Environment

Windows Server 2022
Active Directory Domain Services
RBAC-based OU structure
Hybrid identity integration with Microsoft Entra ID
PowerShell automation scripts

---

# Security and Governance Concepts Demonstrated

- Role-Based Access Control (RBAC)
- Least privilege access design
- Identity lifecycle management (Joiner-Mover-Leaver)
- Access review and group auditing
- IAM automation for operational consistency

---

# Purpose

This project demonstrates how IAM administrators can automate repetitive identity management tasks using PowerShell.
Automation improves:
- Identity governance
- Operational efficiency
- Security consistency
- Access auditing capabilities
This lab was built to simulate IAM operational workflows commonly used in enterprise identity platforms.
