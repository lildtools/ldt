doRunCommand() {

    ldtFolder=$(realpath $(dirname "$0")/.ldt)
    if [ ! -d $ldtFolder ]; then mkdir -p $ldtFolder; fi
    ldtScript=$(realpath $(dirname "$0")/.ldt/ldt)
    if [ ! -f "$ldtScript" ]; then
        setup $ldtFolder
        exit 0
    fi
    if [ "$(command -v bash)" = "" ]; then
        echo "ERR: ldt requires 'bash' to be installed."
        exit 1
    fi
    echo $ldtScript $*




    


    ldt_root=$(realpath $(dirname "$0")/)
    ldtw_bin=$(realpath $(dirname "$0")/bin)
    ldtw_projects=$(realpath $(dirname "$0")/../projects)
    ldtw_workingDir=$PWD
    ldtw_portable="$ldtw_workingDir/.ldt"
    ldtw_dotenv="$ldtw_workingDir/.env"
    ldtw_moduleArg=$1
    ldtw_modulePath=

    LDT_LOGGER_LOGPREFIX="LDTW"
    if [ -f "$ldtw_dotenv" ]; then export $(cat $ldtw_dotenv | xargs); fi
    if [ "$LDT_WRAPPER_DEBUG_MODE" = "true" ]; then
        LDT_LOGGER_LOGLEVEL=DEBUG
    else
        LDT_LOGGER_LOGLEVEL=WARN
    fi
    export LDT_LOGGER_LOGPREFIX
    export LDT_LOGGER_LOGLEVEL

    if [ "$(command -v bash)" = "" ]; then
        echo "ERR: ldtw requires 'bash' to be installed."
        exit 1
    fi
    if [ "$ldtw_moduleArg" = "" ]; then
        echo "ERR: ldtw module is required! (arg1)"
        exit 2
    fi
    if [ ! -d "$ldtw_bin" ] &&
        [ ! -d "$ldtw_projects" ] &&
        [ ! -d "$ldtw_portable" ]; then
        echo "ERROR: ldtw requires 'binary' to be installed."
        exit 404
    fi
    if [ -d "$ldtw_bin" ]; then
        ldtw_modulePath="$ldtw_bin"

        ldtw_ldt_compiler="$ldtw_modulePath/ldt-compiler.sh"
        ldtw_ldt_logger="$ldtw_modulePath/ldt-logger.sh"
    fi
    if [ -d "$ldtw_projects" ]; then
        ldtw_modulePath="$ldtw_projects"

        ldtw_ldt_compiler="$ldtw_modulePath/ldt-compiler/dist/ldt-compiler-1.0.0-SNAPSHOT.sh"
        ldtw_ldt_logger="$ldtw_modulePath/ldt-logger/dist/ldt-logger-1.0.0-SNAPSHOT.sh"
    fi
    if [ -d "$ldtw_portable" ]; then
        ldtw_modulePath="$ldtw_portable"

        ldtw_ldt_compiler="$ldtw_modulePath/bin/ldt-compiler.sh"
        ldtw_ldt_logger="$ldtw_modulePath/bin/ldt-logger.sh"
    fi
    if [ "$ldtw_modulePath" = "" ]; then
        echo "ERR: ldtw module binary is missing!"
        exit 404
    fi

    shift
    ldtl=$ldtw_ldt_logger
    export ldtl

    ldtw_module=$(eval "echo $(echo \$ldtw_ldt_${ldtw_moduleArg})")

    $ldtl logDebug "ldtw_root        : $ldtw_root"
    $ldtl logDebug "ldtw_bin         : $ldtw_bin"
    $ldtl logDebug "ldtw_projects    : $ldtw_projects"
    $ldtl logDebug "ldtw_workingDir  : $ldtw_workingDir"
    $ldtl logDebug "ldtw_portable    : $ldtw_portable"
    $ldtl logDebug "ldtw_dotenv      : $ldtw_dotenv"
    $ldtl logDebug "ldtw_moduleArg   : $ldtw_moduleArg"
    $ldtl logDebug "ldtw_modulePath  : $ldtw_modulePath"
    $ldtl logDebug "ldtw_module ldtc : $ldtw_ldt_compiler"
    $ldtl logDebug "ldtw_module ldtl : $ldtw_ldt_logger"
    $ldtl logDebug "ldtw_moduleRun   : $ldtw_module"
    $ldtl logDebug "ldtw_args        : $*"

    eval /bin/bash $ldtw_module $*

}
