#!/bin/bash

#HOSTS_JSON='{
#"info": [
#{
#  "host": "s2.serv00.com",
#  "username": "xloong",
#  "port": 22,
#  "password": "abc123"
#}
#]
#}'
#echo "host info:$HOSTS_JSON"
# 使用 jq 提取 JSON 数组，并将其加载为 Bash 数组
hosts_info=($(echo "${HOSTS_JSON}" | jq -c ".info[]"))
tgsend() {
  message_text=$1
  #解析模式，可选HTML或Markdown
  MODE='HTML'
  #api接口
  telegramBotToken=${TELEGRAM_TOKEN}
  telegramBotUserId=${TELEGRAM_USERID}

  URL="https://api.telegram.org/bot${telegramBotToken}/sendMessage"
  if [[ -z ${telegramBotToken} ]]; then
    echo "未配置TG推送"
  else
    res=$(timeout 20s curl -s -X POST $URL -d chat_id=${telegramBotUserId} -d parse_mode=${MODE} -d text="${message_text}")
    if [ $? == 124 ]; then
      echo 'TG_api请求超时,请检查网络是否重启完成并是否能够访问TG'
      exit 1
    fi
    resSuccess=$(echo "$res" | jq -r ".ok")
    if [[ $resSuccess = "true" ]]; then
      echo "TG推送成功"
    else
      echo "TG推送失败，请检查TG机器人token和ID"
    fi
  fi
}

for info in "${hosts_info[@]}"; do
  user=$(echo $info | jq -r ".username")
  host=$(echo $info | jq -r ".host")
  port=$(echo $info | jq -r ".port")
  pass=$(echo $info | jq -r ".password")

  script="uname -a && sleep 10 && ps -o pid,user,%cpu,%mem,comm && exit"
  output=$(sshpass -p "$pass" ssh -o StrictHostKeyChecking=no -p "$port" "$user@$host" "bash -s" <<< "$script")

  echo "output:$output"
  if echo "$output" | grep -q "$host"; then
    echo "登录成功"
    tgsend "登录成功请检查!
主机:$host 用户名:$user,
$output"
  else
    echo "登录失败"
    tgsend "登录失败请检查!
主机:$host 用户名:$user,
$output"
  fi
done
