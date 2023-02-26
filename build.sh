#!/usr/bin/env bash
rm -fr release && mkdir release

git clone https://github.com/naiba/nezha || exit $?
cd nezha

export CGO_ENABLED='0'
export GOROOT_FINAL='/usr'
export GOOS='linux'
export GOARCH='amd64'

go get -d -t -u -v ./... || exit $?
go mod tidy || exit $?
go build -trimpath -asmflags '-s -w' -ldflags '-s -w' -o nezha-agent ./cmd/agent || exit $?
go build -trimpath -asmflags '-s -w' -ldflags '-s -w' -o nezha-dashboard ./cmd/dashboard || exit $?

mv -f nezha-agent ../release
mv -f nezha-dashboard ../release
exit 0
