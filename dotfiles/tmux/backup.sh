set -e

pwd=$PWD

cd

tar zcv --exclude 'resurrect' -f .tmux.tar.gz .tmux

mv .tmux.tar.gz $pwd
