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