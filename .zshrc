# PATH関連

# GPG
export GPG_TTY=$(tty)

# brew path
export PATH="/usr/local/sbin:$PATH"

# zsh-comp
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit && compinit
fi

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# カラー
autoload -Uz colors
colors

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '[%F{159}%b%f]'
zstyle ':vcs_info:*' actionformats '[%F{159}%b%f(%F{001}%a%f)]'
precmd() { vcs_info }
PROMPT='%{%F{228}%}%~%{${reset_color}%}${vcs_info_msg_0_}
%(?.%B%F{084}.%B%F{219})%(?!(๑˃̵ᴗ˂̵)ﻭ < !(｡>﹏<｡%) < )%f%b'
RPROMPT=''

# 補完
autoload -U compinit
compinit

# historyの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# historyを共有
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# 古いコマンドと同じものは無視
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
# ビープ音消す
setopt nobeep

# コマンド
function find_cd() {
    cd "$(find . * | peco)"
}
alias fc="find_cd"

function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-src () {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
          if [ -n "$selected_dir" ]; then
        selected_dir="~/dev/src/$selected_dir"
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^f' peco-src
