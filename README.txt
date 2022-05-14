NBA Player Visualization

KWOK, Hin Kwan 913566628

Data URL:
1. https://drive.google.com/file/d/0B3n3WZ2CVCSEYTFhcWIxZHktZnM/view?usp=sharing
2. https://drive.google.com/open?id=0B3n3WZ2CVCSEQ2Y5NE1LM1RBd2c

Referenced libraries: N/A

This visualisation replays the games between teams with additional data.
By clicking into the links in the graph, a game page will be shown.
The visulization aims at help users to review the critical moment of a game. User can know which player is switched in and out, when a team overtake another by navigating the timeline.

To use the data, please download the files and put all content into the data folder. (Data folder itself is not included in the compressed files) I'm sorry about the file size but to make the timeline work, I have to modify the original files.

Root
|-data
   |-careerhigh/*.csv
   |-games/*.csv
   |-logos/*.csv
   |-playbyplays/*.csv
   |-teams/*.csv
   |-games.csv
   |-players.csv
   |-team.csv

Extra credits:
1. Force-directed Diagram in Processing
- Self-implemented Force-directed Diagram.
- Support drag and drop

2. Score line chart
- User can view the score of a game across time, knowing whether and when a team catch up and finally win the game.

2. Game-based event player:
- All events of the same game are combined into the same view.
- User can select events in the selector on the top.

3. Additonal information for selected event:
- Picture, name, position of players
- Link to the player's best game (Only if the game is also shown in the game list). Try navigating to 04-18-2015 Toronto vs Washington.
- Team past record
