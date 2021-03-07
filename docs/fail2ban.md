# fail2ban configuration

| Name                             | Default value | Description                                                                                |
| :------------------------------: | :-----------: | :----------------------------------------------------------------------------------------: |
| security_fail2ban_enabled        | true          | Enable fail2ban                                                                            |
| security_fail2ban_harden_service | true          | The fail2ban process itself runs as _root_, so we use systemd to harden the process a bit. |
| security_fail2ban_banaction      | iptables      | The banaction to use. Defaults to `iptables`.                                              |

- `fail2ban` has too many options too put them all in variables. The configuration for `jail.local` and `sshd.local` are in `templates/etc/fail2ban/jail.local.j2` and `templates/etc/fail2ban/jail.d/sshd.local.j2`. Change these templates according to your needs.
- The service will be **enabled** at boot, but **not** started automatically.
- Have a look at `/etc/fail2ban/actions.d` for all the available `banactions`.
