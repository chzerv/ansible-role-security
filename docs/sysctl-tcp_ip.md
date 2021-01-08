# TCP/IP stack hardening

**Notes:**

1. setting any of these variables to `0` will de-activate them.
2. make sure to quote (`""`) the values, as shown below.

```yaml
security_net_go_hardcore: true
```

> Whether to perform _any_ TCP/IP stack hardening or not. This variable exists so the user doesn't
> have to disable the rest of the variables if they don't care for this feature.

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
