package game.game;

import h2d.Tile;
import h2d.Bitmap;
import h2d.Graphics;
import h3d.mat.Texture;

class CircleMinigame extends Minigame {
    var drawing: Graphics;
    var person: Bitmap;
    var bar: Entity;

    var top = 0;
    var left = 0;
    var right = 0;
    var bottom = 0;
    
    public function new(?g) {
        super(g);

        drawing = new Graphics(spr);
        person = new Bitmap(Tile.fromColor(0x0000FF, 30, 30), spr);
        person.x = Math.random() * (640 * .8) + 640 * .1;
        person.y = Math.random() * (480 * .8) + 480 * .1;

        attach(new SimpleTimerBar(this, g));

        setMouseVisible();
    }

    override function update() {
        super.update();

        if (clicking()) {
            if (mouseMoved()) {
                drawing.beginFill(0x00FF00);
                drawing.drawRect(getMouseX(), getMouseY(), 5, 5);
                drawing.endFill();
            }

            top = changeFlag(top, onTop());
            left = changeFlag(left, onLeft());
            right = changeFlag(right, onRight());
            bottom = changeFlag(bottom, onBottom());

            if (allFlags() && oneFlagDouble()) {
                setMouseInvisible();
                win();
            }
        } else {
            drawing.clear();
            top = left = right = bottom = 0;
            setMouseVisible();
        }
    }

    function allFlags() {
        return top > 0 && left > 0 && right > 0 && bottom > 0;
    }

    function oneFlagDouble() {
        return top == 3 || left == 3 || right == 3 || bottom == 3;
    }

    function changeFlag(old, on) {
        if (old == 0 && on) return 1;
        else if (old == 1 && !on) return 2;
        else if (old == 2 && on) return 3;
        return old;
    }

    function onTop() return getMouseY() < person.y;
    function onLeft() return getMouseX() < person.x;
    function onBottom() return getMouseY() > person.y;
    function onRight() return getMouseX() > person.x;
}