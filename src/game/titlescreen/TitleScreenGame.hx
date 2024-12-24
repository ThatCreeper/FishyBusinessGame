package game.titlescreen;

class TitleScreenGame extends Game {
    public function new() {
        super();
        new PlayButtonEntity(this);
        s2d.camera.anchorX = 0.5;
        s2d.camera.anchorY = 0.5;
    }
}