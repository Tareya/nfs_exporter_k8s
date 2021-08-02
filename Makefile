
all: build 

deps: 
	GO111MODULE=on GOPROXY=https://goproxy.cn,direct go mod tidy

clean: 
	rm -rf build/*

build: deps
	mkdir -p build

	# FreeBDS
	#	GOOS=freebsd GOARCH=amd64 go build -o build/nfs_exporter-freebsd-amd64/nfs_exporter .

	# MacOS
	# GOOS=darwin GOARCH=amd64 go build -o build/nfs_exporter-darwin-amd64/nfs_exporter .
		
	# Linux
	GOOS=linux GOARCH=amd64 go build -o build/nfs_exporter-linux-amd64/nfs_exporter .
	
  
release: build
	# tar -czf build/nfs_exporter-freebsd-amd64.tar.gz build/nfs_exporter-freebsd-amd64
	# tar -czf build/nfs_exporter-darwin-amd64.tar.gz build/nfs_exporter-darwin-amd64
	tar -czf build/nfs_exporter-linux-amd64.tar.gz build/nfs_exporter-linux-amd64
	

docker-build: clean build
	docker rmi -f nfs_exporter:latest
	docker build  -t nfs_exporter --network=host .


docker-push: docker-build
	docker tag nfs_exporter:latest tareya/nfs_exporter:latest
	docker push tareya/nfs_exporter:latest