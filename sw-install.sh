#!/bin/bash

#open 80 and 443 into firewall
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

#update system
yum update -y

#install GPG key for Spacewalk repository
cd /etc/pki/rpm-gpg
curl -s -O http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015
rpm --import RPM-GPG-KEY-spacewalk-2015

#install GPG key for EPEL repository
cd /etc/pki/rpm-gpg
curl -s -O https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
rpm --import RPM-GPG-KEY-EPEL-7

#install GPG key for Java packages repository
cd /etc/pki/rpm-gpg
curl -s https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/java-packages/pubkey.gpg > java-packages.gpg
rpm --import java-packages.gpg

#install Spacewalk repository
rpm -Uvh http://yum.spacewalkproject.org/2.7/RHEL/7/x86_64/spacewalk-repo-2.7-2.el7.noarch.rpm

#install EPEL repository
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

#install Java packages repository
cd /etc/yum.repos.d
curl -s -O https://copr.fedorainfracloud.org/coprs/g/spacewalkproject/java-packages/repo/epel-7/group_spacewalkproject-java-packages-epel-7.repo

#install postgresql database server
yum -y install spacewalk-setup-postgresql

#install spacewalk using postgresql as database server
yum -y install spacewalk-postgresql

#create spacewalk unattanded installation file into root home direcotry
cat > /root/spacewalk-answer-file << EOF
admin-email = root@localhost
ssl-set-cnames = spacewalk2
ssl-set-org = Spacewalk Org
ssl-set-org-unit = spacewalk
ssl-set-city = My City
ssl-set-state = My State
ssl-set-country = US
ssl-password = spacewalk
ssl-set-email = root@localhost
ssl-config-sslvhost = Y
db-backend=postgresql
db-name=spaceschema
db-user=spaceuser
db-password=spacepw
db-host=localhost
db-port=5432
enable-tftp=Y
EOF

#enable postgresql at startup
systemctl enable postgresql

#create first postgresql contend.. directories and stuff
postgresql-setup initdb

#start postgresql
systemctl start postgresql
if [ $? -eq 0 ]; then

su - postgres -c psql <<<"update pg_database set datistemplate=false where datname='template1';"
su - postgres -c psql <<<"drop database template1;"
su - postgres -c psql <<<"create database template1 with owner=postgres encoding='UTF-8' lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0;"
su - postgres -c psql <<<"update pg_database set datistemplate=true where datname='template1';"

#spacewalk silent install
spacewalk-setup --answer-file=/root/spacewalk-answer-file

else
echo postgresql is not running
fi
