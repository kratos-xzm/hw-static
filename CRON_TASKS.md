# 定时任务配置

## 每日马斯克&特朗普新闻汇总

**任务ID：** 554ec0b0-d5b4-4f7f-bc19-2dcb61dd485b

**执行时间：** 每天晚上 21:00（北京时间 GMT+8）

**任务内容：**
1. 访问马斯克 X 账号：https://x.com/elonmusk
2. 访问特朗普 X 账号：https://x.com/realDonaldTrump
3. 抓取当天最新推文（筛选高互动、新闻价值高的内容）
4. 翻译为中文
5. 生成 HTML 汇总页面（文件名：daily_feed_YYYY_MM_DD.html）
6. 推送到 GitHub 仓库：https://github.com/kratos-xzm/hw-static
7. 自动向主人发送通知，包含访问链接

**页面访问地址格式：**
https://kratos-xzm.github.io/hw-static/daily_feed_YYYY_MM_DD.html

**任务状态：** ✅ 已启用

**下次运行时间：** 2026年2月8日 21:00

**超时设置：** 10分钟（600秒）

**通知方式：** 自动通告到当前会话

---

**设置时间：** 2026年2月8日 20:31  
**设置者：** 主人（老K）
