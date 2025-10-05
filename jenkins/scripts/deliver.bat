@echo off

call mvn jar:jar install:install help:evaluate -Dexpression=project.name

for /f "delims=" %%n in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.name') do set NAME=%%n
for /f "delims=" %%v in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.version') do set VERSION=%%v

echo Project name is: %NAME%
echo Project version is: %VERSION%

dir target

java -jar target\%NAME%-%VERSION%.jar

