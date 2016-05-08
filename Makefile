update-binary:
	mkdir -p  $(HOME)/work/src
	git pull
	env GOROOT=/usr/local/go GOPATH=$(HOME)/work /usr/local/go/bin/go get -u -d github.com/falling-sky/go-gslb
	env GOROOT=/usr/local/go GOPATH=$(HOME)/work /usr/local/go/bin/go build github.com/falling-sky/go-gslb
	ls -l `pwd`/go-gslb
	sudo setcap 'cap_net_bind_service=+ep' `pwd`/go-gslb
	sudo service gslb stop ; true
	pkill -x go-gslb ; true
	sudo service gslb start
	sleep 1
	ps auxww |grep go-gsl

install-upstart:
	sudo cp upstart/gslb.conf /etc/init/

install-systemd:
	sudo cp systemd/gslb.service /lib/systemd/system/gslb.service
	sudo systemctl enable gslb.service
	sudo systemctl restart gslb.service
	

update-maxmind:
	mkdir -p download
	cd download && wget http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum2.zip
	cd download && wget http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum2v6.zip
	cd download && unzip GeoIPASNum2.zip && mv GeoIPASNum2.csv ..
	cd download && unzip GeoIPASNum2v6.zip && mv GeoIPASNum2v6.csv ..
	rm download/GeoIPASNum2*zip
	