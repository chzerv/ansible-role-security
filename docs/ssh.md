# SSH related configuration

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
