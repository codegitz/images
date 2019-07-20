#!/bin/bash

id=`sed '/^ID=/!d;s/.*=//' ./config.conf`  
ip=`sed '/^IP=/!d;s/.*=//' ./config.conf`  
name=`sed '/^Name=/!d;s/.*=//' ./config.conf`  
echo $id  
echo $ip  
echo $name 
