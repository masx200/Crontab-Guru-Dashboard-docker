# Crontab-Guru-Docker

## 项目介绍

Crontab-Guru-Docker 是一个基于 Docker 容器化的 Crontab
监控仪表板项目。该项目使用 Cronitor CLI 来提供 Cron 任务的监控和管理功能，通过
Web 界面直观地展示定时任务的执行状态。

## 功能特性

- 📊 可视化的 Cron 任务监控仪表板
- 🐳 完全容器化部署，便于管理和扩展
- 🔧 支持自定义网络配置（IPv4/IPv6）
- 🛡️ 安全的容器配置，最小化权限
- 🌏 支持多时区配置
- 📈 实时任务执行状态监控

## 系统要求

- Docker >= 20.10
- Docker Compose >= 1.29
- 支持 IPv6 的网络环境（可选）

## 安装教程

### 1. 克隆项目

```bash
git clone <your-repo-url>
cd crontab-guru-dashboard-docker
```

### 2. 配置环境变量

编辑 `docker-compose.yml` 文件，修改以下环境变量：

```yaml
environment:
  - "YOUR_USERNAME_HERE=your_actual_username"
  - "YOUR_PASSWORD_HERE=your_actual_password"
```

### 3. 创建数据目录

创建必要的持久化数据目录：

```bash
mkdir -p /vol1/1000/crontab-guru-dashboard/etc/cronitor
mkdir -p /vol1/1000/crontab-guru-dashboard/root/.config/cronitor
mkdir -p /vol1/1000/crontab-guru-dashboard/var/spool/cron/crontabs
```

### 4. 启动服务

```bash
docker-compose up -d
```

## 使用说明

### 访问仪表板

启动服务后，可以通过以下地址访问监控仪表板：

- 本地访问：`http://localhost:10000`
- 网络访问：`http://your-server-ip:10000`

### 配置 Cron 任务

1. 进入容器：
   ```bash
   docker exec -it crontab-guru-dashboard bash
   ```

2. 编辑 crontab：
   ```bash
   crontab -e
   ```

3. 添加你的定时任务，例如：
   ```bash
   0 */4 * * * /app/nightly_task.sh
   ```

### 监控任务状态

- 通过 Web 界面查看任务执行状态
- 使用 Cronitor CLI 查看详细日志：
  ```bash
  cronitor status
  ```

## 配置说明

### 网络配置

项目支持自定义网络配置，包括 IPv4 和 IPv6：

```yaml
networks:
  kspeeder_default:
    external: true
    driver: bridge
    enable_ipv6: true
    ipam:
      config:
        - subnet: 240.172.0.0/24
          gateway: 240.172.0.1
        - subnet: fc01:db8:1::/64
          gateway: fc01:db8:1::1
```

### 端口映射

默认端口映射：

- 容器端口：9000
- 主机端口：10000

### 数据持久化

以下目录会持久化到主机：

- `/etc/cronitor` - Cronitor 配置文件
- `/root/.config/cronitor` - Cronitor 用户配置
- `/var/spool/cron/crontabs` - Cron 任务表

## 故障排除

### 常见问题

1. **容器无法启动**
   - 检查 Docker 服务是否运行
   - 确认端口 10000 未被占用
   - 检查环境变量配置是否正确

2. **无法访问 Web 界面**
   - 检查防火墙设置
   - 确认端口映射正确
   - 查看容器日志：`docker logs crontab-guru-dashboard`

3. **Cron 任务不执行**
   - 检查 crontab 格式是否正确
   - 确认脚本文件权限
   - 查看系统日志

### 日志查看

```bash
# 查看容器日志
docker logs crontab-guru-dashboard

# 实时查看日志
docker logs -f crontab-guru-dashboard
```

## 维护操作

### 更新镜像

```bash
docker-compose pull
docker-compose up -d --force-recreate
```

### 备份数据

```bash
# 备份配置文件
cp -r /vol1/1000/crontab-guru-dashboard /path/to/backup/
```

### 重启服务

```bash
docker-compose restart
```

## 相关链接

- [Crontab Guru 在线工具](https://crontab.guru/dashboard.html)
- [Cronitor 官方文档](https://cronitor.io/docs)
- [Docker 官方文档](https://docs.docker.com/)

## 许可证

本项目采用 MIT 许可证，详情请参阅 [LICENSE](LICENSE) 文件。

## 贡献

欢迎提交 Issue 和 Pull Request 来改进本项目。

## 联系方式

如有问题或建议，请通过以下方式联系：

- 提交 GitHub Issue
- 发送邮件至项目维护者
