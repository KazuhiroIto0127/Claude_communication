# Claude Communication

tmuxで２つのpaneを使い、Claude Codeをそれぞれ立ち上げて、片方が指示役で、目的の遂行を目指す。もう片方が作業役で作業を行う実験プロジェクト。

## 使用方法

```bash
./setup_communication.sh
```

- 上pane: 指示役 Claude Code
- 下pane: 作業役 Claude Code

## ファイル構成

- `setup_communication.sh` - tmuxセッション設定スクリプト
- `instructor_auto_prompt.md` - 指示役プロンプト
- `worker_auto_prompt.md` - 作業役プロンプト
- `send_message.sh` - メッセージ送信スクリプト
- `communication_protocol.md` - コミュニケーション仕様
- `demo_scenario.md` - デモシナリオ
