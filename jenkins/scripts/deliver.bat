@echo off

echo The following Maven command installs your Maven-built Java application
echo into the local Maven repository, which will ultimately be stored in
echo Jenkins's local Maven repository (and the "maven-repository" Docker data
echo volume).

REM Run Maven commands to build, install, and evaluate project properties
call mvn jar:jar install:install help:evaluate -Dexpression=project.name

echo The following command extracts the value of the ^<name/^> element
echo within ^<project/^> of your Java/Maven project's "pom.xml" file.

for /f "usebackq delims=" %%n in (`mvn -q -DforceStdout help:evaluate -Dexpression=project.name`) do set NAME=%%n

echo The following command behaves similarly to the previous one but
echo extracts the value of the ^<version/^> element within ^<project/^> instead.

for /f "usebackq delims=" %%v in (`mvn -q -DforceStdout help:evaluate -Dexpression=project.version`) do set VERSION=%%v

echo The following command runs and outputs the execution of your Java
echo application (which Jenkins built using Maven) to the Jenkins UI.

call java -jar target\%NAME%-%VERSION%.jar
