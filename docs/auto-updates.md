# Automatic updates

**Note:** The configurations for `unattended-upgrades`, `dnf-automatic` and `yum-cron` are in `templates/etc/apt/apt.conf.d/`, `templates/etc/dnf/` and `templates/etc/yum`, respectively. For any changes
that cannot be done through the defined Ansible variables, feel free to change those templates.

**Note2:** Automatic updates are only available for RedHat and Debian based systems. Auto-updating Archlinux seems like a risk.

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

```yaml
security_autoupdates_apply_updates: "yes"
```

> Also install updates after downloading them. **RedHat-based systems only!**
