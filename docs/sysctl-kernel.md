# Kernel hardening using sysctl

**Notes:**

1. Setting any of these variables to `0` will de-activate them.
2. Make sure to quote (`""`) the values, as shown below.

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
security_kern_hidepid_value: "0"
```

> Hide a user's processes from other users. A value of `1` will let a user only see his own processes in tools like `top`, but he **will be able to** see processes' IDs in `/proc`. A value of `2` will also hide the IDs.
> **NOTE:** This causes issues with `D-Bus`, `PulseAudio` and `bluetooth` when using `systemd` > 237.64-1. Should probably NOT be used in personal computers.

```yaml
security_kern_hidepid_mount_opts: nosuid,nodev,noexec,hidepid={{ security_kern_hidepid_value }},gid=proc
```

> A list of the mounting options to be used for `/proc`. **Note** that a `gid=proc` is specified, which means that users or services of the `proc` group will be able to access `proc/$pid`.
