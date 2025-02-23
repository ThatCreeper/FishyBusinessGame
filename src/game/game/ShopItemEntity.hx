package game.game;

import hxd.Key;
import h2d.col.Point;
import h2d.Object;
import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Interactive;
import h2d.filter.DropShadow;
import h2d.Graphics;
import h2d.Bitmap;

class ShopItemEntity extends Entity<ClickerGame> {
    public var idx = 0;
    
    var page: ShopPageEntity;

    var bg: Graphics;
    var inter: Interactive;
    var dsfilter: DropShadow;
    var title: Text;
    var desc: Text;
    var costText: Text;

    var popupHolder: Object;
    var nocashText: Text;
    var boughtText: Text;

    var rhovered = 0.0;
    var shovered = 0.0;
    var rncs = 1.0;
    var rbs = 1.0;

    var dragging = false;
    var draggingX = 0.0;
    var draggingY = 0.0;
    var sdragrot = 0.0;
    var rdragrot = 0.0;

    var rtx = 0.0;
    var rty = 0.0;

    public var cost: Float;
    public var forceshown = false;
    var name: String;
    var description: String;

    public function new(e, ?g, p, n, d, c, id) {
        super(g, p);
        page = e;
        e.attach(this);

        //x = (scrwid - 78 - 15) / 2;
        x = -(78 + 15) - 100;

        idx = id;

        name = n;
        description = d;

        bg = new Graphics(spr);
        bg.beginFill(0xFFDBDB, 1);
        bg.drawRect(-50, -80, 100, 160);
        bg.endFill();
        bg.x = 50;
        bg.y = 80;
        bg.filter = dsfilter = new DropShadow(4, Math.PI / 4, 0, 0.3, 0.8);

        inter = new Interactive(100, 160, bg);
        inter.x = -50;
        inter.y = -80;
        inter.onOver = x -> if (!dragging) shovered = 1.0;
        inter.onOut = x -> if (!dragging) shovered = 0.0;
        inter.onPush = x -> {
            shovered = -1.0;
            dragging = !purchaseable();
            draggingX = game.s2d.mouseX - this.x;
            draggingY = game.s2d.mouseY - this.y;
        }
        inter.onRelease = x -> {
            shovered = 0.0;
            dragging = false;
        }
        inter.onClick = x -> {
            if (purchaseable()) {
                onClick();
                if (Key.isDown(Key.SHIFT)) {
                    while (purchaseable())
                        onClick();
                }
                cd.setS("bought", 1);
                cd.reset("nocash");
                rbs = 0.8;
            } else {
                cd.setS("nocash", 1);
                cd.reset("bought");
                rncs = 0.8;
            }
        }

        var bfnt = DefaultFont.get().clone();
        bfnt.resizeTo(bfnt.size * 2);
        title = new Text(bfnt, bg);
        title.text = n;
        desc = new Text(DefaultFont.get(), bg);
        desc.text = d;
        costText = new Text(bfnt, bg);

        title.y = -80 + 5;
        title.textAlign = Align.Center;
        title.textColor = 0x000000;
        
        desc.y = title.y + title.textHeight + 5;
        desc.x = -50;
        desc.textAlign = Align.Center;
        desc.maxWidth = 100;
        desc.textColor = 0x000000;

        costText.y = 80 - 5 - costText.textHeight;
        costText.textAlign = Align.Center;
        costText.textColor = 0x000000;

        cost = c;

        popupHolder = new Object(spr);

        nocashText = new Text(bfnt, popupHolder);
        nocashText.x = 50;
        nocashText.y = (160 - nocashText.textHeight) / 2;
        nocashText.textAlign = Align.Center;
        nocashText.textColor = 0xFB6D6D;
        nocashText.dropShadow = {
            dx: 1,
            dy: 1,
            alpha: 0.7,
            color: 0x000000
        };
        nocashText.text = "No cash!";
        nocashText.visible = false;
        
        boughtText = new Text(bfnt, popupHolder);
        boughtText.x = 50;
        boughtText.y = (160 - boughtText.textHeight) / 2;
        boughtText.textAlign = Align.Center;
        boughtText.textColor = 0x70D2FF;
        boughtText.dropShadow = {
            dx: 1,
            dy: 1,
            alpha: 0.7,
            color: 0x000000
        };
        boughtText.text = "Bought!";
        boughtText.visible = false;
    }

    function purchaseable() {
        return cost >= 0 && cost <= game.cash;
    }

    function shown() {
        return (forceshown || game.mostcash >= cost);
    }

    function setXY(nx, ny) {
        rtx = nx * 115;
        rty = ny * 175;
        x = M.lerpR(x, rtx, 0.3 * tmod);
        y = M.lerpR(y, rty, 0.3 * tmod);
    }

    override function update() {
        super.update();

        var usablewid = scrwid - 78 - 15;
        var maxX = Math.floor(usablewid / 115);
        if (maxX < 1)
            maxX = 1;
        if (dragging) {
            var lx = x;
            var ly = y;
            var nx = game.s2d.mouseX;// - draggingX;
            var ny = game.s2d.mouseY;// - draggingY;
            var p = new Point(nx, ny);
            spr.parent.globalToLocal(p);
            x = M.lerpR(x, p.x - 50, 0.5 * tmod);
            y = M.lerpR(y, p.y - 80, 0.5 * tmod);
            sdragrot = (x - lx) * 0.03;
        } else {
            setXY(idx % maxX, Math.floor(idx / maxX));
            sdragrot = 0;
        }

        popupHolder.x = rtx - x;
        popupHolder.y = rty - y;
        rncs = M.lerp(rncs, 1, 0.3 * tmod);
        nocashText.scaleX = rncs;
        nocashText.scaleY = rncs;
        nocashText.visible = cd.has("nocash");
        rbs = M.lerp(rbs, 1, 0.3 * tmod);
        boughtText.scaleX = rbs;
        boughtText.scaleY = rbs;
        boughtText.visible = cd.has("bought");
        
        bg.alpha = (shown() && purchaseable()) ? 1 : 0.5;

        if (shown()) {
            title.text = name;
            desc.text = description;
        } else {
            title.text = "???";
            desc.text = "???";
        }

        rdragrot = M.lerp(rdragrot, sdragrot, 0.15 * tmod);
        rhovered = M.lerp(rhovered, shovered, 0.15 * tmod);
        bg.rotation = rhovered * 0.01 + rdragrot;
        bg.scaleX = bg.scaleY = 1 + rhovered * 0.1;
        dsfilter.distance = Math.max(0, 4 + rhovered * 16);

        costText.text = cost < 0 ? "None" : '$$$cost';
    }

    public dynamic function onClick() {
        trace("hi");
    }

    public function drain() {
        game.cash -= cost;
    }
}