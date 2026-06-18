# Little Moon - App Store 上传指南

## 📱 步骤 1: 在 App Store Connect 创建应用

### 1.1 登录 App Store Connect
1. 打开浏览器访问：https://appstoreconnect.apple.com
2. 使用你的 Apple ID 登录

### 1.2 创建新应用
1. 点击 **"My Apps"**（我的 App）
2. 点击左上角的 **"+"** 按钮
3. 选择 **"New App"**（新建 App）

### 1.3 填写应用基本信息
- **Platforms**: 选择 ✅ iOS
- **Name**: `Little Moon`
- **Primary Language**: `Chinese (Simplified)` 或 `English (U.S.)`
- **Bundle ID**: 选择 `app.Little-Moon` （如果看不到，需要先在开发者网站注册）
- **SKU**: `little-moon-001` （任意唯一标识符）
- **User Access**: `Full Access`

点击 **Create** 创建

---

## 📝 步骤 2: 填写应用元数据

### 2.1 App Information（应用信息）
左侧菜单 → **App Information**

- **Privacy Policy URL**: `https://shenxianpeng.github.io/Little-Moon/`
- **Category**: 
  - Primary: `Health & Fitness` 或 `Lifestyle`
  - Secondary: `Medical` (可选)
- **Content Rights**: 选择 `No, it does not contain, show, or access third-party content`

### 2.2 Pricing and Availability（定价和可用性）
左侧菜单 → **Pricing and Availability**

- **Price**: 选择你想要的价格
  - `Free` (免费) 或者
  - `$0.99`, `$1.99`, `$2.99` 等
  
- **Availability**: 选择所有国家或特定国家

### 2.3 App Privacy（应用隐私）
左侧菜单 → **App Privacy**

1. 点击 **"Get Started"**
2. 回答问题：
   - **Do you or your third-party partners collect data from this app?**
     - 选择：`No, we do not collect data from this app`
3. 点击 **"Save"** 和 **"Publish"**

---

## 📸 步骤 3: 准备应用截图和描述

### 3.1 准备截图
需要准备以下尺寸的截图（至少 3 张，最多 10 张）：

**iPhone 6.9" Display** (iPhone 17 Pro Max):
- 尺寸: 1320 x 2868 像素
- 建议截图内容:
  1. 主界面 - 显示三个声音选项
  2. 播放界面 - 显示正在播放白噪音
  3. Timer 界面 - 显示睡眠定时器设置
  4. 音量控制 - 显示音量调节
  5. AirPlay - 显示 AirPlay 功能

### 3.2 应用描述（中文版示例）

**描述内容**:
```
Little Moon - 你的睡眠伴侣 🌙

寻找更好的睡眠质量？Little Moon 为你提供舒缓的白噪音、雨声和海浪声，帮助你快速入睡并保持深度睡眠。

✨ 主要功能
• 三种精心设计的声音：白噪音、雨声、海浪声
• 简洁优雅的界面，易于使用
• 睡眠定时器，自动停止播放
• 后台播放支持，锁屏后继续工作
• AirPlay 支持，可投射到其他设备
• 无广告，无订阅，一次购买永久使用

🌙 适合场景
• 睡前放松，快速入睡
• 工作时提高专注力
• 冥想和瑜伽
• 屏蔽环境噪音
• 安抚婴儿入睡

简单、纯粹、有效。Little Moon 让你的夜晚更安静。
```

**关键词（Keywords）**:
```
white noise,sleep,meditation,relax,ocean,rain,focus,baby sleep,ambient,calm
```

**宣传文本（Promotional Text）** (可选):
```
享受宁静的夜晚，用 Little Moon 改善你的睡眠质量。
```

---

## 🚀 步骤 4: 在 Xcode 中 Archive 和上传

### 4.1 在 Xcode 中打开项目
```bash
open "Little Moon.xcodeproj"
```

### 4.2 选择目标设备
在 Xcode 顶部工具栏：
- 点击设备选择器
- 选择 **"Any iOS Device (arm64)"**

### 4.3 执行 Archive
1. 菜单栏 → **Product** → **Archive**
2. 等待构建完成（约 1-2 分钟）
3. 成功后会自动打开 **Organizer** 窗口

### 4.4 上传到 App Store Connect

在 Organizer 窗口中：

1. 选择刚创建的 Archive
2. 点击右侧的 **"Distribute App"** 按钮
3. 选择 **"App Store Connect"**，点击 **Next**
4. 选择 **"Upload"**，点击 **Next**
5. 配置选项（保持默认）：
   - ✅ Include bitcode for iOS content
   - ✅ Upload symbols
   - ✅ Manage Version and Build Number
6. 点击 **Next**
7. 选择自动签名：**"Automatically manage signing"**
8. 点击 **Next**
9. 确认信息，点击 **Upload**
10. 等待上传完成（可能需要 5-15 分钟）

### 4.5 如果遇到签名问题

如果提示没有 Distribution 证书：

1. Xcode 菜单 → **Settings** (或 Preferences)
2. 选择 **Accounts** 标签
3. 选择你的 Apple ID
4. 点击你的团队名称
5. 点击 **"Manage Certificates"**
6. 点击左下角 **"+"**
7. 选择 **"Apple Distribution"**
8. 关闭窗口，重新 Archive

---

## ✅ 步骤 5: 提交审核

### 5.1 等待处理完成
上传后，需要等待 Apple 处理（通常 5-30 分钟）

在 App Store Connect 中：
1. 进入你的应用
2. 左侧菜单 → **TestFlight** 或直接看主页面
3. 等待状态从 "Processing" 变为 "Ready to Submit"

### 5.2 在 App Store Connect 中完成设置

回到应用主页：

1. 左侧菜单 → **App Store** → **iOS App** → **1.0 Prepare for Submission**
2. 上传截图（拖拽到对应位置）
3. 填写描述、关键词等
4. 选择刚上传的 Build 版本
5. 填写 **Version Release** 信息
6. 填写 **Rating** (年龄分级):
   - 通常选择 `4+` (所有年龄)
7. 审核信息：
   - **Contact Information**: 填写你的邮箱和电话
   - **Notes**: 可以留空或简单说明应用功能

### 5.3 提交审核
1. 点击右上角 **"Save"**
2. 点击 **"Add for Review"** 或 **"Submit for Review"**
3. 确认所有信息
4. 点击 **"Submit"**

---

## ⏱️ 等待审核

- **审核时间**: 通常 1-3 天
- **状态跟踪**: 在 App Store Connect 中查看
- **邮件通知**: Apple 会发邮件通知审核进度

### 可能的状态：
1. **Waiting for Review** - 排队等待审核
2. **In Review** - 正在审核中
3. **Pending Developer Release** - 审核通过，等待你发布
4. **Ready for Sale** - 已上架！🎉

---

## 🎯 快速命令参考

### 在终端中打开 Xcode 项目
```bash
cd "/Users/sxp/Repos/Little Moon"
open "Little Moon.xcodeproj"
```

### 查看已创建的 Archive
```bash
open ~/Library/Developer/Xcode/Archives
```

### 清理构建缓存（如果遇到问题）
```bash
xcodebuild clean -project "Little Moon.xcodeproj" -scheme "Little Moon"
```

---

## 📞 如果遇到问题

### 常见问题解决：

**1. 没有 Bundle ID 选项**
- 访问 https://developer.apple.com
- 进入 **Certificates, Identifiers & Profiles**
- 创建新的 **Identifier**，Bundle ID 为 `app.Little-Moon`

**2. Archive 失败**
- 确保选择了 **"Any iOS Device"** 而不是模拟器
- 清理项目：Product → Clean Build Folder
- 重启 Xcode

**3. 上传失败**
- 检查网络连接
- 确认 Apple Developer 账号正常
- 确认已接受最新的协议（在 developer.apple.com）

**4. 审核被拒**
- 查看 App Store Connect 中的拒绝原因
- 修改问题后重新提交
- 如有疑问可以与审核团队沟通

---

## 🎉 成功上架后

1. 分享你的应用链接
2. 在社交媒体宣传
3. 收集用户反馈
4. 定期更新和改进

祝你的应用审核通过，成功上架！🚀
