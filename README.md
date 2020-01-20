![Image of Pysmine](https://i.ibb.co/GW9M589/logo.png)

# Local development on a remote server
Luisync is a simple utility which allows you to sync your local project to an AWS instance using [Unison](https://www.cis.upenn.edu/~bcpierce/unison/) and [Packer](https://www.packer.io/). 

## Why would I need this?
Once your project starts getting large, it will start draining your computer resources. Sophisticated large apps generally implement a set of high demanding tools like databases, message brokers, error reporters, analytic tools, etc.

`luisync` allows you to code in your local computer and having all the changes get reflected instantly on a remote server. You can run your project on this remote server and interact with it.

## Requirements
- `Docker` and `Make` must me installed in your local computer.  
- An AWS account.

## Usage
First of all, clone the repo and cd into it:
```
git clone https://github.com/luisgrases/luisync
```
```
cd luisync
```
Open Makefile and fill the `AWS_ACCESS_KEY` and `AWS_SECRET_KEY` variables with your account keys. If you don't know how to get them, read the following [guide](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys).

Now run the following command:
```
make build-local
```
This will build an Ubuntu docker image with Unison and Packer installed. We will use it to create our AMI (Amazon Machine Image) and later sync files to the corresponding instance.

The next step is to build the AMI:

```
make create-aws-image
```

Now that we have the AMI, you can now launch an EC2 instance using this image. Check the following [link](https://aws.amazon.com/premiumsupport/knowledge-center/launch-instance-custom-ami/) with instructions on how to do so.  
Once the instance has launched, get it's public DNS and fill the `INSTANCE_DNS` variable in the Makefile. The public DNS looks something like this: `ec2-54-237-51-165.compute-1.amazonaws.com`

Let's proceed to sync our local ssh keys to this newly created instance. To do so, just call the following command:

```
make sync-ssh-keys 
```

Now you are ready to start syncing your files. But before you do that. Fill the `PROJECT_FULL_PATH` variable on the Makefile. As its name indicates. This is the full path of the folder to be synced. For example: ~/harbor/portal-api
After you have set the `PROJECT_FULL_PATH` variable, call the following command:

```
make sync-files
```

The files should start syncing. Once they finish, try to change any file contents and see how it syncs automatically to the remote instance. The files are sync to the `/home/ubuntu/project` directory on the remote instance.

If you want to prevent certain files from being synced, add them to the `default.prf` file.


From here you should be able to configure your instance to build your project there and expose the necessary ports.
If you want to easily ssh the remote instance call:

```
make ssh
```