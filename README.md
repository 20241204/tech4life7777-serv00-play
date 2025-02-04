# serv00 上的一些应用，包括 批量保号、TG消息推送
> frankiejun 和 tech4life7777 大佬的脚本已经被我修改仅保留推送功能，只需要保号推送消息就行
![访问量](https://visitor-badge.glitch.me/badge?page_id=frankiejun-tech4life7777-serv00-play.visitor-badge)

## 前置工作

1. 你需要有一个 serv00 帐号

## 变量说明

| 变量名          | 示例   | 备注                                     |
| --------------- | ------ | ---------------------------------------- |
| HOSTS_JSON      | 见示例 | 可存放 n 个服务器信息                    |
| TELEGRAM_TOKEN  | 略     | telegram 机器人的 token                  |
| TELEGRAM_USERID | 略     | 待通知的 teltegram 用户 ID               |

## HOSTS_JSON 的配置实例

```js
 {
   "info": [
    {
      "host": "s2.serv00.com",
      "username": "kkk",
      "port": 22,
      "password": "fdsafjijgn"
    },
    {
      "host": "s2.serv00.com",
      "username": "bbb",
      "port": 22,
      "password": "fafwwwwazcs"
    }
  ]
}
```

## action 保活内容
1.定时自动登录各个主机，起到保号作用(因 serv00 需要每 3 个月登录一次)  
2.执行兜底保活策略  
3.同步更新 telegram 参数  

## 消息推送
支持向 Telegram 用户发送通知

## 项目鸣谢
[frankiejun](https://github.com/frankiejun/serv00-play)、[tech4life7777](https://github.com/tech4life7777/serv00-play)


## 免责声明
本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 代码、数据及图片均有所属版权, 如转载须注明来源。
使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责。
