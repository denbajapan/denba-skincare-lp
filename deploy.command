#!/bin/bash
# DENBA Skincare - 自動デプロイ
# このファイルをダブルクリックするだけでGitHubにpushされ、Netlifyが自動デプロイします

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

echo "================================"
echo " DENBA Skincare デプロイ開始"
echo "================================"
echo ""

# 変更をすべてステージング
git add index.html images/ _headers netlify.toml

# 変更があるか確認
if git diff --cached --quiet; then
  echo "変更はありません。"
  echo ""
  read -p "Enterを押して閉じる..."
  exit 0
fi

# コミット＆push
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
git commit -m "Update: $TIMESTAMP"
git push origin main
git push denbajapan main

if [ $? -eq 0 ]; then
  echo ""
  echo "================================"
  echo " GitHubにpush完了！"
  echo " Netlifyが自動デプロイ中..."
  echo " https://prismatic-arithmetic-fe5136.netlify.app"
  echo "================================"
else
  echo "pushに失敗しました。"
fi

echo ""
read -p "Enterを押して閉じる..."
