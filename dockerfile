

from docker.cnb.cool/masx200/docker_mirror/systemd-sshd:latest

copy ./etc/ssh/sshd_config /etc/ssh/sshd_config
copy ./usr/lib/systemd/system/ssh.service /usr/lib/systemd/system/ssh.service






run cat > /etc/apt/sources.list <<EOF


# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie main contrib non-free non-free-firmware
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-updates main contrib non-free non-free-firmware
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-updates main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-backports main contrib non-free non-free-firmware
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-backports main contrib non-free non-free-firmware

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security trixie-security main contrib non-free non-free-firmware
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security trixie-security main contrib non-free non-free-firmware

EOF


run cat > /etc/apt/sources.list.d/debian.sources <<EOF



Types: deb
URIs: https://mirrors.tuna.tsinghua.edu.cn/debian
Suites: trixie trixie-updates trixie-backports
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
Types: deb-src
URIs: https://mirrors.tuna.tsinghua.edu.cn/debian
Suites: trixie trixie-updates trixie-backports
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
Types: deb
URIs: https://mirrors.tuna.tsinghua.edu.cn/debian-security
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb-src
URIs: https://mirrors.tuna.tsinghua.edu.cn/debian-security
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

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


run cnpm install -g @anthropic-ai/claude-code corepack pnpm @chongdashu/cc-statusline yarn
RUN cat >  /root/.claude/settings.json <<EOF
{
  "statusLine": {
    "type": "command",
    "command": ".claude/statusline.sh",
    "padding": 0
  }
}
EOF



env ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/anthropic"


env ANTHROPIC_MODEL="glm-4.5"

cmd [ "/sbin/init" ]