## ldt
alias ldt="/bin/bash /config/.ldt/bin/ldt"
## code-server
alias post-install="\
            (ldt code-server os upgrade); \
		    (ldt code-server git-flow install); \
		    (ldt code-server git config global-defaults); \
		    (ldt code-server git config global-cache 1w); \
		    (ldt code-server docker-engine install); "
alias reset-permissions="\
		    (chown -vR $(whoami):$(whoami) /config/.ssh/); \
		    (chmod -v 600 /config/.ssh/id_rsa*); \
		    (chown -vR $(whoami):$(whoami) /work/); \
		    (find /work/ -type d -exec chmod -v 755 {} \;); \
		    (find /work/ -type f -exec chmod -v 644 {} \;);"
