Installation
===============
Simply download gitTestModified.sh, chmod +x permissions to it, and (optionally) add an alias (e.g. ```alias gitTestModified=’~/scripts/gitTestModified.sh’```) in your .bashrc to easily invoke it. So with our example, we could call it with:
```
gitTestModified
```

Usage
===============
By default the script takes no arguments and simply checks the following directories for modified .groovy files (as according to git diff HEAD):
```
grails-app src/groovy
```
This list can be appended simply by passing some bulk arguments to the script. For example, to check for tests that were modified as well, we can do:
```
gitTestModified test # Add 'test' to the directories to search for git changes
```
If there are modified files, the tests will be invoked.  If not, then a simple message will pop up saying so.

####-r Remove default directories

gitTestModified also allows a -r flag to exclusively check the directories passed in, overriding the defaults in the script. So the following call would look ONLY in the ‘test’ directory:
```
gitTestModified -r test # Only check the 'test' directory for git changes
```
Once changed files are found and parsed, the filenames are appended with the wildcard (*) and passed to grails test-app. Since the typical Grails test naming convention is <filename>Spec.groovy or <filename>Tests.groovy, the wildcard will capture these test cases and automatically run them. Obviously if your project does not follow this convention, this script will not work.

####-t Test options

If we want to pass additional arguments to grails test-app, so we can for example, run only tests that failed last time, we can do so using the -t option and then providing the arguments:
```
gitTestModified -t "-rerun" # Only run tests that failed last time we called test-app
```
Since these arguments are passed directly to grails test-app, it’s best to wrap them in quotes due to the dashes and potential spaces. This also means we can append additional tests to run:
```
gitTestModified -t "-unit MyExtraTests.groovy"
```
####-h Help

Finally, the script has a -h flag to display its usage information.

gitTestModified also outputs each call to grails test-app both for easier debugging and for easy copying/pasting in case you want to run the tests independently.