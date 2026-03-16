#!/usr/bin/env node
/**
 * 跨境电商每日简报技能 - 主入口
 * 用法：openclaw daily-digest run [--recipient ou_xxx]
 */

const { execSync } = require('child_process');
const path = require('path');

const args = process.argv.slice(2);
const recipientIndex = args.indexOf('--recipient');
const recipient = recipientIndex !== -1 && args[recipientIndex + 1] 
  ? args[recipientIndex + 1] 
  : 'ou_e0811fcf1b09df1ee2e7ff4840de5543';

console.log('🧹 跨境电商每日简报技能');
console.log('========================');

// 执行 PowerShell 脚本生成简报内容
try {
  const scriptPath = path.join(__dirname, 'generate.ps1');
  const psCommand = `powershell -ExecutionPolicy Bypass -File "${scriptPath}" --recipient "${recipient}"`;
  
  console.log('\n📰 正在抓取新闻源...');
  execSync(psCommand, { stdio: 'inherit', shell: 'pwsh' });
  
  console.log('\n✅ 简报生成完成！');
  console.log('📌 提示：飞书文档创建需要调用 feishu_doc 工具');
  
} catch (error) {
  console.error('❌ 生成失败:', error.message);
  process.exit(1);
}
