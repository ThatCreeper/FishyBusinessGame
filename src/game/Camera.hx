package game;

class Camera extends TimeAware {
    public var x(get, set): Float;
        function get_x() {
            return rx;
        }
        function set_x(v) {
            return rx = sx = v;
        }
    public var y(get, set): Float;
        function get_y() {
            return ry;
        }
        function set_y(v) {
            return ry = sy = v;
        }
    public var sx = 0.0;
    public var sy = 0.0;
    var rx: Float = 0;
    var ry: Float = 0;
    public var scale: Float = 1;

    public function new() {
        
    }

    public function update(s: h2d.Scene, shaking: Bool) {
        rx = M.lerp(rx, sx, 0.2 * tmod);
        ry = M.lerp(ry, sy, 0.2 * tmod);
        
        var c = s.camera;
        c.anchorX = 0.5;
        c.anchorY = 0.5;
        c.scaleX = scale;
        c.scaleY = scale;
        c.x = rx;
        c.y = ry;

        if (shaking) {
            c.x += (Math.random() - 0.5) * 2 * 2 / scale;
            c.y += (Math.random() - 0.5) * 2 * 2 / scale;
        }
    }
}