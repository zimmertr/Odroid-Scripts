Both Odroids:
    sudo pacman -Syu
    su root
    useradd tj -u 9999
    mkdir /home/tj
    passwd tj
    pacman -S sudo
    visudo
    sudo passwd root
    userdel alarm
    rm -rf /home/alarm
    sudo chown tj /home/tj
    
    pacman -S vim git binutils make gcc fakeroot tree
    cd /home/tj/git 
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    
    yay -S docker docker-compose
    sudo systemctl daemon-reload
    sudo systemctl enable docker
    sudo systemctl start docker
    
    sudo vim /usr/bin/hw_status.sh
    sudo chmod +x /usr/bin/hw_status.sh


Sputnik:
    mkdir -p /home/tj/docker/unifi/config
    vim docker-compose.yml
    --------------------------------------------------------------
    version: '3'
    services:
        unifi:
            image: linuxserver/unifi-controller:arm32v6-latest
            restart: unless-stopped
            container_name: unifi
            ports:
                - 3478:3478/udp
                - 10001:10001/udp
                - 8080:8080
                - 8081:8081
                - 8443:8443
                - 8843:8843
                - 8880:8880
                - 6789:6789
            volumes:
                - /home/tj/docker/unifi/config:/config
            environment: 
                - PUID=9999
                - PGID=9999
        bind:
            image: zimmertr/bind:latest
            restart: unless-stopped
            container_name: bind
            ports:
                - 53:53/udp
                - 53:53/tcp
            volumes:
                - /home/tj/docker/BIND/:/etc/named/zones/
    --------------------------------------------------------------
    sudo docker-compose up -d


Explorer:
    mkdir -p /home/tj/pihole/{etc,dnsmasq.d}
    touch /home/tj/docker/pihole/pihole.log
    vim docker-compose.yml
    sudo systemctl stop systemd-resolved
    sudo systemctl disable systemd-resolved
    --------------------------------------------------------------
    version: '3'
    services:
        pihole:
            image: pihole/pihole:latest
            restart: unless-stopped
            container_name: pihole
            ports:
                - 53:53/udp
                - 67:67/udp
                - 53:53/tcp
                - 80:80/tcp
                - 443:443/tcp
            volumes:
                - /home/tj/docker/pihole/etc:/etc/pihole/
                - /home/tj/docker/pihole/dnsmasq.d:/etc/dnsmasq.d/
                - /home/tj/docker/pihole/pihole.log:/var/log/pihole.log
            environment: 
                DNS1: "8.8.8.8"
                DNS2: "8.8.4.4"
                IPv6: "False"
                ServerIp: "192.168.1.176"
                TZ: 'America/Los_Angeles'
                WEBPASSWD: "PASSWORD"
            dns:
                - 127.0.0.1
                - 1.1.1.1
    --------------------------------------------------------------
    sudo docker-compose up -d

