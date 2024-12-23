package src;

import h3d.Engine;
import src.Cooldown;

class Main extends hxd.App {
    public static var FPS: Float = 60;
    public static var GameSpeed: Float = 1;

    var cd: Cooldown;
    var tf: h2d.Text;

    override function init() {
        cd = new Cooldown();
        tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Hello World!";
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