---
mode: agent
description: End-to-end Azure infrastructure provisioning and AVM module management with Terraform, Copilot Agent, and Terraform MCP server.
---

# Provision and Manage Azure Resources with Terraform AVM Modules and MCP Server

## Supported Tools
This workflow leverages the following tools and capabilities:
- Terraform
- GitHub Actions
- Azure CLI
- Terraform MCP Server
- Linter (e.g., tflint)
- Documentation fetchers
- Semantic versioning (semver)
- HTTP requests
- Table/Markdown formatting
- CI/CD automation
- Registry/version checkers
- Changelog/review utilities
- Plan, validate, update, import, and test commands

## Task
Provision and manage Azure resources using modular, AVM-compliant Terraform code, leveraging GitHub Copilot Agent for code generation and the Terraform MCP server for remote execution. Automate the workflow via GitHub Actions for both local and CI/CD scenarios.

## Process
1. **Scan**: Extract all AVM module sources and current versions from Terraform files (e.g., `main.tf`, `modules/*`).
2. **Check**: Fetch the latest available versions for each AVM module from the [Terraform Registry](https://registry.terraform.io/).
3. **Compare**: Parse and compare semantic versions to identify available updates for each module.
4. **Review**: For potential breaking changes, fetch and review the module changelog or documentation from the module's [GitHub repository](https://github.com/Azure/terraform-azurerm-avm-res-keyvault) or registry page.
5. **Update**: Apply version updates and adjust module parameters as required.
   - **If using a local module as a dependency, ensure the referenced directory exists and is committed to the repository.**
   - **If using a registry module, ensure the source is correct and the module is published.**
   - **Do not reference a local module path that does not exist, or you will get an 'Unreadable module directory' error.**
6. **Validate**: Run `terraform validate` and, if available, a linter (e.g., `tflint`) to ensure code and configuration compliance. Optionally, run `terraform plan` to preview changes.
7. **Test**: Execute the CI/CD workflow on a feature branch to ensure all resources are managed and no errors occur (e.g., 'resource already exists').
8. **Optimize & Maintain**: Refactor the workflow for clarity and maintainability. Restrict apply steps to production branches as needed. Document any customizations.

## Output Format
Display results in a table with icons:

| Module | Current Version | Latest Version | Status | Action | Docs |
|--------|----------------|---------------|--------|--------|------|
| avm/modules/example | 0.1.0 | 0.2.0 | 🔄 | Updated | 📖 |
| avm/modules/another | 0.3.0 | 0.3.0 | ✅ | Current | 📖 |

- 🔄 Updated
- ✅ Current
- ⚠️ Manual review required
- ❌ Failed
- 📖 Documentation

## Breaking Change Policy
Pause for approval if updates involve:
- Incompatible parameter changes
- Security/compliance modifications
- Behavioral changes

## Requirements
- Use AVM modules for all Azure resources
- Parameterize all variables
- Use import steps for pre-existing resources
- Store state remotely
- Automate with GitHub Actions
- Maintain Terraform and workflow validity

## Strict Variable Naming Convention Requirement

> **All variable names must be consistent and strictly matched across every layer of the project:**
> - **Terraform modules** (e.g., `modules/azure_sql_database/variables.tf`)
> - **Root environment files** (e.g., `environments/dev/variables.tf`)
> - **Workflow YAML** (e.g., `.github/workflows/terraform-mcp.yml`)
> - **GitHub secrets** (used for CI/CD)
>
> **This is a mandatory requirement.**
> - Every variable name must be identical in spelling, case, and underscores across all files and configuration layers.
> - Any new resource, module, or workflow must strictly adhere to this convention.
> - The prompt file and all documentation must reinforce this rule.
>
> **If you update or add variables, you must update all relevant files and secrets to match.**
> - Inconsistencies will cause deployment failures or misconfigurations.

## References
- [Terraform Registry](https://registry.terraform.io/)
- [AVM Modules](https://github.com/Azure/terraform-azurerm-avm-res-keyvault)
- [Terraform MCP Server](https://github.com/hashicorp/terraform-mcp-server)
- [VS Code Copilot Prompt Files](https://code.visualstudio.com/docs/copilot/copilot-customization#_prompt-files-experimental)
- [Reference Prompt](https://github.com/PlagueHO/github-copilot-assets-library/blob/main/prompts/update_avm_modules_in_bicep.prompt.md)

## Next Steps
After scaffolding a new AVM-compliant module:
1. **Reference the Module in main.tf**: Open the appropriate environment's `main.tf` file (e.g., `environments/dev/main.tf`).
   - Add the new module block for your resource (e.g., Azure SQL Database) **after the resource group module and before any dependent modules**.
   - Wire up all required variables, using outputs from previous modules as needed (e.g., use `module.resource_group.name` for `resource_group_name`).
   - Only modules referenced in `main.tf` will be deployed by Terraform and your CI/CD pipeline.
2. **Commit and Push**: Commit your changes and push them to your GitHub repository.
3. **CI/CD Deployment**: The GitHub Actions workflow will automatically detect and deploy the new resource, following your project's CI/CD process and branch protection rules.
4. **Monitor and Validate**: Monitor the workflow run for successful deployment and validate the resource in Azure.
5. **Iterate as Needed**: Make any necessary adjustments, update variables, or add outputs as your requirements evolve.

> **Note:** If you do not add the new module block to `main.tf`, the resource will not be created or managed, even if the module exists in your repository.

## Guided Workflow
When you request a new resource (e.g., "Add an AVM-compliant module for Azure Cosmos DB"), you will be guided through each required step until the resource is successfully deployed:

1. **Scaffold the Module**: The module code will be generated in the `modules/` directory.
2. **Reference in main.tf**: You will be prompted to add the module block to the appropriate environment's `main.tf` (with clear placement and variable wiring instructions).
3. **Update Variables**: You will be prompted to add any new variables to the environment's `variables.tf` and provide values as needed.
4. **Commit and Push**: You will be reminded to commit and push your changes to the repository.
5. **CI/CD Monitoring**: You will be prompted to monitor the GitHub Actions workflow for successful deployment.
6. **Validation**: You will be prompted to validate the resource in Azure and make any necessary adjustments.

> **You will not be left at any step—each action will be prompted until the resource is fully deployed and validated.**

## Guided Workflow: Import Pre-existing SQL Server and Database
If you are deploying to an environment where the Azure SQL Server or Database already exists, you must import them into the Terraform state before running plan/apply. This is handled automatically in the workflow, but you can also run the following commands locally:

# Import SQL Server
terraform import \
  module.azure_sql_database.azurerm_mssql_server.this \
  "/subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.Sql/servers/<sql_server_name>"

# Import SQL Database
terraform import \
  module.azure_sql_database.azurerm_mssql_database.this \
  "/subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.Sql/servers/<sql_server_name>/databases/<sql_database_name>"

This ensures Terraform will manage the existing resources and avoid 'resource already exists' errors. If the resources do not exist, Terraform will create them as usual.

---

*Happy automating and building on Azure!*
