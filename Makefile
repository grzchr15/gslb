update-binary:
	mkdir -p  $(HOME)/work/src
	git pull
	env GOROOT=/usr/local/go GOPATH=$(HOME)/work /usr/local/go/bin/go get -u github.com/falling-sky/go-gslb
	env GOROOT=/usr/local/go GOPATH=$(HOME)/work /usr/local/go/bin/go build github.com/falling-sky/go-gslb
	sudo setcap 'cap_net_bind_service=+ep' `pwd`/go-gslb
	sudo cp upstart/gslb.conf /etc/init/
	sudo service gslb stop ; true
	pkill -x go-gslb ; true
	sudo service gslb start
	sudo tail -f /var/log/upstart/gslb.log

update-maxmind:
	mkdir -p download
	cd download && wget http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum2.zip
	cd download && wget http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum2v6.zip
	cd download && unzip GeoIPASNum2.zip && mv GeoIPASNum2.csv ..
	cd download && unzip GeoIPASNum2v6.zip && mv GeoIPASNum2v6.csv ..
	rm download/GeoIPASNum2*zip
	