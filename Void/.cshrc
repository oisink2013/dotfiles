# $FreeBSD: release/10.0.0/share/skel/dot.cshrc 243893 2012-12-05 13:56:39Z eadler $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
# more examples available at /usr/share/examples/csh/
#

alias h		history 25
alias j		jobs -l
alias la	ls -aF
alias lf	ls -FA
alias ll	ls -lAF

# A righteous umask
umask 22

setenv	EDITOR	vi
setenv	PAGER	more
setenv	BLOCKSIZE	K
setenv	PANEL_FIFO	/tmp/panel-fifo
setenv	BSPWM_SOCKET	/tmp/bspwm-socket
setenv	BSPWM_TREE	/tmp/bspwm.tree
setenv	BSPWM_HISTORY	/tmp/bspwm.history
setenv	BSPWM_STACK	/tmp/bspwm.stack
set path = ($path $HOME/.config/bspwm/panel)

if ($?prompt) then
	# An interactive shell -- set some stuff up
	set prompt = "%N@%m:%~ %# "
	set promptchars = "%#"

	set filec
	set history = 1000
	set savehist = (1000 merge)
	set autolist = ambiguous
	# Use history to aid expansion
	set autoexpand
	set autorehash
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif

endif
