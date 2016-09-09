
NGINX_COMPLIE_ARGS = \
--with-cc-opt='' \
--with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module \
--with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module \
--with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_v2_module \
--with-http_sub_module --with-http_xslt_module --with-stream --with-stream_ssl_module --with-mail --with-mail_ssl_module --with-threads

lrzsz:
	tar -zxvf lrzsz-0.12.20.tar.gz
	cd lrzsz-0.12.20
	./configure && make && make install
	cd ..
	cd /usr/bin
	ln -s /usr/local/bin/lrz rz
	ln -s /usr/local/bin/lsz sz
	cd -

ntpdate:
	yes | apt-get install ntpdate
	# ntpdate 210.72.145.44
	# @echo "0  *    * * *   root    /usr/sbin/ntpdate 192.168.165.145 >> /var/log/nptdate.log" >> /etc/crontab

tmux:
	tar -zxvf tmux-2.2.tar.gz
	cd tmux-2.2
	./configure && make && make install

editor:
	yes | apt-get install vim

build-tools:
	@echo "============================ build-tools ========================"
	# yes | apt-get install make
	yes | apt-get install gcc
	yes | apt-get install g++
	yes | apt-get install cmake
	yes | apt-get install ctags
	yes | apt-get install automake
	yes | apt-get install autoconf
	@echo "======================================================================"

haproxy:
	unzip haproxy-1.6.0.zip && \
	cd haproxy-1.6.0 && \
	make TARGET=linux2628 && make install && \
	cd ..

keepalived:
	tar -zxvf keepalived-1.2.21.tar.gz && \
	cd keepalived-1.2.21/ && \
	./configure && make && \
	cd ..

memcached:
	tar -zxvf memcached-1.4.25.tar.gz  && \
	cd memcached-1.4.25 && \
	./configure && make && make install && \
	cd ..

redis:
	@echo "============================ redis ================================="
	tar -zxvf redis-3.2.1.tar.gz && \
	cd redis-3.2.1 && \
	make && make install && \
	./utils/install_server.sh && \
	cd ..
	@echo "======================================================================"

mysql-5.6.24:
	@echo "============================= mysql =================================="
	yes | apt-get install libaio1 && \
	unzip mysql-deb-5.6.24.zip && \
	dpkg -i mysqldeb/mysql-common_5.6.24-1debian7_amd64.deb && \
	dpkg -i mysqldeb/mysql-community-server_5.6.24-1debian7_amd64.deb && \
	dpkg -i mysqldeb/mysql-community-client_5.6.24-1debian7_amd64.deb
	@echo "======================================================================"

mysql-5.7.10:
	@echo "============================= mysql =================================="
	yes | apt-get install libaio1 && \
	unzip mysql-server_5.7.10-1debian7_amd64.deb-bundle.zip -d mysql-server_5.7.10 && \
	dpkg -i mysql-server_5.7.10/mysql-common_5.7.10-1debian7_amd64.deb && \
	dpkg -i mysql-server_5.7.10/mysql-community-server_5.7.10-1debian7_amd64.deb && \
	dpkg -i mysql-server_5.7.10/mysql-community-client_5.7.10-1debian7_amd64.deb
	@echo "======================================================================"

mysql-5.7.10-debian8:
	@echo "============================= mysql =================================="
	yes | apt-get install libaio1 && \
	unzip mysql-server_5.7.10-1debian8_amd64.deb-bundle.zip -d mysql-server_5.7.10-1debian8_amd64.deb-bundle && \
	dpkg -i mysql-server_5.7.10-1debian8_amd64.deb-bundle/mysql-common_5.7.10-1debian8_amd64.deb && \
	dpkg -i mysql-server_5.7.10-1debian8_amd64.deb-bundle/mysql-community-server_5.7.10-1debian8_amd64.deb && \
	dpkg -i mysql-server_5.7.10-1debian8_amd64.deb-bundle/mysql-community-client_5.7.10-1debian8_amd64.deb
	@echo "======================================================================"

mongodb:
	@echo "============================ mongodb ================================="
	yes | apt-get install mongodb && \
	service mongodb stop && \
	tar -zxvf mongodb-linux-x86_64-3.2.7.tgz && \
	cp mongodb-linux-x86_64-3.2.7/bin/* /usr/bin -R && \
	echo "never" > /sys/kernel/mm/transparent_hugepage/defrag && \
	echo "never" > /sys/kernel/mm/transparent_hugepage/enabled && \
	service mongodb start
	# 注意：此处mongodb使用了旧版本的配置文件
	@echo "======================================================================"

nginx:
	@echo "============================= nginx =================================="
    apt-get install build-essential libpcre3-dev zlib1g-dev libssl-dev libxml2-dev libxslt1-dev libgeoip-dev && \
	tar -zxvf nginx-1.10.0.tar.gz && \
	cd nginx-1.10.0 && \
	./configure ${NGINX_COMPLIE_ARGS} && make && make install && \
	/usr/local/nginx/sbin/nginx && \
	cd ..
	@echo "======================================================================"

openresty:
	@echo "=========================== openresty ================================"
	tar -zxvf ngx_openresty-1.9.3.1.tar.gz && \
	cd ngx_openresty-1.9.3.1 && \
	./configure && make && make install && \
	cd -
	@echo "======================================================================"

node:
	@echo "============================== node =================================="
	tar -zxvf node-v4.4.4-linux-x64.tar.gz && \
	cp node-v4.4.4-linux-x64/* /usr -R
	@echo "======================================================================"

gm:
	@echo "============================== GraphicsMagick ========================"
	unzip gm.zip -d gm && \
	cd gm && \
	chmod u+x install.sh && \
	./install.sh && \
	cd -
	@echo "======================================================================"

all: lrzsz ntpdate editor build-tools redis mysql mongodb nginx node pm2 gm
