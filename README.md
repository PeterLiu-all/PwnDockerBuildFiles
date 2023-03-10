# PWN Docker Build Files

本仓库包含了16.04~22.04四个版本的pwn docker，集成了一般的工具和作者个人喜欢的工具

## 使用方法

首先在docker-compose.yml中更改volumes为你自己的共享文件夹

就是这里：

```dockerfile
volumes:
      - //d/database_BooksAndFiles/VMware/share_files/:/security/
```

前面的是主机要共享的文件夹，后面的是映射到docker的文件夹

然后在有docker或者docker desktop的情况下，运行install.xx脚本，或者使用如下命令：

```bash
docker-compose build
docker-compose up -d
```

然后`docker exec -it ubpwn<版本号> /bin/bash`就可以启动docker了

build的过程会有一点慢，大概二十多分钟

欢迎师傅们指教！