package game;

import h2d.Scene;
import game.titlescreen.TitleScreenGame;

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

    public static var INST: Main;

    public var ucd: Cooldown;
    public var game: Game;

    var timeSinceTick = 0.0;

    override function init() {
        INST = this;
        hxd.Res.initLocal();
        #if debug
        hxd.res.Resource.LIVE_UPDATE = true;
        #end

        ucd = new Cooldown();
        
        setGame(new TitleScreenGame());
    }

    public static function newScene(): Scene {
        var s = new Scene();
        Main.INST.setScene2D(s);
        return s;
    }

    public static function setGame(game) {
        INST.game?.dispose();
        INST.game = game;
    }

    public function freezeFrame() {
        ucd.setF('frozen', 4);
    }

    override function update(dt:Float) {
        FPS = 1.0 / dt;
        ucd.update(dt, 1);

        GameSpeed = ucd.has('frozen') ? 0.1 : UserGameSpeed;

        game.preUpdate();
        game.update();

        timeSinceTick += dt * GameSpeed;
        while (timeSinceTick >= 1 / TickRate) {
            timeSinceTick -= 1 / TickRate;
            game.tick();
        }

        game.postUpdate();
    }

    override function dispose() {
        game.dispose();
        super.dispose();
    }

    static function main() {
        new Main();
    }
}