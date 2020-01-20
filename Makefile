IMAGE_NAME=luisync
INSTANCE_USER=ubuntu
AWS_ACCESS_KEY=PLACEHOLDER
AWS_SECRET_KEY=PLACEHOLDER
INSTANCE_DNS=PLACEHOLDER
INSTANCE_LOGIN=$(INSTANCE_USER)@$(INSTANCE_DNS)
PROJECT_FULL_PATH=PLACEHOLDER


build-local:
	docker build --rm -t $(IMAGE_NAME) -f Dockerfile .

bash-local:
	docker run -it $(IMAGE_NAME) bin/bash

create-aws-image:
	docker run -it -v ${PWD}/aws-image-template.json:/home/ubuntu/aws-image-template.json -v ${PWD}/serverconfig.sh:/home/ubuntu/serverconfig.sh $(IMAGE_NAME) packer build -var 'aws_access_key=$(AWS_ACCESS_KEY)' -var 'aws_secret_key=$(AWS_SECRET_KEY)' /home/ubuntu/aws-image-template.json

sync-ssh-keys:
	cat ~/.ssh/id_rsa.pub | ssh -i ~/Downloads/luisync.pem $(INSTANCE_LOGIN) "cat - >> ~/.ssh/authorized_keys"

ssh:
	ssh $(INSTANCE_LOGIN)

sync-files:
	docker run -it -v ~/.ssh:/root/.ssh -v ${PWD}/config:/root/.unison -v $(PROJECT_FULL_PATH):/home/ubuntu/project $(IMAGE_NAME) unison default /home/ubuntu/project/ ssh://$(INSTANCE_LOGIN)//home/ubuntu/project/ -ui text -repeat watch