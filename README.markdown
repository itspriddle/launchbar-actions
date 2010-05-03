LaunchBar Actions
=================
Just a few LaunchBar Actions I use.

Installation
------------
**Install Them All**

    $ git clone git://github.com/itspriddle/launcbar-actions
    $ cd launchbar-actions
    $ sh install.sh
    $ mv build/* ~/Library/Application\ Support/LaunchBar/Actions/

**Install Individually**

    $ wget "http://github.com/itspriddle/launchbar-applescripts/raw/master/scripts/[Script Name].scpt"
    $ osacompile -o ~/Library/Application\ Support/LaunchBar/[Script Name].scpt < [Script Name].scpt

Adium
-----
These AppleScripts change your away/online status. With the action selected in LaunchBar,
press spacebar to input a custom status.

**[Adium - Away](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium - Away.scpt)**

    $ wget "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20Away.scpt"
    $ osacompile -o ~/Library/Application\ Support/LaunchBar/Adium\ -\ Away.scpt < Adium\ -\ Away.scpt

**[Adium - Available](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20Available.scpt)**

    $ wget "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20Available.scpt"
    $ osacompile -o ~/Library/Application\ Support/LaunchBar/Adium\ -\ Available.scpt < Adium\ -\ Available.scpt

**[Adium - iTunes Track](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20iTunes%20Track.scpt)**

    $ wget "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20iTunes%20Track.scpt"
    $ osacompile -o ~/Library/Application\ Support/LaunchBar/Adium\ -\ iTunes\ Track.scpt < Adium\ -\ iTunes\ Track.scpt

The Hit List
------------
**[Create new task in The Hit List](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Create%20new%20task%20in%20The%20Hit%20List.scpt)**

    $ wget "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Create%20new%20task%20in%20The%20Hit%20List.scpt"
    $ osacompile -o ~/Library/Application\ Support/LaunchBar/Create\ new\ task\ in\ The\ Hit\ List.scpt < Create\ new\ task\ in\ The\ Hit\ List.scpt

General
-------

**[Copy SSH public key to clipboard](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Copy%20SSH%20public%20key%20to%20clipboard.scpt)**

    $ wget "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Copy%20SSH%20public%20key%20to%20clipboard.scpt"
    $ osacompile -o ~/Library/Application\ Support/LaunchBar/Copy\ SSH\ public\ key\ to\ clipboard.scpt < Copy\ SSH\ public\ key\ to\ clipboard.scpt

**[Tweet current iTunes track](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Tweet%20current%20iTunes%20track.scpt)**
Note: You need to setup [~/.netrc](http://gist.github.com/raw/387548/ed8694aaf1034d8b2251a69273bdf7fe6a231329/netrc) with twitter credentials.

    $ wget "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Tweet%20current%20iTunes%20track.scpt"
    $ osacompile -o ~/Library/Application\ Support/LaunchBar/Tweet\ current\ iTunes\ track.scpt < Tweet\ current\ iTunes\ track.scpt
