# openshift-s2i-tomcat-svn
openshift s2i镜像，从svn拉取代码，maven构建WAR，部署到tomcat服务器上。

Dockerfile在使用时需要进行修改。其中COPY ./CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo是为了换yum源。rm -rf /usr/share/maven/conf/settings.xml和ADD ./settings.xml /usr/share/maven/conf/是修改镜像中maven的配置，指向自己的maven库。

博客地址http://blog.csdn.net/huqigang/article/details/78338376
