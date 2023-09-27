# KidsJoyCenter
Kids Joy Center is an engaging iOS app specifically designed for kids, available exclusively for the iPad Pro 9.7 inch screen, in landscape mode with dimensions width=1024 and height=768. The app brings three delightful games with varying levels of difficulty for a fun-filled learning experience.

## Features

- Three intriguing games:
  1. Memory Game
  2. Sorting Game
  3. Balloon Popping Game
- Three levels of difficulty: Easy, Medium, Hard
- Interactive initial screen with game and difficulty level selection
- High score board with top 5 scores across all games and levels
- Data persistence for high scores across app closures
- Exclusive support for iPad Pro 9.7 inch in landscape mode

## Games

### 1. Memory Game
   - Objective: Pair matching game where the player uncovers images to find matching pairs.
   - View: Image placement varies by difficulty level, programmatically designed views.
   - Game Mechanics: Score and Time tracking, varied rewards based on speed, random image placement every game.

### 2. Sorting Game
   - Objective: Players drag and drop vehicle images to their respective environments, namely, air, water, and land.
   - View: Different number of images by difficulty level, programmatically designed views.
   - Game Mechanics: Score and Time tracking, various rewards based on speed, feedback through animations and sounds.

### 3. Balloon Popping Game
   - Objective: Pop balloons as they appear with varied rewards based on balloon type.
   - View: Balloons are added programmatically with varying speed and number based on the difficulty level.
   - Game Mechanics: Score and Time tracking, endgame scenarios based on user performance, random balloon placement and type every game.

## High Scores Page
   - View: Displays as a pop-up showing top 5 scores with game type and difficulty level.
   - Function: Persistent storage of high scores across app closures using UserDefaults.

## Installation
Ensure you have Xcode installed and configured, then:

1. Clone the repository:
   ```
   git clone https://github.com/Huyenhuynhh/ShopME
   ```
2. Open the project in Xcode and run it on an iPad Pro 9.7 inch simulator or device.

## Usage
1. Start by selecting a game and a difficulty level.
2. Click the play button to start the selected game.
3. Navigate back and forth through games using the navigation controller.
4. Check the high scores by clicking the high scores button.

## Notes
- The app is exclusively designed for iPad Pro 9.7 inch in landscape mode.
- The Initial screen can be designed using Xcode Interface Builder, but other views should be programmed.
- Design with a focus on usability and user experience, especially considering the app's audience - kids.
