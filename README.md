<!-- expanded-projects-20260911 -->
# Angela 项目备份 · 2026-09-11

本次补充备份覆盖 **39 个项目目录及版本集合、4154 个文件**。这些目录包含嵌套项目和历史副本，不等于 39 个独立产品。

[打开本次备份与下载文件](https://github.com/angela19990616-alt/angela-desktop-migration-20260910/releases/tag/expanded-projects-20260911)

包含本机登记的 9 个工作项目，以及脑机示例、独立演示、灵犀实际运行版本和历史版本、当前 3D 网站与企业 Agent 演讲。压缩包按文件内容去重；必须用随包的恢复工具还原目录，不要把 blobs 目录直接当项目运行。

ZIP 大小约 104.9 MiB。已实际恢复全部目录并逐文件核验 SHA-256，同时检查中文路径、Windows 保留名称、大小写冲突和防覆盖行为。GitHub 上传完整性以对应云端回执为准。

## Windows 下载与恢复

需要 Python 3.9 或更新版本、GitHub CLI，并以能访问这个私有仓库的账号完成 `gh auth login`。无需把密钥或账号密码发给别人。

在 PowerShell 中运行：

```powershell
gh release download expanded-projects-20260911 --repo angela19990616-alt/angela-desktop-migration-20260910 --pattern projects-for-windows.zip --pattern restore-expanded.py --pattern SHA256SUMS.txt --dir .\AngelaMigration-20260911
python .\AngelaMigration-20260911\restore-expanded.py --archive .\AngelaMigration-20260911\projects-for-windows.zip --sha256 af9168d5cd1e691f2ea20ae6c71c717764779612637495f201f924c7c436f0f0 --destination "$env:USERPROFILE\AngelaProjects-20260911"
```

恢复工具拒绝覆盖已有项目；再次恢复请换一个新目录。可追加 `--project website-current-source` 仅恢复当前网站，或使用下表的其他目录名。文件恢复完成后，还需重新安装 Windows 依赖、配置账号、恢复所需数据并逐项验证应用。当前尚未在 Windows 实机执行。

## 范围与保留项

- 原 Mac 项目、Git 历史、数据库、上传资料、私有模型和其他原始资料继续留在 Mac；原公网网站继续运行。
- GitHub 包中不包含密钥、私人或企业原始资料、邮件附件、数据库、未知配置、依赖缓存和符号链接指向的私有素材。整个排除目录未展开计数；它不是整机镜像或完整运行环境备份。
- 读取超时的候选文件已补读；当前未挂载的外接硬盘，以及只存在服务器上的内容不在这次本机文件快照内。
- 17 份源文件副本中的内嵌凭据或未确认的测试凭据字面值已替换为占位符；本机原文件未修改。相应文件在包内清单中标记 `inlineCredentialsRemoved`，使用 AI 功能前需另行安全配置。
- 一份旧演示 `demo-manifest-station-final-packaged/index.html` 原本就有 JavaScript 语法错误，备份保留其原有状态；验证未发现移除凭据引入新的语法错误。

## 目录清单

| 恢复目录 | 已核对文件数 |
| --- | ---: |
| `lingxi-dev` | 360 |
| `lingxi-running` | 142 |
| `government` | 146 |
| `organization` | 61 |
| `game` | 8 |
| `media` | 27 |
| `finance` | 14 |
| `bid-agent` | 340 |
| `retail-demo` | 39 |
| `bci-examples` | 48 |
| `codex-projects` | 28 |
| `system-projects` | 1236 |
| `lingxi-release-history` | 1291 |
| `website-current-source` | 314 |
| `demo-manifest-station-ai-auto` | 2 |
| `demo-manifeststation-starryai-v2` | 2 |
| `demo-openhex-browser-extension` | 39 |
| `demo-manifest-station-final-cleaned` | 2 |
| `demo-manifest-lux-final-bundle` | 2 |
| `demo-ai-convenience-store-demo` | 3 |
| `demo-manifest-clean` | 2 |
| `demo-ai-store-os-agent-web-v3-3` | 4 |
| `demo-ai-store-os-agent-web` | 4 |
| `demo-ai-digital-clerk-web` | 2 |
| `demo-manifest-station-package` | 2 |
| `demo-ai-store-os-agent-web-v2` | 4 |
| `demo-urbanscenario-ai-demo-2` | 2 |
| `demo-manifest-station-3` | 2 |
| `demo-mailpilot-ai-gmail-demo` | 2 |
| `demo-ai-store-os-agent-web-v3` | 4 |
| `demo-manifeststation-final` | 2 |
| `demo-manifest-clean-2` | 2 |
| `demo-manifest-station-final-packaged` | 2 |
| `demo-manifest-lux-website` | 2 |
| `demo-urbanscenario-ai-demo` | 2 |
| `demo-structure-rpg-runjump` | 2 |
| `demo-manifeststation-starryai` | 2 |
| `demo-ai-digital-clerk-ai-web` | 6 |
| `standalone-3d-prototypes` | 2 |

## 回退

2026-09-10 的原备份 Release 和恢复工具仍保留。需要回退时使用旧 Release 或 Mac 原项目；本次只新增备份，不切换服务、域名或数据库。网页和编译缓存会按使用需要重建。

---

## 2026-09-10 旧版恢复说明（保留供回退）

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
- `bci-examples-source`：24 个源码文件。
