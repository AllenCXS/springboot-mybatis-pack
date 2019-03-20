@echo off
for /f "tokens=1 delims= " %%a in ('jps -lv^|findstr com.linkcm.Main ^|findstr ${project.artifactId}') do (
TASKKILL /F /PID %%a
echo "kill pid %%a"
)