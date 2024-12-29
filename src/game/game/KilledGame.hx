package game.game;

import hxd.res.DefaultFont;
import h2d.Text;

class KilledGame extends Game {
    public var other: ClickerGame;
    public var bg: BackgroundEntity<KilledGame>;
    public var t: Text;
    
    public function new(o: ClickerGame) {
        super();
        other = o;
        camera.centered = false;
        bg = new BackgroundEntity(this);
        bg.c = 0xFF0000;
        var fon = DefaultFont.get().clone();
        fon.resizeTo(24);
        t = new Text(fon, s2d);
        t.text = 'You got shot!\nYou had $$${o.cash}\npeaking at $$${o.mostcash}\nfor a total of $$${o.totalcash} earned';
        t.textAlign = Align.Center;
    }

    override function update() {
        super.update();
        t.x = scrwid / 2;
        t.y = (scrhei - t.textHeight) / 2;
    }
}