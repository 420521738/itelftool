#!/bin/bash
/usr/bin/celery multi start w1 w2 -c 2 --app=itelftool --logfile="/var/opt/itelftool/logs/%n%I.log" --pidfile=/var/opt/itelftool/pid/%n.pid

