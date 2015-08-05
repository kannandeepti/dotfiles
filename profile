# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

start_mpd_if_not_running () {
    mpid=`pidof mpd`
    # if we found a running mpd
    if [[ $? -eq 0 ]]; then
        username=`id -u -n`
        # check if it's running under this username
        if ps aux | grep "$mpid" | grep mpd | grep -q "$username"; then
            # then this user already has an mpd process running
            return 0
        fi
    fi
    # otherwise, there's no mpd or it's someone else's mpd
    if [ -f $HOME/.mpd/pid ]; then
        # cleanup after bad exits if they exist
        rm -rf $HOME/.mpd/pid
    fi
    # launch mpd (automatically forks into background)
    mpd
}

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# start mpd if it's not already up
start_mpd_if_not_running
