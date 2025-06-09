# EyeApp3D
EyeApp3D for mobile is a cross platform application built in [flutter](https://flutter.dev/) using huggingface api
## Getting Started
Follow these instructions to build and run the project
### Setup Flutter
A detailed guide for multiple platforms setup could be find [here](https://flutter.dev/docs/get-started/install/)
### Setup project
  - Clone this repository using `git clone https://github.com/2TFD/EyeApp3D.git`
  - `cd` into `EyeApp3D`.
  - `flutter pub get` to get all the dependencies.
### Running the app
Make sure you have a connected Android/iOS device/simulator and run the following command to build and run the app in debug mode.

`flutter run`

## Project Structure
```bash
├───android/       
├───assets
│   ├───image/
│   └───models/
├───ios/
├───lib
│   ├───core
│   │   └───brand/
│   └───layers
│       ├───data
│       │   └───network/
│       ├───domain
│       │   ├───cubit/
│       │   ├───entity/
│       │   ├───provider/
│       │   └───repository/
│       └───presentation
│           ├───screens
│           │   ├───chat/
│           │   ├───gallery/
│           │   ├───generation
│           │   │   ├───toimage/
│           │   │   ├───tomodel/
│           │   │   └───tomusic/
│           │   └───reg/
│           └───ui
│               └───cards/
├───mian.dart
```
## Features

### generation
  - images
  - models
  - music(soon)

## Screenshots
<p>
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/camera.png" alt="camera" width="200">\
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/chat_1.png" alt="chat_1" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/chat_2.png" alt="chat_2" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/gallery_images.png" alt="gallery_images" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/gallery_models.png" alt="gallery_models" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/home.png" alt="home" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/image_promt.png" alt="image_promt" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/image_view.png" alt="image_view" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/images_view.png" alt="images_view" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/model_view.png" alt="model_view" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/onboard_1.png" alt="onboard_1" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/onboard2.png" alt="onboard2" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/onboard_3.png" alt="onboard_3" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/preview.png" alt="preview" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/root_gallery.png" alt="root_gallery" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/root_gen.png" alt="root_gen" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/settings.png" alt="settings" width="200">
<img src="https://github.com/2TFD/EyeApp3D/blob/main/publication/screenshots/site.png" alt="site" width="200">
</p>



