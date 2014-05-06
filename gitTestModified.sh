#!/bin/sh
usage(){
    echo "Usage: `basename $0` [-h] [-r] [-t testOptions] [<directory>...]\n"
    echo '    -h      Show this help message.'
    echo '    -r      Only check the directories provided. Otherwise, the provided directories will be appended to the directory list.'
    echo '    -t      Options to pass to "grails test-app". Default: none.'
    echo '            See: http://grails.org/doc/latest/ref/Command%20Line/test-app.html'
}

# Parse the arguments
testOpts=
directories='grails-app src/groovy'

while getopts “hrt:” option
do
    case ${option} in
        h) usage; exit 0;;
        r) directories='';;
        t) testOpts=${OPTARG};;
        *) usage; exit 1;;
    esac
done

shift $(( OPTIND-1 ))
directories+=" ${*}"

# Get the modified files
modifiedFiles=`git diff --name-only HEAD ${directories}`
regex="([^/]*)\.groovy"
testPatterns=''

for filename in ${modifiedFiles}; do
    if [[ ${filename} =~ ${regex} ]]; then
        testPatterns+="${BASH_REMATCH[1]}* "
    fi
done

# Run the tests
if [ -n "${testPatterns}" ]; then
    echo "Calling... grails test-app ${testOpts} ${testPatterns}\n"

    grails test-app ${testOpts} ${testPatterns}
else
  echo "No modified classes found to test."
fi