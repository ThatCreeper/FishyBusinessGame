package src;

import h2d.Tile;
import h2d.domkit.Style;

class SampleView extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <sample-view class="box" layout="vertical">
            <text text={"Hello World!"}/>
            <bitmap src={tile} public id="mybmp"/>
        </sample-view>

    public function new(tile:h2d.Tile,?parent) {
        super(parent);
        initComponent();
    }
}

class Hud {
    var style: Style;
    var view: SampleView;

    public function new(?parent) {
        style = new Style();
        style.load(hxd.Res.style);
        style.allowInspect = true;
        view = new SampleView(Tile.fromColor(0xFF0000, 32, 32), parent);
        view.mybmp.alpha = 0.8;
        style.addObject(view);
    }

    public function dispose() {
        
    }
}