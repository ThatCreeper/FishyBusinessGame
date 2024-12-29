package game.game;

import game.Game;
import h2d.Tile;
import h2d.Bitmap;

class BackgroundEntity<T: Game> extends Entity<T> {
    var b: Bitmap;
    public var c(never, set): Int;
        function set_c(v) {
            return rc = sc = v;
        }
    public var sc(never, set): Int;
        function set_sc(v) {
            scr = ((v >> 16) & 0xFF) / 0xFF;
            scg = ((v >>  8) & 0xFF) / 0xFF;
            scb = ((v >>  0) & 0xFF) / 0xFF;
            return v;
        }
    var scr = 1.0;
    var scg = 1.0;
    var scb = 1.0;
    var rc(never, set): Int;
        function set_rc(v) {
            rcr = ((v >> 16) & 0xFF) / 0xFF;
            rcg = ((v >>  8) & 0xFF) / 0xFF;
            rcb = ((v >>  0) & 0xFF) / 0xFF;
            return v;
        }
    public var rcr = 1.0;
    public var rcg = 1.0;
    public var rcb = 1.0;

    public function new(?g) {
        super(g, g.bgLayer);
        b = new Bitmap(Tile.fromColor(0xFFFFFF), spr);
        b.x = -50;
        b.y = -50;
    }

    override function postUpdate() {
        super.postUpdate();

        rcr = M.lerp(rcr, scr, 0.1 * tmod);
        rcg = M.lerp(rcg, scg, 0.1 * tmod);
        rcb = M.lerp(rcb, scb, 0.1 * tmod);
        b.color.r = rcr;
        b.color.g = rcg;
        b.color.b = rcb;

        b.scaleX = scrwid + 100;
        b.scaleY = scrhei + 100;
    }

    public function instant() {
        rcr = scr;
        rcg = scg;
        rcb = scb;
    }
}