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

    var cashNode: Text;
    var initCashNode = true;
    public var cashWid(get, never): Float;
    public var cashHei(get, never): Float;
    var cashStartAnimX = 0.0;
    var cashEndAnimX = 0.0;
    var cashStartAnimY = 0.0;
    var cashEndAnimY = 0.0;
    var cashAnimTime = 0.0;
    var cashEndAnimScale = 0.0;
    function get_cashWid() {
        return cashNode.textWidth * cashNode.scaleX;
    }

    function get_cashHei() {
        return cashNode.textHeight;
    }

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

        cashNode.text = '$$${cash}';
    }

    override function postUpdate() {
        super.postUpdate();

        updateCash();
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

    public function moveCash(x, y, col, sz) {
        cashNode.textColor = col;
        if (cashEndAnimX == x &&
            cashEndAnimY == y &&
            cashEndAnimScale == sz)
            return;
        cashEndAnimX = x;
        cashEndAnimY = y;
        cashEndAnimScale = sz;
        if (initCashNode || cashAnimTime > 0.5) {
            cashAnimTime = initCashNode ? 10_000 : 0;
            cashStartAnimX = cashNode.x;
            cashStartAnimY = cashNode.y;
        }
        initCashNode = false;
    }

    function easeOutBack(x: Float) {
        var c1 = 1.70158;
        var c3 = c1 + 1;
        
        return 1 + c3 * Math.pow(x - 1, 3) + c1 * Math.pow(x - 1, 2);
    }

    function updateCash() {
        cashAnimTime += deltaTime;
        cashAnimTime = Math.min(cashAnimTime, 0.5);
        var eased = easeOutBack(cashAnimTime / 0.5);
        cashNode.x = M.lerp(cashStartAnimX, cashEndAnimX, eased);
        cashNode.y = M.lerp(cashStartAnimY, cashEndAnimY, eased);
        cashNode.scaleX = cashNode.scaleY = M.lerp(cashNode.scaleX, cashEndAnimScale, 0.2 * tmod);
    }
}