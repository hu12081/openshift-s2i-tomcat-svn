
# openshift-tomcat8-svn
FROM docker.io/centos

# TODO: Put the maintainer name in the image metadata
MAINTAINER huliaoliao

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 3.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
      io.k8s.description="Platform for building tomcat" \
      io.k8s.display-name="builder tomcat" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,tomcat,java,etc." 
      
# TODO: Install required packages here:
COPY ./CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum makecache &&  yum install -y java-1.8.0-openjdk subversion maven && yum clean all -y

#COPY ./s2i/bin/ /usr/libexec/s2i

# TODO (optional): Copy the builder files into /opt/app-root
COPY ./tomcat8/ /opt/app-root/tomcat8

# TODO: Copy the S2I scripts to /usr/local/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN useradd -m tomcat -u 1002 && \
    chmod -R a+rw /opt && \
    chmod -R a+rw /opt/app-root && \
    chmod a+rwx /opt/app-root/tomcat8/* && \
    chmod +x /opt/app-root/tomcat8/bin/*.sh && \
    rm -rf /opt/app-root/tomcat8/webapps/* && \
    rm -rf /usr/share/maven/conf/settings.xml
ADD ./settings.xml /usr/share/maven/conf/

# This default user is created in the openshift/base-centos7 image
USER 1002

# TODO: Set the default port for applications built using this image
EXPOSE 8080
ENTRYPOINT []
# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
