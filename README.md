# easy-deploy
自动化重启tomcat的脚本，手工替换掉war包后，运行此脚本以重启tomcat



### Introduction

重启tomcat需要执行一系列的步骤，包括执行shutdown脚本，清理缓存，再执行startup脚本。有时候因为进程的原因，shutdown脚本并不能完全将tomcat关闭，还需要使用ps、kill等命令将tomcat进程杀死，如果经常要部署重启项目，绝对是十分繁琐和痛苦的。所以考虑将这一系列步骤用脚本自动化。



脚本的执行步骤为：

1.获取该tomcat的pid

2.检测pid是否存在，存在则进行shutdown和kill操作

3.清理tomcat目录下的缓存

4.重启tomcat

5.控制台打印tomcat启动日志



### Usage

1.将easydeploy脚本放到tomcat的bin目录下

2.编辑配置文件

```sh
# DEFINE
tomcat_name="xxxxx";
war_name="xxxxx"
```

tomcat_name为tomcat文件夹的名字

war_name为部署的项目war包名字

3.执行脚本即可

