package game.store;

import h2d.Tile;
import h2d.Bitmap;
import h3d.Engine;

class StoreGame extends Game {
    var whiteoverlay: Bitmap;
    var targetoverlayalpha = 0.0;

    public function new() {
        super();

        new StorePlayerEntity(this);
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
}