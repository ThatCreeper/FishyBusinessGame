package titlescreen;

import src.Game;

class TitleScreenGame extends Game {
    public function new() {
        super();
        new PlayButtonEntity(this);
    }
}