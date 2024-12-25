package game.titlescreen;

import h2d.Tile;
import h2d.Bitmap;
import hxd.Timer;
import h2d.Graphics;

typedef Bubble = {
    var g: Graphics;
    var s: Float;
};

class BubblerEntity extends Entity {
    var graphics: Array<Bubble> = [];
    var ticks = 0;
    var bg: Bitmap;
    var time = 0.0;
    
    public function new(?g) {
        super(g);

        bg = new Bitmap(Tile.fromColor(0xFFFFFF), spr);
        bg.scaleX = 10000;
        bg.scaleY = 10000;
        bg.x = -5000;
        bg.y = -5000;
        bg.alpha = 0;

        for (i in 0...100) {
            graphics.push(makeThing());
        }
    }

    public function makeThing() {
        var g = new Graphics(spr);
        g.beginFill(0xFFFFFF);
        g.drawCircle(0, 0, 30 + Math.random() * 50);
        g.endFill();
        g.x = Math.random() * 800 - 400;
        g.y = 300 + 80 + Math.random() * 300;
        return { g: g, s: 1 + Math.random() * 5};
    }

    override function update() {
        super.update();
        time += Timer.dt;

        for (g in graphics) {
            g.g.y -= g.s * tmod;
        }
        bg.alpha = time / 2 - 0.5;
        if (bg.alpha >= 1) {
            onFinished();
        }
    }

    override function tick() {
        super.tick();

        ticks++;
        if (ticks >= 5) {
            ticks -= 5;
            graphics.push(makeThing());
        }
    }

    public dynamic function onFinished() {

    }
}