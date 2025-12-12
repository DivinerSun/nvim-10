local M = {}

M.ui = {
	Separator = "-",
	Tab = "󰌒 ",
	TabClose = "󰅝 ",
	TabActive = " ",
	TabInactive = "󰅙 ",
}

M.diagnostics = {
  Error = " ",
  Warn  = " ",
  Hint = " ",
  Info  = " ",
}

M.git = {
  Added    = " ",
  Modified = " ",
  Removed  = " ",
	Branch = "󱓎",
}

-- 基础图标
M.kinds = {
	Text = "󰉿",
	Method = "󰊕",
	Function = "󰡱",
	Constructor = "󰊕",
	Field = "󰜢",
	Variable = "󱃼",
	Class = "", -- "󰠱",
	Interface = "󰕝",
	Module = "󰕳",
	Property = "",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "󰴍",
	Keyword = "󰌋",
	Snippet = "󱄽",
	Color = "󰏘",
	File = "󰈙",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "󰫧",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "",
}

-- 经典 Emoji 图标
M.kind_icons_base = {
	Text = "📝",
	Method = "🔧",
	Function = "⚡",
	Constructor = "🏗️",
	Field = "📦",
	Variable = "🔤",
	Class = "🎨",
	Interface = "🔌",
	Module = "📚",
	Property = "🏷️",
	Unit = "📏",
	Value = "💎",
	Enum = "🎯",
	Keyword = "🔑",
	Snippet = "✂️",
	Color = "🌈",
	File = "📄",
	Reference = "🔗",
	Folder = "📁",
	EnumMember = "🎲",
	Constant = "🔒",
	Struct = "🏛️",
	Event = "⚡",
	Operator = "➕",
	TypeParameter = "📐",
}

-- 动物主题 Emoji
M.kind_icons_animal = {
	Text = "🐝", -- 蜜蜂（忙碌的文本）
	Method = "🦊", -- 狐狸（聪明的方法）
	Function = "🐉", -- 龙（强大的函数）
	Constructor = "🦁", -- 狮子（构建者）
	Field = "🐱", -- 猫（字段）
	Variable = "🐶", -- 狗（变量）
	Class = "🦅", -- 鹰（类）
	Interface = "🦋", -- 蝴蝶（接口）
	Module = "🐘", -- 大象（模块）
	Property = "🐰", -- 兔子（属性）
	Unit = "🐜", -- 蚂蚁（单位）
	Value = "💎", -- 宝石（值）
	Enum = "🦉", -- 猫头鹰（枚举）
	Keyword = "🔑", -- 钥匙（关键字）
	Snippet = "🦎", -- 蜥蜴（代码片段）
	Color = "🦜", -- 鹦鹉（颜色）
	File = "🐢", -- 乌龟（文件）
	Reference = "🔗", -- 链接（引用）
	Folder = "🦘", -- 袋鼠（文件夹）
	EnumMember = "🐠", -- 鱼（枚举成员）
	Constant = "🦌", -- 鹿（常量）
	Struct = "🏰", -- 城堡（结构体）
	Event = "⚡", -- 闪电（事件）
	Operator = "🎯", -- 靶心（操作符）
	TypeParameter = "🎪", -- 马戏团（类型参数）
}

-- 自然主题 Emoji
M.kind_icons_nature = {
	Text = "🌸", -- 樱花
	Method = "🌊", -- 海浪
	Function = "⚡", -- 闪电
	Constructor = "🏔️", -- 山
	Field = "🌱", -- 幼苗
	Variable = "🌿", -- 草
	Class = "🌳", -- 大树
	Interface = "🌈", -- 彩虹
	Module = "🌏", -- 地球
	Property = "🍀", -- 四叶草
	Unit = "🌾", -- 稻穗
	Value = "💎", -- 钻石
	Enum = "🎋", -- 竹子
	Keyword = "🔑", -- 钥匙
	Snippet = "🌺", -- 花
	Color = "🌈", -- 彩虹
	File = "🍃", -- 叶子
	Reference = "🔗", -- 链接
	Folder = "🌲", -- 松树
	EnumMember = "🌻", -- 向日葵
	Constant = "⭐", -- 星星
	Struct = "🏛️", -- 神殿
	Event = "🌟", -- 闪亮星星
	Operator = "➕", -- 加号
	TypeParameter = "🌙", -- 月亮
}

-- 食物主题 Emoji
M.kind_icons_food = {
	Text = "🍞", -- 面包
	Method = "🍕", -- 披萨
	Function = "⚡", -- 闪电
	Constructor = "🏗️", -- 建筑
	Field = "🥗", -- 沙拉
	Variable = "🍎", -- 苹果
	Class = "🍰", -- 蛋糕
	Interface = "🍜", -- 面条
	Module = "🍱", -- 便当
	Property = "🍪", -- 饼干
	Unit = "🥖", -- 法棍
	Value = "💎", -- 钻石
	Enum = "🍔", -- 汉堡
	Keyword = "🔑", -- 钥匙
	Snippet = "🍕", -- 披萨片
	Color = "🌈", -- 彩虹
	File = "📄", -- 文件
	Reference = "🔗", -- 链接
	Folder = "📁", -- 文件夹
	EnumMember = "🍟", -- 薯条
	Constant = "🍬", -- 糖果
	Struct = "🏛️", -- 建筑
	Event = "⚡", -- 闪电
	Operator = "➕", -- 加号
	TypeParameter = "🎂", -- 生日蛋糕
}

-- 太空主题 Emoji
M.kind_icons_space = {
	Text = "📡", -- 卫星天线
	Method = "🛸", -- UFO
	Function = "🚀", -- 火箭
	Constructor = "🏗️", -- 建造
	Field = "🌌", -- 银河
	Variable = "⭐", -- 星星
	Class = "🪐", -- 土星
	Interface = "🌠", -- 流星
	Module = "🌍", -- 地球
	Property = "✨", -- 闪光
	Unit = "🛰️", -- 卫星
	Value = "💎", -- 钻石
	Enum = "🌙", -- 月亮
	Keyword = "🔑", -- 钥匙
	Snippet = "🌟", -- 发光星星
	Color = "🌈", -- 彩虹
	File = "📄", -- 文件
	Reference = "🔗", -- 链接
	Folder = "📁", -- 文件夹
	EnumMember = "☄️", -- 彗星
	Constant = "⭐", -- 星星
	Struct = "🏛️", -- 建筑
	Event = "⚡", -- 闪电
	Operator = "➕", -- 加号
	TypeParameter = "🪐", -- 行星
}

M.kind_icons_game = {
	Text = "📜", -- 卷轴
	Method = "🎮", -- 游戏手柄
	Function = "⚔️", -- 剑
	Constructor = "🏗️", -- 建造
	Field = "🗡️", -- 匕首
	Variable = "🎲", -- 骰子
	Class = "🏰", -- 城堡
	Interface = "🎯", -- 靶心
	Module = "🗺️", -- 地图
	Property = "💎", -- 宝石
	Unit = "🛡️", -- 盾牌
	Value = "👑", -- 皇冠
	Enum = "🎰", -- 老虎机
	Keyword = "🔑", -- 钥匙
	Snippet = "🎪", -- 马戏团
	Color = "🌈", -- 彩虹
	File = "📄", -- 文件
	Reference = "🔗", -- 链接
	Folder = "📁", -- 文件夹
	EnumMember = "🎭", -- 面具
	Constant = "⚓", -- 锚
	Struct = "🏛️", -- 神殿
	Event = "⚡", -- 闪电
	Operator = "➕", -- 加号
	TypeParameter = "🎨", -- 调色板
}

M.LazyIcons  = {
    misc = {
      dots = "󰇘",
    },
    ft = {
      octo = " ",
      gh = " ",
      ["markdown.gh"] = " ",
    },
    dap = {
      Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint          = " ",
      BreakpointCondition = " ",
      BreakpointRejected  = { " ", "DiagnosticError" },
      LogPoint            = ".>",
    },
    kinds = {
      Array         = " ",
      Boolean       = "󰨙 ",
      Class         = " ",
      Codeium       = "󰘦 ",
      Color         = " ",
      Control       = " ",
      Collapsed     = " ",
      Constant      = "󰏿 ",
      Constructor   = " ",
      Copilot       = " ",
      Enum          = " ",
      EnumMember    = " ",
      Event         = " ",
      Field         = " ",
      File          = " ",
      Folder        = " ",
      Function      = "󰊕 ",
      Interface     = " ",
      Key           = " ",
      Keyword       = " ",
      Method        = "󰊕 ",
      Module        = " ",
      Namespace     = "󰦮 ",
      Null          = " ",
      Number        = "󰎠 ",
      Object        = " ",
      Operator      = " ",
      Package       = " ",
      Property      = " ",
      Reference     = " ",
      Snippet       = "󱄽 ",
      String        = " ",
      Struct        = "󰆼 ",
      Supermaven    = " ",
      TabNine       = "󰏚 ",
      Text          = " ",
      TypeParameter = " ",
      Unit          = " ",
      Value         = " ",
      Variable      = "󰀫 ",
    },
  }

return M
