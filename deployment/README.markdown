# Raspberry Pi WordClock Host

This is an ansible library that deploys a fresh RaspberryPi with all configuration and software required for running as a WordClock Host.

In this document, the RaspberryPi will be called `wordclock`, whereas the controlling machine is called `control`.

# Prepare the Control Machine

* Make sure you have a recent [Ansible installation](http://docs.ansible.com/ansible/intro_installation.html):

  ```bash
  control$ brew install ansible
  ```

  Replace `brew` with `yum` or `apt-get`, depending on your OS.

* Install the required Ansible roles:

  ```bash
  control$ ansible-galaxy install -r deployment/requirements.yml
  ```

# Prepare the RaspberryPi

* Connect Ethernet to the RaspberryPi. The deployment will configure WLAN, but until then Ethernet is easier.

* Boot the RaspberryPi with a [fresh installation of Raspbian](https://www.raspberrypi.org/downloads/raspbian/).

* Log on at the console (beware the keyboard layout) and enable sshd:

  ```bash
  raspberrypi$ sudo service ssh start
  ```

# First Deployment

The RaspberryPi will start with the default hostname `raspberrypi` so that we need to pass a custom inventory:

```bash
control$ ansible-playbook -i raspberrypi, deployment/playbook.yml
```

# Subsequent Deployments

The first deployment did set the hostname to `wordclock` and also copied the public key, so that subsequent deployments become as simple as:

```bash
control$ ansible-playbook deployment/playbook.yml
```

# WiFi

If you want to configure the WiFi network, create a file `wifi.yml` with the following contents (adapt it to your WIFI settings):

```yaml
wlan_country: DE
wlan_ssid: your-wlan-ssid
wlan_password: your-wlan-password
```

If `wifi.yml` is not present, WiFi will not be configured.
