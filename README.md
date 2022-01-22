# cardano-node: FreeBSD Port (development)

Use this port to build and run a cardano node on FreeBSD port. Once this
project is in a stable state a formal PR will be filed and submitted to have it
included officially within the FreeBSD Ports collection. ***These steps are
temporary for now.***


## Building


### Pre-requisite

Add user user-id/group-id to /usr/ports/UIDs and /usr/ports/GIDs


```
  sudo perl -pi.bak -e 's;^# free: 783;cardano:*:783:783::0:0:Cardano Daemon:/nonexistent:/usr/sbin/nologin;g' /usr/ports/UIDs
```

```
  sudo perl -pi.bak -e 's;^# free: 783;cardano:*:783:;g' /usr/ports/GIDs
```

This allows the port, once completed, to create the ***cardano*** user/group on the system
system.


### Fetch & build port
Copy or clone this project under /usr/ports/net-p2p. For example as root:

```
  cd /usr/ports/
  sudo git clone https://github.com/cardano-bsd-alliance/cardano-node.git
```

Try and build the port:

```
  make install clean
```


Any issues and or suggestions, feel free to open an issue ticket.

