# 修改软件源
COPY sources.list /etc/apt

# 安装VIM、SSH、中文语言包、JDK8、HADOOP
# 设置本机ssh免密登录
RUN apt-get update && \
        apt-get install -y vim && \
        apt-get install -y openssh-server && \
        apt-get install -y language-pack-zh-hans && \
        apt-get install -y software-properties-common && \
        add-apt-repository ppa:webupd8team/java && \
        apt-get update && \
        echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
        apt-get install -y oracle-java8-installer && \
        mkdir /usr/lib/hadoop && \
        cd /usr/lib/hadoop && \
        wget http://www.trieuvan.com/apache/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz && \
        tar -xzf hadoop-3.1.1.tar.gz && \
        apt-get clean && \
        apt-get autoclean && \
        apt-get autoremove && \
        rm -rf /var/lib/apt/lists/* hadoop-3.1.1.tar.gz && \
        sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
        ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa && \
        cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
        sed -i "s|`cat /etc/ssh/ssh_config | grep StrictHostKeyChecking`|StrictHostKeyChecking no|g" /etc/ssh/ssh_config && \
        chmod 600 ~/.ssh/authorized_keys

# 配置JAVA、HADOOP环境变量
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV HADOOP_HOME /usr/lib/hadoop/hadoop-3.1.1
ENV PATH $JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH

# 配置中文语言包的环境变量
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8

EXPOSE 22
EXPOSE 8080
CMD ["bash","-c","service ssh start;bash"]
