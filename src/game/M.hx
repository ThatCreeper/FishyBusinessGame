package game;

class M {
    public static function lerp(from: Float, to: Float, x: Float) {
        return from + (to - from) * x;
    }

    public static function lerpR(from: Float, to: Float, x: Float) {
        var l = lerp(from, to, x);
        if (Math.abs(l - to) < 1)
            return to;
        return l;
    }

    public static function lerpI(from: Int, to: Int, x: Float): Int {
        return from + cast ((to - from) * x);
    }

    public static function rng(min: Float, max: Float) {
        return lerp(min, max, Math.random());
    }

    public static function clamp(x: Float, min: Float, max: Float) {
        return Math.min(Math.max(min, x), max);
    }

    public static function rectsOverlap(x1: Float, y1: Float, x2: Float, y2: Float, x3: Float, y3: Float, x4: Float, y4: Float) {
        return x1 <= x4 && x2 >= x3 &&
               y1 <= y4 && y2 >= y3;
    }
}