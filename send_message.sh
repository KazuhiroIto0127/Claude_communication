#!/bin/bash

# Claude Code間メッセージ送信スクリプト
# 使用方法: ./send_message.sh [target] [message]

SESSION_NAME="claude_communication"

# ターゲットの定義
get_target() {
    case $1 in
        "instructor"|"指示役")
            echo "$SESSION_NAME:0.0"
            ;;
        "worker"|"作業役")
            echo "$SESSION_NAME:0.1"
            ;;
        *)
            echo "不明なターゲット: $1"
            echo "利用可能なターゲット: instructor(指示役), worker(作業役)"
            exit 1
            ;;
    esac
}

# メッセージ送信
send_message() {
    local target=$1
    local message=$2
    
    # セッションが存在するかチェック
    if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
        echo "エラー: tmuxセッション '$SESSION_NAME' が見つかりません"
        echo "先に ./setup_communication.sh を実行してください"
        exit 1
    fi
    
    # ターゲットを取得
    local tmux_target=$(get_target $target)
    if [ $? -ne 0 ]; then
        echo $tmux_target
        exit 1
    fi
    
    # メッセージを送信
    echo "メッセージを送信中: $target → '$message'"
    
    # 確実にプロンプトをクリアしてメッセージを送信
    tmux send-keys -t "$tmux_target" C-c
    sleep 0.3
    tmux send-keys -t "$tmux_target" "$message"
    sleep 0.1
    tmux send-keys -t "$tmux_target" C-m
    
    echo "送信完了"
}

# ヘルプ表示
show_help() {
    echo "Claude Code間メッセージ送信スクリプト"
    echo ""
    echo "使用方法:"
    echo "  $0 [target] [message]"
    echo ""
    echo "ターゲット:"
    echo "  instructor, 指示役  - 指示役Claude Codeに送信"
    echo "  worker, 作業役      - 作業役Claude Codeに送信"
    echo ""
    echo "例:"
    echo "  $0 worker 'プロジェクトの構造を確認してください'"
    echo "  $0 instructor '作業が完了しました'"
    echo ""
    echo "オプション:"
    echo "  --help, -h          - このヘルプを表示"
    echo "  --list, -l          - 利用可能なターゲットを表示"
}

# 利用可能なターゲット表示
show_targets() {
    echo "利用可能なターゲット:"
    echo "  instructor (指示役)"
    echo "  worker (作業役)"
}

# メイン処理
main() {
    case $1 in
        "--help"|"-h")
            show_help
            exit 0
            ;;
        "--list"|"-l")
            show_targets
            exit 0
            ;;
        "")
            echo "エラー: ターゲットとメッセージを指定してください"
            show_help
            exit 1
            ;;
    esac
    
    if [ $# -lt 2 ]; then
        echo "エラー: ターゲットとメッセージの両方を指定してください"
        show_help
        exit 1
    fi
    
    send_message "$1" "$2"
}

# スクリプト実行
main "$@"