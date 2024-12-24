package src;

class Entity extends TimeAware {
    public var game(get, never): Game;
        function get_game() {
            return Main.INST.game;
        }
    
    public function new(?g: Game) {
        if (g == null)
            g = game;
        g.addEntity(this);
    }

    public function preUpdate() {

    }

    public function update() {

    }

    public function postUpdate() {

    }

    public function remove() {
        game.removeEntity(this);
    }

    public function dispose() {

    }
}