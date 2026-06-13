# 青苹果 · 招聘候选人回复监控平台

一个单文件 React 静态网站，用于 HR 招聘候选人回复监控。

## 文件说明

| 文件 | 说明 |
|------|------|
| `index.html` | 主页面（自包含，含内联 React + Babel） |
| `styles.css` | 全局样式（青苹果主题） |
| `favicon.svg` | 网站图标 |
| `assets/` | 静态资源（Logo 等） |

## 部署方式

### Netlify（推荐）
直接拖拽整个文件夹到 [Netlify Drop](https://app.netlify.com/drop) 即可部署。

### Vercel
导入此仓库到 Vercel，框架选择"其他/静态网站"。

### 本地运行
直接用浏览器打开 `index.html` 即可。

## 技术栈
- React 18（CDN）
- Babel Standalone（浏览器内编译 JSX）
- Chart.js（图表）
- SheetJS/xlsx（Excel 解析）
- 零构建、零安装依赖
