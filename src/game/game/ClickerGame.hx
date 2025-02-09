package game.game;

import hxd.res.DefaultFont;
import h2d.Text;
import hxd.Timer;
import hxd.Key;

enum Page {
    Typing;
    Store;
    Hacker;
}

typedef Typer = {
    timeuntil: Float,
    resettime: Float,
    cash: Int
}

class ClickerGame extends Game {
    public var bg: BackgroundEntity<ClickerGame>;
    public var sidebar: SidebarEntity;
    public var pageentity: Entity<ClickerGame>;

    public var cashNode: Text;
    public var initCashNode = true;

    // State
    public var page = Page.Typing;
    public var cash = 0;
    public var totalcash = 0;
    public var mostcash = 0;
    public var luigiprob = 0.0;
    public var totalletters = 0;
    public var letters = 0;
    public var lettersToPost = 30;
    public var cashPerEmail = 1;
    public var hackerProg = 0.0;
    public var hackerPts = 0;
    public var types: Typer = null;
    public var ilust: Typer = null;

    var timeUntilLuigi = 0.0;

    public function new() {
        super();
        camera.centered = false;

        cashNode = new Text(DefaultFont.get());

        bg = new BackgroundEntity(this);
        sidebar = new SidebarEntity(this);
        hudLayer.addChild(cashNode);

        typingPage();

        bg.instant();
    }

    override function update() {
        super.update();

        timeUntilLuigi -= Timer.dt;
        if (timeUntilLuigi <= 0) {
            timeUntilLuigi = 30;
            var roll = Math.random();
            if (roll < luigiprob) {
                Main.setGame(new KilledGame(this));
            }
        }

        if (types != null) {
            types.timeuntil -= Timer.dt;
            if (types.timeuntil <= 0) {
                types.timeuntil = types.resettime;
                cash += types.cash;
            }
        }
        if (ilust != null) {
            ilust.timeuntil -= Timer.dt;
            if (ilust.timeuntil <= 0) {
                ilust.timeuntil = ilust.resettime;
                cash += ilust.cash;
            }
        }

        if (cash > mostcash)
            mostcash = cash;
    }

    public function typingPage() {
        page = Page.Typing;
        sidebar.title = "Electro-Mail";
        pageentity?.remove();
        pageentity = new TypingPageEntity(this);
    }

    public function storePage() {
        page = Page.Store;
        sidebar.title = "Electro-Shop";
        pageentity?.remove();
        pageentity = new ShopPageEntity(this);
    }

    public function hackerPage() {
        page = Page.Hacker;
        sidebar.title = "Hacker Chat";
        pageentity?.remove();
        pageentity = new HackerPageEntity(this);
    }

    public function luigi() {
        luigiprob += 0.02;
        luigiprob *= 1.3;
    }

    public function sendmail() {
        cash += cashPerEmail;
        totalcash += cashPerEmail;
        if (cash > mostcash)
            mostcash = cash;
    }

    public function charity() {
        luigiprob -= 0.004;
        if (luigiprob < 0)
            luigiprob = 0;
    }
}