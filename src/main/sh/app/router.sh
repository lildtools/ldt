run() {
    if [ "$ldt_cmd" = "version" ]; then doPrintVersion; fi
    if [ "$ldt_cmd" = "usage" ]; then doPrintUsage; fi
    if [ "$ldt_cmd" = "run" ]; then doRunCommand; fi
}
