## VM Creation
### Create VM on portal.azure.com
1. Open ports: 22, 80, 443, 3389
2. Setup password
3. Setup DNS
### Add disk
1. Create disk on portal.azure.com
2. Attach disk to VM
3. SSH to VM:
    - find device
    ```
    $ dmesg | grep -i scsi
    [    1.554664] sd 1:0:1:0: [sdb] Attached SCSI disk
    [    1.659058] sd 0:0:0:0: [sda] Attached SCSI disk
    [    2.208637] sd 3:0:0:0: [sdc] Attached SCSI disk
    ```
    - format disk
    ```
    $ sudo fdisk /dev/sdc # sdc is return by previous command
    ```
    - make file system
    ```
    $ sudo mkfs -t ext4 /dev/sdc1
    ```
    - mount file system
    ```
    $ sudo mkdir /data
    $ sudo mount /dev/sdc1 /data
    ```
    - get uuid of file system, and copy the output
    ```
    $ sudo -i blkid
    /dev/sdc1: UUID="0ed882e6-55ea-41cd-bc2b-f1945d365c4d" TYPE="ext4" PARTUUID="68643a49-01"
    ```
    - add line to **```/etc/fstab```**
    ```
    UUID=0ed882e6-55ea-41cd-bc2b-f1945d365c4d       /media/data     ext4    defaults,discard        1       2
    ```
    - trim file system to drop unused blocks
    ```
    $ sudo apt install util-linux
    $ sudo fstrim /data
    ```
    - change default home to /data/home by editing file **```/etc/default/useradd ```** and **```/etc/adduser.conf```**
## Setup HTTPS
> **_NOTE_**: DNS must work before HTTPS setup
### Generate certificates
### Setup NGINX
## Setup Development Environment
## Setup Deployment Environment
