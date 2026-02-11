# Sub-configuration modes (Inside global config)

1. Interface configuration mode

Prompt:

```bash
Router(config-if)#
```

Enter with:

```bash
interface gigabitEthernet0/0
```

Used for:

- IP address config
- Enable/disable interface
- Speed/duplex
- VLAN access/trunk settings

2. Line configuration mode

Prompt:

```bash
Router(config-line)#
```

Enter with:

```bash
line console 0
line vty 0 4
```

Used for:

- Console, SSH, Telnet security

3. Router configuration mode (Routing protocols)

Prompt:

```bash
Router(config-router)#
```

Enter with:

```bash
router rip
router ospf 1
router bgp 65000
```

4. VLAN configuration mode (Switch)

Prompt:

```bash
Switch(config-vlan)#
```

Enter with:

```bash
vlan 10
```

5. Access control list mode

Prompt:

```bash
Router(config-std-nacl)#
Router(config-ext-nacl)#
```

9. Policy / Class map mode (QoS)

Prompt:

```bash
Router(config-pmap)#
```

10. ROM monitor mode (Recovery mode)

Prompt:

```bash
rommon>
```

Used for:

- Password recovery
- Boot troubleshooting
