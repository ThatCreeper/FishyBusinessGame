package game.store;

import h2d.Tile;
import h2d.Bitmap;
import hxd.Key;

class StorePlayerEntity extends Entity {
    public function new(?g) {
        super(g);

        var b = new Bitmap(Tile.fromColor(0xA3D147, 16, 32), spr);
        b.x = -8;
        b.y = -16;
    }

    override function update() {
        super.update();

        camera.sx = x;
        camera.sy = y;
        camera.sscale = 3;
    }

    override function tick() {
        x += (Key.isDown(Key.D) ? 1 : 0) - (Key.isDown(Key.A) ? 1 : 0);
        y += (Key.isDown(Key.S) ? 1 : 0) - (Key.isDown(Key.W) ? 1 : 0);
    }
}