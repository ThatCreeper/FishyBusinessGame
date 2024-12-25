package game.titlescreen;

import sdl.Cursor;
import h2d.Interactive;
import h2d.Tile;
import h2d.Bitmap;

class PlayButtonEntity extends Entity {
    public function new(?g) {
        super(g);
        var g = new Bitmap(Tile.fromColor(0xFFFFFF, 128, 32), spr);
        g.x = -64;
        g.y = -16;
        var i = new Interactive(128, 32, g);
        i.onOver = x -> g.alpha = 0.8;
        i.onOut = x -> g.alpha = 1;
        i.onClick = x -> game.shake(0.2);
    }
}