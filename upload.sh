#!/bin/bash



#Define新建仓库function CreateRepo
CreateRepo(){
	echo "====================Initing repo....:===================="
	git init | tee log.s
	
	echo "===============please enter you repo URL:================"
	read repoUrl
	echo ${repoUrl} >config.s
	git remote add picture ${repoUrl} 
	echo "===============your repo Url is ${repoUrl}==============="
}

#Define上传图片function
upload(){
echo "===================Prepare for upload====================="
git status >NewPic.log
grep -E "gif|png|jpg" NewPic.log >name.s  
grep -E "gif|png|jpg" NewPic.log >>upload_history.s
#name_list=$(cat ./name.s)

#cat ./name.s |awk  -F ' '  '{print $1}' 

git add .
echo "================Enter your commit Message:================"
read commit

echo "your commit is：${commit}"
echo "===================git commiting...======================="
git commit -m"${commit}"
echo "===================git pushing...========================="
git push picture master
echo "===================git push successful===================="

spiltUrl=$(cat ./config.s) 
echo spiltUrl=${spiltUrl}
baseURL=https://raw.githubusercontent.com/codegitz/upload/master/
echo "图片URL为:${baseURL}"
#输出图片URL
LINE=" "
cat ./name.s | while read LINE; do
    echo "picUrl: ${baseURL}${LINE}"
done;
echo "upload successful...."

}
#############################################################
file=".git"
#是否存在仓库
fileflag=false
if [ -d $file ] && [ -e $file ]
then
   echo "=======================检测到Git仓库...====================="
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
      echo "============you choose Do NOT create new repo...========="
	  echo "====================Shell Exiting.....==================="
   fi	  
fi

#存在仓库，上传图片
echo fileflag=${fileflag}
if [ ${fileflag} == true ]
then
   upload 
else
   echo "============找不到Git仓库，Shell退出执行================"
fi
