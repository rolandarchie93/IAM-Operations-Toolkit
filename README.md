# IAM Operations Toolkit

This repository contains PowerShell automation scripts designed to support common Identity & Access Management (IAM) operational tasks in Active Directory environments.

The goal of this toolkit is to simulate real-world IAM workflows such as user provisioning, secure offboarding, and access auditing.

These scripts were developed as part of a hybrid identity lab environment using Active Directory and Microsoft Entra ID.

---

## Repository Structure

scripts/

New-IAMUser.ps1  
Automates user provisioning in Active Directory.

Disable-IAMUser.ps1  
Handles secure offboarding by disabling accounts and removing access.

Get-GroupAudit.ps1  
Exports group membership data for access review and auditing.

---

## IAM Operations Covered

User provisioning  
Account de-provisioning  
Access control validation  
Group membership auditing  
Identity lifecycle management

---

## Lab Environment

Windows Server 2022  
Active Directory Domain Services  
RBAC-based OU structure  
Hybrid identity integration with Microsoft Entra ID

---

## Purpose

This project demonstrates how IAM administrators can automate repetitive identity management tasks using PowerShell.

Automation improves consistency, reduces human error, and enables scalable identity governance in enterprise environments.
