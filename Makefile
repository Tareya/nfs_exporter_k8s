
all: build 

deps: 
	GO111MODULE=on GOPROXY=https://goproxy.cn,direct go mod tidy

clean: 
	rm -rf build/*

build: deps
	mkdir -p build

	# FreeBDS
	#	GOOS=freebsd GOARCH=amd64 go build -o build/nfs_exporter_k8s-freebsd-amd64/nfs_exporter_k8s .

	# MacOS
	# GOOS=darwin GOARCH=amd64 go build -o build/nfs_exporter_k8s-darwin-amd64/nfs_exporter_k8s .
		
	# Linux
	GOOS=linux GOARCH=amd64 go build -o build/nfs_exporter_k8s-linux-amd64/nfs_exporter_k8s .
	
  
release: build
	# tar -czf build/nfs_exporter_k8s-freebsd-amd64.tar.gz build/nfs_exporter_k8s-freebsd-amd64
	# tar -czf build/nfs_exporter_k8s-darwin-amd64.tar.gz build/nfs_exporter_k8s-darwin-amd64
	tar -czf build/nfs_exporter_k8s-linux-amd64.tar.gz build/nfs_exporter_k8s-linux-amd64
	

docker-build: clean build
	docker rmi -f nfs_exporter_k8s:latest
	docker build  -t nfs_exporter_k8s:latest --network=host .


docker-push: docker-build
	docker tag nfs_exporter_k8s:latest tareya/nfs_exporter_k8s:latest
	docker push tareya/nfs_exporter_k8s:latest