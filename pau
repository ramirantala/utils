#!/bin/bash


select FN in $(senza list -o tsv | grep -v stack_name | tr -s '\011' ' ' | cut -d" " -f1-2 | tr -s " " ":"); do
	 echo $REPLY: $FN;
	 stack_name=`echo "$FN" | cut -d":" -f1`
	 stack_version=`echo "$FN" | cut -d":" -f2`
	 echo $stack_name
	 echo $stack_version
	 instances=`senza instances $stack_name $stack_version -o tsv | grep -v stack_name | xargs | cut -d" " -f5`
	 echo $instances
	 cmd=`piu $instances "troubleshooting" | tail -1`

	 $cmd
	 exit 0
done
