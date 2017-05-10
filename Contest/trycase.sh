GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

for let in "${@}"
do
    echo "PROBLEM ${let}"
    cont=1
    zsh ./compile.sh ${let}
    DIR=./data/${let}
    while [ -e ${DIR}/test/test${cont} ]
    do
        file=test${cont}
        echo "Running test ${cont}"
        bin/${let}.out < ${DIR}/test/${file} > ${DIR}/ans/out${cont}
        if [ -e ${DIR}/ans/ans${cont} ]; then
            if cmp -s ${DIR}/ans/ans${cont} ${DIR}/ans/out${cont} ; then
                echo "TEST ${cont}:${RED} WRONG ANSWER ${NC}"
            else
                echo "TEST ${cont}:${GREEN} ACCEPTED ${NC}"
            fi
        fi
        ((cont++))
    done
done
