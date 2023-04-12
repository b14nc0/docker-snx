# docker-snx
Contenedor para vpn snx

**Instalación**

1. git clone http://gitlab.techedgegroup.es/Jorge/vpn-snx.git
2. Editamos el Dockerfile con nuestros datos en la parte de ENV
3. docker build -t vpn-snx:v1 .
4. docker run --name docker-snx -itd --rm --cap-add=ALL -v /lib/modules:/lib/modules -v /dev:/dev --net host vpn-snx:v1

**Parada**

1. docker stop docker-snx

**Borrado**

1. docker image rm vpn-snx:v1
