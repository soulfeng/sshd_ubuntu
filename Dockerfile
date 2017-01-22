# config images of extend
FROM ubuntu:14.04

#author information
MAINTAINER from SunZhiFeng

#begin operation command ,change root of ubuntu into the root of 163 in China



RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list

#install ssh-server
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

#cancel   restrict  of pam 
RUN sed -ri 's/session  required pam_loginuid.so/#session  required  pam_loginuid.so/g'  /etc/pam.d/sshd

#copy config file to relevant position and give script running 
ADD authorized_keys /root/.ssh/authorized_keys
ADD run.sh /run.sh
RUN chmod 755 /run.sh

#dispark  ports
EXPOSE 22

#config AUTO running command
CMD ["/run.sh"]










