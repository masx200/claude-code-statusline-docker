# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Docker container setup for Claude Code with a custom statusline implementation. The project creates a portable development environment with Claude Code CLI tool, configured with Chinese package mirrors and a custom statusline script for enhanced visual feedback.

## Development Commands

### Building and Running
- `./build.sh` - Build the Docker image (`claude-code-statusline-docker:latest`)
- `./start.sh` - Start Claude Code in the Docker container
- `docker compose run --rm claude-code-statusline` - Alternative start method

### Docker Commands
- `docker build -t claude-code-statusline-docker .` - Manual build
- `docker compose -f docker-compose.yml run --rm claude-code-statusline` - Run with compose

## Architecture

### Container Configuration
- **Base Image**: Ubuntu Noble with Chinese package mirrors (BFSU)
- **Node.js**: Version 22.x with Chinese npm registry
- **Package Manager**: Uses `cnpm` for faster package installation in China
- **Claude Code**: Installed globally via npm with custom configuration

### Volume Mounts
The Docker container mounts several directories for persistence:
- `./projects:/root/projects` - Your code projects directory
- `./.claude/plugins:/root/.claude/plugins` - Claude Code plugins
- `./.claude/projects:/root/.claude/projects` - Claude Code project metadata
- `./.claude/shell-snapshots:/root/.claude/shell-snapshots` - Shell session snapshots
- `./.claude/statsig:/root/.claude/statsig` - Statsig configuration
- `./.claude/todos:/root/.claude/todos` - Todo tracking
- `./.claude/settings.json:/root/.claude/settings.json` - Claude Code settings
- `./.claude/statusline.sh:/root/.claude/statusline.sh` - Custom statusline script

### Statusline System
- **Script**: `statusline.sh` - Custom bash script for enhanced Claude Code status display
- **Features**: Directory info, git status, model info, context usage, session data, token count, burn rate
- **Theme**: Modern sleek with custom colors
- **Logging**: Status events logged to `.claude/statusline.log`

### Environment Configuration
- **API Endpoint**: Uses `https://open.bigmodel.cn/api/anthropic` as base URL
- **Model**: Configured for `glm-4.5` model
- **Authentication**: API keys passed via environment variables (see docker-compose.yml)

## Key Files

- `dockerfile` - Container build configuration with Ubuntu base and Chinese mirrors
- `docker-compose.yml` - Service definition with volume mounts and environment variables
- `statusline.sh` - Custom statusline implementation with colored output and logging
- `settings.json` - Claude Code configuration pointing to the custom statusline script
- `build.sh` / `start.sh` - Convenience scripts for building and running

## Development Workflow

1. Place your code projects in the `projects/` directory
2. Run `./build.sh` to build the Docker image
3. Run `./start.sh` to start Claude Code
4. Your projects will be available at `/root/projects` inside the container
5. Claude Code configuration and plugins persist via mounted volumes

## Chinese Development Environment

The container is optimized for Chinese developers with:
- BFSU (Beijing Foreign Studies University) package mirrors
- Chinese npm registry (`registry.npmmirror.com`)
- `cnpm` package manager for faster installations
- Chinese comments and documentation in configuration files