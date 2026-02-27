# constants.sh

BKSHELL_PATH=''
self_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BKSHELL_PATH=$self_path'/../admin/bk.sh'
echo 'BKSHELL_PATH='$BKSHELL_PATH
