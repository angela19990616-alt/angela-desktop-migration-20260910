# Angela 项目迁移到 Windows

这是迁移工具和已核对源码的接收入口。它不是所有项目已迁移完成的证明。

## 当前可接收

- `angela-website-3d`：3D 个人主页、企业 Agent 演讲、配图和录音，以及可编辑源码。源码基准 `3a51b99fb0677ac04bbe3e2210ee1b75d889f343`。忽略本机 npm 配置和发布维护记录。
- `neuro-harbor`：脑电游戏源码，基准 `a21b1234f8e3140bc32bd583307c59fdb0b1d34b`。不包含脑电记录、个人校准数据或旧机器依赖。

快照只包含清单中的当前文件，原始 Git 历史仍保留在 Mac。其余项目正在核对，不能用 GitHub 旧版本覆盖 Mac 最新内容。原 Mac 文件和现有公网服务保持可用，验收前不删除或切换。

## Windows 接收

1. 安装 GitHub CLI，使用自己的 GitHub 账号登录；不要把 Token 发到聊天。
2. 克隆本私有工具仓库，在 PowerShell 中运行 `./restore.ps1`。默认保存到用户目录下的 `AngelaProjects`，也可以用 `-Root D:\AngelaProjects` 指定位置。
3. 脚本从本私有仓库的 Release 下载快照，核验 SHA-256，再逐文件核验后放入目标文件夹。遇到已有同名目录会停止，不覆盖旧内容；重复运行已核验的同一版本会跳过。
4. `manifest.json` 列出当前可恢复内容。验证通过仅表示文件完整，项目运行仍需下方验收。

## 两台电脑的私有通道

Mac 和 Windows 安装官方 Tailscale 并登录同一个账号。Windows 可运行 `tailscale ip -4` 获取设备地址。先验证双方在线和 `tailscale ping <对端地址>`，再传输文件。

当前 Mac 端已安装官方客户端，登录和 VPN 系统授权需要用户完成。Cloudflare 新隧道创建返回认证错误，尚未创建。已有 Lingxi 隧道不用于这次文件迁移。

只需要传文件时可用 Tailscale 文件传输。若需要从 Mac 远程执行 Windows 命令，另行配置 Windows OpenSSH，只允许双方已确认的 Tailscale 地址访问；Tailscale 设备在线不等于 SSH 已配置。不要对公网开放文件目录、SSH、数据库或开发后台。

官方安装说明：[Windows](https://tailscale.com/docs/install/windows)、[Mac](https://tailscale.com/docs/install/mac)。

## 网站运行

安装 Node.js 22.13 或更新兼容版本，在恢复的网站目录执行：

```powershell
npm run install:static
node scripts/build-static.mjs
node --test tests/*.test.mjs
npm run typecheck:static
npm run preview:static
```

打开 `http://127.0.0.1:43127/`。PowerShell 直接执行静态构建脚本，避免原 Mac 的 Bash 包装脚本。检查首页 3D 拖动、项目选择、中英文切换、手机布局、演讲入口、第二章空字幕隐藏、自动播放、暂停、录音。公网网站继续使用现有 GitHub Pages，无需等待 Windows 开机。

## 脑电游戏运行准备

安装 Python 3.11 与 Node.js，使用 `setup-neuro-windows.ps1` 重建 Windows 依赖。旧版 `scripts/setup.py`、`.command` 和 `scripts/launch.py` 面向 Mac，不在 Windows 执行。

安装脚本会验证 Python 导入、运行代码测试；这些检查不证明真实脑电设备正常。必须在 Windows 核对 OpenBCI / LSL 设备连接、实际样本持续增长、通道、屏幕刷新和控制功能后再验收。

## 其余项目

迁移清单包括：灵犀 AI 助理、政府分析、模拟组织、游戏、自媒体、金融、投标 Agent、系统工具、便利店 Demo、脑机示例、自优化模块及独立演示。若干源码和 Git 文件当前为 iCloud 占位文件，必须下载原文件后再核验备份，不能跳过后宣称完整。

数据库、上传资料、私有模型和密钥需要单独迁移清单；不要上传到本仓库。Windows 收到源码后还需重建依赖、恢复数据、配置登录凭据和验证运行。只在目标通过验收后考虑服务入口切换。

## 回滚

本工具只在指定新目录写入已核验文件。停止本次启动的终端即可停止预览；保留原 Mac 项目和现有公网入口。撤销迁移时只移除本次新建且已确认不再需要的目标副本，不修改原项目、域名、数据库或现有服务。

## 已备份的其他代码副本

以下快照仅含当前程序代码，不包含素材、数据、配置、依赖或 Git 历史，暂不能直接当作完整项目运行。

- `government-agent-source`：109 个源码文件。
- `organization-simulation-source`：34 个源码文件。
- `chatgpt-game-source`：5 个源码文件。
- `media-tools-source`：7 个源码文件。
- `finance-tools-source`：12 个源码文件。
- `bid-agent-source`：290 个源码文件。
- `retail-demo-source`：3 个源码文件。
- `selfopt-layer-source`：5 个源码文件。
- `lingxi-source`：201 个源码文件。
- `system-maintenance-source`：14 个源码文件。
- `secrets-hub-program-source`：10 个源码文件。
- `mail-automation-source`：3 个源码文件。
