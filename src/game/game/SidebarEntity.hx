package game.game;

import h3d.mat.BlendMode;
import h2d.Graphics;
import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Tile;
import h2d.Bitmap;

class SidebarEntity extends Entity<ClickerGame> {
    var divPx: Bitmap;
    var divPx2: Bitmap;
    var divPxB: Bitmap;
    var divPxB2: Bitmap;
    var dark1: Bitmap;
    var dark2: Bitmap;
    var stoplights: Graphics;
    
    var highlight: Bitmap;

    var typing: SidebarItemEntity;
    var store: SidebarItemEntity;

    public var title: String;
    var titleEl: Text;
    var cashEl: Text;

    public function new(?g) {
        super(g);

        dark1 = new Bitmap(Tile.fromColor(0x000000, 1, 1, 0.15), spr);
        dark1.scaleY = 32;
        dark2 = new Bitmap(Tile.fromColor(0x000000, 1, 1, 0.15), spr);
        dark2.y = 32;
        dark2.scaleX = 76;

        divPx = new Bitmap(Tile.fromColor(0x000000), spr);
        divPx.x = 76;
        divPx.y = 32;
        divPx2 = new Bitmap(Tile.fromColor(0x000000), spr);
        divPx2.x = 76;
        divPx2.y = 32;
        divPxB = new Bitmap(Tile.fromColor(0x333333), spr);
        divPxB.blendMode = BlendMode.Add;
        divPxB.x = 77;
        divPxB.y = 33;
        divPxB2 = new Bitmap(Tile.fromColor(0x333333), spr);
        divPxB2.blendMode = BlendMode.Add;
        divPxB2.x = 77;
        divPxB2.y = 33;

        title = "Electro-Mail";

        titleEl = new Text(DefaultFont.get(), spr);
        titleEl.textColor = 0x000000;
        titleEl.x = 76;

        stoplights = new Graphics(spr);
        stoplights.beginFill(0xFF0000);
        stoplights.lineStyle(1, 0xAA0000);
        stoplights.drawCircle(1 * 76 / 4, 32 / 2, 6);
        stoplights.beginFill(0xFFFF00);
        stoplights.lineStyle(1, 0xAAAA00);
        stoplights.drawCircle(2 * 76 / 4, 32 / 2, 6);
        stoplights.beginFill(0x00FF00);
        stoplights.lineStyle(1, 0x00AA00);
        stoplights.drawCircle(3 * 76 / 4, 32 / 2, 6);
        stoplights.endFill();

        highlight = new Bitmap(Tile.fromColor(0xFFFFFF, 64, 64), spr);
        typing = new SidebarItemEntity(g);
        typing.y = highlight.y = getY(0);
        typing.x = highlight.x = 6;
        typing.onClick = () -> game.typingPage();
        
        typing = new SidebarItemEntity(g);
        typing.y = getY(1);
        typing.x = 6;
        typing.onClick = () -> game.storePage();
    }

    function getY(id) {
        return 32 + 16 * (id + 1) + 64 * id;
    }

    override function update() {
        super.update();
    }

    override function postUpdate() {
        super.postUpdate();

        divPx.scaleY = scrhei;
        divPx2.scaleX = scrwid;
        divPxB.scaleY = scrhei;
        divPxB2.scaleX = scrwid;
        dark1.scaleX = scrwid;
        dark2.scaleY = scrhei;
        titleEl.text = title;
        titleEl.y = (32 - titleEl.textHeight) / 2;

        highlight.y = M.lerpR(highlight.y, getY(game.page.getIndex()), 0.1 * tmod);
    }
}