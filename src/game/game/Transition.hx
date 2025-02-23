package game.game;

import hxd.res.DefaultFont;
import h2d.Text;

class Transition extends Entity<MindWaveGame> {
    var timer = 2.0;

    public function new(?g) {
        super(g);

        var t = new Text(DefaultFont.get(), spr);
        t.text = game.getNextMinigame().getName();
        t.textAlign = Center;
        t.x = scrwid / 2;
        t.y = scrhei / 2;
    }

    override function update() {
        super.update();

        timer -= deltaTime;
        if (timer <= 0) {
            game.startMinigame();
        }
    }
}