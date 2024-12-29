package game.game;

import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Object;
import h2d.Mask;

class ShopPageEntity extends Entity<ClickerGame> {
    var speed: ShopItemEntity;
    var quality: ShopItemEntity;
    var parenter: Object;
    var money: Text;

    var csiid = 0;
    
    public function new(?g) {
        super(g);

        cd.setS("shake", 0.1);

        parenter = new Object(spr);
        parenter.x = 78 + 15;
        parenter.y = 34 + 15;
        
        speed = nextItem("Speed", "Send emails faster", 35);
        speed.forceshown = true;
        speed.onClick = () -> {
            speed.drain();
            game.lettersToPost--;
            if (game.lettersToPost <= 10) {
                speed.cost = -1;
            }
        }
        quality = nextItem("Quality", "Improve the convincingness of your emails", 100);
        quality.onClick = () -> {
            quality.drain();
            game.cashPerEmail++;
        }

        money = new Text(DefaultFont.get(), g.hudLayer);
        money.textColor = 0x003B00;
    }

    function nextItem(n, d, c) {
        var i = new ShopItemEntity(this, game, parenter, n, d, c, csiid);
        csiid++;
        return i;
    }

    override function update() {
        super.update();

        game.bg.sc = 0xF1B3B3;

        money.text = '$$${game.cash}';
        money.x = scrwid - 15 - money.textWidth;
        money.y = (32 - money.textHeight) / 2;
    }

    override function postUpdate() {
        super.postUpdate();
    }

    override function dispose() {
        super.dispose();
        money.remove();
    }
}