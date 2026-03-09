# Raspberry Pi Word Clock

This is an ansible library that deploys a fresh Raspberry Pi with all configuration and software required for running as a Word Clock.

# Prepare the Control Machine

* Make sure you have a recent [Ansible installation](http://docs.ansible.com/ansible/intro_installation.html).
* Install the required Ansible roles:

  ```command
  $ ansible-galaxy install -r deployment/requirements.yml
  ```

# Prepare the Raspberry Pi

Boot the Raspberry Pi with a fresh installation of Raspberry Pi OS Lite (32 bit) (the Raspberry Pi imager works fine). Make sure you enable SSH.

> Note that it has to be a 32 bit OS as the FadeCandy library is only available for that.

# Deployment

```command
$ ansible-playbook deployment/playbook.yml
```
