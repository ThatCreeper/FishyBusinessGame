package game.game;

import hxd.Key;

class Minigame extends Entity<MindWaveGame> {
    var _mouse: MouseEntity = null;
    var _lastMouseX = -10000;
    var _lastMouseY = -10000;
    var _frameMouseMoved = false;
    public var timer = 5.0;
    public var maxTimer = 5.0;
    public var finished(default, null) = false;
    public var success = true;

    public function new(?g) {
        super(g);
    }

    override function preUpdate() {
        super.preUpdate();

        _frameMouseMoved = false;
        var mx = getMouseX();
        var my = getMouseY();
        if (mx != _lastMouseX || my != _lastMouseY)
            _frameMouseMoved = true;
        _lastMouseX = mx;
        _lastMouseY = my;
    }

    override function update() {
        super.update();

        timer -= deltaTime;
        if (timer <= 0) {
            if (!finished)
                fail();
            game.setTransition(() -> new Transition());
        }
    }

    public function getMouseX() {
        return Math.floor(game.s2d.mouseX);
    }

    public function getMouseY() {
        return Math.floor(game.s2d.mouseY);
    }

    public function setMouseVisible() {
        if (_mouse != null) return;
        _mouse = new MouseEntity(game, this);
        attach(_mouse);
    }

    public function setMouseInvisible() {
        if (_mouse == null) return;
        _mouse.remove();
        _mouse = null;
    }

    public function clicking() {
        return Key.isDown(Key.MOUSE_LEFT);
    }

    public function mouseMoved() {
        return _frameMouseMoved;
    }

    public function win() {
        if (finished)
            return;
        finished = true;
        success = true;
        maxTimer = 1 / (timer / maxTimer);
        timer = Math.min(timer, 1);
    }

    public function fail() {
        if (finished)
            return;
        finished = true;
        success = false;
        maxTimer = 1 / (timer / maxTimer);
        timer = Math.min(timer, 1);
    }
}