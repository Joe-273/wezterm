项目结构如下
```
.
├── adapter // 适配器，将用户数据转为 wezterm 可用配置
│   ├── colors.lua
│   ├── fonts.lua
│   ├── init.lua
│   └── keys.lua
├── config // 用户配置
│   ├── fonts.lua
│   ├── icons.lua
│   ├── init.lua
│   ├── keys.lua
│   └── theme.lua
├── core // 提供响应式和只读属性的创建函数
│   ├── reactive.lua
│   └── readonly.lua
├── events // 自定义事件以及内置事件
│   ├── format-tab-title.lua
│   ├── init.lua
│   ├── update-right-status.lua
│   ├── update-theme.lua
│   └── user-var-changed.lua
├── utils // 工具库
│   ├── color.lua
│   ├── core.lua
│   ├── events.lua
│   ├── helper.lua
│   └── theme.lua
├── store.lua // 数据仓库
└── wezterm.lua // 入口
```