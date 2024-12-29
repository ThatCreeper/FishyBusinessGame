package game.game;

import h2d.Interactive;
import h2d.Tile;
import h2d.Bitmap;

class SidebarItemEntity extends Entity<ClickerGame> {
    var bitmap: Bitmap;
    var highlight: Bitmap;
    var interactive: Interactive;
    var highlighted = false;

    public function new(?g) {
        super(g);

        highlight = new Bitmap(Tile.fromColor(0x000000, 64, 64, 0.5), spr);
        bitmap = new Bitmap(Tile.fromColor(0x000000, 64, 64, 0.5), spr);
        interactive = new Interactive(64, 64, bitmap);
        interactive.onOver = x -> highlighted = true;
        interactive.onOut = x -> highlighted = false;
        interactive.onClick = x -> onClick();

        highlight.alpha = 0;
    }

    override function postUpdate() {
        super.postUpdate();

        highlight.alpha = M.lerp(highlight.alpha, highlighted ? 1.0 : 0.0, 0.1 * tmod);
    }

    public dynamic function onClick() {

    }
}