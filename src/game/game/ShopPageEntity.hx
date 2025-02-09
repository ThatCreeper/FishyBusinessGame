package game.game;

import h2d.Interactive;
import hxd.Key;
import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Object;
import h2d.Mask;

class ShopPageEntity extends Entity<ClickerGame> {
    var speed: ShopItemEntity;
    var quality: ShopItemEntity;
    var charity: ShopItemEntity;
    var typer: ShopItemEntity;
    var illust: ShopItemEntity;

    var parenter: Object;
    var interactive: Interactive;
    var dragging = false;
    var mouseY = 0.0;

    var csiid = 0;
    
    public function new(?g) {
        super(g);

        cd.setS("shake", 0.1);

        interactive = new Interactive(scrwid - 78, scrhei - 34, spr);
        interactive.x = 78;
        interactive.y = 34;
        interactive.cursor = Move;
        interactive.onWheel = x -> {
            parenter.y -= x.wheelDelta * 20;
            if (parenter.y > 34 + 15)
                parenter.y = 34 + 15;
        };
        interactive.onPush = x -> {
            dragging = true;
            mouseY = game.s2d.mouseY - parenter.y;
        };
        interactive.onRelease = x -> dragging = false;

        parenter = new Object(spr);
        parenter.x = 78 + 15;
        parenter.y = 34 + 15;
        
        speed = nextItem("Speed", "Send emails faster", 35);
        speed.forceshown = true;
        speed.onClick = () -> {
            if (speed.cost < 0)
                return;
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
        charity = nextItem("Charity", "Make a donation to a charity. Generally increases your reputation", 20);
        charity.onClick = () -> {
            charity.drain();
            game.charity();
        }
        typer = nextItem("Typist", "Hire / Upgrade an employee who sends emails ($1/6s, /2s)", 5);
        typer.onClick = () -> {
            if (typer.cost < 0)
                return;
            typer.drain();
            typer.forceshown = true;
            typer.cost *= 2;
            if (game.types == null) {
                game.types = {
                    timeuntil: 6,
                    resettime: 6,
                    cash: 1
                }
            } else {
                game.types.timeuntil /= 2;
                game.types.resettime /= 2;
                if (game.types.resettime <= 0) {
                    typer.cost = -1;
                    game.types.resettime = 1;
                }
            }
        }
        illust = nextItem("Artist", "More persuasive typist ($3/8s, upgrades dec time /2s)", 16);
        illust.onClick = () -> {
            if (illust.cost < 0)
                return;
            illust.drain();
            illust.forceshown = true;
            illust.cost *= 2;
            if (game.ilust == null) {
                game.ilust = {
                    timeuntil: 8,
                    resettime: 8,
                    cash: 3
                }
            } else {
                game.ilust.timeuntil /= 2;
                game.ilust.resettime /= 2;
                if (game.ilust.resettime <= 0) {
                    illust.cost = -1;
                    game.ilust.resettime = 1;
                }
            }
        }

        game.cashNode.textColor = 0x003B00;
    }

    function nextItem(n, d, c) {
        var i = new ShopItemEntity(this, game, parenter, n, d, c, csiid);
        csiid++;
        return i;
    }

    override function update() {
        super.update();

        game.bg.sc = 0xF1B3B3;

        game.cashNode.text = '$$${game.cash}';
        game.cashNode.x = M.lerpR(game.cashNode.x, scrwid - 15 - game.cashNode.textWidth, 0.5 * tmod);
        game.cashNode.y = M.lerpR(game.cashNode.y, (32 - game.cashNode.textHeight) / 2, 0.5 * tmod);
        game.cashNode.scaleX = game.cashNode.scaleY = M.lerp(game.cashNode.scaleX, 1, 0.5 * tmod);

        if (dragging) {
            parenter.y = game.s2d.mouseY - mouseY;
            if (parenter.y > 34 + 15)
                parenter.y = 34 + 15;
        }
    }

    override function postUpdate() {
        super.postUpdate();

        interactive.width = scrwid - 78;
        interactive.height = scrhei - 34;
    }
}