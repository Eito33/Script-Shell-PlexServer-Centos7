# Install PlexMediaServer on Centos7
![ImageLOAD](https://forum.openmediavault.org/index.php/Attachment/6587-Capture-JPG/)

### 1. Get a server

**Recommended Specs**

* Type: VPS or dedicated
* Distribution: Centos 7

**Recommended Providers**

* [OVH](https://www.ovh.com/)

### 2 . Install

1. Upload the script on your server

2. install dos2unix

```bash
$ yum install dos2unix
```

3. install script 

```bash
$ dos2unix install.sh
$ chmod +x install.sh
$ ./install.sh
```
4. Check that all is ok
5. Disconnect from your server
6. Reconnect using the following command

```bash
# change user and YourIP
$ ssh user@YourIP -L 8888:localhost:32400
```

7. Create folder (music, movies, ect...) in /opt/plexmedia/
```bash
$ cd /opt/plexmedia
$ mkdir music
```

8. Go to http://localhost:8888/web and configure your library
9. Go to http://yourIP:32400/web/index.html and enjoy !


# Thanks !




