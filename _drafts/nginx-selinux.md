---
layout: post
title: Letting nginx work with SELinux in enforcing mode
categories: linux
---

So here we are. You're setting up your beloved nginx on a brand new CentOS 7 install and... bam! You get this error:

```sh
root@lisa:/etc/nginx$ service nginx start
Redirecting to /bin/systemctl start  nginx.service
Job for nginx.service failed. See 'systemctl status nginx.service' and 'journalctl -xn' for details.
root@lisa:/etc/nginx$ systemctl status nginx.service
nginx.service - nginx - high performance web server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled)
   Active: failed (Result: exit-code) since Mon 2015-12-07 12:02:24 CET; 13s ago
     Docs: http://nginx.org/en/docs/
  Process: 2381 ExecStop=/bin/kill -s QUIT $MAINPID (code=exited, status=0/SUCCESS)
  Process: 2356 ExecReload=/bin/kill -s HUP $MAINPID (code=exited, status=0/SUCCESS)
  Process: 2479 ExecStartPre=/usr/sbin/nginx -t -c /etc/nginx/nginx.conf (code=exited, status=1/FAILURE)
 Main PID: 8696 (code=exited, status=0/SUCCESS)

Dec 07 12:02:24 lisa.fpira.com systemd[1]: Starting nginx - high performance web server...
Dec 07 12:02:24 lisa.fpira.com nginx[2479]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Dec 07 12:02:24 lisa.fpira.com nginx[2479]: nginx: [emerg] open() "/var/run/nginx.pid" failed (13: Permission denied)
Dec 07 12:02:24 lisa.fpira.com nginx[2479]: nginx: configuration file /etc/nginx/nginx.conf test failed
Dec 07 12:02:24 lisa.fpira.com systemd[1]: nginx.service: control process exited, code=exited status=1
Dec 07 12:02:24 lisa.fpira.com systemd[1]: Failed to start nginx - high performance web server.
Dec 07 12:02:24 lisa.fpira.com systemd[1]: Unit nginx.service entered failed state.
Hint: Some lines were ellipsized, use -l to show in full.
```

#### So, what's up?

It turns out we don't have to blame nginx for this.

The error happens when SELinux is enabled and set in *enforcing* mode. It doesn't allow nginx to start the pid or even read its configuration directory /etc/nginx.

Let's check the SELinux status:

```sh
sestatus
```

You should get something like this:

```sh
root@lisa:/etc/nginx$ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      28
```

Now check the SELinux log about nginx:

```
sudo cat /var/log/audit/audit.log | grep nginx | grep denied
```

#### How to fix it?

First of all, be sure *audit2allow* is installed. It's a tool to set and load custom rules on SELinux. On CentOS audit2allow is provided by the *policycoreutils-python* package.

```sh
# yum install -y policycoreutils-python
```

Tell SELinux to set nginx free...

```sh
# cat /var/log/audit/audit.log | grep nginx | grep denied | audit2allow -M pleaseallownginx
# semodule -i pleaseallownginx.pp
```

Fixed?

#### Start nginx and run a check

Now start nginx...

```sh
# service start nginx
```

...and check for it to be running.

```sh
# ps aux | grep nginx
```

You should see it happy in the wild:

```sh
root@lisa:/var$ ps aux | grep nginx
root      2842  0.0  0.1  48616  2448 ?        Ss   12:14   0:00 nginx: master process /usr/sbin/nginx -c /etc/nginxnginx.conf
nginx     2865  0.0  0.1  48620  2176 ?        S    12:19   0:00 nginx: worker process
nginx     2866  0.0  0.1  48620  2428 ?        S    12:19   0:00 nginx: worker process
root      2897  0.0  0.0 112644   964 pts/0    S+   12:32   0:00 grep --color=auto nginx
```

#### It's not over: you get a 403!

Everything seems to be fixed but you visiting the webpage you get a 403. It's still SELinux stopping you by. Cat the logs to further investigate.

```sh
# getenforcing
# cat /var/log/audit/audit.log | grep nginx | grep denied
```

And here's the output:

```sh
root@lisa:/etc/nginx$ cat /var/log/audit/audit.log | grep nginx | grep denied
type=AVC msg=audit(1449484546.693:52861): avc:  denied  { write } for  pid=8696 comm="nginx" name="nginx" dev="dm-1" ino=10261235 scontext=system_u:system_r:httpd_t:s0 tcontext=system_u:object_r:httpd_config_t:s0 tclass=dir
type=AVC msg=audit(1449485604.716:52864): avc:  denied  { append } for  pid=2403 comm="nginx" name="off" dev="dm-1" ino=10259977 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:httpd_config_t:s0 tclass=file
type=AVC msg=audit(1449486144.411:52873): avc:  denied  { read write } for  pid=2479 comm="nginx" name="nginx.pid" dev="tmpfs" ino=381844 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_run_t:s0 tclass=file
type=AVC msg=audit(1449486694.054:52894): avc:  denied  { add_name } for  pid=2819 comm="nginx" name="off" scontext=system_u:system_r:httpd_t:s0 tcontext=system_u:object_r:httpd_config_t:s0 tclass=dir
type=AVC msg=audit(1449486987.622:52897): avc:  denied  { read } for  pid=2843 comm="nginx" name="404.html" dev="dm-1" ino=8715718 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_t:s0 tclass=file
type=AVC msg=audit(1449487039.339:52898): avc:  denied  { read } for  pid=2843 comm="nginx" name="index.html" dev="dm-1" ino=8715722 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_t:s0 tclass=file
type=AVC msg=audit(1449487353.878:52903): avc:  denied  { read } for  pid=2866 comm="nginx" name="404.html" dev="dm-1" ino=8715718 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_t:s0 tclass=file
type=AVC msg=audit(1449488256.496:52908): avc:  denied  { read } for  pid=2866 comm="nginx" name="index.html" dev="dm-1" ino=8715722 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_t:s0 tclass=file
type=AVC msg=audit(1449488390.268:52909): avc:  denied  { read } for  pid=2866 comm="nginx" name="feed.xml" dev="dm-1" ino=8715720 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_t:s0 tclass=file
type=AVC msg=audit(1449488430.096:52911): avc:  denied  { open } for  pid=2866 comm="nginx" path="/var/www/fpira.com/index.html" dev="dm-1" ino=8715722 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_t:s0 tclass=file
type=AVC msg=audit(1449488430.096:52912): avc:  denied  { getattr } for  pid=2866 comm="nginx" path="/var/www/fpira.com/index.html" dev="dm-1" ino=8715722 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_t:s0 tclass=file
type=AVC msg=audit(1449488495.320:52914): avc:  denied  { getattr } for  pid=2866 comm="nginx" path="/var/www/fpira.com/index.html" dev="dm-1" ino=8715722 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_t:s0 tclass=file
type=AVC msg=audit(1449488504.936:52915): avc:  denied  { read } for  pid=2866 comm="nginx" name="404.html" dev="dm-1" ino=8715718 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:var_t:s0 tclass=file
```

#### One last fix

Nginx can now run but SELinux won't let it read the /var/www dir. We have to use *chcon* to change the SELinux security context of that folder.

**Important!** : If your files are not in /var/www just change it with your folder of choice!

```sh
# chcon -Rt httpd_sys_content_t /var/www
```

Reload the page in your browser and it should be working (be sure web caching in your browser is enabled!). 

Well done, mate! Now prize yourself with a good coffee!

Thanks for reading.

Sources

- http://stackoverflow.com/questions/23948527/13-permission-denied-while-connecting-to-upstreamnginx
- http://stackoverflow.com/questions/22586166/why-does-nginx-return-a-403-even-though-all-permissions-are-set-properly
- https://github.com/jdauphant/ansible-role-nginx/issues/24
