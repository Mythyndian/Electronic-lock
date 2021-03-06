# 3-Factor Authentication  Electronic Lock

To unlock a lock first thing to do is bring RFID card near RFID sensor indicated on case of the lock. Next step is provide alphanumeric passcode. Final step is to provide sequrity sequence in mobile application after this steps lock is finally unlocked.

### Prerequisites

* Flutter
* Android Board
* 4 x 4 Keyboard
* LCD Screen 14 x 2
* ESP module
* Android Device or Android Emulator

### Installing

* Create new Flutter project and copy dart files into lib directory.

* Flash Arduino board with Arduino code.
* Flash ESP device with ESP code.
* Don't forget to change IP address in both Arduino and Flutter code.

## Deployment

`cd project_folder`

`flutter build apk --split-per-abi`

## Built With

* [Flutter](https://flutter.dev/) - The Mobile Applications UI framework
* [Arduino](https://www.arduino.cc/reference/en/) - C with help of Arduino libraries


## Authors

* **Maciej Zawistowski** - *Mobile app* - [Mythyndian](https://github.com/Mythyndian)
* **Jakub Ziemba** - *Embedded code and hardware testing* - [Naffik](https://github.com/Naffik)

## Docummentation

* Mobile app code docummentation - [docs](https://mythyndian.github.io/)
