<h1 align="center">StardustEngine</h1>

![icon](icon.png)

StardustEngine 是一个工具链较为完整的跨平台游戏引擎，其核心框架借鉴了Piccolo的分层架构，并在设计上借鉴了 Unity、Godot 等成熟引擎，旨在为 BacklightStudio 量身定制一套适合自己的游戏引擎。

## Current Situation

不带反射系统的版本在 discard 分支下，使用 Visual Studio 管理，有可用的编辑器。

带早期版本反射系统的版本在 old-version 分支下，使用 Visual Studio 管理，目前没有提供编辑器。

当前分支为最新版本，使用 xmake 进行构建，反射系统方面会使用 XGen 完成，不再使用 OpenGL 进行渲染，而改用 bgfx 的方案。