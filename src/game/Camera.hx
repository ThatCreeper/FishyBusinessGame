package game;

class Camera {
    public var x: Float = 0;
    public var y: Float = 0;
    public var scale: Float = 0;

    public function new() {
        
    }

    public function update(s: h2d.Scene, shaking: Bool) {
        var c = s.camera;
        c.anchorX = 0.5;
        c.anchorY = 0.5;
        c.scaleX = scale;
        c.scaleY = scale;
        c.x = x;
        c.y = y;

        if (shaking) {
            c.x += (Math.random() - 0.5) * 2 * 2 / scale;
            c.y += (Math.random() - 0.5) * 2 * 2 / scale;
        }
    }
}