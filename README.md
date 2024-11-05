### Hexlet tests and linter status:
[![Actions Status](https://github.com/levvysokiy/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/levvysokiy/devops-for-programmers-project-77/actions)

https://vysokiylev.xyz

## Requirements

- ansible
- terraform
- make

## Commands

- `make init` - terraform initialization
- `make validate` - validate terraform configuration
- `make plan` - create terraform execution plan
- `make apply` - create resources
- `make destroy` - destroy resources
- `make prepare-servers` - install required packages to the machines
- `make deploy` - execute ansible playbook
- `make generate-terraform-vars` - generate file with variable values for terraform

## How to run a project

### Setup Ansible

1. Install Ansible requirements: `make install-deps`
2. Create file with vault password at the directory `./ansible/` with name `.vault_pass` and put a vault password there
3. Encrypt vault: `make encrypt`

### Generating Terraform variables
Generation is performed using the `make generate-terraform-vars` command.

### Terraform initialization
To initialize terraform project run `make init`

### Terraform apply infrastructure
To syncronize terraform changes run `make apply`

### Servers preparation
To install required packages on the servers run `make prepare-servers`

### Deploy
To deploy app to the servers `make deploy`
