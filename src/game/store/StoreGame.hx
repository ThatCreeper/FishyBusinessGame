package game.store;

import h2d.Tile;
import h2d.Bitmap;
import h3d.Engine;

class StoreGame extends Game {
    var whiteoverlay: Bitmap;
    var bg: Bitmap;
    var targetoverlayalpha = 0.0;
    var p: StorePlayerEntity;

    public static var TWID = 8;
    public static var THEI = 5;
    public static var PWID = TWID * 16;
    public static var PHEI = THEI * 16;

    public function new() {
        super();

        bg = new Bitmap(hxd.Res.map.toTile(), hudLayer);
        bg.x = -16;
        bg.y = -16;

        p = new StorePlayerEntity(this);
        p.x = 7 * 16 + 8;
        p.y = 8;

        whiteoverlay = new Bitmap(Tile.fromColor(0xFFFFFF));
        whiteoverlay.scaleX = 10000;
        whiteoverlay.scaleY = 10000;
        whiteoverlay.x = -5000;
        whiteoverlay.y = -5000;
        whiteoverlay.filter = new h2d.filter.Nothing();
        s2d.add(whiteoverlay, 10);
    }

    override function update() {
        super.update();

        if (whiteoverlay.alpha < targetoverlayalpha) {
            whiteoverlay.alpha += tmod / 120.0;
            whiteoverlay.alpha = Math.min(whiteoverlay.alpha, 1);
        } else {
            whiteoverlay.alpha -= tmod / 120.0;
            whiteoverlay.alpha = Math.max(0, whiteoverlay.alpha);
        }
    }

    public function collides(x, y) {
        if (x < 0)
            return true;
        if (y < 0)
            return true;
        if (x >= TWID)
            return true;
        if (y >= THEI)
            return true;
        if (x == 0 && y == 2)
            return true;
        return false;
    }
}