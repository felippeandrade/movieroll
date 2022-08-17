
<!-- URLs -->

[digital-house-url]: https://www.digitalhouse.com/br/
[tmdb-api-url]: https://www.themoviedb.org/documentation/api




<p align="center">
  <img alt="movieroll" src="https://github.com/vhenriquebm/MovieRoll/blob/develop/images/capa.png" width="1000px"/>
<p>
  
  
<p align="center">
 <a href="#sobre-o-app">Sobre o app</a> •
 <a href="#requisitos-do-projeto">Requisitos do Projeto</a> •
 <a href="#demonstração">Demonstração</a> •
 <a href="#tecnologias-utilizadas">Tecnologias utilizadas</a> •
 <a href="#arquitetura-e-layout">Arquitetura e Layout</a> •
 <a href="#metodologia-de-trabalho">Metodologia de trabalho</a> •
 <a href="#execução-do-projeto">Execução do Projeto</a> •
 <a href="#autores">Autores</a>
</p>
  

---
##  **Sobre o app**

O projeto integrador faz parte do ciclo de finalização do curso iOS mobile developer desenvolvido pela [Digital House Brasil][digital-house-url].

Sabe aquele momento que você deseja assistir um bom filme mas não sabe como decidir? É pra suprir essa necessidade que criamos o aplicativo **Movieroll**. O objetivo do app é roletar filmes utilizando como filtro gêneros, nivel de exigência, data de lançamento e plataformas de streaming. Basta escolher um ou mais filtros que nós sugerimos um filme pra você. O aplicativo ainda apresenta uma tela com os principais lançamentos dividos em gêneros e uma tela de perfil de usuário onde existe a função histórico que guarda os filmes que ele ja roletou, favoritos e filmes assistidos. Enquanto o filme estiver nestas listas ele não aparece mais na roleta, e só volta a aparecer se o usuário ir em configurações e resetar cada uma. Para o usuário ter acesso ao histórico é necessário efetuar login, mas para usufruir das outras funcionalidades do app não é necessário logar.

Para este projeto está sendo consumida a API do [The Movie DataBase][tmdb-api-url], conforme uma das exigências de entrega do projeto: consumo de API.

---
##  **Requisitos do Projeto**

O projeto integrador deve estar em conformida com os seguintes tópicos;

- [x] Deve possuir um design em todas as telas utilizando auto layout;
- [x] Aplicação do POO.
- [x] Deve possuir navegação entre telas (Navigation e Modal);
- [x] Tratativas de erros;
- [x] Deve consumir uma API;
- [x] Deve funcionar em modo offline;
- [x] A arquitetura deve ser MVVM;
- [x] O app deve conter, pelo menos, os seguintes componentes do UIKit: (UITextField, 
UIButton, UILabel, UICollectionView e UITableView).
- [x] O app deve possuir as seguintes features:
    - [x] Tela de carregamento;
    - [x] Tela de login (Facebook e Google são obrigatórios);
    - [x] Tela inicial que deve conter um resumo das funcionalidades do app;
    - [x] Tela de descrição do item;
    - [x] Tela de listagem de características;
- [x] Todo o trabalho deve ser feito utilizando o GitFlow;
- [x] Ao final, o ReadMe deve estar atualizado com screenshots das telas do app e descrição detalhada das funcionalidades.

---
##  **Demonstração**

<div align="center">


**Telas Principais**: Fluxo


https://user-images.githubusercontent.com/101955186/182740245-551ff831-58d4-4b4f-96c0-6a4663e73769.mp4
  
https://user-images.githubusercontent.com/101955186/182740459-112480ff-f7b3-4a49-a2b4-ea32b3efd57e.mp4
  
https://user-images.githubusercontent.com/101955186/182744561-9e1121cf-899b-4507-b1c3-b07bc0785452.mp4

**Login**: Fluxo
  
https://user-images.githubusercontent.com/101955186/183225300-4ea8bd13-60a7-483f-8916-5cc7f1b42e89.mov
  
https://user-images.githubusercontent.com/101955186/183225856-9e3120bf-ec83-4b6d-94a0-091bd657e7d6.mov

https://user-images.githubusercontent.com/101955186/183223634-1053c59c-abbf-48a2-9aa4-e3d51d0879b3.mov
  
https://user-images.githubusercontent.com/101955186/183224388-58e2221d-6238-4bcf-9d9e-cbd9e0654f93.mov

  

</div>

<div align="center">



</div>



---

##  **Tecnologias utilizadas**

- WhatsApp
- Zoom
- Xcode 13.4
- Git - GitFlow
- Cocoapods
- Marvel
- Creative Cloud (Photoshop e Illustrator)
- Firebase - Realtime e Storage
- CoreData

---
##  **Arquitetura e Layout**

Este projeto foi desenvolvido dentro do padrão de projeto **Model-View-ViewModel (MVVM)**, composto pelos seguintes elementos:
* **Model**: Camada de logística de negócios que impulsiona a aplicação e quaisquer regras de negócios, é responsável pelos dados;
* **View**: Camada de interface de usuário, responsável pela aparência da aplicação
* **ViewModel**: Responsável por ser a ligação principal dentro do MVVM, a ViewModel coordena as operações entre a *view* e as camadas *model*, ela será responsável por expor métodos, comandos e propriedades que mantém o estado da View, bem como manipular a Model com resultados de ações da View.

<p align="center">
  <img alt="mvvm" src="https://github.com/vhenriquebm/MovieRoll/blob/develop/images/mvvm.png"/>
<p>

* **Layout**: O app foi construído em grande parte por meio de Storyboard. Para fins de estudo, desenvolvemos as telas abaixo em ViewCode.

<p align="center">
  <img alt="movieroll" src="https://github.com/vhenriquebm/MovieRoll/blob/develop/images/login.png" width="200px"/>
  <img alt="movieroll" src="https://github.com/vhenriquebm/MovieRoll/blob/develop/images/config.png" width="200px"/>
  <img alt="movieroll" src="https://github.com/vhenriquebm/MovieRoll/blob/develop/images/meusdados.png" width="200px"/>
<p>





---
##  **Metodologia de trabalho**

Este projeto utilizou como metodologia principal de trabalho o padrão ágil implementado com o **Scrum**. Este é uma estrutura voltada para o trabalho em equipe, estimulando as equipes a aprenderem com suas experiências, se organizarem enquanto resolvem um problema e refletirem sobre os êxitos e fracassos para melhorarem continuamente, tudo isso realizado em cerimônias de acompanhamento com o time (Planning, Dailys, Retrospective) que juntas culminam na entrega do resultado e fechamento da Sprint - período curto de trabalho pré-fixado onde uma equipe se dedica a entrega das tarefas definidas.


---

##  **Execução do Projeto**

Este projeto deverá ser executado:
1. No sistema operacional MacOS
2. No simulador do Xcode ou IPhone

💡É preciso efetuar a simulação no ambiente de desenvolvimento Xcode ou integrá-lo com Iphone para funcionar.

### Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:
[Git](https://git-scm.com), [CocoaPods](https://cocoapods.org/)

```bash
# Clone este repositório
$ git clone <https://github.com/vhenriquebm/MovieRoll.git>

# Acesse a pasta do projeto no terminal/cmd
$ cd MovieRoll

# Execute o comando *pod install* para iniciar o projeto com as libs necessárias
$ pod install

# Abra o projeto no XCode
$ open MovieRoll.xcworkspace
```

---
##  **Autores**
  
 <div align="center">
   

<a href="https://github.com/vhenriquebm">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/vhenriquebm" width="100px;" alt="Foto de Perfil Vitor Henrique"/>
 <br />
  <p>
 <sub><b>Vitor Henrique</b></sub></a>
<p>

[![Linkedin Badge](https://img.shields.io/badge/-Vitor_Henrique-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/vitor-henrique-736b72213/)
[![Github Badge](https://img.shields.io/badge/-Vitor_Henrique-000?style=flat-square&logo=Github&logoColor=white)](https://github.com/vhenriquebm)
  
  <div align="center">

<a href="https://github.com/ygorgsilva">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/ygorgsilva" width="100px;" alt="Foto de Perfil Ygor Silva"/>
 <br />
  <p>
 <sub><b>Ygor Silva</b></sub></a>
<p>

[![Linkedin Badge](https://img.shields.io/badge/-Ygor_Silva-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/ygor-guimarães-silva-b3abbb146/)
[![Github Badge](https://img.shields.io/badge/-Ygor_Silva-000?style=flat-square&logo=Github&logoColor=white)](https://github.com/ygorgsilva)

<div align="center">

<a href="https://github.com/akabezerra">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/akabezerra" width="100px;" alt="Foto de Perfil Bruno Bezerra"/>
 <br />
  <p>
 <sub><b>Bruno Bezerra</b></sub></a>
<p>

[![Linkedin Badge](https://img.shields.io/badge/-Bruno_Bezerra-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/akabezerra/)
[![Github Badge](https://img.shields.io/badge/-Bruno_Bezerra-000?style=flat-square&logo=Github&logoColor=white)](https://github.com/akabezerra)
  
  
  <div align="center">

<a href="https://github.com/rnt-yoshi">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/rnt-yoshi" width="100px;" alt="Foto de Perfil Renato Yoshinari"/>
 <br />
  <p>
 <sub><b>Renato Yoshinari</b></sub></a>
<p>

[![Linkedin Badge](https://img.shields.io/badge/-Renato_Yoshinari-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/renato-yoshinari-873a1339/)
[![Github Badge](https://img.shields.io/badge/-Renato_Yoshinari-000?style=flat-square&logo=Github&logoColor=white)](https://github.com/rnt-yoshi)
  
  
  <div align="center">
       

<a href="https://github.com/ArturFAraujo">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/ArturFAraujo" width="100px;" alt="Foto de Perfil Artur Araujo"/>
 <br />
  <p>
 <sub><b>Artur Araujo</b></sub></a>
<p>

[![Linkedin Badge](https://img.shields.io/badge/-Artur_Araujo-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/artur-frança-5b0229236/)
[![Github Badge](https://img.shields.io/badge/-Artur_Araujo-000?style=flat-square&logo=Github&logoColor=white)](https://github.com/ArturFAraujo)
  
  
   <div align="center">

<a href="https://github.com/felippeandrade">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/felippeandrade" width="100px;" alt="Foto de Perfil Raul Andrade"/>
 <br />
  <p>
 <sub><b>Raul Andrade</b></sub></a>
<p>

[![Linkedin Badge](https://img.shields.io/badge/-Raul_Andrade-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/felippeandrade/)
[![Github Badge](https://img.shields.io/badge/-Raul_Andrade-000?style=flat-square&logo=Github&logoColor=white)](https://github.com/felippeandrade)



</div>
</div>

## Aceitamos sugestões para melhorar o nosso projeto :)

**Qualquer dificuldade na instalação do Xcode ou na execução do projeto, estamos a disposição no email: vybrar@gmail.com**

---
