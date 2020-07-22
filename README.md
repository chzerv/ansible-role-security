# Ansible Role: Security

[![Build Status](https://travis-ci.com/chzerv/ansible-role-security.svg?branch=master)](https://travis-ci.com/chzerv/ansible-role-security)

**Remember, securing YOUR PC/server is YOUR OWN responsibility.** This is a very basic template and it should be used as a _template_, not a complete solution.

This role performs some basic security configuration on RedHat and Debian based Linux systems, like:

- Install and configure [fail2ban](https://www.fail2ban.org/wiki/index.php/Main_Page) to monitor bad SSH logins.
- Basic SSH hardening like
  - Disable root login.
  - Disable password authentication.
  - Enable key-based authentication.
  - Change the default port.
  - Disable known weak algorithms.
- Set up automatic updates.
- Basic kernel-hardening.
- Remove packages of your choice.

## Requirements

None.

## Role Variables

### SSH

|                   Name                   | Default value |                                                 Description                                                  |
| :--------------------------------------: | :-----------: | :----------------------------------------------------------------------------------------------------------: |
|            security_ssh_port             |      22       |                                  The port through which SSH is accessible.                                   |
|   security_ssh_password_authentication   |      no       |                                    Allow authentication using passwords.                                     |
|      security_ssh_permit_root_login      |      no       |                                    Allow one to login as root using SSH.                                     |
|    security_ssh_permit_empty_password    |      no       |                                  Allow empty passwords for authentication.                                   |
|  security_ssh_key_based_authentication   |      yes      |                                       Allow key-based authentication.                                        |
|   security_ssh_gss_api_authentication    |      no       |                                        Allow GSS api authentication.                                         |
|   security_ssh_challenge_response_auth   |      no       |                                Allow challenge-response based authentication.                                |
|           security_ssh_usedns            |      no       |                                                   Use DNS.                                                   |
|       security_ssh_x11_forwarding        |      no       |                                            Allow X11 forwarding.                                             |
|   security_ssh_disable_weak_algorithms   |     true      |         Disable known weak/legacy algorithms and ciphers. **Requires** Debian 10/RedHat 8/Ubuntu19+.         |
| security_ssh_secure_authorized_keys_file |     true      |                                     Make your authorized_keys read-only.                                     |
|        security_ssh_handler_state        |   restarted   | By default, ssh will be restarted after configuration is done. Change this if you want a different behavior. |

- This role will disable password authentication and only allow key-based authentication. **Make sure your public SSH keys are copied on the remote host before running this role.** Failing to do so can lock you out of the remote host!
- If your server is open to the internet, it's advised to change the default SSH port. Not doing so can lead to huge amounts of unwanted traffic.
- If `X11 forwarding` is a crucial part of your workflow, make sure to set `security_ssh_x11_forwarding` to `yes`.

### fail2ban

|               Name               | Default values |                                        Description                                         |
| :------------------------------: | :------------: | :----------------------------------------------------------------------------------------: |
|    security_fail2ban_enabled     |      true      |                                      Enable fail2ban                                       |
| security_fail2ban_harden_service |      true      | The fail2ban process itself runs as _root_, so we use systemd to harden the process a bit. |

- `fail2ban` has too many options too put them all in variables. The configuration for `jail.local` and `sshd.local` are in `templates/etc/fail2ban/jail.local.j2` and `templates/etc/fail2ban/jail.d/sshd.local.j2`. Change these templates according to your needs.
- The service will be **enabled** at boot, but not started automatically.

### Remove packages

|             Name              | Default value |                 Description                  |
| :---------------------------: | :-----------: | :------------------------------------------: |
| security_cleanup_deb_packages |       -       | A list of packages to remove (Debian family) |
| security_cleanup_rpm_packages |       -       | A list of packages to remove (RedHat family) |

e.g.,

```yaml
security_cleanup_deb_packages:
  - xinetd
  - telnet-server
```

## Dependencies

None.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

## License

MIT / BSD

## Author Information

Xristos Zervakis
