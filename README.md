# nfs_exporter_k8s
A Prometheus NFS exporter for K8S.

## Installation

```
git clone https://github.com/Tareya/nfs_exporter_k8s.git 

cd nfs_exporter_k8s/

make
```

## Docker build

```
docker rmi -f nfs_exporter_k8s:latest 
docker build  -t nfs_exporter_k8s --network=host .

```

## k8s usage

```
# Push the docker image to your registry and change config in yaml folder
# then deploy nfs exporter to kubernetes

kubectl apply -f ./yaml
```

## Usage of `nfs_exporter_k8s`

| Option                    | Default             | Description
| ------------------------- | ------------------- | -----------------
| -h, --help                | -                   | Displays usage.
| --web.listen-address      | `:9102`             | The address to listen on for HTTP requests.
| --web.metrics-path        | `/metrics`          | URL Endpoint for metrics
| --nfs.address             | `127.0.0.1:/xxxxx, 127.0.0.2:/xxx`  | The nfs server IP Path address
| --version                 | -                   | Prints version information



## Reference
[https://github.com/aixeshunter/nfs_exporter](https://github.com/aixeshunter/nfs_exporter)
