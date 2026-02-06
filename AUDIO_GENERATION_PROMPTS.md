# 音频生成提示词 / Audio Generation Prompts

## 1. 白噪音 (White Noise)
**文件名**: `white_noise.mp3` 或 `white_noise.m4a`

### 提示词:
```
生成一段60秒的纯净白噪音音频。要求：
- 频率范围：20Hz - 20kHz 均匀分布
- 音量稳定，无明显起伏
- 平静、舒缓的感觉
- 适合睡眠和放松
- 无循环感，可无缝循环播放
- 音频格式：MP3 或 M4A，44.1kHz 采样率，立体声
```

### English Prompt:
```
Generate a 60-second pure white noise audio file with the following requirements:
- Frequency range: 20Hz - 20kHz evenly distributed
- Stable volume with no noticeable fluctuations
- Calm and soothing atmosphere
- Suitable for sleep and relaxation
- Seamless looping capability without noticeable transitions
- Audio format: MP3 or M4A, 44.1kHz sample rate, stereo
```

---

## 2. 雨声 (Rain)
**文件名**: `rain.mp3` 或 `rain.m4a`

### 提示词:
```
生成一段60秒的逼真雨声音频。要求：
- 中等强度的持续降雨声
- 包含雨滴打在不同表面的自然声音变化
- 偶尔有稍强的雨声起伏，营造自然感
- 柔和、放松的氛围
- 无雷声或其他突兀的声音
- 可无缝循环播放
- 音频格式：MP3 或 M4A，44.1kHz 采样率，立体声
```

### English Prompt:
```
Generate a 60-second realistic rain sound audio file with the following requirements:
- Medium intensity continuous rainfall
- Natural sound variations of raindrops hitting different surfaces
- Occasional slight intensity variations for natural feel
- Soft and relaxing atmosphere
- No thunder or other abrupt sounds
- Seamless looping capability
- Audio format: MP3 or M4A, 44.1kHz sample rate, stereo
```

---

## 3. 海浪声 (Ocean Waves)
**文件名**: `ocean.mp3` 或 `ocean.m4a`

### 提示词:
```
生成一段60秒的平静海浪声音频。要求：
- 温柔的海浪拍打沙滩的声音
- 自然的节奏感，波浪有涨有退
- 包含海水流动、泡沫破裂的细节声音
- 平静、宁静的海滩氛围
- 无海鸥叫声或其他动物声音
- 波浪周期约6-8秒，营造舒缓感
- 可无缝循环播放
- 音频格式：MP3 或 M4A，44.1kHz 采样率，立体声
```

### English Prompt:
```
Generate a 60-second calm ocean waves audio file with the following requirements:
- Gentle waves lapping against the beach
- Natural rhythm with waves rising and receding
- Include detailed sounds of water flow and foam bursting
- Calm and serene beach atmosphere
- No seagull calls or other animal sounds
- Wave cycle approximately 6-8 seconds for a soothing feel
- Seamless looping capability
- Audio format: MP3 or M4A, 44.1kHz sample rate, stereo
```

---

## 使用说明 / Usage Instructions

### 生成音频后的步骤:
1. 将生成的音频文件重命名为相应的文件名
2. 将文件拖放到 Xcode 项目中的 `Little Moon` 文件夹
3. 确保在添加文件时勾选 "Copy items if needed" 和 "Add to targets: Little Moon"
4. 支持的格式：MP3, M4A, CAF, WAV（推荐使用 MP3 或 M4A 以减小文件大小）

### After Generating Audio:
1. Rename the generated audio files to the corresponding filenames
2. Drag and drop the files into the `Little Moon` folder in Xcode
3. Make sure to check "Copy items if needed" and "Add to targets: Little Moon" when adding files
4. Supported formats: MP3, M4A, CAF, WAV (MP3 or M4A recommended for smaller file size)

---

## 推荐的 AI 音频生成工具 / Recommended AI Audio Generation Tools

- **ElevenLabs** - 高质量音效生成
- **Soundraw** - 音乐和音效生成
- **Mubert** - AI 音乐和氛围音生成
- **Suno AI** - 音频和音效生成
- **AudioCraft (Meta)** - 开源音频生成工具

## 备注 / Notes

如果 AI 工具不支持直接生成这些音效，你也可以：
1. 从免费音效库下载（如 Freesound.org, Zapsplat.com）
2. 使用传统音频编辑软件（如 Audacity）生成白噪音
3. 录制真实的环境音并进行处理

If AI tools don't support direct generation of these sounds, you can also:
1. Download from free sound libraries (e.g., Freesound.org, Zapsplat.com)
2. Use traditional audio editing software (e.g., Audacity) to generate white noise
3. Record and process real environmental sounds
