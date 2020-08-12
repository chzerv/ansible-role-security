# Ansible Role: Security

[![Build Status](https://travis-ci.com/chzerv/ansible-role-security.svg?branch=master)](https://travis-ci.com/chzerv/ansible-role-security)
![Ansible Molecule](https://github.com/chzerv/ansible-role-security/workflows/Ansible%20Molecule/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ansible Role](https://img.shields.io/ansible/role/50034?color=dodgerblue)](https://galaxy.ansible.com/chzerv/security)

**Remember, securing YOUR PC/server is YOUR OWN responsibility.** This is a very basic template and it should be used as a _template_, not a complete solution.

This role performs some basic security configuration on RedHat/Debian/Archlinux based Linux systems, like:

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
- Setup/configure PAM modules like `pam_tally2` and `pwquality`.

## Requirements

None.

## Role Variables

- [SSH](docs/ssh.md)
- [fail2ban](docs/fail2ban.md)
- [Remove packages](docs/packages.md)
- [Kernel hardening](docs/sysctl-kernel.md)
- [TCP/IP stack hardening](docs/sysctl-tcp_ip.md)
- [Auto updates](docs/auto-updates.md)
- [PAM](docs/pam.md)

## Dependencies

None.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: server
  vars_files:
    - vars/main.yml

  roles:
    - { role: chzerv.ansible_role_security }
```

The `vars/main.yml` file:

```yaml
security_kern_go_hardcore: true
security_net_go_hardcore: true
security_autoupdates_enabled: true
security_autoupdates_type: "security"
security_fail2ban_enabled: true
security_fail2ban_harden_service: true
```

## License

MIT / BSD

## Author Information

Xristos Zervakis
