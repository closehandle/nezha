#!/usr/bin/env bash
rm -fr release && mkdir release

git clone https://github.com/naiba/nezha || exit $?
cd nezha

go get -d -t -u -v ./... || exit $?
go mod tidy || exit $?
go build -a -trimpath -asmflags '-s -w' -ldflags '-s -w' -o nezha-agent ./cmd/agent || exit $?
go build -a -trimpath -asmflags '-s -w' -ldflags '-s -w' -o nezha-dashboard ./cmd/dashboard || exit $?

mv -f nezha-agent ../release
mv -f nezha-dashboard ../release
exit 0
