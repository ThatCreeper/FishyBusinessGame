package game.game;

import h2d.Tile;
import h2d.Bitmap;

class SimpleTimerBar extends Entity<MindWaveGame> {
    var minigame: Minigame;
    var bm: Bitmap;

    public function new(mg, ?g) {
        super(g);
        minigame = mg;
        bm = new Bitmap(Tile.fromColor(0xFF0000, 1, 32), spr);
        bm.y = scrhei - 32;
        bm.x = 0;
    }

    override function update() {
        super.update();

        bm.scaleX = scrwid * minigame.timer / minigame.maxTimer;
    }
}