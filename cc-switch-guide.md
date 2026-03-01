---
title: "cc-switch 深度体验：一个工具搞定 Claude Code、Codex、OpenClaw 的 API 管理"
date: 2026-03-01
tags: ["AI开发工具", "Claude Code", "OpenClaw", "效率工具", "开源项目"]
---

# cc-switch 深度体验：一个工具搞定 Claude Code、Codex、OpenClaw 的 API 管理

> 搞了两周，终于不用在配置文件里反复横跳了。

作为一个同时用 **Claude Code**、**Codex**、**OpenClaw** 的重度用户，我最烦的不是工具本身，而是**管理一堆 API 配置**。

今天给 Claude Code 配个 key，明天给 Codex 换个 endpoint，后天发现 OpenClaw 的配置又冲突了... 三个工具，三套配置，改来改去简直要命。

直到我发现了 **cc-switch** —— 一个开源的 AI 编程工具管理神器。用了一个月，只想说：**这玩意儿早该出现了**。

![cc-switch 主界面](https://raw.githubusercontent.com/farion1231/cc-switch/main/assets/screenshots/main-en.png)

## 先说说 cc-switch 是什么

[cc-switch](https://github.com/farion1231/cc-switch) 是一个跨平台的桌面应用，目前已经获得 **22k+ stars**，支持 Windows、macOS、Linux 三平台。

它最大的价值在于：**统一管理多个 AI 编程工具的 API 配置**。

### 支持的工具

- ✅ **Claude Code** - Anthropic 的终端 AI 助手
- ✅ **Codex** - OpenAI 的代码生成工具
- ✅ **Gemini CLI** - Google 的 AI 编程助手
- ✅ **OpenCode** - 开源的 AI 编程工具
- ✅ **OpenClaw** - 自建的个人 AI 助手

![添加供应商界面](https://raw.githubusercontent.com/farion1231/cc-switch/main/assets/screenshots/add-en.png)

### 核心功能一览

| 功能 | 说明 | 我的使用感受 |
|------|------|-------------|
| 🔧 供应商管理 | 一键添加/切换不同 API 供应商 | 再也不用改配置文件了 |
| ⚡ 本地 API 代理 | 内置 HTTP 代理，自动接管应用请求 | 这是最香的功能 |
| 🔄 MCP 服务器管理 | 统一配置各类 MCP 工具 | 一处配置，多处生效 |
| 📊 测速功能 | 测试不同 endpoint 的延迟 | 选最快的节点 |
| ☁️ 云同步 | 支持 Dropbox/OneDrive/iCloud 同步 | 换电脑也不怕 |
| 🛡️ 配置备份 | 自动备份，支持历史版本回滚 | 手残党的救星 |

## 为什么我需要 cc-switch？

### 场景一：多工具切换的痛苦

以前我的配置是这样的：

**Claude Code** 配置（`~/.claude/config.json`）：
```json
{
  "api_key": "sk-xxxxx",
  "api_base": "https://some-api-endpoint.com/v1"
}
```

**Codex** 配置（`~/.codex/config.json`）：
```json
{
  "openai_api_key": "sk-yyyyy",
  "openai_base_url": "https://another-endpoint.com/v1"
}
```

**OpenClaw** 配置（`openclaw.json`）：
```json
{
  "env": {
    "KIMI_API_KEY": "sk-zzzzz",
    "OPENAI_API_BASE": "https://yet-another-endpoint.com/v1"
  }
}
```

三个工具，三个配置文件，三个不同的 API key。想换个供应商？得改三个地方。

### 场景二：配置冲突的坑

有次我想给 Claude Code 换个便宜的 API，改完配置后 Codex 挂了 —— 原来它们共用了某个环境变量。排查了半小时，发现是配置冲突。

### cc-switch 的解决方案

用上 cc-switch 之后，所有配置都在一个界面里管理：

1. **添加供应商**（比如某个 API 中转站）
2. **一键"接管"**对应的 AI 工具
3. 所有工具自动使用同一个 API 配置

想换供应商？点一下切换就行，所有工具同时生效。

## 实战：配置一个 API 中转站

下面以配置一个 **API 聚合平台**为例（这里以 KL-API 为例，你也可以用其他类似的 API 中转服务）。

### 第一步：安装 cc-switch

**Windows**：下载 MSI 安装包
```powershell
# 访问 GitHub Releases 下载
https://github.com/farion1231/cc-switch/releases
```

**macOS**（推荐 Homebrew）：
```bash
brew tap farion1231/ccswitch
brew install --cask cc-switch
```

**Linux**：支持 Ubuntu/Debian/Fedora，下载对应格式的安装包。

### 第二步：获取 API 信息

假设你已经在某个 API 平台（比如 KL-API）注册了账号：

1. 登录控制台
2. 创建 API Key
3. 查看 API Base URL（通常是 `https://api.xxx.com/v1`）

**KL-API 的信息示例**：
- Base URL: `https://api.kl-api.info/v1`
- 支持模型: Claude、GPT、Gemini 等 300+ 模型
- 优势: 1.5元 ≈ 1美元额度，比官方渠道节省 70% 成本

### 第三步：在 cc-switch 中添加供应商

打开 cc-switch，点击"添加供应商"，填写以下信息：

```yaml
供应商名称: KL-API
供应商类型: OpenAI Compatible

API Base URL: https://api.kl-api.info/v1
API Key: sk-xxxxxxxxxxxxx
```

![供应商配置界面](https://raw.githubusercontent.com/farion1231/cc-switch/main/assets/screenshots/add-en.png)

**模型映射配置**（关键步骤）：

不同的 API 平台对模型的命名可能不同，需要在 cc-switch 中做映射：

```yaml
# Claude Code 使用的模型
claude-opus-4 -> claude-3-opus-20240229
claude-sonnet-4 -> claude-3-sonnet-20240229
claude-haiku -> claude-3-haiku-20240307

# Codex 使用的模型
codex -> gpt-4o-codex

# Gemini 使用的模型
gemini-pro -> gemini-1.5-pro-latest
```

具体模型名称请参考你所用 API 平台的文档。

### 第四步：启用本地代理（核心功能）

这是 cc-switch 最强大、也是最省心的功能。

**什么是本地代理？**

cc-switch 会在本地启动一个 HTTP 代理服务器（默认端口 8080），然后"接管"你的 AI 工具。被接管后，这些工具的所有 API 请求都会经过 cc-switch，由 cc-switch 转发到你配置的供应商。

**如何启用：**

1. 在 cc-switch 主界面，点击"启动本地代理"
2. 点击"接管 Claude Code"
3. 点击"接管 Codex"
4. 点击"接管 OpenClaw"

![本地代理界面](https://raw.githubusercontent.com/farion1231/cc-switch/main/assets/screenshots/proxy-en.png)

**接管后会发生什么？**

- cc-switch 自动修改各工具的配置文件
- 所有 API 请求走本地代理
- 你可以在 cc-switch 中实时看到 API 调用日志

### 第五步：验证配置

**测试 Claude Code：**
```bash
claude
# 正常使用，如果配置正确，应该能正常对话
```

**测试 Codex：**
```bash
codex "写一个 Python 爬虫"
# 应该能正常调用 API
```

**测试 OpenClaw：**
由于 OpenClaw 的配置比较灵活，需要手动配置一下：

编辑 `openclaw.json`：
```json
{
  "env": {
    "OPENAI_API_BASE": "http://localhost:8080/v1",
    "OPENAI_API_KEY": "dummy-key-cc-switch-will-override"
  }
}
```

这样 OpenClaw 就会通过 cc-switch 的代理发送请求。

## 高级玩法

### 1. 多供应商一键切换

cc-switch 支持配置多个供应商。比如：

- **供应商 A**：日常开发，性价比高
- **供应商 B**：重要项目，稳定性第一
- **官方 API**：关键时刻，兜底备用

点击即可切换，所有工具同时生效，无需逐个修改配置。

![多供应商管理](https://raw.githubusercontent.com/farion1231/cc-switch/main/assets/screenshots/providers-en.png)

### 2. 细粒度模型控制

你可以为不同的模型设置不同的供应商：

```yaml
claude-opus-4: 使用供应商 A（便宜）
claude-sonnet-4: 使用供应商 B（稳定）
gpt-4: 使用官方 API（保底）
```

cc-switch 会自动根据模型选择对应的路由。

### 3. MCP 服务器统一管理

MCP（Model Context Protocol）服务器是现代 AI 工具的重要组成部分。

cc-switch 提供了一个统一的 MCP 管理面板：

- 添加 MCP 服务器（如文件系统、数据库、搜索等）
- 自动同步到 Claude Code、Codex、Gemini
- 一键启用/禁用

再也不用分别维护 `claude_mcp_config.json` 和 `codex_mcp_config.json` 了。

### 4. 会话管理器

cc-switch v3.7+ 新增了**会话管理器**功能：

- 浏览所有 AI 工具的历史对话
- 跨应用搜索历史记录
- 导出重要会话
- 备份到云端

这对于需要长期维护项目的开发者来说非常实用。

### 5. 测速与质量监控

cc-switch 内置了测速功能：

- 测试不同供应商的延迟
- 实时监控 API 调用成功率
- 统计各模型用量

帮你选择最优的 API 路由。

## 常见问题

### Q: cc-switch 会收集我的 API Key 吗？

不会。cc-switch 是开源软件（MIT 协议），所有数据都存储在本地。你可以查看源码确认：
https://github.com/farion1231/cc-switch

### Q: 启用代理后，会影响其他应用吗？

不会。cc-switch 的代理是**应用级别的精准接管**，只影响你明确指定的 AI 工具（Claude Code、Codex 等），不会影响浏览器或其他应用。

### Q: 配置后工具启动报错怎么办？

检查以下几点：
1. cc-switch 是否已启动并显示"代理运行中"
2. API Base URL 是否填写正确（注意 `/v1` 后缀）
3. 模型映射是否正确
4. 在 cc-switch 中点击"测试连接"验证 API 可用性

### Q: 如何备份和迁移配置？

cc-switch 支持：
- 手动导出/导入配置
- 自动备份（保留最近 10 个版本）
- 云同步（Dropbox/OneDrive/iCloud）

换电脑或重装系统时，配置不会丢失。

## 写在最后

用了一个月 cc-switch，最大的感受是：**省心**。

以前维护 3 个 AI 工具的配置，需要记住 3 个配置文件的位置、3 套不同的环境变量、3 个 API key。现在全部交给 cc-switch，我只需要在一个界面里操作。

特别是**本地代理**功能，简直是神来之笔。接管之后，各个工具的使用体验完全没有变化，但背后的 API 路由全部由 cc-switch 统一管理。

如果你也同时在用多个 AI 编程工具，强烈推荐试试 cc-switch。

---

**相关链接：**
- cc-switch GitHub: https://github.com/farion1231/cc-switch
- cc-switch 官方文档: https://github.com/farion1231/cc-switch/blob/main/README_ZH.md
- 我的 API 配置参考（KL-API）: https://api.kl-api.info

**如果本文对你有帮助，欢迎点赞收藏转发！有问题可以在评论区留言交流。**
