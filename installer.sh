#!/usr/bin/env bash

# 未定義な変数があったら途中で終了する
#set -u

# 今のディレクトリ
# dotfilesディレクトリに移動する
BASEDIR=$(dirname $0)
cd $BASEDIR
files=`find . -type f | sed '/installer.sh/d' | sed 's/^.\///' | sed '/.git\//d'`

# dotfilesディレクトリにある、ドットから始まり2文字以上の名前のファイルに対して
for f in ${files}; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    dirname=`dirname $f`
    mkdir ~/$dirname
    # シンボリックリンクを貼る
    ln -snfv ${PWD}/$f ~/${f}
done
