FROM alpine:3.9

ENV K3S_VERSION "v1.18.17%2Bk3s1"

RUN apk -U --no-cache add bash iptables && \
    wget https://github.com/k3s-io/k3s/releases/download/${K3S_VERSION}/k3s -O /bin/k3s && \
    chmod +x /bin/k3s && \
    mkdir -p /etc && \
    chmod 1777 /tmp 

VOLUME [/var/lib/kubelet]
VOLUME [/var/lib/rancher/k3s]
VOLUME [/var/lib/cni]
VOLUME [/var/log]

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/bin/aux
ENV CRI_CONFIG_FILE=/var/lib/rancher/k3s/agent/etc/crictl.yaml

ENTRYPOINT ["/bin/k3s"]
CMD ["agent"]
