#!/bin/bash
sudo apt-get update
sudo apt-get install -y jq
sudo apt-get install -y docker.io
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo kubeadm init --apiserver-advertise-address=$1 --pod-network-cidr=$2
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
sleep 15
kubectl get nodes
CERT_HASH=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')
TOKEN=$(kubeadm token list -o json | jq -r '.token' | head -1)
IP=$(kubectl get nodes -lnode-role.kubernetes.io/master -o json | jq -r '.items[0].status.addresses[] | select(.type=="InternalIP") | .address')
PORT=6443
echo "sudo kubeadm join $IP:$PORT --token=$TOKEN --discovery-token-ca-cert-hash sha256:$CERT_HASH"