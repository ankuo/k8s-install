kubeadm reset
systemctl stop kubelet
systemctl stop docker
rm -rf /var/lib/cni/
rm -rf /var/lib/kubelet/*
rm -rf /etc/cni/
rm -rf /etc/kubernetes
rm -rf /root/.kube
ifconfig cni0 down
ifconfig fiannel.1 down
ifocnfig docker0 down
ip link delete cni0
ip link delete flannel.1
systemctl restart kubelet
systemctl restart docker
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
