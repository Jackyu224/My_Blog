---
layout: post
title: Linux-入门
date: 2024-09-15
category:
  - Linux
  - WSL
thumbnail: /style/image/qw.jpg
---
* content
{:toc}


### WIN10 安装 wsl

1. 打开「Windows 功能」
2. 勾选「适用于 Linux 的 Windows 子系统」和「虚拟机平台」

![Windows 功能](https://cdn.jsdelivr.net/gh/Jackyu224/Img@main/img/202409150441.png))

#### 使用 PowerShell 管理员模式

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

#### 更新到WSL2

```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

#### 下载 Linux 内核更新包

```
https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
```
或者
```
wsl.exe --install
或 
wsl.exe --update
```

#### 将 WSL 2 设置为默认版本

```
wsl --set-default-version 2
```


输入：`wsl --list --online` 或 `wsl -l -o` 查看可用 Linux 发行版列表
输入：`wsl --install -d <Distribution Name>`。 将 `<Distribution Name>` 替换为要安装的发行版的名称












### 参考文档


[WSL 2 安装和管理指南](https://www.sysgeek.cn/install-wsl-2-windows/)
[如何使用 WSL 在 Windows 上安装 Linux](https://learn.microsoft.com/zh-cn/windows/wsl/install)
