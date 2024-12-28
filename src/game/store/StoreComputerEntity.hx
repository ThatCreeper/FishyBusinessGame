package game.store;

import h2d.Interactive;
import h2d.Graphics;

class StoreComputerEntity extends Entity<StoreGame> {
    var player: StorePlayerEntity;
    var graphics: Graphics;
    var cross: Graphics;
    var crossi: Interactive;

    public function new(p, ?g) {
        super(g, g.hudLayer);
        player = p;

        graphics = new Graphics(spr);
        graphics.beginFill(0x797979);
        graphics.drawRect(-80, -50, 160, 100);
        graphics.endFill();
        graphics.lineStyle(1, 0xFFFFFF);
        graphics.moveTo(80 - (16 + 7) / 2, -50 + 1);
        graphics.lineTo(80 - (16 - 7) / 2, -50 + 7);
        graphics.moveTo(80 - (16 + 7) / 2, -50 + 7);
        graphics.lineTo(80 - (16 - 7) / 2, -50 + 1);

        cross = new Graphics(spr);
        cross.beginFill(0xFF0000);
        cross.drawRect(80 - 16, -50, 16, 8);
        cross.endFill();
        cross.lineStyle(1, 0x000000);
        cross.moveTo(80 - (16 + 7) / 2, -50 + 1);
        cross.lineTo(80 - (16 - 7) / 2, -50 + 7);
        cross.moveTo(80 - (16 + 7) / 2, -50 + 7);
        cross.lineTo(80 - (16 - 7) / 2, -50 + 1);
        cross.alpha = 0;

        crossi = new Interactive(16, 8, cross);
        crossi.x = 80 - 16;
        crossi.y = -50;
        crossi.onOver = x -> cross.alpha = 1;
        crossi.onOut = x -> cross.alpha = 0;
        crossi.onClick = x -> remove();
    }

    override function preUpdate() {
        super.preUpdate();
        player.ucd.setF("frozen", 1);
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