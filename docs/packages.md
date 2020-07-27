# Remove packages

|               Name               | Default value |                   Description                   |
| :------------------------------: | :-----------: | :---------------------------------------------: |
|  security_cleanup_deb_packages   |       -       |  A list of packages to remove (Debian family)   |
|  security_cleanup_rpm_packages   |       -       |  A list of packages to remove (RedHat family)   |
| security_cleanup_pacman_packages |       -       | A list of packages to remove (Archlinux family) |

e.g.,

```yaml
security_cleanup_deb_packages:
  - xinetd
  - telnet-server
```
