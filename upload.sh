#!/bin/bash

#配置文件变量初始化
spiltUrl=`sed '/^spiltUrl=/!d;s/.*=//' ./config.conf` 


#可以上传的格式,添加只需满足 |txt|*|....这个格式
format="gif|png|jpg"

#Define新建仓库function CreateRepo
CreateRepo(){
	echo "====================Initing repo....:===================="
	git init #| tee log.s
	mkdir -p images
	echo "===========please enter you remote repo URL:============="
	read repoUrl
	echo ${repoUrl} >>config.conf
	#起个别名picture
	git remote add picture ${repoUrl} 
	echo "========your repo Url is ${repoUrl}"
}

#Define上传图片function
#目前只能增加上传图片，删除什么的有问题
upload(){
echo "===================Prepare for the upload====================="

#1.解决很长时间没有使用的仓库push出现Updates were rejected because the tip of your current branch is behind的问题
#2.解决在本地用git add remore origin添加远程库push出现的问题，问题同上

git status  >NewPic.log
echo "===============auto merge conflicts start=================" 
#git pull picture master --allow-unrelated-histories  
#git add . 
#git commit -m"auto merge conflicts"  
echo "===============auto merge conflicts end===================" 
#git status >NewPic.log
grep -E "${format}" NewPic.log >name.s 
grep -E "${format}" NewPic.log >>upload_history.log

#cat ./name.s |awk  -F ' '  '{print $1}' 

git add .
echo "================Enter your commit Message:================"
read commit

echo "your commit is：${commit}"
echo "===================git commiting...======================="
git commit -m"${commit}"
echo "===================git pushing...========================="

echo "===============auto merge conflicts start=================" 
git pull picture master --allow-unrelated-histories  
git add . 
git commit -m"auto merge conflicts"  
echo "===============auto merge conflicts end===================" 

git push picture master

echo "===================git push successful===================="

#spiltUrl=$(cat ./config.conf) 
echo spiltUrl=${spiltUrl}


baseURL=https://raw.githubusercontent.com/
#拼接返回的图片URL
arr=(${spiltUrl///// })  #按/划分URL，存在数组中
tmpURL=${baseURL}${arr[3]}${arr[4]}
picURL=${tmpURL%.*}
echo ${picURL}

#输出图片URL
#LINE=" "
cat ./name.s | while read LINE; do
    if [ "$LINE" = "" ]; 
	then
      echo "没有新增的图片!"
    else 
      echo "picUrl: ${picURL}/master/${LINE}"
    fi
	echo "upload successful...."
    
done;


}
#############################################################
file=".git"
#是否存在仓库
fileflag=false
if [ -d $file ] && [ -e $file ]
then
   echo "=======================检测到Git仓库...====================="
   git config -l |grep remote.*.url | awk  -F '='  '{print $2}' >> config.conf
   fileflag=true
else
   echo ".git文件目录不存在,是否创建一个新的Git repo？(y/n)"
   read isCreate
   #echo ${isCreate}
   if [ ${isCreate} == y ]
   then
      echo "=====================Create new repo...=================="
	  CreateRepo
	  fileflag=true
   else
      echo "============You choose Do NOT create new repo...========="
	  echo "====================Shell Exiting.....==================="
   fi	  
fi

#存在Git仓库，上传图片
#echo fileflag=${fileflag}
if [ ${fileflag} == true ]
then
   upload
   echo "upload"  
else
   echo "=============找不到Git仓库，Shell退出执行================"
fi
