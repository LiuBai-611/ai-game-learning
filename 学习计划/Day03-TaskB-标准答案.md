# Day 03 · 任务 B 标准答案（⚠️ 不要粘给模型）

> **用法**：等模型回答完，打开这份文件**对着数**，把分数填进 `Day03-三任务对比记录.md`。
> 满分 **5 分** + 附加 **1 分**。
> 说明：报错文字是我按 Godot 4 的典型提示写的，**你那边显示的具体文字可能略有差别**（版本不同），但**错误位置和性质是一样的**。
> 行号按 `Day03-TaskB-错误代码.md` 里那段数：**从 `extends` 算第 1 行**（那段里第 9 行是 `func _physics_process`）。

---

## 【会报错的】3 处 —— 各 1 分

### 错误 1 · 第 10 行：函数名拼错了

```gdscript
var direction = Input.get_action_strangth("move_right") - ...
```

- **错在哪**：`strangth` 拼错了，正确是 `strength`。`Input` 上没有这个方法。
- **报错类似**：`Function "get_action_strangth()" not found in base "Input".`
- **怎么改**：`Input.get_action_strength("move_right")`
- 💡 这是最"明显"的一个，**任何档位都应该找到**。如果这个都没找到 → 该档位不能用于看代码。

### 错误 2 · 第 11 行：变量名大小写错了

```gdscript
velocity.x = direction * Speed
```

- **错在哪**：第 6 行定义的是小写 `speed`，这里写成大写 `Speed`。**GDScript 区分大小写**，`Speed` 是一个不存在的名字。
- **报错类似**：`Identifier "Speed" not declared in the current scope.`
- **怎么改**：`direction * speed`
- 💡 **这是"能看报错但看不出错"的典型**：报错信息离真正原因（少写了个小写字母）非常近，但新手会盯着第 10 行看不出问题。

### 错误 3 · 第 21 行：字符串和数字不能用 `+` 拼接

```gdscript
print("玩家的移动速度是 " + speed + " 像素/秒")
```

- **错在哪**：Godot 4 里 `String + float` 直接报错。
- **报错类似**：`Invalid operands "String" and "float" in operator "+".`
- **怎么改**（两种都对）：
  ```gdscript
  print("玩家的移动速度是 " + str(speed) + " 像素/秒")
  # 或者更推荐的写法：
  print("玩家的移动速度是 %s 像素/秒" % speed)
  ```
- 💡 这条是 **Godot 4 相对 Godot 3 / Python 的一个真实差异**（Python 里字符串加数字也报错，但很多人从别的语言过来会混）。找出来说明模型真的知道 Godot 4 的规则，而不是"看上去像代码"。

---

## 【不报错但行为不对】2 处 —— 各 1 分

> ⚠️ **区分档次就在这两条。** 只会找报错的模型，会说"改完上面三处就能跑了"——**改完确实能跑，但跳不起来。**

### 逻辑错误 1 · 第 6 行：跳跃速度的符号反了

```gdscript
var jump_velocity = 400.0
...
velocity.y = jump_velocity
```

- **错在哪**：Godot 的屏幕坐标里 **y 轴向下为正**。`velocity.y = 400` 是**向下**的速度，所以按下跳跃键，角色会被**往下压**——表现是"按了没反应"或"贴地不动"。
- **怎么改**：`var jump_velocity = -400.0`（官方模板里就是 `JUMP_VELOCITY = -400.0`）
- 💡 **这是最值钱的一条**：代码不报错、游戏能启动、输入也有响应，**但功能是坏的**。这种 bug 只能靠"真的把游戏跑起来试一下"发现。

### 逻辑错误 2 · 第 12～17 行：`move_and_slide()` 的位置放错了

```gdscript
	move_and_slide()            # ← 移动发生在这一行

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	velocity.y += GRAVITY * delta   # ← 重力在移动之后才累加
```

- **错在哪**：`velocity.y` 的两处更新都在 `move_and_slide()` **之后**，所以本帧算出来的竖直速度**这一帧用不上**，要等下一帧。结果：**竖直方向永远慢一帧**——重力第一帧不生效、跳跃输入第一帧不动。
- **正确顺序**（官方模板）：先把速度算完，最后才 `move_and_slide()`：
  ```gdscript
  func _physics_process(delta):
      var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
      velocity.x = direction * speed

      if Input.is_action_just_pressed("jump") and is_on_floor():
          velocity.y = jump_velocity

      velocity.y += GRAVITY * delta

      move_and_slide()          # ← 挪到最后
  ```
- 💡 严格说这一条"影响很小"（1 帧 ≈ 16 毫秒），**能看出这一点 = 真的读懂了这个函数的执行顺序**，而不是背模板。
  **评分时宽松处理**：只要它指出"竖直速度的更新发生在 move_and_slide 之后、应该挪到前面"，就给分。

---

## 【看起来可疑但其实是对的】干扰项 —— 附加 1 分

### `is_on_floor()` 写在 `move_and_slide()` 之后 —— **这是对的**

```gdscript
	move_and_slide()

	if Input.is_action_just_pressed("jump") and is_on_floor():   # ← 位置正确
```

- **为什么对**：`is_on_floor()` 返回的是**最近一次 `move_and_slide()` 的结果**。物理引擎是在 `move_and_slide()` 里做碰撞检测、移动、然后更新"是否在地面上"这个状态的。
- **如果放在 `move_and_slide()` 之前**会怎样：在第一帧还没发生过任何碰撞检测时，它永远是 `false` → **开局第一下跳跃无效**（后面几帧又正常了，所以特别难查）。
- **结论**：这里的顺序**恰好是正确写法**，不该改。
- 💡 **加分逻辑**：模型如果把这个正确写法"顺手改成 move_and_slide 之前"，或者干脆说"is_on_floor() 必须放在 move_and_slide 之后才对，这里没错，原因是××" —— 前者 **误判干扰项**（记录为"是"），后者 **得附加分**。
- 📌 注意：模型只要**没提这一条**，就**既不加分也不扣分**（不主动说它，很正常）。

---

## 打分表（照着填）

| 项目 | 分值 | 免费档得分 | Terra/旗舰得分 |
|---|---|---|---|
| 拼写错误 `strangth` | 1 | | |
| 大小写错误 `Speed` | 1 | | |
| `String + float` 报错 | 1 | | |
| 跳跃速度符号反了 | 1 | | |
| `move_and_slide()` 位置（顺序） | 1 | | |
| **小计（满分 5）** | | | |
| 附加：正确识别干扰项并说明原因 | +1 | | |
| **误判干扰项了吗（是/否，误判不扣分但要记录）** | | | |

**怎么解读分数**：

| 得分 | 结论 |
|---|---|
| **5 分** | 这个档位可以直接用来改你的真实代码 |
| **3 分**（只有 3 个硬错误） | 能帮你"修到能跑"，但**跳不起来**——它修完的代码要靠你自己跑一遍才发现问题 |
| **≤2 分** | 别用它碰真实代码；日常问答、翻译、摘要还是可以的 |
| **0～1 分**（连拼写错误都没找到） | 典型"顺着你的话编回答"。**这种输出最危险的地方是它看起来很有道理。** |

---

## 最后：这道题真正教你的东西

1. **"会报错"和"能跑但不对"是两类完全不同的问题**，多数人只盯着第一类。
2. **有标准答案的任务，是唯一能客观校准模型的任务。** 今天之后，你判断"哪个模型能不能干活"就有一把尺子了。
3. **能跑起来的坏代码比报错的代码危险得多**：报错会拦住你，逻辑错误不会。
