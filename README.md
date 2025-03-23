# Flutter Layout Task

This project implements a video playback system that follows a specific sequence using three videos stored in the phone’s local storage. The BLoC pattern is used for state management.

---

## Project Structure

The project is organized into the following directories:

```
lib/
├── core/                      # Core utilities and resources
│   ├── res/                   # App resources (dimensions, strings)
│   │   ├── app_dimen.dart     # Defines app dimensions
│   │   ├── app_string.dart    # Defines app strings
│   ├── utils/                 # Utility functions
│   │   ├── time_utils.dart    # Utilities related to time handling
│
├── data/                      # Data layer
│   ├── blocs/                 # BLoC state management
│   │   ├── video_player/      # Video player BLoC
│   │   │   ├── video_player_bloc.dart   # BLoC implementation
│   │   │   ├── video_player_event.dart  # Events for video player
│   │   │   ├── video_player_state.dart  # States for video player
│   ├── models/                # Data models
│   │   ├── video_model.dart   # Video model
│
├── presentation/              # UI layer
│   ├── screens/               # Screens
│   │   ├── video_player_screen.dart  # Video player screen UI
│   ├── widgets/               # Reusable UI components
│   │   ├── video_controls.dart       # Video controls UI
│   │   ├── video_progress_bar.dart   # Video progress bar UI
│
├── main.dart                  # Entry point of the application
│
test/                          # Unit and widget tests

```
## Features

1. **BLoC Pattern**:
   - The **BLoC (Business Logic Component)** pattern is used to manage the state of the video player & controls.

2. **Playback Sequence Logic:**:
    - Plays three local videos with automatic pauses (15s, 20s).
    - Loops back to previous videos after completion.

3. **Dynamic UI & Controls**:
    - Displays video title and playback progress..
    - Includes play, pause, and progress bar for each video..

4. **Error Handling**:
    - The app includes error handling for invalid video files or exceptions.

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/Ritesh-056/flutter_video_player.git
   cd flutter_video_player
   ```
   
2. Place the 3 video files inside following directory:
   ```bash
   Must include file name as video1.mp4, video2.mp4 and video3.mp4. Like this :
   ```
   assets/                           # root level order
   │   ├── videos/                   # videos directories
   │   │   ├── video1.mp4
           ├── video2.mp4
           ├── video3.mp4

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## Dependencies

The project uses the following dependencies:

- **flutter_bloc**: For state management using the BLoC pattern.
- **video_player**: For playing videos in the layout.
- **path_provider**: For accessing device directories and file paths.
- **equatable**: For comparing the Dart Objects by overriding == and hashCode.

You can find the full list of dependencies in the `pubspec.yaml` file.