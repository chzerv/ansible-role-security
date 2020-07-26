# PAM configuration

```yaml
security_enforce_strong_passwords: true
security_lock_after_failed_logins: true
```

> - Enforce users to use strong passwords (at least 12 characters, with digits, lowercase, uppercase and symbols).
> - Lock user accounts after 4 consecutive failed login attempts.

```yaml
security_nproc_limit: true
security_nproc_limit_value: "2048"
```

> - Set a nproc limit to help against fork-bombs.
> - The value of the nproc limit. _This does NOT affect the root user!_
>
> **Please note that having a very low limit can make your system unusable!**
