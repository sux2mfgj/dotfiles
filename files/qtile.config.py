# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget
#  mod = "mod4"
alt = "mod1"

keys = [
    # Switch between windows in current stack pane
    Key(
        [alt], "j",
        lazy.layout.down()
    ),
    Key(
        [alt], "k",
        lazy.layout.up()
    ),
    Key(
        [alt], "h",
        lazy.layout.previous(),
    ),

    Key(
        [alt], "l",
        lazy.layout.next(),
    ),

    #
    Key([alt, "shift"], "h",
        lazy.layout.move_left()),
    Key([alt, "shift"], "l",
        lazy.layout.move_right()),

    # Move windows up or down in current stack
    Key(
        [alt, "control"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [alt, "control"], "j",
        lazy.layout.shuffle_up()
    ),

    # Switch window focus to other pane(s) of stack
    Key(
        [alt], "space",
        lazy.layout.shuffle_up()
    ),

    # Swap panes of split stack
    Key(
        [alt, "shift"], "space",
        lazy.layout.rotate()
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
#      Key(
#          [alt, "shift"], "Return",
#          lazy.layout.toggle_split()
#      ),
    Key([alt], "Return", lazy.spawn("terminator")),
    Key([alt], "g", lazy.spawn("google-chrome-stable")),

    Key([alt], "i", lazy.layout.grow()),
    Key([alt], "m", lazy.layout.shrink()),
#      Key([alt], "n", lazy.layout.normalize()),
#      Key([alt], "o", lazy.layout.maximize()),

    Key([alt], "f", lazy.window.toggle_floating()),

    # Toggle between different layouts as defined below
    Key([alt], "Tab", lazy.nextlayout()),
    Key([alt, 'shift'], "d", lazy.window.kill()),

    Key([alt, "control"], "r", lazy.restart()),
    Key([alt, "control"], "q", lazy.shutdown()),
    Key([alt], "t", lazy.spawncmd()),

    # change screen
    Key([alt], "e", lazy.to_screen(0)),
    Key([alt], "w", lazy.to_screen(1)),
]

groups = [
    Group('1'),
    Group('2'),
    Group('3'),
    Group('4', layout='stack'),
    Group('7', layout='stack'),
    Group('8', layout='stack'),
    Group('9'),
    Group('0', layout='treetab'),
]

for i in groups:
    # alt1 + letter of group = switch to group
    keys.append(
        Key([alt], i.name, lazy.group[i.name].toscreen())
    )

    # alt1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([alt, "shift"], i.name, lazy.window.togroup(i.name))
    )

borders = {
        'border_normal': '#000066',
        'border_forcus': '#0000FF',
        'border_width': 2,
}

layouts = [
    layout.MonadTall(**borders),
    layout.Stack(stacks=2),
    layout.TreeTab(),
    layout.Max(),
]

widget_defaults = dict(
    font='Arial',
    fontsize=16,
    padding=3,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(), widget.Prompt(),
                widget.WindowName(),
                widget.CurrentLayout(),
#                  widget.TextBox("default config", name="default"),
                widget.Systray(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
            ],
            25,
        ),
        bottom=bar.Bar(
            [
                widget.Battery(),
#                  widget.GmailChecker(),
#                  widget.KeyboardLayout(),
                widget.CPUGraph(),
                widget.MemoryGraph(),
                widget.NetGraph(),
                widget.Clipboard(),
                widget.Notify(),

#                  widget.HDDGraph(path = '/home'),
#                  widget.LoadAverageGraph(),
            ],
            25,
        ),
    ),

    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.CurrentLayout(),
#                  widget.TextBox("default config", name="default"),
                widget.Systray(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
            ],
            25,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [alt], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag(
        [alt], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([alt], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
from libqtile import hook
import subprocess


@hook.subscribe.startup_once
def startup_once():
    subprocess.Popen(['fcitx-autostart'])
    subprocess.Popen(['xmodmap', '/home/hima/.xmodmap'])
    subprocess.Popen(['xrandr', '--size', '1920x1080'])
    subprocess.Popen(['start-pulseaudio-x11'])