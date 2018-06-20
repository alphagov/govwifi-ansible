# GovWifi Ansible

Ansible playbooks to provision GovWifi infrastructure on AWS.
This will ensure that the servers are correctly configured to run GovWifi.

## Setup
  - Ensure you have ansible installed locally with `pip3 install ansible`
  - Ensure that your AWS credentials are set up in `~/.aws/credentials`
```
[govwifi]
aws_access_key_id = XXXYYY
aws_secret_access_key = super-secret-key
```
  - Populate an `inventory` file with IP addresses of the servers that you are provisioning under the relevant categories.
  You can find an example of this in `inventory.sample`.
```
[frontend_staging_dublin]
xx.xx.xx.xx
xx.xx.xx.xx
```
  - Your ssh configuration will need to be set up to allow Ansible to ssh into your targets through the bastion server. It will look something like this:
```
Host stagingbastion
  HostName xxx.xxx.xxx.xxx
  IdentityFile ~/.ssh/your-staging-bastion-key
  User ubuntu

Host xxx.xxx.xxx.xxx
  IdentityFile ~/.ssh/your-ec2-key
  User ec2-user
  ProxyCommand ssh stagingbastion -W %h:%p
```

## Run
### London
`make staging-london-frontend provision`
or
`make production-london-frontend provision`

### Dublin
`make staging-dublin-frontend provision`
or
`make production-dublin-frontend provision`
