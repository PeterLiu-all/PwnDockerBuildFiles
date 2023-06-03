**This README has a English version, please scroll down or [click here](#english-versiontranslated-by-gpt35)**

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

然后你可以自己写一些脚本来简化启动、停止、删除的过程，我这里提供了一些bash脚本供参考（在scripts文件夹下），如有错漏欢迎指出

build的过程会有一点慢，大概二十多分钟

其中比较麻烦的是Ubuntu16，因为Ubuntu16中能下载的最高版本的python不支持pwngdb新版（不支持f""字符串等），而且gdb是有一个指定的python版本的，pwngdb又是依赖于这个指定的python，而这个指定的python版本在gdb编译过程中是写死的，所以我在dockerfile中手动编译了gdb和python。同时又由于Ubuntu16的ruby版本过低，无法下载one_gadget和seccomp-tools，因此又通过极其复杂的方法下载了最新版ruby（怎么还要密钥啊喂）

欢迎师傅们指教！

# English Version（translated by gpt3.5）

## PWN Docker Build Files

This repository contains PWN Docker images for four versions of Ubuntu: 16.04 to 22.04. These images are integrated with commonly used tools and tools preferred by the author.

### Usage

First, modify the `volumes` field in the `docker-compose.yml` file to your own shared folder. It looks like this:

```dockerfile
volumes:
      - //d/database_BooksAndFiles/VMware/share_files/:/security/
```

The first part is the folder you want to share from the host, and the second part is the folder you want to map to the Docker container.

Then, if you have Docker or Docker Desktop installed, run the `install.xx` script or use the following commands:

```bash
docker-compose build
docker-compose up -d
```

After that, you can start the Docker container by running `docker exec -it ubpwn<version> /bin/bash`.

You can also write some scripts to simplify the startup, shutdown, and deletion processes. Some sample Bash scripts are provided in the `scripts` folder. Please feel free to suggest any corrections.

The build process may take a while, approximately twenty minutes.

The most complicated image to build is Ubuntu 16, because the latest version of Python that can be downloaded in Ubuntu 16 does not support the latest version of pwngdb (which uses f-strings). Moreover, gdb has a specific version of Python that it depends on, and this version of Python is hard-coded into the gdb compilation process. Therefore, the Dockerfile manually compiles gdb and Python. Also, because the Ruby version in Ubuntu 16 is too low, one_gadget and seccomp-tools cannot be downloaded. To solve this problem, the author downloaded the latest version of Ruby using a complex method (which requires a key).

Any suggestions or comments from experts are welcome!
