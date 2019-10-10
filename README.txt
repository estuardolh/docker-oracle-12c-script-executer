docker-oracle-12c-script-executer
===
Usage mode:

  Build: Build image in docker named "o12c-scripts-tester".
    ./build.sh

  Run: Creates instance(docker container) named "script-tester".
    ./run.sh

  Execute(N times): Execute the list of scripts indicated in script_list.txt(more details below).
    ./execute.sh

Configuration file:

  {PWD}/scripts/script_list.txt			File with list of file names of sql scripts to execute.
                                        Each sql script will be executed in the defined order.

                                        Example of content:
                                          script1.sql
                                          script2.sql
                                        These files must exists in {PWD}/scripts/

About image
---

File structure inside image:

- execute							Soft link to execute_sql.pl at /stage/
- /stage/scripts/					Directory for scripts.
- /stage/scripts/script_list.txt	File with file names of sql scripts to be executed.
