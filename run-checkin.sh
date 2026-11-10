#!/usr/bin/env bash
# ============================================================================
# run-checkin.sh — WorkBuddy 每日自动签到封装脚本
#
# 作用: 进入项目目录执行签到，并把输出追加到日志文件。
# 由 crontab 每天 09:00 调用；也可手动执行 ./run-checkin.sh 立即签到。
#
# 注意: 真正签到成功的前提是 auths/ 下已存在有效的 workbuddy-<uid>.json 凭证。
#       没有凭证时脚本会输出提示并正常退出，不会报错崩溃。
# ============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="${SCRIPT_DIR}/logs"
LOG_FILE="${LOG_DIR}/checkin.log"

mkdir -p "$LOG_DIR"

cd "$SCRIPT_DIR"

echo "============================================================"
echo "  WorkBuddy 签到任务启动 — $(date '+%Y-%m-%d %H:%M:%S')"
echo "============================================================"

# 批量签到
python3 workbuddy_checkin.py signin || true

# 附上积分日报
python3 workbuddy_checkin.py credit || true

echo "  任务结束 — $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
