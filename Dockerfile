FROM fedora:20

RUN yum update -y -q; yum clean all

ENV container docker

# Setup systemd
RUN yum install -y -q systemd; yum clean all; \
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum install -y -q nrpe; yum clean all
RUN systemctl enable nrpe.service
RUN sed -e 's/^server_address=127.0.0.1/#server_address=127.0.0.1/' \
        -e 's/^allowed_hosts=127.0.0.1/#allowed_hosts=127.0.0.1/' \
        -i /etc/nagios/nrpe.cfg

EXPOSE 5666

CMD ["/usr/sbin/init"]
