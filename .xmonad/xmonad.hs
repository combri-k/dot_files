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
import XMonad.Hooks.ManageHelpers
-- utils
import XMonad.Util.EZConfig
import XMonad.Util.Run
-- }}}

-- The basics {{{
myTerminal           = "gnome-terminal"
myFocusFollowsMouse  = True
myBorderWidth        = 2
myNormalBorderColor  = "white"
myFocusedBorderColor = "#f92672"
-- }}}

-- Keybindings {{{
myKeysP :: [(String, X ())]
myKeysP = [ ("M-x g", spawn "google-chrome")
          , ("M-x o", spawn "opera")
          , ("M-x t", spawn "thunderbird")
          , ("M-x j", spawn "java -jar /home/ck/.jd/JDownloader.jar")
          , ("M-x n", spawn "nautilus --no-desktop") ]

myKeys :: [((ButtonMask, KeySym), X ())]
myKeys = [ ((0, 0x1008ff11), spawn "amixer -q set Master 2dB+")
         , ((0, 0x1008ff13), spawn "amixer -q set Master 2dB-")
         , ((0, 0xff61), spawn "gnome-screenshot")
         -- , ((0, 0xff65),     spawn "amixer -q set Master 2dB+")
         -- , ((0, 0xff66),     spawn "amixer -q set Master 2dB-")
         , ((0, 0x1008ff12), spawn "amixer -q set Master toggle") ]
-- }}}

-- Hooks & Layouts {{{
myLayoutHook = spacing 10 $ smartBorders $ avoidStruts $ (tiled ||| Mirror tiled ||| full)
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 3/100
    full = Full

myManageHook = composeOne [ isFullscreen -?> doFullFloat ]
-- }}}

-- Main {{{
main = do
    -- The way I autostarted BEFORE (usefull with the StdinReader of xmobar (e.g.: http://code.google.com/p/xmonad/issues/detail?id=402))
    -- xmproc <- spawnPipe "/home/ck/.xmonad/autostart"
    xmonad $ defaultConfig { terminal           = myTerminal
                           , focusFollowsMouse  = myFocusFollowsMouse
                           , borderWidth        = myBorderWidth
                           , normalBorderColor  = myNormalBorderColor
                           , focusedBorderColor = myFocusedBorderColor
                           , layoutHook         = avoidStruts $ myLayoutHook
                           , manageHook         = manageDocks <+> manageHook defaultConfig
                           , startupHook        = do
                                                  setWMName "LG3D"
                                                  spawn "/home/ck/.xmonad/autostart"
                                                  startupHook defaultConfig
                           , logHook            = dynamicLogWithPP xmobarPP
                                                   -- ppOutput = hPutStrLn xmproc,
                                                  { ppTitle = xmobarColor "#56c2d6" "" . shorten 20
                                                  , ppCurrent = xmobarColor "#56c2d6" "" . wrap "[[" "]]"
                                                  , ppHidden = xmobarColor "white" "#161616" . wrap "[" "]"
                                                  , ppHiddenNoWindows = xmobarColor "#444444" "#161616" . wrap "[" "]"
                                                  , ppSep = " | " }
      } `additionalKeysP` myKeysP `additionalKeys` myKeys
-- }}}
