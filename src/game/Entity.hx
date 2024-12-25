package game;

import h2d.Object;

class Entity extends TimeAware {
    public var game: Game;
    public var spr: Object;
    public var x: Float = 0;
    public var y: Float = 0;
    public var scale: Float = 1;
    public var rotation: Float = 0;

    public var camera(get, never): Camera;
        function get_camera() {
            return game.camera;
        }

    public var scrwid(get, never): Int;
        function get_scrwid() {
            return game.scrwid;
        }
    public var scrhei(get, never): Int;
        function get_scrhei() {
            return game.scrhei;
        }
    
    public function new(?g: Game, ?layer) {
        if (g == null)
            g = Main.INST.game;
        game = g;
        game.addEntity(this);

        spr = new Object(layer ?? game.gameLayer);
    }

    public function preUpdate() {
        updateCooldowns();
    }

    public function update() {

    }

    public function postUpdate() {
        spr.x = x;
        spr.y = y;
        spr.scaleX = scale;
        spr.scaleY = scale;
        spr.rotation = rotation;

        if (cd.has("shake")) {
            spr.x += (Math.random() - 0.5) * 2 * 2 / scale;
            spr.y += (Math.random() - 0.5) * 2 * 2 / scale;
        }
    }

    public function tick() {

    }

    public function remove() {
        game.removeEntity(this);
    }

    public function dispose() {
        spr.remove();
    }

    public function shake(s) {
        cd.setS("shake", s);
    }
}