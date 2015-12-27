update-binary:
	mkdir -p  /home/jfesler/work/src
	env GOROOT=/usr/local/go GOPATH=/home/jfesler/work /usr/local/go/bin/go get -u github.com/falling-sky/go-gslb
	env GOROOT=/usr/local/go GOPATH=/home/jfesler/work /usr/local/go/bin/go build github.com/falling-sky/go-gslb
	sudo setcap 'cap_net_bind_service=+ep' `pwd`/go-gslb
	sudo cp upstart/go-gslb.conf /etc/init/
	sudo service go-gslb restart

