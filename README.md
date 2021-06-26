# Ansible Role: Security

![Test and release.](https://github.com/chzerv/ansible-role-security/workflows/Test%20and%20release./badge.svg?branch=master)
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
- Disable core dumps, using `limits`.
- Set an `nproc` limit for protection against fork bombs, using `limits` (does not apply for the root user).

## Requirements

-  After running this role, SSH access will only be possible using public keys, therefore,
your SSH keys must be already copied to the remote host. See [this ArchWiki entry](https://wiki.archlinux.org/title/SSH_keys#Copying_the_public_key_to_the_remote_server) on how to easily copy your SSH keys to the remote host.
- Basic understanding of what each setting does.
- Not strictly a requirement, but if you decide to let the role configure PAM related stuff, make sure you have a root shell open before running the role.

None.

## Role Variables

- [SSH](docs/ssh.md)
- [fail2ban](docs/fail2ban.md)
- [Remove packages](docs/packages.md)
- [Kernel hardening](docs/sysctl-kernel.md)
- [TCP/IP stack hardening](docs/sysctl-tcp_ip.md)
- [Auto updates](docs/auto-updates.md)
- [PAM](docs/pam-limits.md)

## Dependencies

None.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: server
  vars_files:
    - vars/main.yml

  roles:
    - { role: chzerv.security }
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
