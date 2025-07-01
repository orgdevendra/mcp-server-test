# End-to-End Guide: Deploying Azure Resources with Terraform AVM Modules, GitHub Copilot Agent, and Terraform MCP Server

## Overview
This document provides a step-by-step guide to provisioning and managing Azure resources using Azure Verified Modules (AVM) with Terraform, leveraging GitHub Copilot Agent for AI-powered development, and utilizing the Terraform MCP server for remote operations. The workflow is fully automated via GitHub Actions and is designed for both local and remote (CI/CD) execution.

---

## Introduction
Modern cloud infrastructure development benefits from modular, reproducible, and automated workflows. By combining:

- **Terraform AVM modules** for best-practice, reusable Azure resource definitions,
- **GitHub Copilot Agent** for AI-assisted code generation and troubleshooting,
- **Terraform MCP server** for scalable, remote Terraform execution,
- **VS Code** for a streamlined development environment,

you can rapidly build, test, and deploy robust Azure infrastructure with minimal manual intervention.

---

## Prerequisites
- Azure subscription with required permissions.
- GitHub repository for your infrastructure code.
- VS Code with Copilot Agent and required extensions.
- Docker installed (for local MCP server and workflow compatibility).
- Terraform MCP server image (e.g., `hashicorp/terraform-mcp-server`).
- GitHub Actions secrets set for Azure authentication (`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`, etc.).

---

## VS Code & MCP Server Setup

1. **Configure VS Code for MCP Server:**
   - Open your `settings.json` and add the following configuration:
     ```jsonc
     "mcp": {
       "servers": {
         "terraform": {
           "command": "docker",
           "args": [
             "run",
             "-i",
             "--rm",
             "hashicorp/terraform-mcp-server"
           ]
         },
         "microsoft.docs.mcp": {
           "type": "http",
           "url": "https://learn.microsoft.com/api/mcp"
         }
       }
     }
     ```
   - This enables VS Code to communicate with the Terraform MCP server for remote plan/apply operations.

2. **Start the MCP Server (if running locally):**
   ```sh
   docker run -i --rm hashicorp/terraform-mcp-server
   ```

3. **Install Copilot Agent and Azure extensions in VS Code.**

---

## How the Terraform MCP Server and Microsoft Docs MCP Server Are Used

### Terraform MCP Server
- **Purpose:** The Terraform MCP server provides a remote, scalable, and consistent execution environment for all Terraform operations (init, plan, apply, import, etc.).
- **How it's used:**
  - All Terraform commands in the workflow (including `init`, `plan`, `apply`, and all `import` steps) are executed via Docker using the `hashicorp/terraform-mcp-server` image.
  - This ensures that both local development and CI/CD runs in GitHub Actions use the same Terraform MCP server backend, providing consistent results and easier troubleshooting.
  - The VS Code settings (`settings.json`) are configured to point to the MCP server, so Copilot Agent and other tools can leverage it for remote operations.
- **Example:**
  ```yaml
  - name: Terraform Plan
    run: |
      docker run --rm \
        -e ARM_CLIENT_ID \
        -e ARM_CLIENT_SECRET \
        -e ARM_SUBSCRIPTION_ID \
        -e ARM_TENANT_ID \
        -v ${{ github.workspace }}:/workspace \
        -w /workspace/environments/${{ matrix.env_folder }} \
        hashicorp/terraform:latest plan -input=false -out=tfplan \
        ...var arguments...
  ```
  > All such commands are executed by the MCP server container, not directly on the host or runner.

### Microsoft Docs MCP Server
- **Purpose:** The Microsoft Docs MCP server is used for documentation lookup and AI-powered assistance within VS Code.
- **How it's used:**
  - The VS Code settings include a reference to the Microsoft Docs MCP server endpoint (`https://learn.microsoft.com/api/mcp`).
  - This allows Copilot Agent and other extensions to fetch up-to-date documentation, code samples, and guidance directly from Microsoft Docs while you work.
- **Note:** No infrastructure operations are performed by the Docs MCP server; it is only used for documentation and learning support.

---

## Implementation Steps

### 1. **Project Initialization**

- **Prompt Example:**
  ```
  Create a modular Terraform project for Azure using AVM modules for resource group, storage account (with Data Lake Gen2 and containers), and key vault. Structure the repo for environments (dev/prod) and modules, and prepare for GitHub Actions CI/CD.
  ```

- **Actions:**
  - Use Copilot Agent to scaffold the directory:
    ```
    /modules/resource_group
    /modules/storage_account
    /modules/key_vault
    /environments/dev
    /environments/prod
    ```
  - Generate `main.tf`, `variables.tf`, `outputs.tf` for each module and environment.

### 2. **Module Development**

- **Prompt Example:**
  ```
  Generate AVM-compliant Terraform code for an Azure Storage Account module, including Data Lake Gen2, containers, and folders (bronze, silver, gold).
  ```

- **Actions:**
  - Use Copilot Agent to generate and validate module code.
  - Ensure all variables are parameterized and outputs are defined.

### 3. **Environment Configuration**

- **Prompt Example:**
  ```
  Reference the modules in environments/dev/main.tf and wire up all required variables.
  ```

- **Actions:**
  - Reference modules with correct source paths.
  - Pass variables from environment files.

### 4. **Backend & State Management**

- **Prompt Example:**
  ```
  Add a backend.tf to environments/dev for remote state storage.
  ```

- **Actions:**
  - Configure backend (e.g., Azure Storage Account) for state.

### 5. **GitHub Actions CI/CD Workflow**

- **Prompt Example:**
  ```
  Create a GitHub Actions workflow to run Terraform init, import, plan, and apply using Docker and the MCP server. Include steps to import pre-existing Azure resources.
  ```

- **Actions:**
  - Add `.github/workflows/terraform-mcp.yml`.
  - Ensure secrets are referenced for authentication.
  - Add import steps for all pre-existing resources (resource group, key vault, storage account, containers, Data Lake Gen2 filesystem and paths).
  - Example import command:
    ```yaml
    - name: Terraform Import Data Lake Gen2 Path Bronze
      run: |
        docker run --rm \
          -e ARM_CLIENT_ID \
          -e ARM_CLIENT_SECRET \
          -e ARM_SUBSCRIPTION_ID \
          -e ARM_TENANT_ID \
          -v ${{ github.workspace }}:/workspace \
          -w /workspace/environments/${{ matrix.env_folder }} \
          hashicorp/terraform:latest import \
            ...var arguments... \
            'module.storage_account.azurerm_storage_data_lake_gen2_path.bronze' \
            "https://${{ secrets.TF_STORAGE_ACCOUNT_NAME }}.dfs.core.windows.net/rows/bronze"
    ```

### 6. **Importing Pre-existing Resources**

- **Prompt Example:**
  ```
  Add Terraform import steps for all pre-existing Azure resources so that Terraform manages them and avoids 'resource already exists' errors.
  ```

- **Actions:**
  - Add sequential import steps for each resource.
  - Validate with `terraform plan` that all resources are managed.

### 7. **Testing and Validation**

- **Prompt Example:**
  ```
  Validate the workflow by running it on a feature branch. Ensure all resources are imported and managed, and no 'already exists' errors occur.
  ```

- **Actions:**
  - Run the workflow and check logs.
  - Fix any issues with import addresses or variable passing.

### 8. **Fine-tuning and Maintenance**

- **Prompt Example:**
  ```
  Optimize the workflow for performance and maintainability. Restrict apply to production branches as needed.
  ```

- **Actions:**
  - Refactor workflow for clarity.
  - Add conditions to restrict apply steps.
  - Document any customizations.

---

## Example Prompts for Copilot Agent

- "Scaffold a modular Terraform AVM project for Azure with resource group, storage account, and key vault modules."
- "Generate a GitHub Actions workflow for Terraform with import steps for pre-existing Azure resources."
- "Add import steps for Data Lake Gen2 folders (bronze, silver, gold) to the workflow."
- "Validate all module and environment files for AVM compliance and correct variable wiring."
- "How do I configure VS Code to use the Terraform MCP server for remote operations?"

---

## Best Practices

- Always use AVM modules for consistency and compliance.
- Parameterize all variables for reusability.
- Use import steps for any pre-existing resources to avoid conflicts.
- Store state remotely for team collaboration.
- Use GitHub Actions for automated, repeatable deployments.
- Fine-tune VS Code settings for MCP server integration and Copilot Agent productivity.

---

## Conclusion

By following this guide, you can efficiently develop, test, and deploy Azure infrastructure using Terraform AVM modules, GitHub Copilot Agent, and the Terraform MCP server. This approach ensures best practices, automation, and maintainability for your cloud projects.

---

*Happy automating and building on Azure!*
