package src;

import hxd.Key;
import h2d.Layers;
import h2d.domkit.Style;
import h2d.Tile;

class Main extends hxd.App {
    public static var FPS: Float = 60;
    public static var GameSpeed: Float = 1;
    public static var UserGameSpeed: Float = 1;
    public static var TickRate = 60;
    public static var tmod(get, never): Float;
    public static var utmod(get, never): Float;
    public static function get_tmod(): Float {
        return utmod * GameSpeed;
    }
    public static function get_utmod(): Float {
        return 60 / FPS;
    }

    public var ucd: Cooldown;
    public var hud: Hud;
    var tf: h2d.Text;
    public var hudLayer: h2d.Object;
    public var bgLayer: h2d.Object;
    public var gameLayer: h2d.Object;
    var FRAMES = 0;

    var timeSinceTick = 0.0;

    override function init() {
        hxd.Res.initLocal();
        hxd.res.Resource.LIVE_UPDATE = true;

        ucd = new Cooldown();
        
        initLayers();
        
        tf = new h2d.Text(hxd.res.DefaultFont.get(), gameLayer);
        tf.text = "Hello World!";
        // ucd.setS("down", 3);

        hud = new Hud(hudLayer);
        
    }

    function initLayers() {
        setScene2D(new h2d.Scene());
        hudLayer = new h2d.Object();
        bgLayer = new h2d.Object();
        gameLayer = new h2d.Object();
        s2d.add(bgLayer, 0);
        s2d.add(gameLayer, 1);
        s2d.add(hudLayer, 2);
    }

    public function freezeFrame() {
        ucd.setF('frozen', 4);
    }

    override function update(dt:Float) {
        FPS = 1.0 / dt;
        ucd.update(dt, 1);

        GameSpeed = ucd.has('frozen') ? 0.1 : UserGameSpeed;

        if (ucd.has('frozen'))
            FRAMES++;

        if (Key.isPressed(Key.A))
            freezeFrame();

        timeSinceTick += dt * GameSpeed;
        while (timeSinceTick >= 1 / TickRate) {
            timeSinceTick -= 1 / TickRate;
        }

        // Render
        if (GameSpeed > 0.1)
            tf.text = 'FPS: $FPS Frames: $FRAMES';
        tf.y = ucd.has("down") ? 100 : 0;
    }

    override function dispose() {
        hud.dispose();
        super.dispose();
    }

    static function main() {
        new Main();
    }
}