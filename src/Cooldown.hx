package src;

// Vaguely based on the dnLibs api
class Cooldown {
    var smap: Map<String, Float>;
    var fmap: Map<String, Float>;
    
    public function new() {
        smap = new Map();
        fmap = new Map();
    }

    public function setS(cd: String, s: Float) {
        if (remDurS(cd) >= s)
            return;
        smap.set(cd, s);
    }

    public function setF(cd: String, f: Float) {
        if (remDurF(cd) >= f)
            return;
        fmap.set(cd, f);
    }

    public function update(dt: Float, speed: Float, skipFrame = false) {
        for (x in smap.keyValueIterator()) {
            var n = x.value - dt;
            if (n <= 0)
                smap.remove(x.key);
            else
                smap.set(x.key, n);
        }
        if (skipFrame)
            return;
        for (x in fmap.keyValueIterator()) {
            var n = x.value - speed;
            if (n <= 0)
                fmap.remove(x.key);
            else
                fmap.set(x.key, n);
        }
    }

    public function has(cd: String) {
        return smap.exists(cd) || fmap.exists(cd);
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

    public function remDurS(cd: String) {
        var v;
        v = smap.get(cd);
        if (v != null)
            return v;
        v = fmap.get(cd);
        if (v != null)
            return v / Main.FPS;
        return 0;
    }

    public function remDurF(cd: String) {
        var v;
        v = fmap.get(cd);
        if (v != null)
            return v;
        v = smap.get(cd);
        if (v != null)
            return v * Main.FPS;
        return 0;
    }
}