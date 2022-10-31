<p align="center"><a href="https://rubyonrails.org/" target]="_blank"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Ruby_On_Rails_Logo.svg/1200px-Ruby_On_Rails_Logo.svg.png" width="400"></a></p>

<h2 align="center">Yay! You’re on Rails!</h2>

<br><br>

# Atualize o repositório e depois a branch local
Descarte todas as alterções locais pra ficar igual a branch remota atualizada
```
git reset --hard origin/main
```
# Para iniciar execute o bashcript start.sh
```
source start.sh
```
# Atualize as dependencias (gems)
```
app bundle
```
# Crie o banco de dados
```
app rails db:create
```
# Migre as tablas para o bd
```
app rails db:migrate
```
# Criando um modelo (MVC) de exemplo e migrando para o bd
```
app scaffold Pessoa nome:string cpf:string && app rails db:migrate
```
# Localhost
[http://localhost:3000/](http://localhost:3000/)

# Comandos úteis

## Destruindo o Scaffold Pessoa
```
app rails destroy scaffold Pessoa
```