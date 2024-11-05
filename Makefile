init:
	make -C terraform init

validate:
	make -C terraform validate

plan:
	make -C terraform plan

apply:
	make -C terraform apply

destroy:
	make -C terraform destroy

prepare-servers:
	make -C ansible prepare-servers

deploy:
	make -C ansible deploy

install-deps:
	make -C ansible install-deps

generate-terraform-vars:
	make -C ansible generate-terraform-vars