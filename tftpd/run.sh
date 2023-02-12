#!/bin/bash
chmod 777 -R /data
echo ok >/data/test
exec /usr/sbin/in.tftpd -c -s /data --foreground