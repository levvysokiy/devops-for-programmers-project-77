VAULT_FILE=.ansible/group_vars/webservers/vault.yml
VAULT_PASS_FILE=./ansible/.vault_pass

install-deps:
	ansible-galaxy install -r ./ansible/requirements.yml
# Зашифровать файл
encrypt:
	ansible-vault encrypt --vault-password-file $(VAULT_PASS_FILE) $(VAULT_FILE)
# Расшифровать файл
decrypt:
	ansible-vault decrypt --vault-password-file $(VAULT_PASS_FILE) $(VAULT_FILE)
prepare-servers:
	ansible-playbook ./ansible/playbook.yml --tags=prepare-servers
deploy:
	ansible-playbook ./ansible/playbook.yml --tags=deploy