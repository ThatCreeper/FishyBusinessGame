package game.game;

class ShopPageEntity extends Entity<ClickerGame> {
    public function new(?g) {
        super(g);
    }

    override function update() {
        super.update();

        game.bg.sc = 0xF1B3B3;
    }
}