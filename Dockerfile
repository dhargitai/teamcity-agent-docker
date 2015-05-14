FROM ariya/centos7-oracle-jre7

MAINTAINER Hargitai Dávid <diatigrah@gmail.com>

ADD docker/setup-agent.sh /setup-agent.sh
RUN chmod +x /setup-agent.sh
RUN yum -y install wget unzip

EXPOSE 9090
CMD ["/setup-agent.sh", "run"]
