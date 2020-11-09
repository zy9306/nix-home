set -e

dest=$PWD

cd

tar zcvf .zplug.tar.gz .zplug

mv .zplug.tar.gz $dest
