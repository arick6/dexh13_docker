# Docker 镜像使用说明

### Ubuntu 下安装


# 1. 更新包索引并安装依赖项
```bash
sudo apt update
```
```
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
# 7. 构建 Docker 镜像
在项目根目录（包含 `Dockerfile`、`gsl.tar.gz`、`eigen-3.3.7.tar.gz`、SDK 安装包等文件）下运行：
```bash
docker build -t dexh13-ubuntu:22.04 .
```
# 7. 运行并进入容器
启动容器(没有添加相机访问权限):
```bash
docker run -it \
  --name dexh13 \
  --device=/dev/ttyUSB0 \
  --group-add dialout \
  -v /path/to/examples/dexh13:/app/ \
  dexh13-ubuntu:22.04
```

# Docker 构建缓慢或失败
可用鱼香的一键docker配置


