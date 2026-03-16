# 跨境电商每日简报 - GitHub Pages 版本

生成静态 HTML 简报，自动部署到 GitHub Pages。

## 配置步骤

### 1. 登录 GitHub

```bash
gh auth login
```

### 2. 创建仓库

```bash
gh repo create daily-digest --public --source=. --remote=origin
```

### 3. 启用 GitHub Pages

访问：https://github.com/你的用户名/daily-digest/settings/pages
选择分支：main，文件夹：/root

### 4. 运行脚本生成简报

```bash
.\generate-html.ps1
```

### 5. 推送部署

```bash
git add .
git commit -m "Daily digest: 2026-03-16"
git push
```

## 访问链接

部署后访问：`https://你的用户名.github.io/daily-digest/2026-03-16.html`
