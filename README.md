# java-heap-tool
A tool to monitor heap memory allocation of a java process. It uses jstat. Pass process id(pid) to shell script tool.sh. Shell script can be customised to perform custom actions based on conditional requirements.

Test.java is a java program which is written intentionally to leak memory. It writes process id of java process into"pid" file. 

Run bash script file tool.sh multiple times or in successive loop to see the tool working.
