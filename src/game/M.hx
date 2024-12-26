package game;

class M {
    public static function lerp(from: Float, to: Float, x: Float) {
        return from + (to - from) * x;
    }

    public static function rng(min: Float, max: Float) {
        return lerp(min, max, Math.random());
    }

    public static function clamp(x: Float, min: Float, max: Float) {
        return Math.min(Math.max(min, x), max);
    }
}