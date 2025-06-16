#!/bin/bash

# Claude Communication Setup Script
# tmuxで２つのpaneを使い、Claude Codeをそれぞれ立ち上げるスクリプト

SESSION_NAME="claude_communication"

# 既存のセッションがあれば削除
tmux kill-session -t $SESSION_NAME 2>/dev/null

# 新しいセッションを作成
tmux new-session -d -s $SESSION_NAME

# セッション名を設定
tmux rename-window -t $SESSION_NAME:0 'Claude-Communication'

# 縦分割でpaneを作成
tmux split-window -h -t $SESSION_NAME:0

# 左pane: 指示役 (Instructor)
tmux send-keys -t $SESSION_NAME:0.0 'echo "=== 指示役 Claude Code ==="' C-m
tmux send-keys -t $SESSION_NAME:0.0 'echo "このpaneは指示を出すClaude Codeです"' C-m
tmux send-keys -t $SESSION_NAME:0.0 'echo "右のpaneの作業役に指示を出してください"' C-m
tmux send-keys -t $SESSION_NAME:0.0 'claude' C-m

# 右pane: 作業役 (Worker)
tmux send-keys -t $SESSION_NAME:0.1 'echo "=== 作業役 Claude Code ==="' C-m
tmux send-keys -t $SESSION_NAME:0.1 'echo "このpaneは作業を実行するClaude Codeです"' C-m
tmux send-keys -t $SESSION_NAME:0.1 'echo "左のpaneからの指示を待機中..."' C-m
tmux send-keys -t $SESSION_NAME:0.1 'claude' C-m

# セッションにアタッチ
tmux attach-session -t $SESSION_NAME
