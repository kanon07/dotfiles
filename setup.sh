#https://qiita.com/w-tdon/items/24348728c9256e5bf945

set -u
#DOT_DIRECTORY="${HOME}/dotfiles"
DOT_DIRECTORY=$(cd $(dirname $0); pwd)
DOT_CONFIG_DIRECTORY=".config"

echo "link home directory dotfiles"
cd ${DOT_DIRECTORY}
mkdir -p ${HOME}/.backup
for f in .??*
do
    #無視したいファイルやディレクトリ
    [ "$f" = ".git" ] && continue
    [ "$f" = ".config" ] && continue
    cp ${HOME}/${f} ${HOME}/.backup/
    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

echo "link .config directory dotfiles"
cd ${DOT_DIRECTORY}/${DOT_CONFIG_DIRECTORY}
for file in `\find . -maxdepth 8 -type f`; do
#./の2文字を削除するためにfile:2としている
    ln -snfv ${DOT_DIRECTORY}/${DOT_CONFIG_DIRECTORY}/${file:2} ${HOME}/${DOT_CONFIG_DIRECTORY}/${file:2}
done

source ~/.bashrc
echo "linked dotfiles complete!"
