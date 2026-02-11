# Login with ssh

Let's setup remote ssh login our devices.

You need:

- Hostname
- Domain name
- RSA keys
- Local user account
- VTY lines configured for SSH

1. Set Hostname

Jump into global configuration mode and write:

```
Router(config)# hostname Router1
Switch(config)# hostname Switch1
```

2. Set domain name

```
Router(config)# ip domain-name lab.uz
```

3. Create local user

```
Router(config)# username USER secret PASSWORD
```

4. Create rsa key

```
Router(config)# crypto key generate rsa

How many bits? 1024 or 2048
```

5. Enable ssh version 2

```
Router(config)# ip ssh version 2
```

6. Configure vty line for ssh only

```
Router(config)# line vty 0 15
Router(config-line)# login local
Router(config-line)# transport input ssh
```

7. Verify ssh is enabled

```
Router# show ip ssh
```

8. Test

```
ssh -L USER IP_ADDRESS
```
