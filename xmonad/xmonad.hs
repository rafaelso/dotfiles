import System.IO

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myManageHook = composeAll
	[ className =? "Skype" --> doShift "9"
	, className =? "Chromium-browser" --> doShift "8"
	, isFullscreen --> doFullFloat
	]

myKeys = [ ((mod4Mask .|. shiftMask, xK_l), spawn "slock") ] ++
  [
    ((m .|. mod4Mask, key), screenWorkspace sc
      >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ]

main = do
xmproc <- spawnPipe "xmobar"
xmproc2 <- spawnPipe "xmobar ~/.xmobarrc2"
hPutStrLn xmproc2 ""
xmonad $ defaultConfig
	{ terminal   = "urxvtcd"
	, modMask    = mod4Mask
	, workspaces = myWorkspaces
	, manageHook = myManageHook <+> manageDocks <+> manageHook defaultConfig
	, layoutHook = avoidStruts $ layoutHook defaultConfig
	, logHook    = dynamicLogWithPP xmobarPP
		{ ppOutput = hPutStrLn xmproc
		, ppTitle  = xmobarColor "green" "" . shorten 50
		--, ppLayout = const "" --
		}
		<+> dynamicLogWithPP xmobarPP
		{ ppOutput = hPutStrLn xmproc2
		, ppTitle  = xmobarColor "green" "" . shorten 50
		}
	, startupHook = ewmhDesktopsStartup >> setWMName "LG3D"
	}
	`additionalKeys` myKeys
