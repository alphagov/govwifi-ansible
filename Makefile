aws_profile = govwifi

check-env:
	$(if ${INVENTORY},,$(error Please specify your target environment))

staging-london-frontend:
	$(eval export ANSIBLE_ENV=staging)
	$(eval export INVENTORY=frontend_staging_london)
	$(eval export AWS_REGION=eu-west-2)

staging-dublin-frontend:
	$(eval export ANSIBLE_ENV=staging) # for production this will be wifi
	$(eval export INVENTORY=frontend_staging_dublin)
	$(eval export AWS_REGION=eu-west-1)

production-london-frontend:
	$(eval export ANSIBLE_ENV=wifi)
	$(eval export INVENTORY=frontend_production_london)
	$(eval export AWS_REGION=eu-west-2)

production-dublin-frontend:
	$(eval export ANSIBLE_ENV=wifi)
	$(eval export INVENTORY=frontend_production_dublin)
	$(eval export AWS_REGION=eu-west-1)

provision: check-env
	AWS_PROFILE=$(aws_profile) \
	AWS_REGION=$(AWS_REGION) \
	ANSIBLE_HOST_KEY_CHECKING=false \
	ansible-playbook -i inventory \
		playbooks/frontend.yml \
		--limit $(INVENTORY) \
		$(if $(TAGS),--tags "$(TAGS)",)
