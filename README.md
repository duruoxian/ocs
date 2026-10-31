# ocs 🗂️

> **Open Coding Sessions** —— opencode / claude code / codex 的历史会话，像 ZCode 一样好找 🦜
> 浏览、搜索、一键切回——单文件 Python 终端 TUI，零第三方依赖。

![会话列表](docs/screenshot-1.png)

## 为什么需要它 👀

opencode、claude code、codex 三家编码 CLI 的历史会话都各自难找：官方命令要么只看得到
当前目录，要么只有 ID 和标题，想回到几天前某个项目里聊过的会话全靠翻记忆。

ocs 把它们变成 ZCode 那样的体验：

- 🗂️ **单工具视图**：门面只显示当前一家的 logo 和会话（按目录分组、组内时间倒序）
- 🔀 **点工具行切换**：列表顶部三行，点击/回车在三家之间切换，记住上次选择；
  没装的工具也能切进去（提示"还没有会话"）
- 🔍 **模糊搜索**：不光搜标题，还能搜**会话里聊过的内容**（用中文关键词找英文标题的会话也没问题）
- 👁️ **右侧实时预览**：会话详情 + 你提过的问题，光标一动就切换
- 💬 **对话视图**：只显示你的提问，点击某条提问才展开对应的 AI 回答，再点收起（见下图）
- ⏎ **一键切回**：回车继续会话（自动切到会话目录），退出后回到列表接着选
- 🧹 会话管理：重命名（opencode）、批量删除、分叉继续、`ctrl-y` 复制会话 ID

![对话视图](docs/screenshot-2.png)

## 依赖 🧩

| 依赖 | 说明 |
|---|---|
| Python 3.8+ | 只用标准库，无 pip 依赖 |
| [fzf](https://github.com/junegunn/fzf) ≥ 0.68 | 交互界面（`--wrap=word` 0.68 起才有；另用到 `--info-command`、`execute`/`reload`/`--track`） |
| opencode / claude code / codex | 数据来源，**装了哪家显示哪家**（数据在 `~/.local/share/opencode/`、`~/.claude/`、`~/.codex/`） |
| 终端 | Linux 任意现代终端（**Konsole** 下鼠标与复制体验最完整）；macOS Terminal.app / iTerm2；Windows Terminal |

## 安装 📦

### Linux / macOS

```bash
git clone https://github.com/duruoxian/ocs.git
cd ocs
./install.sh          # 安装到 ~/.local/bin/ocs，并自动把 PATH 写进 shell 配置
```

macOS 只需额外 `brew install fzf`（剪贴板用系统自带的 pbcopy，OSC 底色查询原生支持）。

### Windows（PowerShell）🪟

Windows 上用 `ocs.ps1`（薄启动器，核心逻辑仍是同一个 `ocs` Python 脚本）：

```powershell
winget install Python.Python.3.12     # 若还没有
winget install junegunn.fzf
cd ocs
./install.ps1
```

Windows 与 Linux 的差异：复制文字直接**拖动选中、右键「复制」**（不需要 F8/右键切换）；
`ctrl-y` 走 `clip`；点工具行后列表立即切换，logo 待重启生效。

## 使用 ⌨️

```bash
ocs        # 打开会话列表（日常就用这一条）
ocs -h     # 查看完整帮助/教程
```

界面里的键位：

| 操作 | 效果 |
|---|---|
| 打字 | 过滤（可搜标题 + 会话内容全文） |
| `↑` `↓` | 选择，右侧实时预览 |
| 点击/回车顶部工具行 | 切换 opencode / claude code / codex（记住上次选择） |
| `回车` / `双击` | 继续选中的会话，退出后自动回到列表 |
| `→` / `←` | 打开 / 退出「对话视图」（点击消息行展开/收起该条 AI 回答） |
| `ctrl-r` | 重命名会话（opencode） |
| `ctrl-d` | 删除（光标在分组行=删整组；`tab` 多选后=批量删） |
| `ctrl-e` | 分叉继续（复制一份会话来聊；opencode） |
| `ctrl-y` | 复制会话 ID 到剪贴板 |
| `右键` / `F8` | 把鼠标交给终端（拖动选字、右键「复制」菜单），再按 `F8` 切回 |
| `esc` | 退出 |

命令行：

```bash
ocs -p /path/目录     # 只看指定目录（含子目录）的会话
ocs --last [N]        # 不进列表，直接继续最近第 N 个会话
ocs --show ID         # 终端里查看详情（支持 oc:/cc:/cx: 前缀与 id 前缀）
ocs --delete ID...    # 删除会话（删除前确认）
ocs -l                # 纯文本列表（适合管道/脚本）
```

## 实现小记 🔧

- **数据**：opencode 只读直连其 SQLite（WAL，不影响运行中的 opencode）；
  claude code / codex 解析各自的 JSONL 会话文件（mtime+size 缓存、坏行/坏文件跳过）；
  重命名/删除 opencode 走官方 CLI，另两家删除会话文件（realpath 护栏限定在各自目录内）
- **界面**：单个 fzf 实例 + `execute`/`reload`，所有操作都在界面内完成；`--track`
  让光标跨刷新保持；门面 logo 画在 fzf header，切换工具即重启 fzf
- **Logo**：opencode 官方像素字（底色随终端自适应，OSC 11 查询）+ claude/codex 官方品牌 mark
  （烘焙自 Wikimedia 官方 SVG），三家统一 8 行高
- **配色**：琥珀分组、真彩灰提示，刻意不用青色（部分终端主题把 cyan 渲染成刺眼的绿）
- **开发验证**：交互与鼠标操作在 Xvfb 隔离环境里用真实事件回归测试

更细的日常操作说明见 [使用教程.md](使用教程.md)。

## License

MIT ♥️
