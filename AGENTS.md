# AGENTS.md

此文件为在此代码库中工作的 AI Agent 提供指导。

## 项目概述

这是一个带有自定义状态栏实现的 Claude Code Docker
容器设置。该项目创建了一个便携式开发环境，包含 Claude Code CLI
工具，配置了中文软件包镜像和自定义状态栏脚本，以提供增强的视觉反馈。

## 开发命令

### 构建和运行

- `./build.sh` - 构建 Docker 镜像 (`claude-code-statusline-sshd:latest`)
- `./start.sh` - 在 Docker 容器中启动 Claude Code
- ` docker compose  up -d` - 备用启动方法

### Docker 命令

- `docker build -t claude-code-statusline-sshd .` - 手动构建
- `docker compose -f docker-compose.yml run --rm claude-code-statusline-sshd` - 使用
  compose 运行

## 架构

### 容器配置

- **基础镜像**: debian trixie 配置中文镜像源 (BFSU)
- **Node.js**: 22.x 版本，使用中文 npm 镜像源
- **包管理器**: 使用 `cnpm` 在中国境内加速包安装
- **Claude Code**: 通过 npm 全局安装，带有自定义配置

### 卷挂载

Docker 容器挂载多个目录以实现持久化：

- `./projects:/root/projects` - 您的代码项目目录
- `./.claude/plugins:/root/.claude/plugins` - Claude Code 插件
- `./.claude/projects:/root/.claude/projects` - Claude Code 项目元数据
- `./.claude/shell-snapshots:/root/.claude/shell-snapshots` - Shell 会话快照
- `./.claude/statsig:/root/.claude/statsig` - Statsig 配置
- `./.claude/todos:/root/.claude/todos` - 待办事项跟踪
- `./.claude/settings.json:/root/.claude/settings.json` - Claude Code 设置
- `./.claude/statusline.sh:/root/.claude/statusline.sh` - 自定义状态栏脚本

### 状态栏系统

- **脚本**: `statusline.sh` - 自定义 bash 脚本，用于增强 Claude Code 状态显示
- **功能**: 目录信息、git
  状态、模型信息、上下文使用情况、会话数据、令牌计数、消耗速率
- **主题**: 现代化设计，使用自定义颜色
- **日志记录**: 状态事件记录到 `.claude/statusline.log`

### 环境配置

- **API 端点**: 使用 `https://open.bigmodel.cn/api/anthropic` 作为基础 URL
- **模型**: 配置为 `glm-4.5` 模型
- **身份验证**: API 密钥通过环境变量传递 (参见 docker-compose.yml)

## 关键文件

- `dockerfile` - 容器构建配置，基于 debian 和中文镜像源
- `docker-compose.yml` - 服务定义，包含卷挂载和环境变量
- `statusline.sh` - 自定义状态栏实现，带有彩色输出和日志记录
- `settings.json` - Claude Code 配置，指向自定义状态栏脚本
- `build.sh` / `start.sh` - 构建和运行的便捷脚本

## 开发工作流程

1. 将您的代码项目放置在 `projects/` 目录中
2. 运行 `./build.sh` 构建 Docker 镜像
3. 运行 `./start.sh` 启动 Claude Code
4. 您的项目将在容器内的 `/root/projects` 中可用
5. Claude Code 配置和插件通过挂载的卷持久化

## 中文开发环境

容器针对中文开发者进行了优化：

- BFSU (北京外国语大学) 软件包镜像源
- 中文 npm 镜像源 (`registry.npmmirror.com`)
- `cnpm` 包管理器以实现更快的安装
- 配置文件中的中文注释和文档
