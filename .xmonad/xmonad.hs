-- Imports {{{

import XMonad
import System.Exit
import System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M
-- actions
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
-- layouts
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.StackTile
-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
-- utils
import XMonad.Util.EZConfig
import XMonad.Util.Run

-- }}}
-- The basics {{{

myTerminal      = "gnome-terminal" -- "urxvt"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth   = 2
myModMask       = mod1Mask -- mod4Mask
myWorkspaces    = ["/dev/","/b/","/misc/","/media/"]
myNormalBorderColor = "white"
myFocusedBorderColor = "#f92672"

-- }}}
-- Keybindigs {{{

myKeysP = [ ("M-x g", spawn "google-chrome")
          , ("M-x n", spawn "nautilus --no-desktop")
          , ("M-x s", spawn "skype")
          , ("M-x k", spawn "jdownloader")
          , ("M-x o", spawn "opera") ]
myKeys  = [ ((0, 0x1008ff11), spawn "amixer -q set Master 2dB-")
          , ((0, 0x1008ff13), spawn "amixer -q set Master 2dB+")
          , ((0, 0x1008ff12), spawn "amixer -q set Master toggle") ]

-- }}}
-- Hooks & Layouts {{{

myLayoutHook = spacing 10 $ smartBorders$ avoidStruts$ (tiled ||| Mirror tiled ||| full)
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 3/100
    full = Full

myManageHook = ( composeAll . concat $
    [ [className =? "Gimp"           --> doFloat]
    , [className =? "MPlayer"        --> doFloat]
    , [className =? "MPlayer"        --> doShift "/media/"] ])

-- }}}
-- Main {{{

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/kevin/.xmonad/conf/xmobar"
    xmproc <- spawnPipe "/bin/bash /home/kevin/.xmonad/conf/autoload"
    xmonad $ defaultConfig {
        -- the basics
        terminal = myTerminal,
        focusFollowsMouse = myFocusFollowsMouse,
        borderWidth = myBorderWidth,
        modMask = myModMask,
        workspaces = myWorkspaces,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        -- hooks & layouts
        layoutHook = avoidStruts $ myLayoutHook,
        manageHook = manageDocks <+> manageHook defaultConfig,
        logHook = dynamicLogWithPP xmobarPP
                    { ppOutput = hPutStrLn xmproc
                    , ppTitle = xmobarColor "#56c2d6" "" . shorten 20
                    , ppCurrent = xmobarColor "#56c2d6" "" . wrap "[[" "]]"
                    , ppHidden = xmobarColor "white" "#161616" . wrap "[" "]"
                    , ppHiddenNoWindows = xmobarColor "#444444" "#161616" . wrap "[" "]"
                    , ppSep = " | " },
                  startupHook = setWMName "LG3D" }
        `additionalKeysP` myKeysP `additionalKeys` myKeys
-- }}}
