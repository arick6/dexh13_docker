# dexh13-ubuntu:22.04 Docker 镜像使用说明

## 一、安装 Docker

### Ubuntu 下安装


# 1. 更新包索引并安装依赖项
```bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

# 2. 添加 Docker 官方 GPG key（科学上网）
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```
# 4. 添加 Docker 源
```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
# 5. 更新包索引并安装Docker CE
```bash
sudo systemctl start docker
```
```
sudo systemctl enable docker
```

# 6. 验证Docker安装
```bash
sudo docker --version
```
