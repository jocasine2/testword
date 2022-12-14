
#!/bin/bash

#funções uteis
function getEnv(){
    eval "$(
    cat .env | awk '!/^\s*#/' | awk '!/^\s*$/' | while IFS='' read -r line; do
        key=$(echo "$line" | cut -d '=' -f 1)
        value=$(echo "$line" | cut -d '=' -f 2-)
        echo "export $key=\"$value\""
    done
    )"
}
function user_docker(){
    if id -nG "$USER" | grep -qw "docker"; then
        echo $USER belongs to docker group
    else
        sudo usermod -aG docker ${USER}
        echo $USER has added to the docker group
    fi
}

function enter(){
    docker exec -it $@ bash
}

function app(){
    if [ $1 == "new" ]; then
        echo criando $2
        new_app
        app_turbolink_remove
        atualiza_nome_app $2
        docker-compose up -d
    elif [ $1 == "enter" ]; then
        getEnv
        enter $APP_NAME-app
    elif [ $1 == "scaffold" ]; then
        app_scaffold ${*:2}
    elif [ $1 == "migrate" ]; then
        app rails db:migrate
    elif [ $1 == "remove" ]; then
        remove_app
    else
        docker-compose run app $@
    fi
}

function new_app(){
    app rails new ../app
}

function app_reset(){
    permissions_update
    remove_app
    new_app
}

function app_scaffold_api(){
    docker-compose run app rails g scaffold $@ --api
}

function app_scaffold(){
    docker-compose run app rails g scaffold $@
}

function bd(){
    docker-compose run postgres $@
}

function remove_app(){
    # permissions_update

    #para remover o app criado 
    sudo rm -rf bin 
    sudo rm -rf config 
    sudo rm -rf db 
    sudo rm -rf lib 
    sudo rm -rf log 
    sudo rm -rf public 
    sudo rm -rf storage 
    sudo rm -rf test 
    sudo rm -rf tmp 
    sudo rm -rf vendor 
    sudo rm -rf app 
    sudo rm -rf .gitattributes 
    sudo rm -rf config.ru 
    sudo rm -rf Gemfile.lock  
    sudo rm -rf package.json 
    sudo rm -rf Rakefile 
    sudo rm -rf .ruby-version 
    sudo rm -rf Gemfile
    sudo rm -rf docker-compose/postgres
}

app_turbolink_remove(){
   sudo sed -i "10c    <%#= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %> <!--trecho desabilitado pelo start.sh-->" app/views/layouts/application.html.erb
}

atualiza_nome_app(){
   sudo sed -i "1cAPP_NAME="$1 .env
}

function permissions_update(){
    sudo chown -R $USER:$USER app
    sudo chown -R $USER:$USER .env
    sudo chown -R $USER:$USER .gitignore
    sudo chown -R $USER:$USER Dockerfile
    sudo chown -R $USER:$USER Gemfile
    sudo chown -R $USER:$USER Gemfile.lock
    sudo chown -R $USER:$USER README.md
    sudo chown -R $USER:$USER docker-compose.yml
    sudo chown -R $USER:$USER start.sh
    sudo chown -R $USER:$USER docker-compose/Gemfile
    sudo chown -R $USER:$USER docker-compose/functions.sh
    sudo chown -R $USER:$USER config/master.key
    sudo chown -R $USER:$USER db/migrate
    echo permissões atualisadas!
}

function prune(){
    docker system prune -a -f
}

function build_project(){
    app_reset

    app_scaffold_api unit name:string
    app_scaffold_api localization longitude:string latitude:string
    app_scaffold_api store name:string localization:references
    app_scaffold_api list name:string date_time:date store:references
    app_scaffold_api item name:string list:references
    app_scaffold_api itemlist item:references list:references default:boolean unit:references
    app_scaffold_api priceperunitofmeasure quantity:float unit:references
    app_scaffold_api product description:string unit:references packagingquantity:float price:float
    app_scaffold_api productitem item:references product:references
    app_scaffold_api storeproduct store:references product:references

    docker-compose up -d

    app rails db:create
    app rails db:migrate
}

function destroy_project(){
    remove_app
    docker-compose down
    prune
}

function restart(){
    docker-compose down
    prune
    ./start.sh
}

function se_existe(){
    file=$1
    if [ -f "$file" ] || [ -d "$file" ]
    then
        $2
    fi
}

function Welcome(){
    echo funções carregadas!
}

Welcome
