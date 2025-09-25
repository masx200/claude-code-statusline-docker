from  library/ubuntu:noble 


run cat > /etc/apt/sources.list <<EOF

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb http://mirrors.bfsu.edu.cn/ubuntu/ noble main restricted universe multiverse
deb-src http://mirrors.bfsu.edu.cn/ubuntu/ noble main restricted universe multiverse
deb http://mirrors.bfsu.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
deb-src http://mirrors.bfsu.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
deb http://mirrors.bfsu.edu.cn/ubuntu/ noble-backports main restricted universe multiverse
deb-src http://mirrors.bfsu.edu.cn/ubuntu/ noble-backports main restricted universe multiverse

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
deb http://mirrors.bfsu.edu.cn/ubuntu/ noble-security main restricted universe multiverse
deb-src http://mirrors.bfsu.edu.cn/ubuntu/ noble-security main restricted universe multiverse

# 预发布软件源，不建议启用
deb http://mirrors.bfsu.edu.cn/ubuntu/ noble-proposed main restricted universe multiverse
deb-src http://mirrors.bfsu.edu.cn/ubuntu/ noble-proposed main restricted universe multiverse

EOF


run cat > /etc/apt/sources.list.d/ubuntu.sources <<EOF

Types: deb
URIs: http://mirrors.bfsu.edu.cn/ubuntu
Suites: noble noble-updates noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
Types: deb-src
URIs: http://mirrors.bfsu.edu.cn/ubuntu
Suites: noble noble-updates noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
Types: deb
URIs: http://mirrors.bfsu.edu.cn/ubuntu
Suites: noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb-src
URIs: http://mirrors.bfsu.edu.cn/ubuntu
Suites: noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 预发布软件源，不建议启用

Types: deb
URIs: http://mirrors.bfsu.edu.cn/ubuntu
Suites: noble-proposed
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb-src
URIs: http://mirrors.bfsu.edu.cn/ubuntu
Suites: noble-proposed
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

EOF



run apt update 
run apt install apt-transport-https ca-certificates -y jq bash sudo

copy ./statusline.sh /root/.claude/statusline.sh

workdir /root
run chmod +x .claude/statusline.sh

run curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash - 
run apt install -y nodejs npm

run apt clean && rm -rfv /var/lib/apt/lists/*


run npm config set registry https://registry.npmmirror.com
run npm install -g cnpm --registry=https://registry.npmmirror.com


run cnpm install -g @anthropic-ai/claude-code corepack pnpm @chongdashu/cc-statusline
RUN cat >  /root/.claude/settings.json <<EOF
{
  "statusLine": {
    "type": "command",
    "command": ".claude/statusline.sh",
    "padding": 0
  }
}
EOF
ENTRYPOINT [ "npx" ,"-y", "@anthropic-ai/claude-code" ]


env ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/anthropic"
# env ANTHROPIC_API_KEY="${API_KEY_AND_AUTH_TOKEN}"
# env ANTHROPIC_AUTH_TOKEN="${API_KEY_AND_AUTH_TOKEN}"

env ANTHROPIC_MODEL="glm-4.5"