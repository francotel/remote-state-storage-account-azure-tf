SHELL := /usr/bin/env bash
.EXPORT_ALL_VARIABLES:

##  ENV  ##
demo:
	$(eval AZ_REGION    = $(shell echo "East US"))

# HOW TO EXECUTE

# Executing Terraform PLAN
#   $ make tf-plan env=dev

# Executing Terraform APPLY
#   $ make tf-apply env=<env>

# Executing Terraform DESTROY
#	$ make tf-destroy env=<env>

#####  TERRAFORM  #####
all-test: clean tf-plan

.PHONY: clean tf-output tf-init tf-plan tf-apply tf-destroy build-ami
	rm -rf .terraform

tf-init: $(env)
	terraform init -reconfigure -upgrade -var="az_region=${AZ_REGION}" && terraform validate 

tf-plan: $(env)
	terraform fmt --recursive && terraform validate && terraform plan -var="az_region=${AZ_REGION}" -out=tfplan

tf-apply: $(env)
	terraform fmt --recursive && terraform validate && terraform apply -auto-approve -parallelism=10 --input=false tfplan

tf-destroy: $(env)
	terraform destroy -var="az_region=${AZ_REGION}"

tf-output: $(env)
	terraform output