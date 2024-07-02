load() {
    ## load:variables
    ldt_cmd=$1
    shift

    ## load:environment
    if [ -f $ldt_workindDir/.env ]; then
        export $(cat $ldt_workindDir/.env | xargs)
    fi
    if [ -f $ldt_workindDir/ldt.env ]; then
        export $(cat $ldt_workindDir/ldt.env | xargs)
    fi

    ## load:logger
    logger="eval echo"
    if [ ! "$(command -v ldtl)" = "" ]; then logger=ldtl; fi
    if [ ! "$(command -v $ldtl)" = "" ]; then logger=$ldtl; fi
    if [ ! "$(command -v ldt-logger)" = "" ]; then logger=ldt-logger; fi
    if [ ! "$(command -v ldtLogger)" = "" ]; then logger=ldtLogger; fi
    LDT_LOGGER_LOGPREFIX=" LDT"
    if [ "$LDT_DEBUG_MODE" = "true" ]; then
        LDT_LOGGER_LOGLEVEL=DEBUG
    else
        LDT_LOGGER_LOGLEVEL=WARN
    fi
    export LDT_LOGGER_LOGPREFIX
    export LDT_LOGGER_LOGLEVEL
}
