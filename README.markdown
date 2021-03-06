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

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/[Script%20Name].scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/[Script Name].scpt"

Adium
-----
These AppleScripts change your away/online status. With the action selected in LaunchBar,
press spacebar to input a custom status.

**[Adium - Away](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20Away.scpt)**

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20Away.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Adium - Away.scpt"

**[Adium - Available](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20Available.scpt)**

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20Available.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Adium - Available.scpt"

**[Adium - iTunes Track](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20iTunes%20Track.scpt)**

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20iTunes%20Track.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Adium - iTunes Track.scpt"

**[Adium - Send Message](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20Send%20Message.scpt)**

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Adium%20-%20Send%20Message.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Adium - Send Message.scpt"

The Hit List
------------
**[Create new task in The Hit List](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Create%20new%20task%20in%20The%20Hit%20List.scpt)**

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Create%20new%20task%20in%20The%20Hit%20List.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Create new task in The Hit List.scpt"

GitHub
------
**[Create gist from clipboard](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Create%20gist%20from%20clipboard.scpt)**
Note: Requires [gist](http://github.com/defunkt/gist) in your path

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Create%20gist%20from%20clipboard.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Create gist from clipboard.scpt"

**[Create private gist from clipboard](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Create%20private%20gist%20from%20clipboard.scpt)**
Note: Requires [gist](http://github.com/defunkt/gist) in your path

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Create%20private%20gist%20from%20clipboard.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Create private gist from clipboard.scpt"

General
-------
**[Copy SSH public key to clipboard](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Copy%20SSH%20public%20key%20to%20clipboard.scpt)**

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Copy%20SSH%20public%20key%20to%20clipboard.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Copy SSH public key to clipboard.scpt"

**[Tweet current iTunes track](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Tweet%20current%20iTunes%20track.scpt)**
Note: You need to setup [~/.netrc](http://gist.github.com/raw/387548/22528295e10c4f76fc8f8a4ef2e649366de051ad/netrc) with twitter credentials.

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Tweet%20current%20iTunes%20track.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Tweet current iTunes track.scpt"

**[Screenshot to Dropbox](http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Screenshot%20to%20Dropbox.scpt)**

    $ curl --silent "http://github.com/itspriddle/launchbar-actions/raw/master/scripts/Screenshot%20to%20Dropbox.scpt" \
        | osacompile -o "$HOME/Library/Application Support/LaunchBar/Actions/Screenshot to Dropbox.scpt"
