package game.game;

import h2d.Tile;
import h2d.Bitmap;
import hxd.res.DefaultFont;
import h2d.Text;
import hxd.Key;

class HackerPageEntity extends Entity<ClickerGame> {
    static var wakeup = "<mr phish> WAKE UP\n";
    static var confirmed = "<xXhackermanXx> ugh i'll do something fine bro\n";
    static var motd = [
        "MOTD: Money has to come from somewhere\n",
        "MOTD: People don't like it when you hurt them\n",
        "MOTD: France exists\n",
        "MOTD: I could go for a sandwich\n",
        "MOTD: haxe\n"
    ];

    var text: Text;
    var bar: Bitmap;
    var hpts: Text;

    public function new(?g) {
        super(g);
        
        cd.setS("shake", 0.1);

        text = new Text(DefaultFont.get(), spr);
        text.x = 78;
        var rnd = Math.floor(Math.random() * motd.length);
        text.text = motd[rnd];
        text.textColor = 0x00FF00;
        text.y = scrhei - text.textHeight;

        bar = new Bitmap(Tile.fromColor(0x00FF00), spr);
        bar.scaleX = 32;

        var fnt = DefaultFont.get().clone();
        fnt.resizeTo(24);
        hpts = new Text(fnt, spr);
        hpts.textColor = 0x00FF00;
        hpts.dropShadow = {
            dx: 1,
            dy: 1,
            alpha: 1,
            color: 0x100009
        };
        hpts.x = 78;
        hpts.y = 34;
    }

    override function update() {
        super.update();

        game.bg.sc = 0x100009;
        
        var pressed = @:privateAccess Key.keyPressed;
        for (i in 7...pressed.length) {
            if (Key.isPressed(i)) {
                game.hackerProg += 1 / 20;
                text.text += wakeup;
            }
        }

        if (game.hackerProg > 1) {
            game.hackerProg = 0;
            text.text += confirmed;
            game.hackerPts++;
        }

        text.y = M.lerp(text.y, scrhei - text.textHeight, 0.3 * tmod);
        bar.scaleY = (scrhei - 34) * game.hackerProg;
        bar.y = scrhei - bar.scaleY;
        bar.x = scrwid - 32;
        hpts.text = 'H${game.hackerPts}';
    }
}