package game.game;

import h2d.Graphics;

class MouseEntity extends Entity<MindWaveGame> {
    var minigame: Minigame;

    public function new(?g, m) {
        super(g, g.hudLayer);

        minigame = m;

        var bmp = new Graphics(spr);
        bmp.beginFill(0xFF0000);
        bmp.drawRect(0, 0, 8, 8);
        bmp.endFill();

        update();
    }

    override function update() {
        super.update();

        x = minigame.getMouseX();
        y = minigame.getMouseY();
    }
}