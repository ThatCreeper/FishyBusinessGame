package game.titlescreen;

import game.store.StoreGame;

class TitleScreenGame extends Game {
    public function new() {
        super();
        new PlayButtonEntity(this);
    }

    public function bubble() {
        shake(10);
        var b = new BubblerEntity();
        b.onFinished = () -> Main.setGame(new StoreGame());
    }
}