#!/bin/bash
# Run tests under Travis for continuous integration.

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then 
  export DISPLAY=:99.0
  sh -e /etc/init.d/xvfb start 
  sleep 3  # give xvfb some time to start
fi

# Download the Selenium and ChromeDriver binaries.
go get -d -v
pushd vendor
go get -d -v
go run init.go
popd

# Run the tests. Travis has firefox already installed.
go test -test.v -test.run=TestFirefox --start_frame_buffer=false
