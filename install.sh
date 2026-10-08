#!/bin/sh
# ocs 安装脚本：把单文件脚本装到 ~/.local/bin/ocs
set -e

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
bin="${HOME}/.local/bin"

mkdir -p "$bin"
install -m 755 "$dir/ocs" "$bin/ocs"
echo "✓ 已安装到 $bin/ocs"

case ":${PATH}:" in
  *":${bin}:"*) ;;
  *) echo "⚠ 提示：$bin 不在 PATH 里，请把它加进 PATH 后重新打开终端（fish: fish_add_path $bin）" ;;
esac

echo "运行 ocs 试试（需要先安装并使用过 opencode、以及安装 fzf）"
