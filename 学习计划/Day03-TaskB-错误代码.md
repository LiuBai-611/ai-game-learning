# Day 03 · 任务 B 的测试代码（有 5 处问题 + 1 处干扰项）

> **用法**：把下面代码块里的内容**原样**粘进提示词，派给两个不同档位的模型。
> ⚠️ **不要把这个文件和 `Day03-TaskB-标准答案.md` 一起粘进去**——粘了就等于把答案给模型了。
> ⚠️ 代码里用的是 **Tab 缩进**（别转成空格），Godot 对混用缩进会另外报错，那就变成"你自己引入的错"了。

---

## 复制这段

```gdscript
extends CharacterBody2D
# 假设这个项目里已经配置好 move_left / move_right / jump 三个输入动作

const GRAVITY = 980
@export var speed = 300.0
var jump_velocity = 400.0


func _physics_process(delta):
	var direction = Input.get_action_strangth("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction * Speed
	move_and_slide()

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	velocity.y += GRAVITY * delta


func _ready():
	print("玩家的移动速度是 " + speed + " 像素/秒")
```

---

## 这段代码在做什么（你自己的参考，别粘给模型）

一个 Godot 4 的 2D 玩家角色：
- 水平方向：读左右输入 → 给 `velocity.x`
- 竖直方向：按跳跃键给一个向上的速度；每帧加重力
- 每帧最后调用 `move_and_slide()` 真正移动

**新手会觉得"这不就是官方模板吗"** —— 它确实是照着官方模板改的，改坏的地方刚好是**最容易被忽略的 5 个点**。

---

## 背景知识（粘贴前可以先读，避免看不懂模型的回答）

| 概念 | 一句话 |
|---|---|
| `velocity` | 角色当前速度（像素/秒），**x 向右为正，y 向下为正**（屏幕坐标系，和数学坐标相反） |
| `move_and_slide()` | 用 `velocity` 真正把角色移动一帧，并处理碰撞；它会**顺便更新** `is_on_floor()` 的结果 |
| `delta` | 上一帧到这一帧的时间（秒）。速度 × delta = 这一帧该移动的距离 |
| `@export` | 让这个变量出现在 Godot 右侧属性面板里，可以直接调 |
| 输入动作 | `move_left` 这种名字要在「项目设置 → 输入映射」里先定义，代码里才能用 |
