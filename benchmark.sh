#!/bin/bash
# A Bash script to execute a Benchmark about implementation of Gateway pattern for Spring Cloud

echo "Gateway Benchmark Script"

OSX="OSX"
WIN="WIN"
LINUX="LINUX"
UNKNOWN="UNKNOWN"
PLATFORM=$UNKNOWN

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

function detectOS() {

    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        PLATFORM=$LINUX
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        PLATFORM=$OSX
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        PLATFORM=$WIN
    elif [[ "$OSTYPE" == "msys" ]]; then
        PLATFORM=$WIN
    elif [[ "$OSTYPE" == "win32" ]]; then
        PLATFORM=$WIN
    else
        PLATFORM=$UNKNOWN
    fi

    echo "${green}Platform detected: $PLATFORM${reset}"
    echo

    if [ "$PLATFORM" == "$UNKNOWN" ]; then
        echo "${red}Sorry, this platform is not recognized by this Script."
        echo
        echo "Open a issue if the problem continues:"
        echo "https://github.com/spencergibb/spring-cloud-gateway-bench/issues${reset}"
        echo
        exit 1
    fi

}

function detectGo() {

    if type -p go; then
        echo "${green}Found Go executable in PATH${reset}"
    else
        echo "${red}Not found Go installed${reset}"
        exit 1
    fi

}

function detectJava() {

    if type -p java; then
        echo "${green}Found Java executable in PATH${reset}"
    else
        echo "${red}Not found Java installed${reset}"
        exit 1
    fi

}

function detectMaven() {

    if type -p mvn; then
        echo "${green}Found Maven executable in PATH${reset}"
    else
        echo "${red}Not found Java installed${reset}"
        exit 1
    fi

}

function detectWrk() {

    if type -p wrk; then
        echo "${green}Found wrk executable in PATH${reset}"
    else
        echo "${red}Not found wrk installed${reset}"
        exit 1
    fi

}

function setup(){

    detectOS

    detectGo
    detectJava
    detectMaven

    detectWrk

    mkdir -p reports
    rm ./reports/*.txt
}

setup

#Launching the different services

function runStatic() {

    cd static
    if [ "$PLATFORM" == "$OSX" ]; then
        GOOS=darwin GOARCH=amd64 go build -o webserver.darwin-amd64 webserver.go
        ./webserver.darwin-amd64
    elif [ "$PLATFORM" == "$LINUX" ]; then
        rm webserver
        go build -o webserver webserver.go
        ./webserver
        exit 1
    elif [ "$PLATFORM" == "$WIN" ]; then
        echo "Googling"
        exit 1
    else
        echo "Googling"
        exit 1
    fi

}

function runZuul() {

    echo "${green}Running Gateway Zuul${reset}"

    cd zuul
    ./mvnw -DskipTests clean package
    java -jar target/zuul-0.0.1-SNAPSHOT.jar
}

function runGateway() {

    echo "${green}Running Spring Gateway${reset}"

    cd gateway
    ./mvnw -DskipTests clean package
    java -jar target/demo-0.0.1-SNAPSHOT.jar
}

function runLinkerd() {

    echo "${green}Running Gateway Linkerd${reset}"

    cd linkerd
    java -jar linkerd-1.3.4.jar linkerd.yaml
}

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        echo "${red}** Trapped CTRL-C${reset}"
        kill $(ps aux | grep './webserver.darwin-amd64' | awk '{print $2}')
        pkill java
        exit 1
}

#Run Static web server
runStatic &

echo "${green}Verifying static webserver is running${reset}"

response=$(curl http://localhost:8000/hello.txt)
if [ '{output:"I Love Spring Cloud"}' != "${response}" ]; then
    echo
    echo "${red}Problem running static webserver, response: $response${reset}"
    echo
    exit 1
fi;

echo "Wait 10"
sleep 10

function runGateways() {

    echo "${green}Run Gateways${reset}"
    runZuul &
    runGateway &
    runLinkerd &

}

runGateways
sleep 10

echo "${green}Verifying gateways are running${reset}"

response=$(curl http://localhost:8081/hello.txt)
if [ '{output:"I Love Spring Cloud"}' != "${response}" ]; then
    echo
    echo "${red}Problem running Spring Cloud Gateway, response: $response${reset}"
    echo
    exit 1
fi;

response=$(curl http://localhost:8082/hello.txt)
if [ '{output:"I Love Spring Cloud"}' != "${response}" ]; then
    echo
    echo "${red}Problem running Zuul, response: $response${reset}"
    echo
    exit 1
fi;

response=$(curl http://localhost:4140/hello.txt)
if [ '{output:"I Love Spring Cloud"}' != "${response}" ]; then
    echo
    echo "${red}Problem running LinkerD, response: $response${reset}"
    echo
    exit 1
fi;

#Execute performance tests

function runPerformanceTests() {

    echo "${red}JVM Warmup${reset}"
    wrk -t 10 -c 200 -d 30s  http://localhost:8000/hello.txt > ./reports/static.txt

    echo "${green}Gateway Warmup${reset}"
    wrk -t 10 -c 200 -d 30s http://localhost:8082/hello.txt > /dev/null 2>&1
    echo "${green}LinkerD Warmup${reset}"
    wrk -H "Host: web" -t 10 -c 200 -d 30s http://localhost:4140/hello.txt  > /dev/null 2>&1
    echo "${green}Zuul Warmup${reset}"
    wrk -t 10 -c 200 -d 30s http://localhost:8081/hello.txt  > /dev/null 2>&1

    echo "${red}Actual tests${reset}"

    for run in {1..4}
    do
      echo "${green}Actual test run: ${run}${reset}"
      wrk -t 10 -c 200 -d 30s http://localhost:8082/hello.txt >> ./reports/gateway.txt
      wrk -H "Host: web" -t 10 -c 200 -d 30s http://localhost:4140/hello.txt >> ./reports/linkerd.txt
      wrk -t 10 -c 200 -d 30s http://localhost:8081/hello.txt >> ./reports/zuul.txt
    done

    echo "${green}Main tests complete${reset}"

}


runPerformanceTests

ctrl_c
echo "${green}Script Finished${reset}"
