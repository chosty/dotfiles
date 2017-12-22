# PATH関連

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# sublime
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin":$PATH

# zsh-comp
fpath=(/usr/local/share/zsh-completions $fpath)

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init -)"

# java
export JAVA_HOME=`/usr/libexec/java_home`

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# prompt
PROMPT="%c $ "

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
