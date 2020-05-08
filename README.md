## 分离 sshd、sftpd 服务

### 测试环境

+ 系统版本：Asianux 4.5 2017 版，理论上 CentOS 6 可行
+ 软件版本：OpenSSH 5.3，OpenSSH 8.1

### 安装步骤

#### 1. Shell 脚本

```bash
cd Shell/
bash setup.sh
```

#### 2. rpmbuild

```bash
yum -y install rpm-build
rpm -qa | grep -P "openssh-\d"       # 查看 OpenSSH 版本
cd OpenSSH[Version]/rpmbuild/SPECS/
rpmbuild -ba sftpd.spec

rpm -ivh sftpd                       # 安装 sftpd
service sftpd start                  # 启动 sftpd
chkconfig sftpd on
```

### 测试结果

```bash
useradd test                         # 添加用户
echo 123123 | passwd --stdin test    # 设置密码

sftp test@localhost                  # 通
ssh test@localhost                   # 通
sftp -oPort=2222 test@localhost      # 通
ssh -p 2222 test@localhost           # 不通
```

