# Raspberry Pi WordClock Host

This is an ansible library that deploys a fresh Raspberry Pi with all configuration and software required for running as a WordClock Host. The Raspberry Pi will hereafter be called `wordclock`, whereas the controlling machine is called `control`.

* Boot `wordclock` with a [fresh installation of Raspbian](https://www.raspberrypi.org/downloads/raspbian/)

* Make sure you have a recent [Ansible installation](http://docs.ansible.com/ansible/intro_installation.html) on `control`, e.g.

  ```
  $ brew install ansible
  ```

  Replace `brew` with `yum` or `apt-get`, depending on your OS.

* Copy the public key to `wordclock`:

  ```
  $ ssh-copy-id pi@wordclock
  ```

1. Test that you can login without a password:

  ```
  control$ ssh pi@wordclock
  ```

  Note that there is no password prompt because authentication happens using the private key previously loaded into the SSH agent.

1. Check that Ansible can reach `wordclock`:

  ```
  control$ ansible all -m ping
  ```

# Deployment

```
control$ ansible-playbook raspi/site.yml
```

# WiFi

If you want to configure the WiFi network, create a file `wifi.yml` with the following contents (adapt it to your WIFI settings):

```
wlan_country: DE
wlan_ssid: your-wlan-ssid
wlan_password: your-wlan-password
```

If `wifi.yml` is not present, WiFi will not be configured.
