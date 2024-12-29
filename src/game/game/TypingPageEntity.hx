package game.game;

class TypingPageEntity extends Entity<ClickerGame> {
    public function new(?g) {
        super(g);
    }

    override function update() {
        super.update();

        game.bg.sc = 0xF1F6E4;
    }
}