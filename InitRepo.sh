#!/bin/bash

CreateRepo(){
	echo "====================Initing repo....:===================="
	git init | tee log.s
	
	echo "===============please enter you repo URL:================"
	read repoUrl
	#git remote add picture ${repoUrl} 
	echo "===============your repo Url is ${repoUrl}==============="
}


:<<EOF
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



spiltUrl=https://github.com/codegitz/images.git

baseURL=https://raw.githubusercontent.com/
#codegitz/upload/master/

#https://raw.githubusercontent.com/codegitz/images/master/Xshell_GEmdcwQlQQ.png

#https://raw.githubusercontent.com/codegitz/upload/master/Xshell_GEmdcwQlQQ.png


 
arr=(${spiltUrl///// })
tmpURL=${baseURL}${arr[3]}${arr[4]}
picURL=${tmpURL%.*}
echo ${picURL}
#cat ./name.s |awk  -F ' '  '{print $1}' 
EOF




git config -l |grep https | awk  -F '='  '{print $2}'



