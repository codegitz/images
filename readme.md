# Shell上传图片到Github

这个脚本完成了简单的上传图片到github，然后返回可以直接访问的URL，可以用于做小图床

## 要求

1.一个新的github仓库

2.本地安装好`git bash`环境，配置ssh更为方便

3.存在配置文件`conf/upload.conf`

模板如下：

```
#github仓库地址，最好是新建一个，太老旧的仓库有历史遗留问题
repoUrl=https://github.com/codegitz/testImages.git

#可以上传的格式,添加只需满足 |txt|*|....这个格式
format=gif|png|jpg

#github图床的基本路径
baseURL=https://raw.githubusercontent.com/
```



## 示例

新建一个文件夹，里面放上Shell脚本和配置文件。

![](https://raw.githubusercontent.com/codegitz/pictures/master/explorer_VkEFfUIsR7.png)

在当前文件夹打开git bash，授予shell执行权限

```shell
 chmod +x upload.sh
```

然后执行脚本

```shell
 ./upload.sh
```

如下，按照提示执行操作，先查看配置文件是否正确，然后执行shell

![](https://raw.githubusercontent.com/codegitz/pictures/master/Vd6Fp9G89A.gif)



打开最后返回的URL，可以访问到图片。

![](https://raw.githubusercontent.com/codegitz/pictures/master/chrome_CJdMShVyZX.png)



# 最后

温馨提示，因为这个是匆匆写完，所以最好是新建一个github仓库来做仓库地址，老旧版本的仓库会有很多问题出现冲突，分支冲突，历史冲突等等问题，此shell尚未解决。