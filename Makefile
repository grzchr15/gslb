update-binary:
	mkdir -p  $(HOME)/work/src
	git pull
	env GOROOT=/usr/local/go GOPATH=$(HOME)/work /usr/local/go/bin/go get -u github.com/falling-sky/go-gslb
	env GOROOT=/usr/local/go GOPATH=$(HOME)/work /usr/local/go/bin/go build github.com/falling-sky/go-gslb
	sudo setcap 'cap_net_bind_service=+ep' `pwd`/go-gslb
	sudo cp upstart/go-gslb.conf /etc/init/
	sudo service go-gslb restart

