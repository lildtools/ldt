validate() {
    ## validate:command
    if [ "$ldt_cmd" = "" ]; then ldt_cmd=run; fi
    if [ "$ldt_cmd" = "-h" ]; then ldt_cmd=usage; fi
    if [ "$ldt_cmd" = "--help" ]; then ldt_cmd=usage; fi
    if [ "$ldt_cmd" = "-u" ]; then ldt_cmd=usage; fi
    if [ "$ldt_cmd" = "--usage" ]; then ldt_cmd=usage; fi
    if [ "$ldt_cmd" = "-v" ]; then ldt_cmd=version; fi
    if [ "$ldt_cmd" = "--version" ]; then ldt_cmd=version; fi

    if [ ! "$ldt_cmd" = "version" ] &&
        [ ! "$ldt_cmd" = "usage" ]; then
        $logger logError "Unknown command!"
        $logger logDebug "-- cause: ldt_cmd=$ldt_cmd"
        exit 400
    fi
}
