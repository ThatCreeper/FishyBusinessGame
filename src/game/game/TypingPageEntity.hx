package game.game;

import hxd.res.DefaultFont;
import h2d.Text;
import h2d.Tile;
import h2d.Bitmap;
import hxd.Key;

class TypingPageEntity extends Entity<ClickerGame> {
    var wid = 0.0;
    var barbg: Bitmap;
    var bar: Bitmap;
    var bgr = 0.0;
    var bgg = 0.0;
    var bgb = 0.0;
    var cashtext: Text;
    var samanthatext: Text;
    var emailsent: Text;
    var textrx = 0.0;
    var textry = 0.0;

    static var samantha = "Dearest Samantha, You are recieveing this electronic email because you are subjject to a large winning of $10,00,000 dollars from the King of England due to your knighthood. YOu are set to be knighted on the twenty-first night of september (but not like the song). In order to come to the event you must pay a holding fee of two hundred dollars. Thank you. New sign in to Steam From your account \"mark\"Location of sign in: Chicago, IL, US Authorized by: Steam Mobile Authenticator confirmation. If the details above look familiar, you can safely ignore this email. If not, please reset your Steam password now. https://steampasswordreset.biz. Cheers, The Steam Team. ";
    
    public function new(?g) {
        super(g);

        samanthatext = new Text(DefaultFont.get(), spr);
        samanthatext.x = 76;
        samanthatext.y = 32;
        samanthatext.textColor = 0x000000;
        samanthatext.alpha = 0.3;

        barbg = new Bitmap(Tile.fromColor(0xFFFFFF), spr);
        barbg.scaleX = 250;
        barbg.scaleY = 32;
        bar = new Bitmap(Tile.fromColor(0x639FEE), spr);
        bar.scaleX = 0;
        bar.scaleY = 32;

        var fn = DefaultFont.get().clone();
        fn.resizeTo(36);
        cashtext = new Text(fn, spr);
        cashtext.textColor = 0x034E03;
        
        // for (x in 0...game.totalletters) {
        //     samanthatext.text += samantha.charAt(x % samantha.length);
        // }

        fn = DefaultFont.get().clone();
        fn.resizeTo(16);
        emailsent = new Text(fn, spr);
        emailsent.textColor = 0x639FEE;
        emailsent.text = "Email sent!";
        emailsent.rotation = 0.2;
        emailsent.dropShadow = {
            dx: 1,
            dy: 1,
            alpha: 0.7,
            color: 0x000000
        };

        cd.setS("shake", 0.1);
    }

    override function update() {
        super.update();

        game.bg.sc = 0xF1F6E4;
    
        var pressed = @:privateAccess Key.keyPressed;
        for (i in 7...pressed.length) {
            if (Key.isPressed(i)) {
                game.letters++;
                samanthatext.text += samantha.charAt(game.totalletters % samantha.length);
                game.totalletters++;
            }
        }

        if (game.letters > game.lettersToPost) {
            game.letters = 0;
            wid = 0;
            bgr = 0x63 / 0xFF;
            bgg = 0x9F / 0xFF;
            bgb = 0xEE / 0xFF;
            game.sendmail();
            cd.setS("shake", 0.1);
            cd.setS("sent", 0.3);
            textrx = Math.random() * 250;
            textry = Math.random() * 32;
        }

        wid = M.lerp(wid, game.letters / game.lettersToPost, 0.15 * tmod);
        bgr = M.lerp(bgr, 0, 0.1 * tmod);
        bgg = M.lerp(bgg, 0, 0.1 * tmod);
        bgb = M.lerp(bgb, 0, 0.1 * tmod);

        barbg.x = bar.x = 76 + (scrwid - 76 - 250) / 2;
        barbg.y = bar.y = 32 + (scrhei - 32 - 32) / 2;
        bar.scaleX = wid * 250;
        barbg.color.r = bgr;
        barbg.color.g = bgg;
        barbg.color.b = bgb;

        emailsent.x = barbg.x - 8 + textrx;
        emailsent.y = barbg.y - 8 + textry;
        emailsent.visible = cd.has("sent");

        cashtext.text = '$$${game.cash}';
        cashtext.x = 76 + (scrwid - 76 - cashtext.textWidth) / 2;
        cashtext.y = 32 + (scrhei - 32) / 3 - cashtext.textHeight / 2;
        
        samanthatext.maxWidth = scrwid - 76;
    }
}