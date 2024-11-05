VAULT_FILE=./group_vars/all.yml
VAULT_PASS_FILE=.vault_pass

install-deps:
	ansible-galaxy install -r requirements.yml
# Зашифровать файл
encrypt:
	ansible-vault encrypt --vault-password-file $(VAULT_PASS_FILE) $(VAULT_FILE) --encrypt-vault-id=default
# Расшифровать файл
decrypt:
	ansible-vault decrypt --vault-password-file $(VAULT_PASS_FILE) $(VAULT_FILE)
prepare-servers:
	ansible-playbook playbook.yml --tags=prepare-servers
deploy:
	ansible-playbook playbook.yml --tags=deploy
generate-terraform-vars:
	ansible-playbook terraform.yml