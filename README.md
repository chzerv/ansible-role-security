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
- Basic TCP/IP stack hardening.
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

|               Name               | Default value |                                        Description                                         |
| :------------------------------: | :-----------: | :----------------------------------------------------------------------------------------: |
|    security_fail2ban_enabled     |     true      |                                      Enable fail2ban                                       |
| security_fail2ban_harden_service |     true      | The fail2ban process itself runs as _root_, so we use systemd to harden the process a bit. |

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

### Kernel hardening

**Notes:**

1. setting any of these variables to `0` will de-activate them.
2. make sure to quote (`""`) the values, as shown below.

```yaml
security_kern_disable_kexec: "1"
```

> Don't allow replacing the current running kernel. Available values are `0` and `1`.

```yaml
security_kern_restrict_dmesg: "1"
```

> Only allow log access to users with the `CAP_SYS_ADMIN` capability set (usually the _root_ user).

```yaml
security_kern_restrict_kptr: "1"
```

> Hide kernel symbol addresses. A value of `1` will hide them from regular users, while a value of `2` will also hide them from the root user.

```yaml
security_kern_sysctl_opts:
  net.ipv4.ip_forward: 0
```

> User defined sysctl settings. Any additional settings have to follow the same format: `key: value`.

```yaml
security_kern_hidepid_value: "2"
```

> Hide a user's processes from other users. A value of `1` will let a user only see his own processes in tools like `top`, but he **will be able to** see processes' IDs in `/proc`. A value of `2` will also hide the IDs.

```yaml
security_kern_hidepid_mount_opts: nosuid,nodev,noexec,hidepid={{ security_kern_hidepid_value }},gid=proc
```

> A list of the mounting options to be used for `/proc`. **Note** that a `gid=proc` is specified, which means that users or services of the `proc` group will be able to access `proc/$pid`.

### TCP/IP stack hardening

**Notes:**

1. setting any of these variables to `0` will de-activate them.
2. make sure to quote (`""`) the values, as shown below.

```yaml
security_net_syn_cookies_protection: "1"
```

> Helps protect against [SYN flooding](https://en.wikipedia.org/wiki/SYN_flood) attacks.

```yaml
security_net_default_rp_filter: "1"
security_net_all_rp_filter: "1"
```

> Let the kernel do source validation of the received packets, which can help prevent attacks which use IP spoofing methods. A value of `1` sets the filtering mechanism to _strict_ mode, and a value of `2` will set it to _loose_ mode. **Both of these variables must have the same value**.

```yaml
security_net_default_icmp_redirect_sending: "0"
security_net_all_icmp_redirect_sending: "0"
```

> Disable ICMP redirect sending. **Both of these variables must have the same value**.

```yaml
security_net_icmp_accept_redirects: "0"
```

> Don't accept ICMP redirects. This can protect against MITM (Man In The Middle) attacks.

### Auto updates

```yaml
security_autoupdates_enabled: true
```

> Enable automatic updates.

```yaml
security_autoupdates_type: "security"
```

> What type of updates to perform automatically. Valid values are `security` (only download security related updates) and `all` (download all updates).

```yaml
security_autoupdates_mail_to: "root"
```

> The mail address to which notifications about updates will be sent. **This requires a mail server already up and running**. If you don't have a mail server, or simply don't need mail notifications, leave this to the default value.

```yaml
security_autoupdates_mail_on_error: true
```

> Only send mail notifications when something goes wrong. **Debian-based distributions only!**

```yaml
security_autoupdates_reboot: "true"
security_autoupdates_reboot_time: "04:00"
```

> Reboot the system after the updates are done, at the specified time. **Debian-based distributions only!**

```yaml
security_autoupdates_blacklist:
  - "linux-"
```

> Make listed packages ignore automatic updates. By default, only kernel related packages are ignored. **Note that special characters must be escaped.** **Debian-based distributions only!**

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
