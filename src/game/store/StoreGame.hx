package game.store;

import h3d.Engine;

class StoreGame extends Game {
    public function new() {
        super();

        new StorePlayerEntity(this);
    }

    override function update() {
        super.update();

        Engine.getCurrent().backgroundColor = 0xFFFFFF;
    }
}