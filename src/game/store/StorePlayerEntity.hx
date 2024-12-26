package game.store;

import h2d.Tile;
import h2d.Bitmap;
import hxd.Key;

class StorePlayerEntity extends Entity<StoreGame> {
    public function new(?g) {
        super(g);

        var b = new Bitmap(Tile.fromColor(0xA3D147, 16, 32), spr);
        b.x = -8;
        b.y = -16 - 8;
    }

    override function update() {
        super.update();

        camera.x = StoreGame.PWID / 2;
        camera.y = StoreGame.PHEI / 2;
        camera.sscale = 4;
    }

    override function tick() {
        var xd = (Key.isDown(Key.D) ? 1 : 0) - (Key.isDown(Key.A) ? 1 : 0);
        var yd = (Key.isDown(Key.S) ? 1 : 0) - (Key.isDown(Key.W) ? 1 : 0);
        x += xd;
        y += yd;
        if (xd < 0) {
            if (game.collides(Math.floor(x / 16.0), Math.floor(y / 16.0))) {
                x += 1;
            }
        } else if (xd > 0) {
            if (game.collides(Math.floor(x / 16.0), Math.floor(y / 16.0))) {
                x -= 1;
            }
        }
        if (yd < 0) {
            if (game.collides(Math.floor(x / 16.0), Math.floor(y / 16.0))) {
                y += 1;
            }
        } else if (yd > 0) {
            if (game.collides(Math.floor(x / 16.0), Math.floor(y / 16.0))) {
                y -= 1;
            }
        }
    }
}