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

# 上下分割でpaneを作成
tmux split-window -v -t $SESSION_NAME:0

# 上pane: 指示役 (Instructor)
tmux send-keys -t $SESSION_NAME:0.0 'echo "=== 指示役 Claude Code ==="' C-m
tmux send-keys -t $SESSION_NAME:0.0 'echo "この上paneは指示を出すClaude Codeです"' C-m
tmux send-keys -t $SESSION_NAME:0.0 'echo "準備完了：タスクを貼り付けてください"' C-m
tmux send-keys -t $SESSION_NAME:0.0 'claude "$(cat instructor_auto_prompt.md)"' C-m

# 下pane: 作業役 (Worker)
tmux send-keys -t $SESSION_NAME:0.1 'echo "=== 作業役 Claude Code ==="' C-m
tmux send-keys -t $SESSION_NAME:0.1 'echo "この下paneは作業を実行するClaude Codeです"' C-m
tmux send-keys -t $SESSION_NAME:0.1 'echo "準備完了：指示を待機中..."' C-m
tmux send-keys -t $SESSION_NAME:0.1 'claude "$(cat worker_auto_prompt.md)"' C-m

# セッションにアタッチ
tmux attach-session -t $SESSION_NAME
