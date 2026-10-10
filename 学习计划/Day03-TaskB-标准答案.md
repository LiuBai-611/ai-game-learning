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

### `is_on_floor()` 读的是"最近一次 `move_and_slide()` 的结果" —— **写法没错，不该改**

```gdscript
	move_and_slide()

	if Input.is_action_just_pressed("jump") and is_on_floor():   # ← 这一行不是错误
```

- **为什么不算错**：`is_on_floor()` 返回的永远是**最近一次已经完成的 `move_and_slide()` 的接触结果**。这里先调用了 `move_and_slide()`，读到的是**本帧**的状态；官方模板把这一行放在 `move_and_slide()` **之前**，读的是**上一帧**的状态 —— 两种都成立。
- ⚠️ **这里更正我自己一句**：原稿写的是"放在 `move_and_slide()` 之前会让开局第一下跳跃无效"，**说过头了**。第一帧确实读不到地面，但**官方模板就是这么写的**，它把这当成可接受的代价（下一帧起自动补上）。所以"之前/之后"不是对错问题，只差**一帧状态的新鲜度**。
- **结论**：这处顺序**不是 bug**，不该改。模型若说"必须放在 `move_and_slide()` 之后才对"，是**结论对、理由过头**；若它把这行改到别处还说是"修 bug"，那是**误导**。
- 💡 **加分逻辑**：指出这一处是正确写法并说明原因（读的是最近一次 `move_and_slide()` 的结果）→ **加 1 分**；把它当错误"修"掉 → 记为**误判干扰项**。
- 📌 模型只要**没提这一条**，就**既不加分也不扣分**（不主动说它很正常）。
- 📌 注意：模型只要**没提这一条**，就**既不加分也不扣分**（不主动说它，很正常）。

---

## 官方对照：这道题的"标尺"长什么样

Godot 官方文档里的 CharacterBody2D 平台跳跃模板（[Using CharacterBody2D/3D · godot-docs](https://raw.githubusercontent.com/godotengine/godot-docs/master/tutorials/physics/using_character_body_2d.rst)）：

```gdscript
extends CharacterBody2D

var speed = 300.0
var jump_speed = -400.0        # ← 负数！y 轴向下为正，所以"向上"要取负号

func _physics_process(delta):
    # Add the gravity.
    velocity += get_gravity() * delta      # ← 重力先算

    # Handle Jump.
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_speed            # ← 再处理跳跃

    # Get the input direction.
    var direction = Input.get_axis("ui_left", "ui_right")
    velocity.x = direction * speed

    move_and_slide()                       # ← 最后才移动
```

**对着这段看，今天那 5 处问题一目了然**：`jump_speed` 是**负**的（我们代码里是正的）、`move_and_slide()` 在**最后**（我们代码里在中间）、重力在跳跃判定**之前**（我们代码里在最后）。

📌 **两条附带说明**（免得你以后挨个抠）：
- 官方模板的重力是**无条件累加**的（`velocity += get_gravity() * delta`）。有些版本/教程写 `if not is_on_floor(): ...`，两种都在用 —— 这一条**不作为得分点**。
- 官方模板用 `Input.get_axis(...)` 一行拿方向；我们代码里 `get_action_strength` 相减**等价且正确**，只是啰嗦，**也不是错**。

> 💡 **这段官方模板就是你以后的"对照尺"**：以后 AI 给你写移动代码，拿它比一眼，就知道对方是照模板写的还是自己编的。

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
| **5 分**（5 处全找到） | 这个档位可以直接用来改你的真实代码 |
| **4 分**（漏掉跳跃符号那一格） | ⚠️ **最危险的一档**：它能把代码"修到能跑"，但**跳不起来**，而且它会理直气壮地告诉你"这里没问题" |
| **3 分**（只有 3 个硬错误） | 同上，且连执行顺序都没看出问题。它修完的代码要靠你自己跑一遍才会发现问题 |
| **≤2 分** | 别用它碰真实代码；日常问答、翻译、摘要还是可以的 |
| **0～1 分**（连拼写错误都没找到） | 典型"顺着你的话编回答"。**最危险的是它看起来很有道理。** |

> ⚠️ **附加分不能抵消逻辑错误。** 找出干扰项（+1）说明它"不乱改"，但漏掉跳跃符号说明它"看不出坏在哪"——这两件事不能互相顶替。
> **真正的分水岭是「跳跃速度符号」这一格**：那是唯一"不报错、能启动、按了没反应"的 bug，也是唯一能区分"读懂了物理"和"背下了语法"的一处。

---

## 最后：这道题真正教你的东西

1. **"会报错"和"能跑但不对"是两类完全不同的问题**，多数人只盯着第一类。
2. **有标准答案的任务，是唯一能客观校准模型的任务。** 今天之后，你判断"哪个模型能不能干活"就有一把尺子了。
3. **能跑起来的坏代码比报错的代码危险得多**：报错会拦住你，逻辑错误不会。
