# Guacamole Setup - from source
## Virtual box shared folder
1. sudo apt-get install virtualbox-guest-utils
2. sudo usermod -aG vboxsf userName
## Install Dependencies
1. install from apt
```
sudo apt install lxde --no-install-recommends gcc-6 g++-6 tightvncserver tomcat8 nginx
````
## Build guacamole server from source
2. download guacamole server & client from https://guacamole.apache.org
3. install dependent libraries
```
sudo apt install libpng-dev libfreerdp-dev libpango1.0-dev libavcodec-dev libavutil-dev libssh2-1-dev libssl1.0-dev libswscale-dev libtelnet-dev libvncserver-dev libvorbis-dev libpulse-dev libwebp-dev libossp-uuid-dev
```
3. build & install guacamole server
```
./configure --with-init-dir=/etc/init.d
make CC=gcc-6
sudo make install
sudo ldconfig
```
4. install guacamole client
```
cp guacamole.war /var/lib/tomcat8/webapps
sudo chown tomcat8:tomcat8 /var/lib/tomcat8/webapps/guacamole.war
```
## Configure Users
```
sudo mkdir /etc/guacamole
```
1. sudo vi /etc/guacamole/user-mapping.xml
```
<user-mapping>
	
    <!-- Per-user authentication and config information -->
    <authorize username="USERNAME" password="PASSWORD">
        <protocol>vnc</protocol>
        <param name="hostname">localhost</param>
        <param name="port">5900</param>
        <param name="password">VNCPASS</param>
    </authorize>

    <!-- Another user, but using md5 to hash the password
         (example below uses the md5 hash of "PASSWORD") -->
    <authorize 
            username="USERNAME2"
            password="319f4d26e3c536b5dd871bb2c52e3178"
            encoding="md5">

        <!-- First authorized connection -->
        <connection name="localhost">
            <protocol>vnc</protocol>
            <param name="hostname">localhost</param>
            <param name="port">5901</param>
            <param name="password">VNCPASS</param>
        </connection>

        <!-- Second authorized connection -->
        <connection name="otherhost">
            <protocol>vnc</protocol>
            <param name="hostname">otherhost</param>
            <param name="port">5900</param>
            <param name="password">VNCPASS</param>
        </connection>

    </authorize>

</user-mapping>
```
2. /usr/bin/vncserver
3. start vncserver
# Configuration NGINX
# Configuration SSL
```
openssl pkcs12 -in /usr/local/nginx/ssl/xxx.pfx -clcerts -nokeys -out /usr/local/nginx/ssl/xxx.crt
openssl pkcs12 -in /usr/local/nginx/ssl/xxx.pfx -nocerts -nodes -out /usr/local/nginx/ssl/xxx.rsa
```
# Boot to text mode
- backup
```
sudo cp -n /etc/default/grub /etc/default/grub.orig
```
- sudo gedit /etc/default/grub
```
1. Comment the line GRUB_CMDLINE_LINUX_DEFAULT=”quiet splash”
2. Change GRUB_CMDLINE_LINUX=”” to GRUB_CMDLINE_LINUX=”text”
3. Uncomment this line #GRUB_TERMINAL=console
```
- update grub
```
sudo update-grub
sudo systemctl set-default multi-user.target
```
## Guacamole setup - Docker
https://guacamole.apache.org
