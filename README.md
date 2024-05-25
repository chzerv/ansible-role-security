# Ansible Role: Security

> **Important Changes**:
> As of v0.7, the role no longer supports the `security_enforce_strong_passwords`, `security_log_after_failed_logins` and `security_nproc_limit` options. Bad PAM configuration can lock you out of the system, so I'll have to find a better way to implement these.

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
- Disable core dumps, using `limits`.

## Requirements

- After running this role, SSH access will only be possible using public keys, therefore,
  your SSH keys must be already copied to the remote host. See [this ArchWiki entry](https://wiki.archlinux.org/title/SSH_keys#Copying_the_public_key_to_the_remote_server) on how to easily copy your SSH keys to the remote host.
- Basic understanding of what each setting does.

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
