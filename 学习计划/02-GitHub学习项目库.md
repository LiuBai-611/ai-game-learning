# GitHub 学习项目库（可下载 + 每个项目该看什么）

> **使用方法**：不要一次全下载。按计划里的时间点，只下当天需要的那一个。
> **每个项目的固定流程**：读 README（找 Godot 版本）→ Download ZIP → 解压到 `D:\dev\godot-demos\` → Godot「导入」→ 选 `project.godot` 所在文件夹 → F5 运行 → 报错就整段贴给 AI。
> ⚠️ **版本警告**：Godot 3 和 4 的代码几乎不通用。下载前一定看 README 里写的版本。本计划全程用 **Godot 4.x**。

---

## 一、必下（按计划时间点）

### #1 godotengine/godot-demo-projects ★ 官方示例合集（Day 11 用）
- 地址：https://github.com/godotengine/godot-demo-projects
- 在线预览：https://godotengine.github.io/godot-demo-projects/
- 是什么：官方维护的示例项目大全，2D/3D/GUI/物理/音频分类齐全，每个 demo 都极小。
- **重点看**：`2d/platformer`（平台跳跃完整实现）、`2d/dodge_the_creeps`（最经典的入门项目）、`2d/finite_state_machine`（状态机）、`gui/`（UI 全套）
- **注意**：仓库有多个分支对应不同 Godot 版本（如 `master` / `4.x` / `3.x`），**要选和你引擎版本一致的分支**再下载。

### #2 官方入门教程项目 Dodge the Creeps（Day 11～13 用）
- 官方文档：https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html
- 是什么：官方手把手教程，从零做一个"躲避怪物"的小游戏。
- **重点看**：项目虽然小，但包含了**完整的游戏骨架**——玩家、敌人、碰撞、计分、音效、胜负、重开。你第一周的所有概念都能在这里找到对应。
- **建议**：中文文档在 https://docs.godotengine.org/zh-cn/stable/ （把 URL 里的 `en` 换成 `zh-cn`）

### #3 GDScript 语法与实战范例（Day 23 读代码训练用）
- 搜索关键词（在 GitHub 搜索框直接搜）：`godot 4 gdscript examples`、`godot 4 beginner project`
- 挑选标准（**用这三条筛，不要凭 star 数**）：
  1. README 写明 Godot 4.x 且最近一年有更新
  2. 仓库里有 `.tscn` 场景文件（说明是真项目，不是纯代码片段）
  3. 脚本文件单个体积不大（< 300 行）
- 好的候选特征：仓库名带 `godot-4`、`platformer`、`tutorial`、`starter-kit`

### #4 平台跳跃类完整开源项目（Day 23、Day 29 用）
- 搜索关键词：`godot 4 platformer`、`godot 4 2d platformer open source`
- 你要在里面找的**具体东西**：
  - 玩家的状态机怎么写（对比你自己的写法）
  - 敌人的巡逻/追击逻辑
  - 关卡是怎么组织的（一个场景一关？还是数据驱动？）
  - 存档怎么做

### #5 免费素材包（Day 26、36 用）
| 来源 | 地址 | 授权特点 |
|---|---|---|
| **Kenney** | https://kenney.nl/assets | 全部 **CC0**：可商用、可修改、**无需署名**。小白最安全的选择，先从这里拿 |
| **itch.io 素材区** | https://itch.io/game-assets/free | 每个素材授权不同，**必须逐个看 License** |
| **OpenGameArt** | https://opengameart.org/ | 授权混杂（CC0 / CC-BY / CC-BY-SA / GPL），**必须逐个看** |
| **Tiny Swords** | 在 itch.io 搜索 "Tiny Swords"（作者 Pixel Frog） | ⚠️ **重点注意**：这是很有名的免费 2D 素材包，但**它的授权条款历史上做过调整**（早期版本与后续版本的条件不同，社区对能否商用有大量讨论）。**下载和使用前，必须打开它当前页面阅读作者写的授权说明原文**，不要相信任何二手转述。必要时直接看 itch.io 页面上的 License 区块 |
| **Lospec 调色板** | https://lospec.com/palette-list | 调色板参考，像素美术必备 |
| **sfxr 音效生成** | https://sfxr.me/ | 网页直接生成 8-bit 音效，可商用无顾虑 |
| **freesound** | https://freesound.org/ | 音效库，**每个音效授权不同，逐个看** |

> **素材判断三步法**（每次都要做）：
> ① 找 License 原文 → ② 回答"能商用吗 / 要署名吗 / 能改吗" → ③ 把答案记进 `godot笔记/05-素材许可.md`。
> 有一个答不上来 → 换素材。**不要赌**。

---

## 二、进阶与支线（第 7 周之后按需）

### #6 MCP（Model Context Protocol）相关
- 官方文档：https://modelcontextprotocol.io/
- 是什么：让 AI 能安全读取你本地文件、调用你的工具的开放协议。想深挖"让 AI 真正帮你干活"，这是核心。
- **怎么用**：第 7 周 Day42～43 之后看。先搞懂概念，再考虑自己写一个简单的 MCP server。

### #7 three.js（第 12 周之后，可选支线）
- 官网（含大量官方 examples）：https://threejs.org/
- 中文入门参考：https://developer.mozilla.org/zh-CN/docs/Games/Techniques/3D_on_the_web
- 是什么：JavaScript 的网页 3D 库。能在浏览器里跑 3D 场景，可做网页小游戏、3D 作品集。
- **什么时候学**：**先做完并发布你的 2D 游戏**。three.js 属于"锦上添花"，不是入门主线，现在学只会分散注意力。
- 入门路径（等你到了再回来看）：官方 `examples/` 里的 `webgl_geometry_cube` → `misc_controls_orbit` → 自己拼一个可旋转的 3D 物品展示。

### #8 游戏 AI 与 Agent 工作流参考
- 搜索关键词：`AI game dev workflow`、`Claude Code game development`、`AGENTS.md examples`
- 你在找的是**方法论**，不是代码：别人怎么组织"AI agent 帮我做游戏"这套流程的（怎么写规矩文件、怎么拆分任务、怎么验证）。
- ⚠️ 这类仓库更新极快、质量差异极大，**看到夸张宣传（"49 个 AI 智能体组成游戏工作室"之类）要冷静**：先看它到底产出过什么能玩的游戏，再看它的工作流文档里有没有可复制的具体做法。**只抄流程，不抄口号**。

---

## 三、GitHub 使用速查（小白版）

| 我想做的事 | 怎么做 |
|---|---|
| 下载一个项目的代码 | 仓库页 → 绿色 `Code` 按钮 → `Download ZIP` |
| 下载后怎么用 Godot 打开 | 解压 → Godot 里点「导入」→ 选中 `project.godot` **所在的文件夹** → 导入并编辑 |
| 搜索项目 | 顶部搜索框；用 `godot 4 platformer` 这种"引擎版本 + 类型"组合最有效 |
| 筛选质量 | 结果页点 `Sort: Most stars`；再看 `Updated` 时间（超过 2 年没更新的慎选） |
| 看某个文件的历史 | 点开文件 → 右上角 `History` |
| 想知道某个词是什么意思 | 在仓库里用 `Ctrl+F` 搜；或把代码贴给 AI 问 |
| 我改坏了想还原 | GitHub Desktop → 右键改动的文件 → `Discard changes`（前提：改动还没 commit） |

---

## 四、选项目的四条硬标准（避免浪费时间）

下载前先问这四个问题，**两个以上答不上来就别下**：

1. **它用哪个 Godot 版本？** README 里写了吗？
2. **它最近一年更新过吗？** 三年没更新的 Godot 项目基本跑不起来。
3. **它有 `.tscn` 场景文件吗？** 只有 `.gd` 脚本的仓库多半是代码片段，不是能跑的项目。
4. **它的 README 里有截图/GIF 吗？** 有截图的说明作者真的跑通过。

---

## 五、读完一个项目后必须留下的三行记录

在 `学习日志.md` 里写：

```markdown
### 项目：<仓库名>（<日期>）
- 它做了什么：（一句话）
- 我看懂了什么：（1～3 条，要具体到"它用信号做碰撞通知"这种程度）
- 我改了什么 + 结果：（改了哪里、发生了什么）
```

**没有这三行 = 这个项目白下了。** 下载项目本身不产生任何学习，改动和记录才产生。
