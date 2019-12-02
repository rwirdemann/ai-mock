VERSION=`git rev-parse HEAD`
BUILD=`date +%FT%T`
LDFLAGS=-ldflags "-X main.githash=${VERSION} -X main.buildstamp=${BUILD} -s -w"
-include .env

build:
	env GOOS=linux CGO_ENABLED=0 go build ${LDFLAGS} -a -installsuffix cgo -o bin/answers lambda/answers/main.go

clean:
	rm -rf ./bin

deploy-dev: clean build
	sls deploy -s dev

.PHONY: build deploy-dev clean