# 青苹果 · 招聘候选人回复监控平台

> 清新青苹果绿主题的招聘候选人消息接收与统计分析系统，**单文件 React + 浏览器端 Babel，零构建、零安装**，包含完整 UI/UX 升级与响应式适配。

## ✨ 核心功能

### 1. 简历导入 + 联系方式自动筛选 + 自动发送
- 支持 **Excel / CSV** 简历批量导入（多文件）
- 自动识别手机号、微信字段，对格式异常的联系方式**红/黄标签提示**
- 选择"微信"或"短信"渠道，**自动校验**候选人联系方式有效性
- 支持模板变量：`{name}` `{position}` `{city}`
- 支持单条 / **批量**发送招聘邀请
- 一键下载导入模板

### 2. 实时回复监控
- 候选人列表中**回复标绿、未回复标红**，已发送但未回复为蓝色
- 自动模拟 webhook 接收回复（8 秒扫描一次，随机 1~2 人状态切换）
- 点击候选人查看**完整互动时间线**、回复内容、基本信息
- 行 hover 快速操作：直接发起短信 / 微信 / 复制手机号

### 3. 数据可视化（Chart.js v4）
- 顶部 4 张统计卡片（含 Mini Sparkline 趋势线）
- **HR 总览水平条形图** + **每日堆叠柱状图** + **发送/回复对比（柱状 / 雷达切换）**
- **来源渠道回复率统计**（含进度条可视化）
- **HR 表现排行**（3 张图表：HR 总量条形图 / 单 HR 每日明细 / 部门占比饼图）

### 4. 每日智能建议（AI）
趋势分析、来源分析、HR 表现 3 个页面底部自动生成**个性化建议**（基于真实回复数据计算），最多 4 条，AI 标签 + 日期标识。

### 5. 完整 UI/UX 升级包（v1+v2+v3）
- 玻璃质感（Glassmorphism）侧栏 / Modal / Toast / 工具栏
- Aurora 极光渐变背景 + Noise 噪点
- Vercel 风格 Toast 通知
- 骨架屏（Skeleton）首次加载
- 视差滚动（Parallax 50% 速度）
- 滚动揭示动画（Reveal on Scroll，IntersectionObserver）
- 点击涟漪（Ripple）+ 顶栏进度条 + 浮动返回顶部 FAB
- 焦点环（Focus Ring）+ 弹簧缓动（Spring Easing）

## 🎨 薄荷绿主题
- 主色：`#0FA968`（薄荷绿）+ `#0A7D49`（深绿）
- 背景：白底 + 极光渐变
- 通过 CSS 变量集中管理，可在一处修改主题色
- 圆角、阴影、状态徽标均为统一薄荷绿风格

## 📱 响应式与缩放
- **6 档断点**：≤480 / ≤720 / 721-900 / 901-1100 / 1101-1280 / ≥1280 / ≥1600
- **移动端**：汉堡按钮 + 抽屉式侧栏、表格横向滚动、Modal 全屏化
- **整页缩放**：顶栏右侧工具栏（50% / 60% / ... / 100% / ... / 200%，共 11 档）
- **快捷键**：`Ctrl/Cmd + +/-` 缩放，`Ctrl/Cmd + 0` 重置
- **持久化**：缩放状态保存到 `localStorage`，刷新保留
- **iOS 系统缩放**：viewport `user-scalable=yes`，允许双指捏合

## 🚀 快速开始

### 方式 1：本地直接打开（最简单）
双击 `start.bat`（Windows），或在 Chrome 中按 `Ctrl+O` 打开 `index.html`。
注意：必须用现代浏览器（Chrome / Edge / Firefox 最新版）。

### 方式 2：本地起一个静态服务器
```bash
# Python 3
python -m http.server 5173

# 或 Node
npx serve -l 5173 -s .
```
浏览器访问 http://localhost:5173

### 方式 3：部署到 Vercel（推荐，长期免费 URL）
1. 把本项目推送到 GitHub：
   ```bash
   git init && git add . && git commit -m "init"
   git branch -M main
   git remote add origin https://github.com/<您的用户名>/greenapple-hr.git
   git push -u origin main
   ```
2. 打开 https://vercel.com/new ，用 GitHub 登录
3. Import 您的 `greenapple-hr` 仓库，点击 Deploy
4. 1-2 分钟后得到永久 URL：`https://greenapple-hr-xxx.vercel.app`

**配置已就绪**：
- `vercel.json`（静态站点配置 + 安全头 + 1 年静态资源缓存）
- `package.json` 的 `build` 脚本为 no-op（无构建步骤）
- 入口：`index.html`（~3.9MB，内联 5 个 vendor JS）

### 方式 4：部署到 CloudBase 静态托管
1. 在 https://console.cloud.tencent.com/tcb 开通 CloudBase 服务
2. 创建环境 + 启用"静态网站托管"
3. 用 `tcb` 命令行上传：
   ```bash
   npm install -g @cloudbase/cli
   tcb login
   tcb hosting deploy ./index.html ./app.js ./styles.css ./favicon.svg ./assets -e <您的环境ID>
   ```

## 📁 项目结构

```
demo/
├── index.html              # 3.9MB 入口（含 5 个内联 vendor JS）
├── app.js                  # 110KB React 源码
├── styles.css              # 86KB 薄荷绿主题 + 响应式 + 缩放
├── vercel.json             # Vercel 部署配置
├── package.json            # 元信息
├── vite.config.js          # Vite 配置（备用，未使用）
├── favicon.svg             # 站点图标
└── assets/                 # logo + 历史图片
    ├── logo.svg
    └── *.png
```

## 🔌 接入真实后端

当前回复监控使用前端模拟（定时器轮询）。对接真实业务时：

1. **微信 / 短信发送**：将 `SendDialog` 的 `onConfirm` 改为调用后端 API。
2. **实时回复**：
   - 推荐 **WebSocket** 监听后端回复事件，调用 `markReplied(id)` 切换状态。
   - 也可使用 **SSE** 或 **长轮询** 替代。
3. **候选人 / 简历导入**：将 `parseResumeFile` 解析后的数据 POST 到后端入库。
4. **数据统计**：将 `useMemo` 内的 `daily/sourceStats/hrStats` 改为从后端拉取。

## 🛠 技术栈

- **React 18.3.1** —— UI 框架
- **Babel Standalone 7.x** —— 浏览器内编译 JSX，零构建
- **Chart.js 4.4.4** —— 数据可视化
- **SheetJS (xlsx) 0.20.x** —— Excel/CSV 解析
- **纯 CSS**（无 Tailwind / 无 UI 库）—— Glassmorphism、Aurora、Skeleton 等
- **零 npm 依赖**（无 node_modules）—— 可直接 `file://` 打开

## 📄 License

MIT
