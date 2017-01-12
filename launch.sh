#!/usr/bin/env bash
if [ ! -f ./tg ]; then
  wget "https://valtman.name/files/telegram-cli-1222"
  mv telegram-cli-1222 ./tg
  chmod 777 tg
  ./tg -s bot.lua
fi
./tg -s bot.lua
