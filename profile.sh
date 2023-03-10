#!/usr/bin/env bash

function find_idle_profile()
{
    RESPONSE_CODE=$(sudo curl -s -o /dev/null -w "%{http_code}" http://${domain}/)

    if [ ${RESPONSE_CODE} -ge 400 ] # 400 보다 크면 (즉, 40x/50x 에러 모두 포함)
    then
        CURRENT_PROFILE=green
    else
        CURRENT_PROFILE=$(sudo curl -s http://${domain}/)
    fi

    if [ ${CURRENT_PROFILE} == blue ]
    then
      IDLE_PROFILE=green
    else
      IDLE_PROFILE=blue
    fi

    echo "${IDLE_PROFILE}"
}
# 쉬고 있는 profile의 port 찾기
function find_idle_port()
{
    IDLE_PROFILE=$(find_idle_profile)

    if [ ${IDLE_PROFILE} == blue ]
    then
      echo "8090"
    else
      echo "9999"
    fi
}