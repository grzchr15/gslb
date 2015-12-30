update-binary:
	mkdir -p  $(HOME)/work/src
	git pull
	env GOROOT=/usr/local/go GOPATH=$(HOME)/work /usr/local/go/bin/go get -u github.com/falling-sky/go-gslb
	env GOROOT=/usr/local/go GOPATH=$(HOME)/work /usr/local/go/bin/go build github.com/falling-sky/go-gslb
	sudo setcap 'cap_net_bind_service=+ep' `pwd`/go-gslb
	sudo cp upstart/gslb.conf /etc/init/
	sudo service gslb stop
	pkill -x go-gslb ; true
	sudo service gslb start
	sudo tail -f /var/log/upstart/gslb.log
