#!/bin/bash
# chat gpt
echo -e "こんにちは、Chat GPTです。 終了する場合は次の単語を入力してください。 '\033[36mexit\033[0m'.\n"
running=true

DIR="$(cd "$(dirname "$0")" && pwd -P)"
OPENAI_TOKEN=$(cat $DIR/../OPEN_AI_TOKEN)

if [[ -z "$OPENAI_TOKEN" ]]; then
  echo -e "すみません、OPEN AIのトークンがないみたいですね。次のURLからトークンを作成してください。https://beta.openai.com/account/api-keys"
  exit
fi

while $running; do
  printf "\033[36m私 \033[0m"
  read prompt

  if [ "$prompt" == "exit" ]; then
    running=false
  elif [[ "$prompt" =~ ^image: ]]; then
    image_url=$(curl https://api.openai.com/v1/images/generations \
      -sS \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer $OPENAI_TOKEN" \
      -d '{
    		"prompt": "'"${prompt#*image:}"'",
    		"n": 1,
    		"size": "512x512"
	}' | jq -r '.data[0].url')
    echo -e "\n\033[36mchatgpt \033[0mYour image was created. \n\nLink: ${image_url}\n"
    if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
      curl -sS $image_url -o temp_image.png
      imgcat temp_image.png
      rm temp_image.png
    else
      echo "Would you like to open it? (Yes/No)"
      read answer
      if [ "$answer" == "Yes" ] || [ "$answer" == "yes" ] || [ "$answer" == "y" ] || [ "$answer" == "Y" ] || [ "$answer" == "ok" ]; then
        open "${image_url}"
      fi
    fi
  elif [[ -z "$prompt" ]]; then
    continue
  else
    # escape quotation marks
    escaped_prompt=$(echo "$prompt" | sed 's/"/\\"/g')
    # request to OpenAI API
    response=$(curl https://api.openai.com/v1/completions \
      -sS \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer $OPENAI_TOKEN" \
      -d '{
  			"model": "text-davinci-003",
  			"prompt": "'"${escaped_prompt}"'",
  			"max_tokens": 1000,
  			"temperature": 0.7
	}' | jq -r '.choices[].text' | sed '1,2d')

    echo -e "\033[36mchatgpt \033[0m${response}"
  fi
done
