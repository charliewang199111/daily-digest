---
name: daily-digest
description: |
  跨境电商每日简报技能。自动生成亚马逊、速卖通、阿里国际站等平台新闻，以及理发工具行业动态。
  支持定时运行（每天早上 9 点）和手动触发。
---

# 跨境电商每日简报技能

自动生成跨境电商行业简报，包含平台政策、行业动态、竞争对手情报等内容。

## 使用方式

### 手动触发

```bash
openclaw daily-digest run
```

### 定时运行（每天早上 9 点）

技能安装时会自动创建 Windows 计划任务。

### 指定接收人

```bash
openclaw daily-digest run --recipient "ou_xxx"
```

## 输出内容

简报包含以下模块：

1. **平台政策更新**
   - 亚马逊美国站
   - 速卖通 (AliExpress)
   - 阿里国际站 (Alibaba.com)

2. **行业动态**
   - 理发工具/美容仪器市场
   - 跨境电商整体趋势

3. **竞争对手情报**
   - 主要卖家动态
   - 新品上架信息

4. **学习资源推荐**
   - 今日推荐文章/视频/课程

5. **明日提醒**
   - 促销活动
   - 截止日期

## 输出格式

- 飞书云文档（自动创建并分享链接）
- 文档标题：`跨境电商每日简报 - YYYY 年 M 月 D 日`

## 配置项

在 `openclaw.json` 中可配置：

```json
{
  "dailyDigest": {
    "enabled": true,
    "schedule": "0 9 * * *",
    "recipient": "ou_e0811fcf1b09df1ee2e7ff4840de5543",
    "topics": [
      "amazon",
      "aliexpress",
      "alibaba",
      "beauty-tools",
      "cross-border"
    ]
  }
}
```

## 新闻源

- 雨果网 (cifnews.com)
- AMZ123 (amz123.com)
- 跨境电商媒体
- 平台官方博客

## 注意事项

- 首次运行需要配置飞书应用权限
- 文档自动创建在用户的飞书云空间
- 支持断网重试机制
