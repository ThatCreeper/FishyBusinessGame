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

    function collisionTopLeftX() {
        return x - 6;
    }

    function collisionTopLeftY() {
        return y - 8;
    }

    function collisionBottomRightX() {
        return x + 5;
    }

    function collisionBottomRightY() {
        return y + 7;
    }

    function collidesIterative(xd, yd) {
        var tlX = collisionTopLeftX() + xd;
        var tlY = collisionTopLeftY() + yd;
        var brX = collisionBottomRightX() + xd;
        var brY = collisionBottomRightY() + yd;

        var tlXT = Math.floor(tlX / 16);
        var tlYT = Math.floor(tlY / 16);
        var brXT = Math.floor(brX / 16);
        var brYT = Math.floor(brY / 16);

        for (yT in tlYT...(brYT+1)) {
            for (xT in tlXT...(brXT+1)) {
                if (game.collides(xT, yT)) {
                    return true;
                }
            }
        }

        return false;
    }

    // Only works with xd = 1 rn
    function attemptXY(xd, yd) {
        if (collidesIterative(xd, yd))
            return false;
        x += xd;
        y += yd;
        return true;
    }

    function attemptX(xd) {
        if (collidesIterative(xd, 0))
            return false;
        x += xd;
        return true;
    }

    function attemptY(yd) {
        if (collidesIterative(0, yd))
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