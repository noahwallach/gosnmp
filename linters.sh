#!/bin/bash

# TODO pillage more from
# - https://gitlab.allegorithmic.com/open-source/go-storage/blob/9fa15deb79fdcb87dff55af662b8ebd51cef4f89/vendor/google.golang.org/grpc/vet.sh

fail_on_output() {
    tee /dev/stderr | (! read)
}

if [ "$TRAVIS_GOARCH" = "amd64" ] ; then
  # travis doesn't install goimports on 386 - WTF?
  echo "=== GOIMPORTS ==="
  goimports -d . 2>&1 | fail_on_output
fi

if [ "$TRAVIS_GOARCH" = "amd64" ] ; then
  echo "=== GOLANGCI-LINT ==="
  # golangci-lint run --out-format line-number 2>&1 | fail_on_output
  # golangci-lint run --out-format line-number
  # golangci-lint run --out-format line-number --new-from-rev d388e71

  # do this until I can get final bug sorted out
  # golangci-lint run -D errcheck -D govet --out-format line-number

  echo $PATH
  go get -u github.com/soniah/golangci-lint
  cd /home/travis/gopath/src/github.com/soniah/golangci-lint && make build && ls
  # TODO build binary, copy to $PATH
  which golangci-lint
  echo "run 1"
  golangci-lint run --out-format line-number --disable-all  -E ineffassign
  echo "run 2"
  golangci-lint run --out-format line-number
fi
