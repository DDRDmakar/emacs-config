:<<"::CMDLITERAL"
@ECHO OFF
GOTO :CMDSCRIPT
::CMDLITERAL

##=====[ Here is Bash script for Linux ]=====##
EMACS_CONFIG_DIR="$HOME/.emacs.d"

cp -r ./lisp "$EMACS_CONFIG_DIR"
cp ./init.el "$EMACS_CONFIG_DIR"
cp ./easykey.el "$EMACS_CONFIG_DIR"
cp ./org.el "$EMACS_CONFIG_DIR"
cp ./hdl.el "$EMACS_CONFIG_DIR"
cp ./other.el "$EMACS_CONFIG_DIR"
cp ./addition.el "$EMACS_CONFIG_DIR"
cp ./variables.el "$EMACS_CONFIG_DIR"
cp ./info.org "$EMACS_CONFIG_DIR"

if [ $# -eq 1 ] # Copy system-specific config too if 1 argument is supplied
then
cp ./system-specific.el "$EMACS_CONFIG_DIR"
fi

exit $? # Return exit status of previous command
##=====[ End Bash script ]=====##

:CMDSCRIPT

::=====[ Here is CMD script for Windows ]=====::
::=====[ End CMD script ]=====::
