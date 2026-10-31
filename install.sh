#!/bin/sh
# ocs 安装脚本（Linux / macOS）：把单文件脚本装到 ~/.local/bin/ocs
set -e

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
bin="${HOME}/.local/bin"

mkdir -p "$bin"
install -m 755 "$dir/ocs" "$bin/ocs"
echo "✓ 已安装到 $bin/ocs"

# PATH 检查与自动补写（macOS 的 zsh 默认不含 ~/.local/bin）
path_ok=false
case ":${PATH}:" in
  *":${bin}:"*) path_ok=true ;;
esac
if [ "$path_ok" = false ]; then
  echo "⚠ $bin 不在 PATH 里，正在自动补写……"
  case "$(basename "${SHELL:-sh}")" in
    zsh)   rc="$HOME/.zshrc" ;;
    bash)  rc="$HOME/.bashrc" ;;
    fish)  rc="$HOME/.config/fish/config.fish" ;;
    *)     rc="$HOME/.profile" ;;
  esac
  mkdir -p "$(dirname "$rc")" 2>/dev/null || true
  if [ "$(basename "${SHELL:-sh}")" = fish ]; then
    line="fish_add_path $bin"
  else
    line="export PATH=\"$bin:\$PATH\""
  fi
  if [ -f "$rc" ] && grep -qsF "$line" "$rc"; then
    echo "  （$rc 里已有，跳过）"
  else
    printf '\n# ocs（opencode 会话选择器）\n%s\n' "$line" >> "$rc"
    echo "  ✓ 已写入 $rc —— 重开终端（或 source $rc）后生效"
  fi
fi

echo "运行 ocs 试试。依赖：python3、fzf（brew install fzf），以及至少用过一家的："
echo "  opencode / claude code / codex —— 装了哪家显示哪家，界面里点工具行切换"
