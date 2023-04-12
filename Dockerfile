FROM debian
RUN apt update && apt-get install wget curl -y \
&& curl -k https://93.90.21.245/CSHELL/snx_install.sh -o snx_install.sh \ 
&& dpkg --add-architecture i386 \
&& apt update && apt-get install -y bzip2 kmod libstdc++5:i386 libpam0g:i386 libx11-6:i386 expect iptables net-tools iputils-ping iproute2 \
&& chmod a+rx snx_install.sh \
&& ./snx_install.sh \
&& ldd /usr/bin/snx 
ENV SNX_PASSWORD="PassEnBase64"
ENV SNX_USER="User"
ENV SNX_SERVER="93.90.21.245"
ADD snx.sh /root
RUN chmod +x /root/snx.sh
CMD ["/root/snx.sh"]
