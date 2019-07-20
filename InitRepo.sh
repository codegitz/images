#!/bin/bash

CreateRepo(){
	echo "====================Initing repo....:===================="
	git init | tee log.s
	
	echo "===============please enter you repo URL:================"
	read repoUrl
	#git remote add picture ${repoUrl} 
	echo "===============your repo Url is ${repoUrl}==============="
}



file=".git"
#是否存在仓库
fileflag=false
if [ -d $file ] && [ -e $file ]
then
   fileflag=true
else
   
   echo ".git文件目录不存在,是否创建一个新的Git repo？(y/n)"
   read isCreate
   echo ${isCreate}
   if [ ${isCreate} == y ]
   then
      echo "create new repo..."
	  CreateRepo
	  fileflag=true
   else
      echo "Do not create new repo..."
   fi	  
fi


