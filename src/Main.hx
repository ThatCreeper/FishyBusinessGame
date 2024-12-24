package src;

import h2d.Layers;
import h2d.domkit.Style;
import h2d.Tile;

class Main extends hxd.App {
    public static var FPS: Float = 60;
    public static var GameSpeed: Float = 1;

    public var cd: Cooldown;
    public var hud: Hud;
    var tf: h2d.Text;
    public var hudLayer: h2d.Object;
    public var bgLayer: h2d.Object;
    public var gameLayer: h2d.Object;

    override function init() {
        hxd.Res.initLocal();
        hxd.res.Resource.LIVE_UPDATE = true;

        cd = new Cooldown();
        
        initLayers();
        
        tf = new h2d.Text(hxd.res.DefaultFont.get(), gameLayer);
        tf.text = "Hello World!";
        cd.setS("down", 3);

        hud = new Hud(hudLayer);
        
    }

    function initLayers() {
        hudLayer = new h2d.Object();
        bgLayer = new h2d.Object();
        gameLayer = new h2d.Object();
        s2d.add(bgLayer, 0);
        s2d.add(gameLayer, 1);
        s2d.add(hudLayer, 2);
    }

    override function update(dt:Float) {
        FPS = 1.0 / dt;
        cd.update(dt);

        // Render
        tf.text = 'FPS: $FPS';
        tf.y = cd.has("down") ? 100 : 0;
    }

    override function dispose() {
        hud.dispose();
        super.dispose();
    }

    static function main() {
        new Main();
    }
}