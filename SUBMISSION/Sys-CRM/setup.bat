@echo off
rem ## 
rem ## This setup file can be used to setup the environment for 
rem ## compiling and running EMS samples with Java
rem ## 

rem ## 
rem ## Set TIBEMS_ROOT to the root of your installation of
rem ## TIBCO Enterprise Message Service software
rem ## 

rem ## IF NOT "%TIBEMS_ROOT%"=="" goto cont



:cont

rem ## 
rem ## You should not need to change the text below
rem ## 

set TIBEMS_JAVA=lib


if NOT EXIST %TIBEMS_JAVA%\jms.jar goto badenv
if NOT EXIST %TIBEMS_JAVA%\tibjms.jar goto badenv
if NOT EXIST %TIBEMS_JAVA%\tibjmsufo.jar goto badenv
if NOT EXIST %TIBEMS_JAVA%\tibjmsadmin.jar goto badenv
if NOT EXIST %TIBEMS_JAVA%\tibcrypt.jar goto badenv
if NOT EXIST %TIBEMS_JAVA%\slf4j-api-1.4.2.jar goto badenv
if NOT EXIST %TIBEMS_JAVA%\slf4j-simple-1.4.2.jar goto badenv

set CLASSPATH=%TIBEMS_JAVA%\jms.jar;%CLASSPATH%
set CLASSPATH=class;%TIBEMS_JAVA%\tibjms.jar;%TIBEMS_JAVA%\tibjmsufo.jar;%TIBEMS_JAVA%\tibcrypt.jar;%TIBEMS_JAVA%\tibjmsadmin.jar;%TIBEMS_JAVA%\slf4j-api-1.4.2.jar;%TIBEMS_JAVA%\slf4j-simple-1.4.2.jar;%TIBEMS_JAVA%\mysql-connector-java-5.1.16-bin.jar;%CLASSPATH%
javac -d class -sourcepath src src/*.java 


pause

goto end

:badenv
echo .
echo Error: TIBEMS_ROOT variable is not set or does not correctly specify
echo the root directory of the TIBCO Enterprise Message Service software. 
echo Please correct the TIBEMS_ROOT variable at the beginning of this script.
echo .

:end

