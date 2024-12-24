package game;

import h2d.Object;

class Entity extends TimeAware {
    public var game: Game;
    public var spr: Object;
    public var x: Float;
    public var y: Float;

    public var camera(get, never): Camera;
        function get_camera() {
            return game.camera;
        }
    
    public function new(?g: Game, ?layer) {
        if (g == null)
            g = Main.INST.game;
        game = g;
        game.addEntity(this);

        spr = new Object(layer ?? game.gameLayer);
    }

    public function preUpdate() {

    }

    public function update() {

    }

    public function postUpdate() {
        spr.x = x;
        spr.y = y;
    }

    public function tick() {

    }

    public function remove() {
        game.removeEntity(this);
    }

    public function dispose() {

    }
}