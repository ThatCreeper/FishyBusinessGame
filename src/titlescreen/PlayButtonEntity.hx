package titlescreen;

import sdl.Cursor;
import h2d.Interactive;
import h2d.Tile;
import h2d.Bitmap;
import src.Entity;

class PlayButtonEntity extends Entity {
    public function new(?g) {
        super(g);
        var g = new Bitmap(Tile.fromColor(0xFFFFFF, 128, 32), spr);
        x = 80;
        y = 80;
        var i = new Interactive(128, 32, g);
        i.onOver = x -> g.alpha = 0.8;
        i.onOut = x -> g.alpha = 1;
        i.onPush = x -> trace("p");
        i.onRelease = x -> trace("r");
        i.onClick = x -> trace("c");
    }
}