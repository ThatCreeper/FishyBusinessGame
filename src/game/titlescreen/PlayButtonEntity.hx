package game.titlescreen;

import hxd.Timer;
import h2d.Object;
import h2d.Text;
import hxd.res.DefaultFont;
import h2d.HtmlText;
import sdl.Cursor;
import h2d.Interactive;
import h2d.Tile;
import h2d.Bitmap;

class PlayButtonEntity extends Entity {
    var camscale = 1.0;
    var time = 0.0;

    public function new(?g) {
        super(g);
        var c = new Object(spr);
        var g = new Bitmap(Tile.fromColor(0xFFFFFF, 128, 32), c);
        g.x = -64;
        g.y = -16;
        var i = new Interactive(128, 32, g);
        i.onOver = x -> {
            g.alpha = 0.8;
            camscale = 1.5;
            time = 0;
        }
        i.onOut = x -> {
            g.alpha = 1;
            camscale = 1;
        }
        i.onClick = x -> {
            game.shake(10);
            new BubblerEntity();
        }
        var t = new Text(DefaultFont.get(), c);
        t.text = "Play Game";
        t.textColor = 0x000000;
        t.textAlign = Align.Center;
        t.y -= t.textHeight / 2;
    }

    override function update() {
        super.update();

        time += Timer.dt;

        scale = M.lerp(scale, camscale, 0.2 * tmod);
        rotation = (scale - 1) * Math.sin(time) * 0.1;
    }
}