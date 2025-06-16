#!/bin/bash

# Claude Communication Setup Script
# tmuxで２つのpaneを使い、Claude Codeをそれぞれ立ち上げるスクリプト

SESSION_NAME="claude_communication"

# 既存のセッションがあれば削除
tmux kill-session -t $SESSION_NAME 2>/dev/null

# 新しいセッションを作成（指示役）
tmux new-session -d -s $SESSION_NAME -n instructor

# 作業役用の新しいウィンドウを作成
tmux new-window -t $SESSION_NAME -n worker

# 指示役ウィンドウの設定
tmux send-keys -t $SESSION_NAME:instructor 'echo "=== 指示役 Claude Code ==="' C-m
tmux send-keys -t $SESSION_NAME:instructor 'echo "このウィンドウは指示を出すClaude Codeです"' C-m
tmux send-keys -t $SESSION_NAME:instructor 'echo "準備完了：タスクを貼り付けてください"' C-m
tmux send-keys -t $SESSION_NAME:instructor 'claude' C-m
sleep 2
tmux send-keys -t $SESSION_NAME:instructor '$(cat instructor_auto_prompt.md)' C-m

# 作業役ウィンドウの設定
tmux send-keys -t $SESSION_NAME:worker 'echo "=== 作業役 Claude Code ==="' C-m
tmux send-keys -t $SESSION_NAME:worker 'echo "このウィンドウは作業を実行するClaude Codeです"' C-m
tmux send-keys -t $SESSION_NAME:worker 'echo "準備完了：指示を待機中..."' C-m
tmux send-keys -t $SESSION_NAME:worker 'claude' C-m
sleep 2
tmux send-keys -t $SESSION_NAME:worker '$(cat worker_auto_prompt.md)' C-m

# セッションにアタッチ
tmux attach-session -t $SESSION_NAME
