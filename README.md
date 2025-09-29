# Claude Code Statusline Docker

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![Node.js](https://img.shields.io/badge/Node.js-22.x-green.svg)](https://nodejs.org/)

Docker 容器化的 Claude Code
开发环境，配备自定义状态栏显示，专为中文开发者优化。提供便携式、高性能的 AI
编程助手体验。

## ✨ 核心特性

### 🐳 容器化开发环境

- 基于 Ubuntu Noble 镜像，预配置中文软件包镜像源
- 集成 Claude Code CLI 工具和依赖
- 一键构建和启动，开箱即用

### 🎨 智能状态栏

- 实时显示当前目录、Git 状态、模型信息
- 上下文使用情况监控和可视化进度条
- 会话数据、Token 计数、成本消耗追踪
- 现代化彩色主题，提供直观的视觉反馈

### 🌏 中文优化

- BFSU (北京外国语大学) 软件包镜像源
- 中文 npm 镜像源 (`registry.npmmirror.com`)
- `cnpm` 包管理器加速安装
- 完整的中文文档和注释

### 💾 数据持久化

- 项目代码、配置、插件、会话记录全部持久化
- 通过 Docker 卷挂载实现数据安全存储
- 支持跨会话的状态保持

## 🚀 快速开始

### 前置要求

- [Docker](https://www.docker.com/) (建议版本 20.10+)
- [Docker Compose](https://docs.docker.com/compose/) (建议版本 2.0+)
- API 密钥 (用于 Claude Code 认证)

### 环境配置

1. **克隆项目**

   ```bash
   git clone <repository-url>
   cd claude-code-statusline-sshd
   ```

2. **配置环境变量**

   编辑 `docker-compose.yml` 文件，设置 API 密钥：

   ```yaml
   environment:
     - ANTHROPIC_API_KEY=${API_KEY_AND_AUTH_TOKEN}
     - ANTHROPIC_AUTH_TOKEN=${API_KEY_AND_AUTH_TOKEN}
   ```

   或者创建 `.env` 文件：

   ```bash
   echo "API_KEY_AND_AUTH_TOKEN=your_api_key_here" > .env
   ```

3. **构建镜像**

   ```bash
   ./build.sh
   # 或手动构建
   docker build -t claude-code-statusline-sshd .
   ```

4. **启动容器**
   ```bash
   ./start.sh
   # 或使用 Docker Compose
   docker compose run --rm claude-code-statusline
   ```

### 首次使用

1. 将您的代码项目放入 `projects/` 目录
2. 启动容器后，项目将在容器内的 `/root/projects` 中可用
3. 使用 Claude Code 进行开发，享受增强的状态栏体验

## 📁 项目结构

```
claude-code-statusline-sshd/
├── 📄 README.md              # 项目文档
├── 📄 CLAUDE.md              # Claude Code 使用指南
├── 📄 AGENTS.md              # AI Agent 使用指南
├── 📄 LICENSE                # MIT 许可证
├── 📄 .gitignore             # Git 忽略规则
├── 🐳 dockerfile             # 容器构建配置
├── 🐳 docker-compose.yml     # Docker Compose 配置
├── 📜 statusline.sh          # 自定义状态栏脚本
├── ⚙️ settings.json          # Claude Code 配置
├── 🛠️ build.sh               # 构建脚本
├── 🚀 start.sh               # 启动脚本
├── 📂 projects/              # 代码项目目录
├── 📂 .claude/               # Claude Code 配置目录
├── 📂 etc/                   # 系统配置文件
└── 📂 usr/                   # 用户配置文件
```

## 🎯 状态栏功能详解

### 实时信息显示

状态栏提供三行详细信息：

**第一行 - 核心信息**

- 📁 当前工作目录
- 🌿 Git 分支状态
- 🤖 当前使用的模型
- 🏷️ 模型版本信息
- 📟 Claude Code 版本
- 🎨 输出样式模式

**第二行 - 上下文与会话**

- 🧠 上下文使用情况和剩余百分比
- ⌛ 会话时间和重置倒计时
- 📊 可视化进度条显示

**第三行 - 成本与使用统计**

- 💰 累计成本和消耗速率 ($/小时)
- 📊 Token 使用总数和每分钟速率
- 🔥 实时 burn rate 监控

### 颜色编码系统

- **目录**: 天蓝色 (`#75B5FF`)
- **Git**: 柔和绿色 (`#96E6B3`)
- **模型**: 淡紫色 (`#AFAFFF`)
- **上下文**: 根据剩余量变色 (红色 → 橙色 → 绿色)
- **成本**: 淡金色 (`#FFDEAD`)
- **会话**: 根据剩余时间变色 (粉色 → 黄色 → 绿色)

## 🔧 高级配置

### 自定义状态栏

编辑 `statusline.sh` 文件可以自定义状态栏的显示内容、颜色和行为。脚本支持：

- 自定义颜色主题
- 调整信息显示顺序
- 添加新的监控指标
- 修改进度条样式

### 环境变量配置

通过 `docker-compose.yml` 可以配置以下环境变量：

```yaml
environment:
  - LANG=zh_CN.UTF-8 # 语言设置
  - DEBIAN_FRONTEND=noninteractive # Debian 前端设置
  - EDITOR=nano # 默认编辑器
  - TZ=Asia/Shanghai # 时区设置
  - ANTHROPIC_API_KEY=${API_KEY} # API 密钥
  - ANTHROPIC_AUTH_TOKEN=${API_KEY} # 认证令牌
  - ANTHROPIC_BASE_URL=https://open.bigmodel.cn/api/anthropic # API 端点
  - ANTHROPIC_MODEL=glm-4.5 # 模型选择
```

### 网络配置

容器默认配置了 1Panel 网络，支持 IPv4/IPv6 双栈：

```yaml
networks:
  1panel-network:
    external: true
    driver: bridge
    enable_ipv6: true
    ipam:
      config:
        - subnet: "172.19.20.0/24"
        - subnet: "fc01:db8:21::/64"
```

## 🔍 故障排除

### 常见问题

1. **容器启动失败**

   - 检查 Docker 服务是否运行
   - 确认端口 33333 未被占用
   - 验证 API 密钥配置正确

2. **状态栏不显示**

   - 确认 `statusline.sh` 脚本具有执行权限
   - 检查 `settings.json` 配置路径正确
   - 查看 `.claude/statusline.log` 日志文件

3. **网络连接问题**
   - 检查防火墙设置
   - 确认代理配置（如需要）
   - 验证 API 端点可访问性

### 日志调试

查看状态栏日志：

```bash
tail -f .claude/statusline.log
```

查看容器日志：

```bash
docker logs claude-code-statusline
```

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

1. Fork 本项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 支持

- 📧 通过 GitHub Issues 提交问题
- 📚 查看 [CLAUDE.md](CLAUDE.md) 了解 Claude Code 使用指南
- 🤖 查看 [AGENTS.md](AGENTS.md) 了解 AI Agent 使用指南

---

**⭐ 如果这个项目对您有帮助，请给我们一个 Star！**
