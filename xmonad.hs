import XMonad
import XMonad.Util.EZConfig
import XMonad.Operations
import XMonad.Util.Dzen
import XMonad.Hooks.DynamicLog (dynamicLog, dzen)
import XMonad.Layout.ResizableTile
import System.IO
import XMonad.Actions.Volume
import Data.Map
import Data.Monoid (mappend)

-- Volume control stuff from: http://dmwit.com/volume/
alert = dzenConfig centred . show . round

centred = onCurr (center 150 66)
    >=> font "-*-helvetica-*-r-*-*-64-*-*-*-*-*-*-*"
    >=> addArgs ["-fg", "#80c0ff"]
    >=> addArgs ["-bg", "#000040"]

-- rebind Mod to the windows key
modm = mod4Mask

myLayout = ResizableTall 1 (4/100) (3/5) [] ||| Full 

-- MOD + SHIFT + L => lock screen
-- f11 => lower volume
-- f12 => raise volume
myKeys = [
    ((modm .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l"),
    ((0, xK_F11), lowerVolume 4 >>= alert),
    ((0, xK_F12), raiseVolume 4 >>= alert),
    ((modm, xK_u), sendMessage MirrorShrink),
    ((modm, xK_i), sendMessage MirrorExpand)
    ]

main = do
    xmonad =<< (XMonad.Hooks.DynamicLog.dzen $ defaultConfig {
            layoutHook = myLayout, modMask = mod4Mask, logHook = dynamicLog
        } `additionalKeys` myKeys)
