# PicDog para Android - Kotlin

## Funcionalidade

Exibe fotos de cachorro pela raça.

## Estrutura:
Alguns dos componentes utilizados são:

- Arquitetura MVVM.
- SQLite - para armazenamento em cache local.
- DispatchQueue - para tarefas em segundo plano, como chamadas de rede e acesso ao banco de dados.
- URLSession - para as chamadas de rede.
- Codable - pela desserialização.
- SDWebImage - para carregamento e cache de imagens.
- UICollectionView - para exibir a lista de imagens.

## Libs:

   **SDWebImage - Para download e armazenamento local de imagens**
   
                use_frameworks!
                pod 'SDWebImage'
            
  
## Modelos:
Dois modelos diferentes foram recebidos das chamadas de API bem-sucedida:

- [ ] https://iddog-nrizncxqba-uc.a.run.app/feed ->
- FeedEntity - com a categoria (raça) e uma lista com as url das fotos.

- [ ] https://iddog-nrizncxqba-uc.a.run.app/signUp ->
- UserResponse - com as informações do usuário (UserEntity).

No caso de uma resposta de erro, o modelo ErrorResponse foi criado para capturar a mensagem.

Para o banco de dados, está sendo usados modelos "UserEntity" e "FeedEntity", que contêm informações relevantes para executar o aplicativo no modo offline.

Para a obtenção de imagens, está send usando o SDWebImage.

## Visualizações:
Para a visualização, está sendo utilizada quatro atividades (SplashViewController, AuthViewController, MainViewController and MainTabBarViewController).

- SplashViewController:

    A única funcionalidade é redirecionar o usuário caso ele esteja logado ou não.

- AuthViewController:

    Está exibindo uma página de boas-vindas.

    Interação com o usuário :

    EditText onde o usuário deve inserir o email e um botão "SIGN UP", onde o usuário pode se inscrever no aplicativo.


![alt text](https://github.com/kiviabrito/PicDog-iOS/blob/master/Screenshot_AuthViewController.png) 


- MainViewController and MainTabBarViewController :

    MainTabBarViewController possui quatro guias, para as quatro raças diferentes, e exibe a list de imagens no MainViewController.
    Também inclui um botão "SIGN OUT".

    Interação com o usuário:

    Alterne entre as guias (exibindo fotos de diferentes raças). Ao clicar numa imagem, é exibida uma caixa de diálogo com a imagem expandida. O usuário também tem a opção de sair da conta.


![alt text](https://github.com/kiviabrito/PicDog-iOS/blob/master/Screenshot_MainViewController.png) 


## Executar o app

Nenhuma atualização é necessária, basta clonar o projeto e executá-lo.

Nota: Para o aplicativo funcionar no modo offline, é necessário que o usuário tenha pelo menos um acesso com a Internet conectada, para que possa buscar os dados da rede e armazená-los na base de dados local.
