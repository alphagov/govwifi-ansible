aws_profile = govwifi

check-env:
	$(if ${INVENTORY},,$(error Please specify your target environment))

staging-london-frontend:
	$(eval export INVENTORY=frontend_staging)
	$(eval export AWS_REGION=eu-west-2)

staging-dublin-frontend:
	$(eval export INVENTORY=frontend_staging)
	$(eval export AWS_REGION=eu-west-1)

provision: check-env
	AWS_PROFILE=$(aws_profile) \
	AWS_REGION=$(AWS_REGION) \
	ANSIBLE_HOST_KEY_CHECKING=false \
	ansible-playbook -i inventory \
		playbooks/frontend.yml \
		--limit $(INVENTORY)
