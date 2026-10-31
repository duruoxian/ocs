官方 Logo 像素数据（2026-10-31 从官方品牌 SVG 栅格化）
========================================================

来源
  Claude : Wikimedia "Claude_AI_logo.svg" 的爆花 mark，#D97757
  OpenAI : Wikimedia "OpenAI_Logo.svg" 的结花 mark，终端上用白 #EEEEEE
  下载: https://commons.wikimedia.org/wiki/Special:FilePath/<文件名>
  栅格化: cairosvg 高分辨率渲染 → LANCZOS 降到 16×16，alpha 阈值 0.45/0.46

文件
  claude-mark.txt / openai-mark.txt : 16×16 像素网格（'#'=mark 色，'.'=透明）
  claude-mark.png / openai-mark.png : 放大预览图

终端渲染方法（半块字符画，4 或 8 行 = 16 像素行 ÷ 2）
  上下两像素 (t, b)：t#b#→█  t#b.→▀  t.b#→▄  t#b. 同列 b='o' 时用暗底
  前景色 = 品牌色；'.'=透明（露终端底色）
