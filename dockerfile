# 使用官方Node.js Alpine基础镜像（推荐LTS版本）
FROM node:22-alpine
run sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories 
# 设置容器内工作目录 
WORKDIR /app

run npm install -g cnpm --registry=https://registry.npmmirror.com
run npm config set registry https://registry.npmmirror.com 
# 安装系统依赖（根据实际需求调整）
RUN apk add --no-cache \
    git sudo\
    python3 \
    make \
    g++

# 全局安装@immich/cli（附加清理缓存步骤减小镜像体积）
RUN cnpm install -g @immich/cli --unsafe-perm \
    && npm cache clean --force \
    && rm -rf /tmp/* 


run sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories
RUN apk add --no-cache  tzdata  # 安装cron和时区工具 



ENV TZ=Asia/Shanghai  

# 设置时区 



RUN echo "0 */4 * * * /app/nightly_task.sh" > /etc/crontabs/root  # 直接写入root的crontab


# Install dependencies
RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates \
    dcron


run mkdir -pv /tmp/usr/local/bin/
# Install cronitor CLI
RUN curl -sL https://gh-proxy.com/https://github.com/cronitorio/cronitor-cli/releases/download/31.6/linux_amd64.tar.gz -o /tmp/usr/local/bin/cronitor.tar.gz 

run sudo tar xvf /tmp/usr/local/bin/cronitor.tar.gz -C /usr/local/bin/
run    chmod +x /usr/local/bin/cronitor
run    rm /tmp/usr/local/bin/cronitor.tar.gz


# Expose dashboard port
EXPOSE 9000

# Run the dashboard
CMD ["bash","-c","cronitor configure --dash-username $YOUR_USERNAME_HERE --dash-password $YOUR_PASSWORD_HERE && cronitor dash --port 9000"]

env TELEMETRY=off


