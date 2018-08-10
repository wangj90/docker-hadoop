FROM ubuntu
MAINTAINER 王俊 "wang_j90@126.com"
# 修改软件源
COPY sources.list /etc/apt
RUN apt-get update
# 安装oracle-java8
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true                                                                                             | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer
# 下载并解压hadoop3.1.1
RUN mkdir /usr/lib/hadoop
RUN wget -P /usr/lib/hadoop http://www.trieuvan.com/apache/hadoop/common/hadoop-                                                                                            3.1.1/hadoop-3.1.1.tar.gz
RUN tar -xzf /usr/lib/hadoop/hadoop-3.1.1.tar.gz -C /usr/lib/hadoop
RUN rm /usr/lib/hadoop/hadoop-3.1.1.tar.gz
# 删除所有更新的软件
RUN apt-get clean all
