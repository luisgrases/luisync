packer build \
    -var 'aws_access_key=AWS_ACCESS_KEY' \
    -var 'aws_secret_key=AWS_SECRET_KEY' \
    schrnzr-aws-image-template.json
