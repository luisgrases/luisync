IMAGE_NAME=luisync
INSTANCE_USER=ubuntu
INSTANCE_DNS=ec2-3-82-233-242.compute-1.amazonaws.com
INSTANCE_LOGIN=$(INSTANCE_USER)@$(INSTANCE_DNS)
PROJECT_PATH=~/harbor/portal-api

build-local:
	docker build --rm -t $(IMAGE_NAME) -f Dockerfile .

bash-local:
	docker run -it $(IMAGE_NAME) bin/bash

create-aws-image:
	docker run -it $(IMAGE_NAME) packer build -var 'aws_access_key=AKIAJGMTEPHZGO3K6HPA' -var 'aws_secret_key=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' /home/ubuntu/aws-image-template.json

sync-ssh:
	cat ~/.ssh/id_rsa.pub | ssh -i ~/Downloads/luisync.pem $(INSTANCE_LOGIN) "cat - >> ~/.ssh/authorized_keys"

ssh:
	ssh $(INSTANCE_LOGIN)

unison:
	docker run -it -v ~/.ssh:/root/.ssh -v ~/projects/luisync/config:/root/.unison -v $(PROJECT_PATH):/home/ubuntu/project $(IMAGE_NAME) unison default -ui text -repeat watch