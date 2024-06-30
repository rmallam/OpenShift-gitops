#cloud-config
user: rakesh
password: rakesh
chpasswd: { expire: False }
#runcmd:
#  - cat <<EOF > /etc/yum.repos.d/mariadb.repo
#    [mariadb]
#    name = MariaDB
#    baseurl = https://rpm.mariadb.org/10.6/rhel/$releasever/$basearch
#    gpgkey= https://rpm.mariadb.org/RPM-GPG-KEY-MariaDB
#    gpgcheck=1
##    EOF
# # - sudo yum install -y mariadb
