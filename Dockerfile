FROM alpine:latest


RUN command sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update \
    && apk add -u coreutils bash \
    && rm -rf /var/lib/apt/lists/*

RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone \
&& apk del tzdata

COPY build/nfs_exporter_k8s-linux-amd64/nfs_exporter_k8s /bin

RUN chmod +x /bin/nfs_exporter_k8s

EXPOSE 9102

ENTRYPOINT ["/bin/nfs_exporter_k8s"]
