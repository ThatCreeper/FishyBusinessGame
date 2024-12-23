package src;

import h2d.domkit.Style;
import h2d.Tile;

class SampleView extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <sample-view class="box" layout="vertical">
            <text text={"Hello World!"}/>
            <bitmap src={tile} public id="mybmp"/>
        </sample-view>

    public function new(tile:h2d.Tile,?parent) {
        super(parent);
        initComponent();
    }
}

class Main extends hxd.App {
    public static var FPS: Float = 60;
    public static var GameSpeed: Float = 1;

    var cd: Cooldown;
    var tf: h2d.Text;
    var style: Style;

    override function init() {
        hxd.Res.initLocal();
        hxd.res.Resource.LIVE_UPDATE = true;
        style = new Style();
        style.load(hxd.Res.style);
        cd = new Cooldown();
        tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Hello World!";
        var view = new SampleView(Tile.fromColor(0xFF0000, 32, 32), s2d);
        view.mybmp.alpha = 0.8;
        style.addObject(view);
        cd.setS("down", 3);
    }

    override function update(dt:Float) {
        FPS = 1.0 / dt;
        cd.update(dt);

        // Render
        tf.text = 'FPS: $FPS';
        tf.y = cd.has("down") ? 100 : 0;
    }

    override function dispose() {
        super.dispose();
    }

    static function main() {
        new Main();
    }
}