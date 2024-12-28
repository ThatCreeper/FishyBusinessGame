package game.store;

import h2d.Tile;
import h2d.Bitmap;
import hxd.Key;

// cooldowns:
// -- ucd --
// "frozen" stops gameplay. used for ui
class StorePlayerEntity extends Entity<StoreGame> {
    public function new(?g) {
        super(g);

        var b = new Bitmap(Tile.fromColor(0xA3D147, 16, 32), spr);
        b.y = -32;
        var B = new Bitmap(Tile.fromColor(0x355ED1, 16, 16), spr);
        B.y = -16;
        var r = new Bitmap(Tile.fromColor(0xFF0000, 12, 16), spr);
        r.x = 2;
        r.y = -16;
    }

    override function update() {
        super.update();

        camera.x = StoreGame.PWID / 2;
        camera.y = StoreGame.PHEI / 2;
        camera.sscale = 4;

        if (ucd.has("frozen"))
            return;

        if (Key.isPressed(Key.E)) {
            /* Computer interaction tiles */
            if (inTile(6, 0) || inTile(7, 0)) {
                new StoreComputerEntity(this, game);
            }
        }
    }

    function collisionTopLeftX() {
        return x + 2;
    }

    function collisionTopLeftY() {
        return y - 16;
    }

    function collisionBottomRightX() {
        return collisionTopLeftX() + 12;
    }

    function collisionBottomRightY() {
        return y;
    }

    function collidesIterative(xd, yd) {
        var tlX = collisionTopLeftX() + xd;
        var tlY = collisionTopLeftY() + yd;
        var brX = collisionBottomRightX() + xd;
        var brY = collisionBottomRightY() + yd;

        return game.collidesPxRect(tlX, tlY, brX, brY);
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

    function inTile(tx, ty) {
        return Math.floor(x / 16.0) == tx && Math.floor((y - 1) / 16.0) == ty;
    }

    override function tick() {
        if (ucd.has("frozen"))
            return;
        var xd = (Key.isDown(Key.D) ? 1 : 0) - (Key.isDown(Key.A) ? 1 : 0);
        var yd = (Key.isDown(Key.S) ? 1 : 0) - (Key.isDown(Key.W) ? 1 : 0);
        attemptXY(xd, yd) || attemptX(xd) || attemptY(yd);
    }
}