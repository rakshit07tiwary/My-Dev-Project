# My-Dev-Project

Project template for deploying Azure infrastructure using Terraform modules and environment-specific configurations.

**Overview:**
- **Purpose:** Reusable Terraform modules to create an Azure Resource Group, Virtual Network, Subnet, Network Interface and Virtual Machine. Environments (dev/qa/prod) consume the modules with environment-specific variables.

**Prerequisites:**
- Install Terraform >= 1.9.0
- An Azure account and credentials configured for the AzureRM provider (Service Principal, Managed Identity, or Azure CLI)

**Repository Layout:**
- modules/: Reusable Terraform modules
	- resource-group/: creates an Azure Resource Group
	- virtual_network/: creates an Azure Virtual Network
	- subnet/: creates an Azure Subnet and outputs `subnet_id`
	- virtual_machine/: creates an Azure VM (depends on NIC and subnet)
- environments/: environment-specific stacks that instantiate the modules
	- dev/, qa/, prod/: each contain `main.tf`, `provider.tf`, `variable.tf`, and `terraform.tfvars` for that environment

**Provider & Versioning:**
- Each environment defines the `azurerm` provider and required Terraform version. Example: `required_version = ">= 1.9.0"` and `azurerm` provider `~> 4.0` (see environment provider.tf files).

**Usage (quick start):**
1. Change to the environment folder you want to deploy, for example:

```bash
cd environments/dev
```

2. Initialize Terraform (installs providers and prepares the working directory):

```bash
terraform init
```

3. Preview changes:

```bash
terraform plan -var-file=terraform.tfvars
```

4. Apply changes:

```bash
terraform apply -var-file=terraform.tfvars
```

**Variables and Inputs:**
- Each environment defines objects for modules in `variable.tf` (for example `rg`, `vnet`, `subnet`, `VM`). Provide values in the environment's `terraform.tfvars` file.
- The VM module expects a `VM` object containing `prefix`, `vm_name`, `resource_group_name`, `location`, `vm_size`, `admin_username`, and `ssh_public_key_path`.

**Outputs:**
- The `subnet` module exports `subnet_id` which is consumed by the NIC/VM modules.

**Security notes & recommendations:**
- Do not hardcode credentials or sensitive values in files committed to the repo. Use environment variables, a secure secrets manager, or Terraform Cloud/Backend with state encryption.
- The VM module currently contains an `admin_password` placeholder in the example VM configuration — replace this and prefer SSH keys (`ssh_public_key_path`) and disable password authentication.

**Extending the stack:**
- Add new modules under `modules/` and reference them from environment `main.tf` files.
- Keep module interfaces (variable and outputs) small and explicit to maximize reusability.

**Troubleshooting:**
- If you see provider version issues, ensure the provider versions in the environment `provider.tf` match your installed provider plugin. Run `terraform init -upgrade` to refresh plugins.

If you want, I can commit this README update and create an example `dev/terraform.tfvars` or add a short `Makefile` to simplify the common commands.