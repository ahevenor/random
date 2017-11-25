run: build
	PORT=8080 POLL_DURATION=10s bin/random

build: clean
	go build -o bin/random

clean:
	rm -f bin/random

docker-run:
	docker run --rm -t -d -p 8080:8080 enocom/random:latest

docker-build: clean docker-bin
	docker build -t enocom/random:latest .

docker-bin:
	CGO_ENABLED=0 \
	GOOS=linux \
	GOARCH=amd64 \
	    go build \
	    -a \
	    -installsuffix nocgo \
	    -o ./bin/random \
	    github.com/enocom/random
