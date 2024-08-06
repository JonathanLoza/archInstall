import XMonad
import XMonad.Util.EZConfig
--import XMonad.Util.Ungrab
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.LayoutCombinators
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import qualified XMonad.StackSet as W
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.SpawnOnce 
import XMonad.Layout.Spacing ( spacingRaw, Border(Border) )
import XMonad.Layout.Gaps
    ( Direction2D(D, L, R, U),
      gaps,
      setGaps,
      GapMessage(DecGap, ToggleGaps, IncGap) )

main :: IO ()
main = xmonad 
	. withSB mySB
	-- . ewmhFullscreen 
	. ewmh 
	$ myConfig

myConfig = def
    { modMask    = mod4Mask      -- Rebind Mod to the Super key
    , layoutHook = myLayout
    , manageHook = myManageHook <+> namedScratchpadManageHook scratchpads
    , startupHook = myStartupHook
    , handleEventHook = handleEventHook def <> Hacks.windowedFullscreenFixEventHook
    , terminal    = "kitty"
    , focusFollowsMouse  = True
    , borderWidth        = 2
    , normalBorderColor  = "#3b4252"
    , focusedBorderColor = "#F28123"
    , workspaces         = myWorkspaces
    }
  `additionalKeysP`
    [ ("M-p", spawn "rofi -show drun")
    , ("M-d", spawn "xrandr --output HDMI-0 --auto --left-of eDP-1-1; xmonad --restart")
    , ("M-m", spawn "xrandr --output HDMI-0 --auto --same-as eDP-1-1; xmonad --restart")
    --, ("M-f", sendMessage $ JumpToLayout "fullComplete")
    --, ("M-f", sequence_ [sendMessage $ JumpToLayout "fullComplete", spawn "xdotool mousemove 0 0"])
    , ("M-f", sendMessage $ JumpToLayout "fullComplete")
    , ("M-S-m", spawn "hakuneko-desktop-nightly --no-sandbox")
    , ("M-S-a", namedScratchpadAction scratchpads "pavucontrol")
    , ("M-S-y", namedScratchpadAction scratchpads "music")
    , ("M-S-t", namedScratchpadAction scratchpads "term")
    , ("M-S-h", namedScratchpadAction scratchpads "htop")
    , ("M-S-b", namedScratchpadAction scratchpads "bluetooth")
    , ("M-x", spawn "systemctl suspend")
    ]

myWorkspaces :: [String]
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myPP :: PP
myPP = filterOutWsPP [scratchpadWorkspaceTag]
  def
    { 
    ppCurrent = \name -> "\"" ++ name ++ "\": \"current active\", "
    , ppVisible = \name -> "\"" ++ name ++ "\": \"active\" , "
    , ppHidden = \name -> "\"" ++ name ++ "\": \"hidden\", "
    , ppHiddenNoWindows = \name -> "\"" ++ name ++ "\": \"empty\", "
    , ppOrder = \(ws : _ : _ : _) -> [ws]
    }

mySB :: StatusBarConfig
mySB = statusBarProp "" (pure myPP)

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat    
    , className =? "Brave-browser"  --> doShift "2"
    , isFullscreen --> doFullFloat
    , isDialog  --> doFloat
    ]

myLayout =  fullGap ||| tiled ||| mirror ||| fullComplete
  where
    fullComplete = renamed [Replace "fullComplete"] $ noBorders $ Full
    fullGap  = renamed [Replace "fullGap"] $ gapsConfig $ smartBorders $ Full
    tiled    = renamed [Replace "tiled"] $ gapsConfig $ spacingConfig $ lessBorders Screen $ Tall nmaster delta ratio 
    mirror   = renamed [Replace "mirror"] $ gapsConfig $ spacingConfig $ lessBorders Screen $ Mirror $ Tall nmaster delta ratio 
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes
    gapsConfig = gaps [(L,30), (R,30), (U,50), (D,40)]
    spacingConfig = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True 

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "picom"
  spawnOnce "eww open powermenu"
  spawn "feh --bg-fill --no-fehbg ~/Images/Berserk-alone.png"


-- scratchPads
scratchpads :: [NamedScratchpad]
scratchpads = [
    NS "pavucontrol" "pavucontrol" (className =? "Pavucontrol")
        (customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4)),
    NS "term" "kitty --class scratchpad" (className =? "scratchpad")
        (customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4)),
    NS "htop" "kitty --class htop htop" (className =? "htop")
        (customFloating $ W.RationalRect (1/12) (1/12) (5/6) (5/6)),
    NS "bluetooth" "blueman-manager" (appName =? "blueman-manager")
        (customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4)),
    NS "music" "youtube-music" (appName =? "youtube music")
        (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  ]
