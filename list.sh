#!/usr/bin/bash
function dnf_list {
   filename="installed_dnf_"
   dnf info --installed | grep -e ^Name -e ^Summary | sed -e ':a;N;$!ba;s/\nSummary[ ]\+:/\t/g' | sed -e 's/Name[ ]\+: //g' > ${filename}
   return 0
}

function pip_list {
   if [[ $1 -ne 2  && $1 -ne 3 ]]; then
      echo "Give me an argument"
      return -1
   fi
   
   filename="installed_pip_"
   if [[ $1 -eq 2 ]]; then
      python -m pip list > ${filename}
   else
      filename=${filename%_}3_
      python3 -m pip list > ${filename}
   fi
   
   # it's bad, but it's fine for this task
   sed '1,2d' ${filename} | echo "$(cut -d' ' -f1)" > ${filename}
   # without quotes in echo, newlines are lost
   
   return 0
}

function pip_check {
   if [[ $1 -ne 2  && $1 -ne 3 ]]; then
      echo "Give me an argument"
      return -1
   fi
   
   dnffile="installed_dnf"
   pipfile="installed_pip"
   pattern="python2-"
   resultfile="list_pip"
   if [[ $1 -eq 3 ]]; then
      pipfile=${pipfile}3
      resultfile=${resultfile}3
      pattern=${pattern%2-}3-
   fi
   
   # use tab as delimiter
   dnf_names=$(cat ${dnffile} | cut -d$'\t' -f1)
   
   while read LINE
   do
      echo ${LINE}
      echo "${dnf_names}" | grep -i -e "${pattern}${LINE}"
      echo "---"
   done < ${pipfile} > ${resultfile}
}

# while read LINE
# do
#    i=1
#    perl -i -pe 's{---}{++$n == '"$i"' ? '"${LINE}"'__ : $&}ge' res
#    #awk "/---/{c+=1}{if(c==$i){sub('---',${LINE},$0)};print}" res
#    #sed -i "s/---/${LINE}/${i}" res
#    ((i++))
# done < pip_installed

# while read LINE
# do
#    if [[ ${LINE} =~ __(.+)__ ]]
#    then
#       sed -i 's/'"${BASH_REMATCH[1]}"'/__&__/' pip_installed
#       sed -i 's/'"${BASH_REMATCH[1]}"'/__&__/' pip3_installed
#    fi
# done < res

