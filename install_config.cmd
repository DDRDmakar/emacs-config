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
cp ./visual.el "$EMACS_CONFIG_DIR"
cp ./info.org "$EMACS_CONFIG_DIR"

if [ $# -eq 1 ] # Copy system-specific config too if 1 argument is supplied
then
cp ./system-specific.el "$EMACS_CONFIG_DIR"
fi

exit $? # Return exit status of previous command
##=====[ End Bash script ]=====##

:CMDSCRIPT

::=====[ Here is CMD script for Windows ]=====::

set EMACS_CONFIG_DIR="C:%HOMEPATH%\AppData\Roaming\.emacs.d"
echo %EMACS_CONFIG_DIR%

copy lisp "%EMACS_CONFIG_DIR%"
copy init.el "%EMACS_CONFIG_DIR%"
copy easykey.el "%EMACS_CONFIG_DIR%"
copy org.el "%EMACS_CONFIG_DIR%"
copy hdl.el "%EMACS_CONFIG_DIR%"
copy other.el "%EMACS_CONFIG_DIR%"
copy addition.el "%EMACS_CONFIG_DIR%"
copy variables.el "%EMACS_CONFIG_DIR%"
copy visual.el "%EMACS_CONFIG_DIR%"
copy info.org "%EMACS_CONFIG_DIR%"

::=====[ End CMD script ]=====::
