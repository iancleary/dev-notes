# ansible hosts

## Ensure Ansible is installed

```bash
sudo apt-get install ansible && ansible --version
```

You should see something like the below output.

```bash
ubuntu@build-server:~/deploy/fastapi-ansible$ ansible --version
ansible 2.5.1
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/home/ubuntu/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.17 (default, Nov  7 2019, 10:07:09) [GCC 7.4.0]
```

## Linux Hosts

```bash
sudo nano /etc/hosts
```

Add/Edit the names of your targets.

```bash
#/etc/hosts
127.0.0.1 localhost
172.31.22.216   web-server
172.31.22.217   db-server
```

## Ansible Hosts

```bash
sudo nano /etc/ansible/hosts
```

Name your server groups (targets can be in multiple groups).
The default generated file provides examples.

Notes:

* if you do not edit `/etc/hosts`, you will have to use the private IP addresses within this file.
* You can specify users with `ansible_user=ubuntu`. This could be a group_var if common to multiple servers.

```bash
#/etc/ansible/hosts
# ...

[webservers]
app-server ansible_user=ubuntu
```

## SSH Keys

Ensure that you have the ssh keys installed the server you will be running ansible on.

### Start the ssh-agent

```bash
eval $(ssh-agent)
```

If a pid is shown, it is running.

### Add your keys

```bash
ssh-add /path/to/your/key.pem
```

## Ping your servers

Ping all servers

```bash
ansible -m ping all
```

Alternatively, ping just a single group.

```bash
ansible -m ping webservers
```

If all goes well, your output will be green.

![images/ansible-hosts/ping.png](images/ansible-hosts/ping.png)

*Question: What was my `/etc/ansible/hosts` configuration for this image?*