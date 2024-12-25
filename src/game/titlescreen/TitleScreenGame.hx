package game.titlescreen;

class TitleScreenGame extends Game {
    public function new() {
        super();
        new PlayButtonEntity(this);
    }
}