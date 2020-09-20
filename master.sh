base_dir=~/k8s-1.16
kubeadm init --config $base_dir/conf/kubeadm.yaml
mkdir ~/.kube
cp /etc/kubernetes/admin.conf ~/.kube/config
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f $base_dir/conf/kube-flannel.yaml
sleep 5
kubectl apply -f $base_dir/conf/traefik-config.yaml

echo "==================================================================="
echo "      k8s 安装成功 "
echo "      take the kubeadm jonin ...."
echo "==================================================================="

