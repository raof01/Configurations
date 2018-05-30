# Guacamole Setup
## Install Dependencies
1. install from apt
```
sudo apt install xfce4
sudo apt install gcc-6 g++-6
sudo apt install tightvncserver
sudo apt install tomcat8
sudo apt install nginx
````
2. install java: download from java.oracle.com, and unzip file:
```
sudo mkdir /usr/java && sudo tar xvfz jdk.tar.gz -C /usr/java --strip-components=1
sudo update-alternatives --install /usr/bin/java java /usr/java/bin/java 0
sudo ln -s /usr/java /usr/lib/jvm/default-java
```
## Build guacamole server from source
1. download guacamole server & client from https://guacamole.apache.org
2. install dependent libraries
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
```
## Configure Users
```
sudo mkdir /etc/guacamole
```
1. user-mapping.xml
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
## Configuration NGINX
## Configuration SSL
