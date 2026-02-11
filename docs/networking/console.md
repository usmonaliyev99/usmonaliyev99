# Console

In first time, we connect to router or switch with console cable.
We have to secure this connection.

When you entered router, you are in user exec mode, like:

```
Router>
Switch>
```

You need to jump into privileged exec mode:

```
enable
```

It look like this:

```
Router#
Switch#
```

Go to global configuration mode with:

```
configure terminal
```

After that command, you see like this:

```
Router(config)#
Switch(config)#
```

Select console line with:

```
line console 0
```

It gives:

```
Router(config-line)#
Switch(config-line)#
```

Now we cat put password on that line:

```
password 123
login
```

It's done, you can exit with `exit` command

You can encrypt that password in global configuration mode with:

```
service password-encryption
```
