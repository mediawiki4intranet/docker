#!/bin/sh
### BEGIN INIT INFO
# Provides:          draw.io
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Should-Start:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/stop local draw.io service
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin
NAME=draw.io
PIDFILE=/var/run/draw.io.pid

. /lib/lsb/init-functions

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

case "$1" in
    start)
        log_daemon_msg "Starting draw.io service" $NAME
        start-stop-daemon -S -b --pidfile $PIDFILE -m -x /usr/bin/java -- -jar /home/wiki4intranet/jetty-runner.jar --host 127.0.0.1 --port 8073 /home/wiki4intranet/draw.war
        log_end_msg $?
        ;;
    stop)
        log_daemon_msg "Stopping draw.io service" $NAME
        if [ -e $PIDFILE ]; then
            kill `cat $PIDFILE` 2>/dev/null >/dev/null && rm $PIDFILE
            log_end_msg $?
        else
            echo -n ...not running
            log_end_msg 0
        fi
        ;;
    restart|force-reload)
        log_daemon_msg "Restarting draw.io service" $NAME
        [ -e $PIDFILE ] && kill `cat $PIDFILE` 2>/dev/null >/dev/null && sleep 1 && rm $PIDFILE
        start-stop-daemon -S -b --pidfile $PIDFILE -m -x /usr/bin/java -- -jar /home/wiki4intranet/jetty-runner.jar --host 127.0.0.1 --port 8073 /home/wiki4intranet/draw.war
        log_end_msg $?
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|force-reload}"
        exit 1
        ;;
esac

exit 0
