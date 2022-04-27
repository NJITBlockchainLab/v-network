#!/bin/bash

set -e

HOST="${HOST:-0.0.0.0}"
START_PORT="9700"
NODE_NUM="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22"

if [ ! -d "/home/indy/ledger/sandbox/keys" ]; then
    echo "Ledger does not exist - Creating..."

    if [ ! -z "$IPS" ]; then
        echo von_generate_transactions -s "$IPS" -n "$NODE_NUM"
        von_generate_transactions -s "$IPS" -n "$NODE_NUM"
    elif [ ! -z "$IP" ]; then
        echo von_generate_transactions -i "$IP" -n "$NODE_NUM"
        von_generate_transactions -i "$IP" -n "$NODE_NUM"
    else
        echo von_generate_transactions -n "$NODE_NUM"
        von_generate_transactions -n "$NODE_NUM"
    fi
fi

cat <<EOF > supervisord.conf
[supervisord]
logfile = /tmp/supervisord.log
logfile_maxbytes = 50MB
logfile_backups=22
loglevel = info
pidfile = /tmp/supervisord.pid
nodaemon = true
minfds = 1024
minprocs = 200
umask = 022
user = indy
identifier = supervisor
directory = /tmp
nocleanup = true
childlogdir = /tmp
strip_ansi = false

[program:node1]
command=start_indy_node Node1 $HOST 9701 $HOST 9702
directory=/home/indy
stdout_logfile=/tmp/node1.log
stderr_logfile=/tmp/node1.log

[program:node2]
command=start_indy_node Node2 $HOST 9703 $HOST 9704
directory=/home/indy
stdout_logfile=/tmp/node2.log
stderr_logfile=/tmp/node2.log

[program:node3]
command=start_indy_node Node3 $HOST 9705 $HOST 9706
directory=/home/indy
stdout_logfile=/tmp/node3.log
stderr_logfile=/tmp/node3.log

[program:node4]
command=start_indy_node Node4 $HOST 9707 $HOST 9708
directory=/home/indy
stdout_logfile=/tmp/node4.log
stderr_logfile=/tmp/node4.log

[program:node5]
command=start_indy_node Node5 $HOST 9709 $HOST 9710
directory=/home/indy
stdout_logfile=/tmp/node5.log
stderr_logfile=/tmp/node5.log

[program:node6]
command=start_indy_node Node6 $HOST 9711 $HOST 9712
directory=/home/indy
stdout_logfile=/tmp/node6.log
stderr_logfile=/tmp/node6.log

[program:node7]
command=start_indy_node Node7 $HOST 9713 $HOST 9714
directory=/home/indy
stdout_logfile=/tmp/node7.log
stderr_logfile=/tmp/node7.log

[program:node8]
command=start_indy_node Node8 $HOST 9715 $HOST 9716
directory=/home/indy
stdout_logfile=/tmp/node8.log
stderr_logfile=/tmp/node8.log

[program:node9]
command=start_indy_node Node9 $HOST 9717 $HOST 9718
directory=/home/indy
stdout_logfile=/tmp/node9.log
stderr_logfile=/tmp/node9.log

[program:node10]
command=start_indy_node Node10 $HOST 9719 $HOST 9720
directory=/home/indy
stdout_logfile=/tmp/node10.log
stderr_logfile=/tmp/node10.log

[program:node11]
command=start_indy_node Node11 $HOST 9721 $HOST 9722
directory=/home/indy
stdout_logfile=/tmp/node11.log
stderr_logfile=/tmp/node11.log

[program:node12]
command=start_indy_node Node12 $HOST 9723 $HOST 9724
directory=/home/indy
stdout_logfile=/tmp/node12.log
stderr_logfile=/tmp/node12.log

[program:node13]
command=start_indy_node Node13 $HOST 9725 $HOST 9726
directory=/home/indy
stdout_logfile=/tmp/node13.log
stderr_logfile=/tmp/node13.log

[program:node14]
command=start_indy_node Node14 $HOST 9727 $HOST 9728
directory=/home/indy
stdout_logfile=/tmp/node14.log
stderr_logfile=/tmp/node14.log

[program:node15]
command=start_indy_node Node15 $HOST 9729 $HOST 9730
directory=/home/indy
stdout_logfile=/tmp/node15.log
stderr_logfile=/tmp/node15.log

[program:node16]
command=start_indy_node Node16 $HOST 9731 $HOST 9732
directory=/home/indy
stdout_logfile=/tmp/node16.log
stderr_logfile=/tmp/node16.log

[program:node17]
command=start_indy_node Node17 $HOST 9733 $HOST 9734
directory=/home/indy
stdout_logfile=/tmp/node17.log
stderr_logfile=/tmp/node17.log

[program:node18]
command=start_indy_node Node18 $HOST 9735 $HOST 9736
directory=/home/indy
stdout_logfile=/tmp/node18.log
stderr_logfile=/tmp/node18.log

[program:node19]
command=start_indy_node Node19 $HOST 9737 $HOST 9738
directory=/home/indy
stdout_logfile=/tmp/node19.log
stderr_logfile=/tmp/node19.log

[program:node20]
command=start_indy_node Node20 $HOST 9739 $HOST 9740
directory=/home/indy
stdout_logfile=/tmp/node20.log
stderr_logfile=/tmp/node20.log

[program:node21]
command=start_indy_node Node21 $HOST 9741 $HOST 9742
directory=/home/indy
stdout_logfile=/tmp/node21.log
stderr_logfile=/tmp/node21.log

[program:node22]
command=start_indy_node Node22 $HOST 9743 $HOST 9744
directory=/home/indy
stdout_logfile=/tmp/node22.log
stderr_logfile=/tmp/node22.log

[program:printlogs]
command=tail -F /tmp/supervisord.log /tmp/node1.log /tmp/node2.log /tmp/node3.log /tmp/node4.log /tmp/node5.log /tmp/node6.log /tmp/node7.log /tmp/node8.log /tmp/node9.log /tmp/node10.log /tmp/node11.log /tmp/node12.log /tmp/node13.log /tmp/node14.log /tmp/node15.log /tmp/node16.log /tmp/node17.log /tmp/node18.log /tmp/node19.log /tmp/node20.log /tmp/node21.log /tmp/node22.log
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0

EOF

echo "Starting indy nodes"
supervisord
