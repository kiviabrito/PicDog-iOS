# PicDog iOS App - Swift 5

## Functionality

Show dog pictures by the breed.

## Structure:
Some os the components used are:

- MVVM Architecture.
- SQLite - for local caching.
- DispatchQueue - for tasks on the background, as network calls and access to database.
- URLSession - for the network calls.
- Codable - for the deserialization.
- SDWebImage - for image loading and cache.
- UICollectionView - for displaying list of Pictures.

## Models:
Two different models were receive from a success API calls :

- [ ] https://iddog-nrizncxqba-uc.a.run.app/feed - >
- FeedEntity - with the category(breed), and a list of url photos.

- [ ] https://iddog-nrizncxqba-uc.a.run.app/signUp - >
- UserResponse - with the user(UserEntity) information.

In case of an error response, ErrorResponse model was create to catch the message.

For the database it is using the "UserEntity" model and "FeedEntity" model, which contain relevante information to run the app on the offline mode.

For the picture cashing, it is using SDWebImage.

## Views:
For the view it is using four ViewControllers (SplashViewController, AuthViewController, MainViewController and MainTabBarViewController).

- SplashViewController : 

    The only functionality is to redirect the user wherever he is signed up or not.

- AuthViewController: 

    It is displaying a welcome page.

    User Interaction : 

    UITextField where the user should enter the email, and a "SIGN UP" Button where the user can sign up to the app.

![alt text](https://github.com/kiviabrito/PicDog-iOS/blob/master/Screenshot_AuthViewController.png) 

- MainViewController and MainTabBarViewController : 

    MainTabBarViewController has four tabs, for the four different breeds, which displays the tab view with the MainViewController.
    It also includes a "SIGN OUT" button.

    User Interaction:

    Switch between tabs(displaying fotos from different breeds), when clicking on a picture it shows a dialog with the expanded picture, and the user also has a option to sign out.


![alt text](https://github.com/kiviabrito/PicDog-iOS/blob/master/Screenshot_MainViewController.png) 


## Executar o app

  No update is necessary, you can just clone the project and run it.
  #### Note: For the app work on the offline mode it is necessary that the user has had at least one access with the internet connected, so it can fetch the data from the network and store it on the local data base.




