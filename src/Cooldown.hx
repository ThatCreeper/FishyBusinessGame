package src;

// Vaguely based on the dnLibs api
class Cooldown {
    var map: Map<String, Float>;
    
    public function new() {
        map = new Map();
    }

    public function setS(cd: String, s: Float) {
        map.set(cd, s);
    }

    public function setF(cd: String, f: Float) {
        setS(cd, f / Main.FPS);
    }

    public function update(dt: Float) {
        for (x in map.keyValueIterator()) {
            var n = x.value -= dt * Main.GameSpeed;
            if (n <= 0)
                map.remove(x.key);
            else
                map.set(x.key, n);
        }
    }

    public function has(cd: String) {
        return map.exists(cd);
    }

    public function hasSetF(cd: String, f: Float) {
        if (has(cd))
            return true;
        setF(cd, f);
        return false;
    }

    public function hasSetS(cd: String, s: Float) {
        if (has(cd))
            return true;
        setS(cd, s);
        return false;
    }
}