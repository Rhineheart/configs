import XMonad
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.ThreeColumns
import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.Simplest
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
--import XMonad.Config.Xfce

myStrutlessLayout = ThreeCol 1 (3/100) (1/3)
myStrutLayout = fullscreenFull Simplest
myTiledLayout = Mirror $ Tall 1 (3/100) (1/2)
portraitThreeCol = Mirror $ ThreeCol 1 (3/100) (1/3)

main = do 
	-- dzenLeftBar <- spawnPipe myTaskBar
	-- dzenRightBar <- spawnPipe myStatusBar
	xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig --xfceConfig
		{ borderWidth = 0
		-- , modMask = mod4Mask
		, layoutHook = noBorders $ avoidStruts(myStrutlessLayout) ||| myStrutLayout ||| myTiledLayout ||| portraitThreeCol
		-- , logHook = myLogHook dzenLeftBar
		, handleEventHook = fullscreenEventHook
		, manageHook = fullscreenManageHook <+> manageDocks
		, terminal = "urxvt"
		, workspaces = ["1:edit", "2:edit", "3:edit", "4:www", "5", "6", "7", "8:irc", "9"]
        } `additionalKeysP` myKeys

myKeys = [] ++ [
		(mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
		|(key, scr) <- zip "wer" [0,1,2]
		,(action,mask) <- [ (W.view, ""), (W.shift, "S-")]
	]

myDzenBackground = "#2E3246"
myDzenForeground = "#7080AF"
myDzenFont = "-*-terminus-*-*-*-*-12-*-*-*-*-*-iso8859-*"

myDzenStyle = " -fg '" ++ myDzenForeground ++ "' -bg '" ++ myDzenBackground ++ "' -fn '" ++ myDzenFont ++ "' -h '16'"

myStatusBar = "conky -c /home/rhine/.conkyrc_status | dzen2 -h 1080 -x 1420 -w 500 -p -ta r -e 'onstart=lower'" ++ myDzenStyle 

myTaskBar = "dzen2 -h 1080 -w 1420 -p -ta l -e 'onstart=lower'" ++ myDzenStyle

myLogHook h = dynamicLogWithPP $ defaultPP

    -- display current workspace as darkgrey on light grey (opposite of 
    -- default colors)
    { ppCurrent         = dzenColor "#E2FBBA" "#B3C69A" . pad 

    -- display other workspaces which contain windows as a brighter grey
    , ppHidden          = dzenColor "#30609F" "" . pad 

    -- display other workspaces with no windows as a normal grey
    , ppHiddenNoWindows = dzenColor "#204060" "" . pad 

    -- display the current layout as a brighter grey
    , ppLayout          = dzenColor "#2F4F8F" "" . pad 

    -- if a window on a hidden workspace needs my attention, color it so
    , ppUrgent          = dzenColor "#ff0000" "" . pad . dzenStrip

    -- shorten if it goes over 100 characters
    , ppTitle           = shorten 100  

    -- no separator between workspaces
    , ppWsSep           = ""

    -- put a few spaces between each object
    , ppSep             = "  "

    -- output to the handle we were given as an argument
    , ppOutput          = hPutStrLn h
    }
