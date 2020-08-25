# 基础镜像
FROM openjdk:8u262-jdk

LABEL maintainer "jiashiwen@jd.com"

#ENV JAVA_TOOL_OPTIONS=" -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Xms512m -Xmx2G"
ENV JAVA_TOOL_OPTIONS=" -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -Xms512m"
ENV SPRING_ENV="--server.port=80 --syncer.config.path.logfile=/log --syncer.config.path.datafile=/data"

# 对应pom.xml文件中的dockerfile-maven-plugin插件buildArgs配置项JAR_FILE的值
ARG JAR_FILE
# 复制打包完成后的jar文件到/opt目录下
#COPY ${JAR_FILE}  /opt/app.jar
#RUN mkdir -p /opt/redissyncer-monitor && mkdir -p /log && mkdir -p /data
RUN mkdir -p /opt/redissyncer-monitor
COPY ${JAR_FILE} /opt/redissyncer-monitor/redissyncer-monitor.jar
# 启动容器时执行
#CMD java -jar /opt/redissyncer/redissyncer.jar --server.port=80
CMD java -jar /opt/redissyncer-monitor/redissyncer-monitor.jar ${SPRING_ENV} && 1

# 使用端口80
EXPOSE 80
