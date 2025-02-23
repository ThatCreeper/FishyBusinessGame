package game.game;

import hxd.Window;

@:access(h2d.Scene)
class MindWaveGame extends Game {
    var minigame: Minigame;
    var transition: Transition;
    var nextGame: MinigameProvider;

    public function new() {
        super();
        camera.centered = false;
        s2d.scaleMode = LetterBox(640, 480);
        s2d.events.defaultCursor = Hide;

        setTransition(() -> new Transition(this));
    }

    public function setTransition(e: ()->Transition) {
        nextGame = new CircleMinigameProvider();
        if (minigame != null)
            minigame.remove();
        minigame = null;
        transition = e();
    }

    public function getNextMinigame() {
        return nextGame;
    }

    public function startMinigame() {
        transition.remove();
        transition = null;
        centerMouse();
        minigame = nextGame.make();
    }

    function centerMouse() {
        var win = Window.getInstance();
        win.setCursorPos(Math.floor(win.width / 2), Math.floor(win.height / 2), true);
    }
}