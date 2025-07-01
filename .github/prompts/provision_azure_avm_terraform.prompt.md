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

## References
- [Terraform Registry](https://registry.terraform.io/)
- [AVM Modules](https://github.com/Azure/terraform-azurerm-avm-res-keyvault)
- [Terraform MCP Server](https://github.com/hashicorp/terraform-mcp-server)
- [VS Code Copilot Prompt Files](https://code.visualstudio.com/docs/copilot/copilot-customization#_prompt-files-experimental)
- [Reference Prompt](https://github.com/PlagueHO/github-copilot-assets-library/blob/main/prompts/update_avm_modules_in_bicep.prompt.md)

## Next Steps
After scaffolding a new AVM-compliant module:
1. **Reference the Module**: Add a module block for your new resource in the appropriate environment's `main.tf` (e.g., `environments/dev/main.tf`), wiring up all required variables.
2. **Commit and Push**: Commit your changes and push them to your GitHub repository.
3. **CI/CD Deployment**: The GitHub Actions workflow will automatically detect and deploy the new resource, following your project's CI/CD process and branch protection rules.
4. **Monitor and Validate**: Monitor the workflow run for successful deployment and validate the resource in Azure.
5. **Iterate as Needed**: Make any necessary adjustments, update variables, or add outputs as your requirements evolve.

---

*Happy automating and building on Azure!*
