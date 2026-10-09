# Day 01 完整步骤（✅ 已完成，保留备查）

> **完成状态（2026-09-26 核实）**：
> - Git 已装 ✅（实际路径 `D:\dev\Git\`）｜ 全局配置已设 ✅（用户名 `刘白`；邮箱用你注册 GitHub 的那个——**⚠️ 邮箱、Token、API Key 一律不要写进任何会被推送到公开仓库的文档**）
> - GitHub 账号已注册 ✅ ｜ 仓库 `LiuBai-611/ai-game-learning` 已创建并**成功推送** ✅
> - 本地仓库在 `D:\dev\ai-game-learning`，已有 5 条提交 ✅
> - **过程中真实踩的坑（已解决，记录备查）**：① GitHub 下载通道被阻断 → 换镜像；② Git 授权弹窗反复失败 → 改用 Token
>
> ⚠️ **用户名大小写**：正确写法是 **`LiuBai-611`**（大写 B），本文原稿写成 `Liubai-611`（小写 b）。GitHub 地址不区分大小写所以能用，但**写文档、加好友、填资料时用正确的大小写**。
>
> 下面是完整流程，**换电脑重做时照着走**。**注意第 2 步必须先建目录**（原稿漏了，直接 `cd` 会失败）。

---

## 第 1 步：配置 Git（2 分钟）

**双击** `day01-setup.cmd`（就在本文件旁边）。

它会问你两件事：

| 问题 | 填什么 |
|---|---|
| `Your name or nickname` | `Liubai-611`（或你的真名，随意。这只是提交记录上显示的标签） |
| `Your GitHub email` | **注册 GitHub 用的那个邮箱**（必须一致，否则 GitHub 不认你的提交） |

跑完它只打印你的 name 和 email 这两项（不会打印其他全局配置）。**核对这两项**即可。

> 为什么要你亲自跑：`git config` 需要你的邮箱，我不能替你编一个。
> 脚本做的事就是替你输入这几条命令：
> ```
> git config --global user.name  "..."
> git config --global user.email "..."
> git config --global core.autocrlf true      ← Windows 必须，否则换行符会让 Git 认为你改了所有文件
> git config --global init.defaultBranch main
> git config --global core.quotepath false    ← 不加这个，中文文件名会显示成乱码
> git config --global credential.helper manager
> ```

---

## 第 2 步：把仓库拉到本地（3 分钟）

**开一个新终端**（`Win + R` → 输入 `cmd` → 回车），然后逐条粘贴：

```cmd
mkdir D:\dev\ai-game-learning
cd /d D:\dev\ai-game-learning
git clone https://github.com/LiuBai-611/ai-game-learning.git .
```

> ⚠️ **第一行 `mkdir` 不能省**。原稿没有它，如果 `D:\dev\ai-game-learning` 还不存在，`cd` 会直接报"系统找不到指定的路径"，后面全失败。
> （`cd` 只负责"切换"到已有目录，**不会创建**目录。这点以后写脚本时经常用到。）

> 注意最后那个 **`.`** 不能漏！它表示"克隆到当前目录"，而不是新建一层文件夹。
>
> ⚠️ **克隆的目标目录必须是空的**。如果你之前跑过旧版 `day01-setup.cmd`（它会在里面预建 `学习日志.md`），先把那个文件移走或删掉再克隆，否则会报 `destination path '.' already exists and is not an empty directory`。**当前版本已改成不预建日志，就是为了避免这个冲突。**

看到 `done.` 就成功了。然后验证：

```cmd
dir
git log --oneline
```

应该能看到 `README.md`、`.git` 文件夹，以及一条 `Initial commit` 记录。

**这一步如果报错**：大概率是网络问题（GitHub 在国内时常抽风）。重试一次；还不行就把报错原文发我。

---

## 第 3 步：第一次提交（5 分钟）

### 3.1 建立不会被提交的忽略规则

在 `D:\dev\ai-game-learning` 里新建文件 `.gitignore`，内容：

```gitignore
# 密钥（绝对不能提交）
.env
.env.*

# Godot（第 2 周开始会用到）
# 只忽略缓存目录。⚠️ 不要忽略 *.import / *.uid：
# 它们保存资源的导入设置和稳定 ID，必须提交，否则别人重新导入会得到不同结果。
.godot/
export/

# 系统文件
Thumbs.db
desktop.ini
```

### 3.2 把学习计划文档复制进来

把 `学习计划\` 文件夹**整个**复制到 `D:\dev\ai-game-learning\` 下面。
（这些文档以后就是你的资料库，放在仓库里可以随时查阅，也顺便让仓库有内容。）

### 3.3 提交

```cmd
cd /d D:\dev\ai-game-learning
git add .
git status
git commit -m "Day 01: 建立学习仓库，加入学习计划与日志"
git push
```

> `git push` 第一次会**弹出浏览器让你登录 GitHub**，点授权即可。
> 如果弹出的是黑底命令行要求输入密码 —— **GitHub 早就不支持密码了**，需要用 Token 或走浏览器授权。遇到这个情况把截图发我。

---

## 第 4 步：写今天的第一行日志

编辑 `学习日志.md`，把中文模板从 `学习计划\06-学习日志模板.md` 复制进去，然后填上今天这一行：

```markdown
| 2026-09-26 | 01 | 装好 Git 2.55、注册 GitHub、建仓库并完成第一次 push | 明白了"Git 是本机记录，GitHub 是网站" | 克隆时网络报错 | 完成三模型对比 |
```

**没写日志 = 今天没完成。** 这是整个 12 周计划里回报率最高的一件事。

---

## 第 5 步：Day 01 的 AI 动作（20 分钟）

用**同一个问题**分别问 3 个模型（ChatGPT / Claude / DeepSeek）：

> 我要从零学做游戏，不会编程。Godot 和 Unity 该选哪个？
> 用 200 字回答，给我三个理由和一个反对意见。

把三段回答贴进 `学习日志.md`，写 3 行结论：
- 谁的答案最具体？
- 谁最啰嗦？
- 谁给的行动建议最可执行？

这一步是在练**多模型判断力**——也就是你要学的"熟练运用多模型"的第一课。

---

## 今天完成后的检查清单

- [ ] `git --version` 有输出（Git 2.55）
- [ ] `git config --global --list` 能看到你的 name 和 email
- [ ] `D:\dev\ai-game-learning` 里有 `README.md` 和 `.git` 文件夹
- [ ] GitHub 网页上能看到你的新提交
- [ ] `学习日志.md` 里有今天这一行
- [ ] 用 3 个模型对比了同一个问题

**全部打勾 = Day 01 完成。** 发我一句"好了"，我给你安排 Day 02。
