#!/bin/bash

PLACE=`pwd`
if [ $# != 0 ]
then
	if [ $1 = "-h" ]
	then
		echo ". make_shellscript.sh (ファイル名.sh)"
		echo ". make_shellscript.sh (場所) (ファイル名.sh)"
		return 0
	fi
fi
if [ $# = 2 ]
then
	cd $1
	NAME=$2
elif [ $# = 1 ]
then
	NAME=$1
else
	echo "write param ((place)) (file name)"
	return 0
fi
rm -rf ${NAME}
echo "#!/bin/bash

PLACE${NAME%.*}=\`pwd\`
if [ \$# != 0 ]
then
	if [ \$1 = \"-h\" ]
	then
		echo \"説明\"
		echo \". ${NAME}\"
		return 0
	fi
fi
#write progrum

cd \$PLACE${NAME%.*}" >> ${NAME}
cd $PLAcE
