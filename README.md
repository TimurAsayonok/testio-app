# The testio-app

Testio App is a simple app with 2 screen based on Swift language

For the app realizatdion I have tried to use `MVVM + Coordinator pattern` Architecture with `Realm` as a persistent layer to store servers.

After getting `Bearer token` this token will be saved in keychain and the app will ask backend for `servers` or present `servers` from Realm db

### 🧰 Libs
- `Dip` - Dependency Injection Container
- `IQKeyboardManagerSwift` - Helper for working with keyboard and TextFeild
- `KeychainAccess` - Wrapper for Keychain
- `netfox` - Small tool for observing all apu calls in the app (3rd party libs as well)
- `Realm, RealmDatabase` - DataBase for storing data in local
- `RxDataSource` - Reactive helper for working with UITableView, UICollectionView ...
- `RxGesture` - Reactive helper for handling any interactions with UIView
- `RxSwift` - Main Reactive lib
- `SwiftLint` - main helper for checking code style

### 🤤 Folders
- `Testio` - main folder
    - `Scenes` - Contains screens
    - `Coordinators` - Contains Coordinator entities
    - `Dip` - Contains dependency containers
    - `Extensions` - Contains Extensions for entities
    - `Services` -  Contains and Wrappers under the main lib (Keychain, URLSession...)
    - `NetworkLayer` - Contains entities to work with Network Api Calls
    - `Model` - Contains entities to represent models
    - `Common` - Contains entities shared in the app
- `TextioTests` - contains tests for Testio.

### 📺 Screens
- Login screen
- Servers List screen

### 🎨 Design
https://www.figma.com/file/NEqPdYxCcxnB5b1ByahrXU/Great-task-for-Great-iOS-Developer?type=design&node-id=0-1&t=enkkIHU8uBxE6AmQ-0

### 🧐 How to start? 
I think that you know what to do 😎🤩
