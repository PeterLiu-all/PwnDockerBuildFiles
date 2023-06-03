Write-Output "正在build镜像文件，大概需要20~30分钟~~"
docker-compose build
Write-Output "正在生成容器，马上就好！"
docker-compose up -d

Write-Output "使用如下命令来打开一个docker终端："
Write-Output 'docker exec -it ubpwn<版本号> /bin/bash，比如：'
Write-Output 'docker exec -it ubpwn18.04 /bin/bash'