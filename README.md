# dotemacs #

## environment-specific setup ##

The system-specific file will load automatically because it can detect
the OS you're running on. To customize, edit:

    ./linux.el
    ./mac.el
    ./window.el

You'll need to customize the host-specific and user-specific files
yourself to match the actual name of your host and user.

Copy the host example then modify:

    cp -p ./host.el.sample ~/.Andrews-MacBook-Pro.local.el

Copy the user example then modify:

    cp -p ./user.el.sample ~/.agoodnough.el

### mac os note ###

switch default key bindings

    (setq mac-right-option-modifier 'control)

Above was my first attempt to get a control key on the right side

I ended up switching the modifier keys in the Keyboard control panel
Command becomes Alt
Alt becomes Command
Doing it this way the command-line editing is identical to Emacs

On the Keyboard tab, also set "Use all F1, F2, etc. as standard function keys..." = true

And on the Shortcuts tab, unchecked almost all keyboard shortcuts

This made it so the mac settings were not needed (as the keys were
already flipped at the OS-level. Having them in the emacs config
would have flipped them again.

Using KeyRemap4MacBook to re-map Left Arrow to be my Right Cntl Key

iTerm, set "Use option as meta key" = true

Last issue is the function key. I often hit it when I want my Left Cntl Key so I'd like to swap Function and Left Cntl.
