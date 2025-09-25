# Claude Code Statusline Docker

Docker 容器化 Claude Code 开发环境，带有自定义状态栏显示。

## 功能特性

- 基于 Ubuntu Noble 镜像，配置中国源
- 集成 Claude Code CLI 工具
- 自定义状态栏脚本，提供丰富的会话信息
- 中文开发环境优化
- 持久化数据存储

## 快速开始

### 构建镜像

```bash
./build.sh
```

### 启动容器

```bash
./start.sh
```

### 使用 Docker Compose

```bash
docker-compose run --rm claude-code-statusline
```

## 项目结构

```
.
├── dockerfile              # 容器构建配置
├── docker-compose.yml     # Docker Compose 配置
├── statusline.sh          # 自定义状态栏脚本
├── settings.json          # Claude Code 配置文件
├── build.sh              # 构建脚本
├── start.sh              # 启动脚本
├── projects/             # 代码项目目录
└── .claude/              # Claude Code 配置和插件
```

## 状态栏功能

自定义状态栏显示以下信息：
- 当前目录信息
- Git 状态
- 模型信息
- 上下文使用情况
- 会话数据
- Token 计数
- 消耗速率

## 数据持久化

容器挂载以下目录实现数据持久化：
- `./projects:/root/projects` - 代码项目
- `./.claude/plugins:/root/.claude/plugins` - Claude Code 插件
- `./.claude/projects:/root/.claude/projects` - 项目元数据
- `./.claude/shell-snapshots:/root/.claude/shell-snapshots` - Shell 会话快照
- `./.claude/statsig:/root/.claude/statsig` - Statsig 配置
- `./.claude/todos:/root/.claude/todos` - 待办事项
- `./.claude/settings.json:/root/.claude/settings.json` - Claude Code 设置
- `./.claude/statusline.sh:/root/.claude/statusline.sh` - 状态栏脚本

## 环境配置

- **API 端点**: `https://open.bigmodel.cn/api/anthropic`
- **模型**: `glm-4.5`
- **认证**: 通过环境变量传递 API 密钥

## 开发流程

1. 将代码项目放置在 `projects/` 目录
2. 运行 `./build.sh` 构建镜像
3. 运行 `./start.sh` 启动 Claude Code
4. 在容器内，项目位于 `/root/projects` 目录
5. 通过挂载的卷实现配置和插件持久化

## 中文开发环境

容器针对中文开发者优化：
- 使用 BFSU (北京外国语大学) 源
- 中国 npm 源 (`registry.npmmirror.com`)
- `cnpm` 包管理器加速安装
- 中文注释和文档

## 许可证

本项目采用 MIT 许可证。