package game;

class Game extends TimeAware {
    public var entities: List<Entity>;
    public var hudLayer: h2d.Object;
    public var bgLayer: h2d.Object;
    public var gameLayer: h2d.Object;
    public var s2d: h2d.Scene;
    public var camera: Camera;

    public function new() {
        initLayers();
        entities = new List();
    }

    function initLayers() {
        s2d = Main.newScene();
        hudLayer = new h2d.Object();
        bgLayer = new h2d.Object();
        gameLayer = new h2d.Object();
        s2d.add(bgLayer, 0);
        s2d.add(gameLayer, 1);
        s2d.add(hudLayer, 2);
    }
    
    public function preUpdate() {
        for (e in entities)
            e.preUpdate();
    }

    public function update() {
        for (e in entities)
            e.update();
    }

    public function postUpdate() {
        for (e in entities)
            e.postUpdate();
        camera.update(s2d);
    }

    public function tick() {
        for (e in entities)
            e.tick();
    }

    public function dispose() {
        for (e in entities)
            e.dispose();
    }

    public function removeEntity(e) {
        entities.remove(e);
        e.dispose();
    }

    public function addEntity(e: Entity) {
        entities.add(e);
    }

    public function shake(s) {
        cd.setS("shake", s);
    }
}