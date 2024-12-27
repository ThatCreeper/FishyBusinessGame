package game.store;

import h2d.Graphics;

class StoreComputerEntity extends Entity<StoreGame> {
    var player: StorePlayerEntity;
    var graphics: Graphics;

    public function new(p, ?g) {
        super(g, g.hudLayer);
        player = p;

        graphics = new Graphics(spr);
        graphics.beginFill(0x797979);
        graphics.drawRect(-80, -50, 160, 100);
        graphics.endFill();
    }

    override function preUpdate() {
        super.preUpdate();
        player.ucd.setF("freeze", 1);
    }

    override function update() {
        super.update();
    }

    override function postUpdate() {
        x = camera.x;
        y = camera.y;
        super.postUpdate();
    }
}