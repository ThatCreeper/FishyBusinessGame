package game.store;

class StorePlayerEntity extends Entity {
    public function new(?g) {
        super(g);
    }

    override function update() {
        super.update();

        camera.sx = x;
        camera.sy = y;
    }
}