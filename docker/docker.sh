#!/bin/sh
# 1.安装 docker
base_dir=~/k8s-1.16
yum remove docker \
                    docker-client \
                    docker-client-latest \
                    docker-common \
                    docker-latest \
                    docker-latest-logrotate \
                    docker-logrotate \
                    docker-selinux \
                    docker-engine-selinux \
                    docker-engine 
rm -rf /etc/systemd/system/docker.service.d 
rm -rf /var/lib/docker
rm -rf /var/run/docker
systemctl stop firewalld && systemctl disable firewalld
iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat && iptables -P FORWARD ACCEPT
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
rpm -ivh $base_dir/docker/*.rpm --nodeps --force
systemctl enable docker
systemctl start docker
cat << EOF >> /etc/docker/daemon.json 
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "insecure-registries": ["0.0.0.0/0"]
}
EOF
systemctl restart docker
