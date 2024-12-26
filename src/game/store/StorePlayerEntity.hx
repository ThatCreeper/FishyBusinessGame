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
        var B = new Bitmap(Tile.fromColor(0x355ED1, 16, 16), spr);
        B.x = -8;
        B.y = -8;
        var r = new Bitmap(Tile.fromColor(0xFF0000, 12, 16), spr);
        r.x = -6;
        r.y = -8;
    }

    override function update() {
        super.update();

        camera.x = StoreGame.PWID / 2;
        camera.y = StoreGame.PHEI / 2;
        camera.sscale = 4;
    }

    function collidesTop(xd, yd) {
        return game.collides(Math.floor((x + xd - 6) / 16), Math.floor((y + yd - 8) / 16)) ||
               game.collides(Math.floor((x + xd + 5) / 16), Math.floor((y + yd - 8) / 16));
    }

    function collidesBottom(xd, yd) {
        return game.collides(Math.floor((x + xd - 6) / 16), Math.floor((y + yd + 7) / 16)) ||
               game.collides(Math.floor((x + xd + 5) / 16), Math.floor((y + yd + 7) / 16));
    }

    function collidesLeft(xd, yd) {
        return game.collides(Math.floor((x + xd - 6) / 16), Math.floor((y + yd - 8) / 16)) ||
               game.collides(Math.floor((x + xd - 6) / 16), Math.floor((y + yd + 7) / 16));
    }

    function collidesRight(xd, yd) {
        return game.collides(Math.floor((x + xd + 5) / 16), Math.floor((y + yd - 8) / 16)) ||
               game.collides(Math.floor((x + xd + 5) / 16), Math.floor((y + yd + 7) / 16));
    }

    function collidesDelta(xd, yd) {
        if (xd < 0) {
            if (yd < 0) {
                return collidesLeft(xd, yd) || collidesTop(xd, yd);
            } else {
                return collidesLeft(xd, yd) || collidesBottom(xd, yd);
            }
        } else {
            if (yd < 0) {
                return collidesRight(xd, yd) || collidesTop(xd, yd);
            } else {
                return collidesRight(xd, yd) || collidesBottom(xd, yd);
            }
        }
    }

    // Only works with xd = 1 rn
    function attemptXY(xd, yd) {
        if (collidesDelta(xd, yd))
            return false;
        x += xd;
        y += yd;
        return true;
    }

    function attemptX(xd) {
        if (collidesDelta(xd, 0))
            return false;
        x += xd;
        return true;
    }

    function attemptY(yd) {
        if (collidesDelta(0, yd))
            return false;
        y += yd;
        return true;
    }

    override function tick() {
        var xd = (Key.isDown(Key.D) ? 1 : 0) - (Key.isDown(Key.A) ? 1 : 0);
        var yd = (Key.isDown(Key.S) ? 1 : 0) - (Key.isDown(Key.W) ? 1 : 0);
        attemptXY(xd, yd) || attemptX(xd) || attemptY(yd);
    }
}