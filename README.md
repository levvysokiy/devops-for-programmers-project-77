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