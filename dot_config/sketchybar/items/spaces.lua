local constants = require("constants")
local settings = require("config.settings")

local spaces = {}

local swapWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

local currentWorkspaceWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

local default_workspaces = { "1", "2", "3", "4", "5" }

local function selectCurrentWorkspace(focusedWorkspaceName)
  for _, ws in ipairs(default_workspaces) do
    local item = spaces[ws]
    if item ~= nil then
      local isSelected = ws == focusedWorkspaceName
      item:set({
        icon = { color = isSelected and settings.colors.orange or settings.colors.grey },
        background = { drawing = isSelected and "on" or "off" },
      })
    end
  end

  sbar.trigger(constants.events.UPDATE_WINDOWS)
end

local function findAndSelectCurrentWorkspace()
  sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
    local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
    selectCurrentWorkspace(focusedWorkspaceName)
  end)
end

local function createWorkspaces()
  for _, ws in ipairs(default_workspaces) do
    spaces[ws] = sbar.add("item", "space." .. ws, {
      position = "left",
      icon = {
        string = ws,
        padding_left = 10,
        padding_right = 10,
        color = settings.colors.grey,
        font = {
          family = settings.fonts.numbers,
          style = settings.fonts.styles.bold,
          size = 14.0,
        },
      },
      label = { drawing = false },
      background = {
        color = settings.colors.bg2,
        border_width = 1,
        height = 24,
        border_color = settings.colors.black,
        corner_radius = 5,
        drawing = false,
      },
      padding_left = 2,
      padding_right = 2,
      click_script = "aerospace workspace " .. ws,
    })
  end

  findAndSelectCurrentWorkspace()
end

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
  selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
  sbar.trigger(constants.events.UPDATE_WINDOWS)
end)

createWorkspaces()
