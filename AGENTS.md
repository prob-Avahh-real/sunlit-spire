# 晴光碑谷 (Sunlit Spire)

纪念碑谷风格的等距旋转解谜，主题偏明快晴空：珊瑚、薄荷、黄油色建筑，阳光与云层背景。

## 目标平台

| 平台 | 方式 | 产出 |
|------|------|------|
| 🍎 iOS | Capacitor → Xcode | IPA |
| 🤖 Android | Capacitor → Gradle | APK |
| ⌚ 手表 | 窄屏自适应 | 同 APK |
| 💍 智能戒指 | DeviceOrientation | 倾斜转向 |
| 🦯 智能手杖 | DeviceMotion | 轻点寻路 / 摆动转向 |

## 玩法

- 点击地砖：角色沿连通路径行走
- 拖动彩色旋钮：旋转建筑组，改变通路
- 到达金色光门过关
- 5 关：晨光第一步 → 旋转廊桥 → 双塔对齐 → 折角回廊 → 日冕之环

### 智能硬件

| 输入 | 动作 |
|------|------|
| 戒指左右倾 | 旋转当前/第一座塔 |
| 手杖轻点（加速度尖峰） | 尝试走向光门 |
| 手杖左右摆 | 旋转第一座塔 |

## 技术栈

- Canvas 2D 等距渲染 + BFS 寻路
- Capacitor 原生包装
- DeviceOrientation / DeviceMotion

## 构建

```bash
npm install
./build.sh          # 同步 www + 打 Android debug APK
```

改 `index.html` 后需复制到：

- `www/index.html`
- `android/app/src/main/assets/public/index.html`（`npx cap sync` 或 `./build.sh`）

## Harness / Loop（助手）

- 遵循根 `/Users/skat/AGENTS.md`：**Harness Engineering** + **Loop Engineering**
- Guide = 本文件；Sensor = 下方验证命令；同类失误第二次须沉淀规则或测试（棘轮）
- 开干前写清 **Done**；每切片过验证环；显式停止（成功 / 上限 / 无进展 / 人审）
- 详解：`docs/HARNESS_ENGINEERING.md`、`docs/LOOP_ENGINEERING.md`

## 验证环 / Done

```bash
npm install
npm test          # 若有
npm run build     # 或 build:web
npx cap sync android   # 若有 android/
# 可选：JAVA_HOME=…/openjdk@17 npm run apk:debug
```

**Done 示例**：测试通过（若有）+ web 产物进 `www/`/`dist/` + `cap sync` 无报错。可选穿戴未做可搁置，不纳入强制 Done。
